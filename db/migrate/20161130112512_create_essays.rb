class CreateEssays < ActiveRecord::Migration
  def change
    create_table :essays do |t|
      t.integer :essay_application_id
      t.string :essay
      t.timestamps
    end
  end
end


