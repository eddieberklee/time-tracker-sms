class CreateMeTable < ActiveRecord::Migration
  def change
    create_table :me_tables do |t|
      t.string :name
      t.text :personality
    end
  end
end
