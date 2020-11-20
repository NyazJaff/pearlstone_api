require 'json'
require 's3_storage'

class ReportController < ApplicationController
  # before_action :set_s3_object

  def saving_estimate

    Dir.mktmpdir('pdf_render', 'tmp') do |tmp_dir|
      @key = 'test.pdf'
      s3_path = S3Storage.estimate_pdf_path(@key)
      grover_pdf(tmp_dir) do |pdf|
        # TrackedFileReference.new()
        S3Storage.new(s3_path).save_file(pdf)
        UserMailer.sample_email(s3_path).deliver

        render json: { status: 'SUCCESS', action: action_name, data: @key }, status: :ok
        # to download instead of opening in browser remove 'disposition: inline
        # send_data(pdf, :filename => "my_fisssle.pdf", :type => "application/pdf",  disposition: "inline")
      end
    end
  rescue => e
    render json: { status: 'ERROR', action: action_name, data: e }, status: 500
  end

  def grover_pdf(directory)
    grover = Grover.new('http://localhost:3000/invoice/render_pdf/1?tes', format: 'A4',  timeout: 0)
    pdf = grover.to_pdf

    File.open(Rails.root.join("#{directory}/#{@key}"), 'wb') { |f| f.write(pdf) }
    yield pdf
  end
end
