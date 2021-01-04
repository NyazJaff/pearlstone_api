require 'json'
require 's3_storage'
require 'tracked_file_reference'
require 'saving_calculation'

class ReportController < ApplicationController
  protect_from_forgery with: :null_session
  # before_action :set_s3_object

  def saving_estimate
    user = get_param_user
    puts params[:reportId], "params[:reportId]"
    raise 'INVALID_USER_PASSE.' unless user
    Dir.mktmpdir('pdf_render', 'tmp') do |tmp_dir|
      @key = "PearlstoneSavingEstimate-#{Time.now.strftime('%Y-%m-%d %H:%M')}.pdf"
      s3_path = S3Storage.estimate_pdf_path(@key)
      @calculation = CalculationResult.find_by(id: params[:report_id])
      @calculation.user_id = user.id
      @calculation.save

      grover_pdf(tmp_dir, @calculation.id) do |pdf|
        tracked_file = TrackedFileReference.new(user: user, file_path: s3_path, category: :saving_estimate)
        tracked_file.save_file(pdf)
        UserMailer.saving_estimate_report_email(s3_path, user).deliver
        render json: { status: 'success', action: action_name, data: s3_path }, status: :ok
        # to download instead of opening in browser remove 'disposition: inline
        # send_data(pdf, :filename => "my_fisssle.pdf", :type => "application/pdf",  disposition: "inline")
      end
    end
  rescue => e
    render json: { status: 'error', action: action_name, data: e, backtrace: e.backtrace}, status: 500
  end

  def grover_pdf(directory, calculation_id)
    options = {format: 'A4',
               timeout: 0,
               # header_template: 'Some header',
               # headerTemplate: 'instance header',
               # footerTemplate: 'instance header'
    }

    grover = Grover.new("http://#{request.host_with_port}/report/generate_estimate/#{calculation_id}", options )
    pdf = grover.to_pdf

    # pdf = Grover::Processor.new(Rails.root).convert(:pdf, "http://#{request.host_with_port}/report/generate_estimate/#{calculation_id}", 'header_template' => '<html><body><div>testestest 1111 </div></body</html>', 'footer_template' => 'instance footer'  )
    File.open(Rails.root.join("#{directory}/#{@key}"), 'wb') { |f| f.write(pdf) }
    yield pdf
  end

  def generate_estimate
    @calculation = CalculationResult.find_by_id(params['calculation_id'])
    @user = User.find_by_id(@calculation.user_id)
    if @calculation.nil? || @user.nil?
      render :json => "If you seeing this message then please contact us to resolve it for you: your report id is: #{params['calculation_id']}"
    end
  end

  def saving_calculation
    saving_calculation = SavingCalculation.new(
      x_average_kws:     params['average_kws'],
      y_turn_off:        params['turn_off'],
      z_events_per_week: params['events_per_week'],
      t_events_duration: params['events_duration']
    )

    id = saving_calculation.save.id

    render json: { status: 'success', action: action_name, data: saving_calculation.result, saving_calculation_id: id }, status: :ok
  end

end
