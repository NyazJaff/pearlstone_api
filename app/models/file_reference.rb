# frozen_string_literal: true

# == Schema Information
#
# Table name: file_references
#
#  id             :integer          not null, primary key
#  category       :integer
#  user_id        :integer
#  path           :string(190)
#
# Indexes
#
#  index_file_references_category_and_user_id_and_path          (category, user_id, path)
#  index_file_references_on_category_and_updated_at             (category, updated_at)
#
class FileReference < ApplicationRecord
  belongs_to :user
  enum category: [:saving_estimate]
end
