class UserMailer < ApplicationMailer
  default from: "up694452@myport.ac.uk"

  def sample_email(file_key, user)
    @user = user
    S3Storage.tmp_file(file_key) do |attachment|
      attachments['Pearlstone.pdf'] = File.read(attachment.path)
      mail(to: "up694452@myport.ac.uk", subject: 'Sample Email')
    end
  end
end
