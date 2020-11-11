# Preview all emails at http://localhost:3000/rails/mailers/example_mailer
class ExampleMailerPreview < ActionMailer::Preview

  def sample_mail_preview
    pdf_path = Rails.root.join("public/property/pdfs/hello_world.pdf")
    ExampleMailer.sample_email(pdf_path)
  end
end
