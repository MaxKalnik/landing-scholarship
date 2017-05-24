class CreateEssayApplications < ActiveRecord::Migration
  def change
    create_table :essay_applications do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone

      t.string :photo
      t.string :transcript
      t.string :recommendation

      t.timestamps
    end
  end
end
