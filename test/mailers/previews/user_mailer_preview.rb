# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  def user_mail_preview
    pdf_path = 'estimates/PearlstoneSavingEstimate-2020-11-26 10:54.pdf'
    user = User.find(1)
    UserMailer.sample_email(pdf_path, user)
  end
end
