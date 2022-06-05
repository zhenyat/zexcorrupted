class CreateJoinTableDotcomPair < ActiveRecord::Migration[7.0]
  def change
    create_join_table :dotcoms, :pairs do |t|
      t.index [:dotcom_id, :pair_id]
      # t.index [:pair_id, :dotcom_id]
    end
  end
end
