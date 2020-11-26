# frozen_string_literal: true

class S3Storage
  def initialize(key)
    @key = key
    @s3 = Aws::S3::Resource.new(
        region:            ENV.fetch("AWS_REGION"),
        access_key_id:     ENV.fetch("AWS_ACCESS_KEY_ID"),
        secret_access_key: ENV.fetch("AWS_SECRET_ACCESS_KEY"))
    @bucket_name =         ENV.fetch("AWS_BUCKET_NAME")
    @s3_obj = @s3.bucket(@bucket_name).object(key)
  end

  def save_file(file_body)
    @s3_obj.put(body: file_body)
  end

  def file(path)
    @s3.bucket(@bucket_name).object(@key).get({response_target: path}) # finding a file on s3 and saving it locally
  end

  def self.tmp_file(key)
    Tempfile.create(['estimate', '.pdf'], 'tmp/') do |tmp_file|
      S3Storage.new(key).file(tmp_file.path) # save s3 file matching key to tmp directory
      yield tmp_file
    end
  end

  def self.estimate_pdf_path(file_name)
    "estimates/#{file_name}"
  end

end
