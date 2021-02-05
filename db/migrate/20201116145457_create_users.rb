class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string  :user_name      , limit: 100
      t.string  :first_name     , limit: 100, null: false
      t.string  :second_name    , limit: 100
      t.string  :last_name      , limit: 100
      t.string  :contact_number , limit: 40
      t.string  :building_name  , limit: 40
      t.string  :address_line_1 , limit: 40
      t.string  :address_line_2 , limit: 40
      t.string  :city           , limit: 40
      t.string  :country        , limit: 30
      t.string  :postcode       , limit: 15
      t.string  :email          , limit: 30, null: false, unique: true
      t.string  :role                      , default: User.roles[:user]
      t.string  :password_digest
      t.integer :created_user_id

      t.timestamps
    end

    add_index(:users, [:email])
  end
end
