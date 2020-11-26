# frozen_string_literal: true

require 's3_storage'

# This class is created to group the functionality of saving file reference (FileReference)
# and writing file data together (S3Storage)
class TrackedFileReference

  def initialize(user:, file_path:, category:)
    @user = user
    @file_path = file_path
    @category = category
  end

  def save_file(file)
    FileReference.transaction do
      FileReference.find_or_create_by(path: @file_path, user_id: @user.id, category: @category)
      S3Storage.new(@file_path).save_file(file)
    end
  end

  def file
    FileReference.where(
      path:     @file_path,
      user_id:  @user.id,
      category: @category
    ).first # Change to <.first!> when confident that every image generated will have reference in DB
  end
end
