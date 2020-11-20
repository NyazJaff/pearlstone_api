require 'open-uri'
# require 'base64'  #standard library
# require 'aws-sdk' #gem install aws-sdk
# require 'mime'    #gem install mime

class InvoiceController < ApplicationController
  before_action :set_s3_object, only: [:show]
  before_action :set_directory, only: [:show]

  def show
    respond_to do |format|
      format.html do
        pdf_path = Rails.root.join("#{@directory}/#{@key}")

        puts pdf_path
        UserMailer.sample_email(pdf_path).deliver
      end
      format.pdf_file do
        # grover_pdf do |pdf|
        #   # to download instead of opening in browser remove 'disposition: inline
        #   send_data(pdf, :filename => "my_fisssle.pdf", :type => "application/pdf",  disposition: "inline")
        # end
      end
      format.pdf do
        # html = render_to_string(action: "show.slim")
        # grover = Grover.new(html, format: 'A4')
        # grover = sds

        # grover = Grover.new('http://localhost:3000/invoice/render_pdf/1', format: 'A4')
        # pdf = grover.to_pdf


        grover_pdf do |pdf|
          # File.open(Rails.root.join("#{@directory}/#{@key}"), 'rb') do |file|
          #   # @s3_obj.put(body: file)
          # end

          # to download instead of opening in browser remove 'disposition: inline
          send_data(pdf, :filename => "my_fisssle.pdf", :type => "application/pdf",  disposition: "inline")
        end
      end
    end
  end


  def grover_pdf
    grover = Grover.new('http://localhost:3000/invoice/render_pdf/1?tes', format: 'A4',  timeout: 0)
    pdf = grover.to_pdf
    File.open(Rails.root.join("#{@directory}/#{@key}"), 'wb') { |f| f.write(pdf) }
    yield pdf
  end


  def view_pdf
    redirect_to @s3_obj.presigned_url(:get)
  end

  def render_pdf
  end

  private

  def set_directory
    @directory = "public/property/pdfs"
    `mkdir -p #{@directory}` unless Dir.exist?(@directory)
  end

  def set_s3_object
    s3 = Aws::S3::Resource.new(region: ENV.fetch("AWS_REGION"),
                               access_key_id: ENV.fetch("AWS_ACCESS_KEY_ID"),
                               secret_access_key: ENV.fetch("AWS_SECRET_ACCESS_KEY"))
    bucket_name = ENV.fetch("AWS_BUCKET_NAME")
    @key = "hello_world.pdf"
    @s3_obj = s3.bucket(bucket_name).object(@key)
  end
end
