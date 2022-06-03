class CreateApis < ActiveRecord::Migration[7.0]
  def change
    create_table :apis do |t|
      t.references :dotcom,   null: false, foreign_key: true
      t.integer    :mode,     null: false, default: 0, limit: 1
      t.string     :base_url
      t.string     :path
      t.string     :key
      t.string     :secret
      t.string     :user
      t.integer    :status,   null: false, default: 0, limit: 1

      t.timestamps
    end
  end
end
