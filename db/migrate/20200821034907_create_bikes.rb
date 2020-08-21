class CreateBikes < ActiveRecord::Migration[6.0]
  def change
    create_table :bikes do |t|
      t.string :name
      t.string :type
      t.integer :quality
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
