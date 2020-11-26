class CreateFileReferences < ActiveRecord::Migration[6.0]
  def change
    create_table :file_references do |t|
      t.integer :category,              null: false
      t.integer :user_id,               null: false
      t.string :path, limit: 190,       null: false
      t.timestamps                      null: false
    end

    add_index(:file_references, [:category, :updated_at])
    add_index(:file_references, [:category, :user_id, :path], name:
        'index_file_references_category_and_user_id_and_path')
  end
end
