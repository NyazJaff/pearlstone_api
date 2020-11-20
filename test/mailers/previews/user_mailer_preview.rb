# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  def user_mail_preview
    pdf_path = Rails.root.join("public/property/pdfs/hello_world.pdf")
    UserMailer.sample_email(pdf_path)
  end
end
