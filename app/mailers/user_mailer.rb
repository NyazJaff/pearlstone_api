require 's3_storage'

class UserMailer < ApplicationMailer
  default from: "Pearlstone Energy Ltd <nyaz.k.jaff@gmail.com>"

  def saving_estimate_report_email(file_key, user)
    @user = user
    S3Storage.tmp_file(file_key) do |attachment|
      attachments[file_key.split('/').last] = File.read(attachment.path)
      mail(to: user.email, subject: 'Pearlstone - Saving Estimate - ' + Time.now.strftime("%d-%m-%Y").to_s)
    end
  end
end
