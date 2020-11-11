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
        ExampleMailer.sample_email(pdf_path).deliver
      end
      format.pdf_file do
        grover_pdf do |pdf|
          # to download instead of opening in browser remove 'disposition: inline
          send_data(pdf, :filename => "my_fisssle.pdf", :type => "application/pdf",  disposition: "inline")
        end
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
        send_raw_email
      end
    end
  end

  def send_raw_email
    # Replace sender@example.com with your "From" address.
    # This address must be verified with Amazon SES.
    sender = "up694452@myport.ac.uk"
    sendername = "Sender Name"

    # Replace recipient@example.com with a "To" address. If your account
    # is still in the sandbox, this address must be verified.
    recipient = "up694452@myport.ac.uk"

    # Specify a configuration set.
    configsetname = "ConfigSet"

    # Replace us-west-2 with the AWS Region you're using for Amazon SES.
    awsregion = "us-west-2"

    # The subject line for the email.
    subject = "Customer service contact info"

    # The full path to the file that will be attached to the email.
    attachment = Rails.root.join("#{@directory}/#{@key}")

    # The email body for recipients with non-HTML email clients.
    textbody = """
Hello,
Please see the attached file for a list of customers to contact.
"""

    # The HTML body of the email.
    htmlbody = """
<html>
<head></head>
<body>
<h1>Hello!</h1>
<p>Please see the attached file for a list of customers to contact.</p>
</body>
</html>
"""

    # Create a new MIME text object that contains the base64-encoded content of the
    # file that will be attached to the message.
    file = MIME::Application.new(Base64::encode64(open(attachment,"rb").read))

    # Specify that the file is a base64-encoded attachment to ensure that the
    # receiving client handles it correctly.
    file.transfer_encoding = 'base64'
    file.disposition = 'attachment'

    # Create a MIME Multipart Mixed object. This object will contain the body of the
    # email and the attachment.
    msg_mixed = MIME::Multipart::Mixed.new

    # Create a MIME Multipart Alternative object. This object will contain both the
    # HTML and plain text versions of the email.
    msg_body = MIME::Multipart::Alternative.new

    # Add the plain text and HTML content to the Multipart Alternative part.
    msg_body.add(MIME::Text.new(textbody,'plain'))
    msg_body.add(MIME::Text.new(htmlbody,'html'))

    # Add the Multipart Alternative part to the Multipart Mixed part.
    msg_mixed.add(msg_body)

    # Add the attachment to the Multipart Mixed part.
    msg_mixed.attach(file, 'filename' => attachment)

    # Create a new Mail object that contains the entire Multipart Mixed object.
    # This object also contains the message headers.
    msg = MIME::Mail.new(msg_mixed)
    msg.to = { recipient => nil }
    msg.from = { sender => sendername }
    msg.subject = subject
    msg.headers.set('X-SES-CONFIGURATION-SET',configsetname)

    # Create a new SES resource and specify a region
    ses = Aws::SES::Client.new(region: ENV.fetch("AWS_REGION"),
                               access_key_id: ENV.fetch("AWS_ACCESS_KEY_ID"),
                               secret_access_key: ENV.fetch("AWS_SECRET_ACCESS_KEY"))

    # Try to send the email.
    begin

      # Provide the contents of the email.
      resp = ses.send_raw_email({
                                    raw_message: {
                                        data: msg.to_s
                                    }
                                })
      # If the message was sent, show the message ID.
      puts "Email sent! Message ID: " + resp[0].to_s

      # If the message was not sent, show a message explaining what went wrong.
    rescue Aws::SES::Errors::ServiceError => error
      puts "Email not sent. Error message: #{error}"

    end
  end

  def send_email
    sender = "up694452@myport.ac.uk"

    # Replace recipient@example.com with a "To" address. If your account
    # is still in the sandbox, this address must be verified.
    recipient = "up694452@myport.ac.uk"
    configsetname = "ConfigSet"
    subject = "Amazon SES test (AWS SDK for Ruby)"
    htmlbody =
        '<h1>Amazon SES test (AWS SDK for Ruby)Nyazzzz</h1>'\
  '<p>This email was sent with <a href="https://aws.amazon.com/ses/">'\
  'Amazon SES</a> using the <a href="https://aws.amazon.com/sdk-for-ruby/">'\
  'AWS SDK for Ruby</a>.'
    textbody = "This email was sent with Amazon SES using the AWS SDK for Ruby."
    encoding = "UTF-8"
    # puts "Seninggg sent!"
    ses = Aws::SES::Client.new(region: ENV.fetch("AWS_REGION"),
                               access_key_id: ENV.fetch("AWS_ACCESS_KEY_ID"),
                               secret_access_key: ENV.fetch("AWS_SECRET_ACCESS_KEY"))

    # Try to send the email.
    begin
      # Provide the contents of the email.
      resp = ses.send_email({
                                destination: {
                                    to_addresses: [
                                        recipient,
                                    ],
                                },
                                message: {
                                    body: {
                                        html: {
                                            charset: encoding,
                                            data: htmlbody,
                                        },
                                        text: {
                                            charset: encoding,
                                            data: textbody,
                                        },
                                    },
                                    subject: {
                                        charset: encoding,
                                        data: subject,
                                    },
                                },
                                source: sender
                                # Comment or remove the following line if you are not using
                                # a configuration set
                                # configuration_set_name: configsetname,
                            })
      puts "Email sent!"

      # If something goes wrong, display an error message.
    rescue StandardError => e
      puts "Email not sent. Error message: #{e}"
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
