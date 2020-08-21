class CreateBikes < ActiveRecord::Migration[6.0]
  def change
    create_table :bikes do |t|
      t.string :location
      t.integer :length
      t.integer :rating
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
