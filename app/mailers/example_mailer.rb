class ExampleMailer < ApplicationMailer
  default from: "up694452@myport.ac.uk"


  def sample_email(pdf_path)
    attachments['free_book.pdf'] = File.read(pdf_path)
    mail(to: "up694452@myport.ac.uk", subject: 'Sample Email')
  end
end
