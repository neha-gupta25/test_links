class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.text :html

      t.timestamps null: false
    end
  end
end
