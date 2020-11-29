require 's3_storage'

class UserMailer < ApplicationMailer
  default from: "up694452@myport.ac.uk"

  def sample_email(file_key, user)
    @user = user
    S3Storage.tmp_file(file_key) do |attachment|
      attachments[file_key.split('/').last] = File.read(attachment.path)
      mail(to: user.email, subject: 'Pearlstone - Saving Estimate ')
    end
  end
end
