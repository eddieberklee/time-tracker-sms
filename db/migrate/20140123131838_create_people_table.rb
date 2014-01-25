class CreatePeopleTable < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :name
      t.text :personality
      t.text :reminders
    end
  end
end
