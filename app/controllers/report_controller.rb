require 'json'
require 's3_storage'
require 'tracked_file_reference'
require 'saving_calculation'

class ReportController < ApplicationController
  protect_from_forgery with: :null_session
  # before_action :set_s3_object

  def saving_estimate
    user = get_param_user
    raise 'INVALID_USER_PASSED' unless user
    Dir.mktmpdir('pdf_render', 'tmp') do |tmp_dir|
      @key = "PearlstoneSavingEstimate-#{Time.now.strftime('%Y-%m-%d %H:%M')}.pdf"
      s3_path = S3Storage.estimate_pdf_path(@key)
      grover_pdf(tmp_dir) do |pdf|
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

  def grover_pdf(directory)
    grover = Grover.new("http://#{request.host_with_port}/report/generate_estimate", format: 'A4',  timeout: 0,
                        footer_template: "<div class='text right'>What ever text you want</div>")
    pdf = grover.to_pdf

    File.open(Rails.root.join("#{directory}/#{@key}"), 'wb') { |f| f.write(pdf) }
    yield pdf
  end

  def generate_estimate

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
