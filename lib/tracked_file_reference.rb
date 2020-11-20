# frozen_string_literal: true

# This class is created to group the functionality of saving file reference (FileReference)
# and writing file data together (S3Storage)
class TrackedFileReference

  def initialize(file_path:, user:, category:)
    @file_path = file_path
    @category = category
    @user = user
  end

  def save_file
    FileReference.transaction do
      FileReference.find_or_create_by(path: @file_path, category: @category, user: @user.id)

      # ImageWriter.new.data_to_blob(data_or_io: data_or_io, blob: @data_blob, tempfile_name: 'tracked_data_blob')
    end
  end

  def file
    FileReference.where(
      path:     @file_path,
      user:     @user.id,
      category: @category
    ).first # Change to <.first!> when confident that every image generated will have reference in DB
    # Please remember to uncomment the test coverage

    @data_blob.read_data
  end
end
