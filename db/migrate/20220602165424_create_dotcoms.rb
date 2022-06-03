class CreateDotcoms < ActiveRecord::Migration[7.0]
  def change
    create_table :dotcoms do |t|
      t.string  :name,   null: false, index: {unique: true}
      t.integer :status, null: false, default: 0, limit: 1

      t.timestamps
    end
  end
end
