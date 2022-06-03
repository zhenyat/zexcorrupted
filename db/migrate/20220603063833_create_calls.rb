class CreateCalls < ActiveRecord::Migration[7.0]
  def change
    create_table :calls do |t|
      t.references :api,    null: false, foreign_key: true
      t.string     :name,   null: false, index: {unique: true}
      t.string     :title,  null: false
      t.string     :link
      t.integer    :status, null: false, default: 0, limit: 1

      t.timestamps
    end
  end
end
