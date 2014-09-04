class CreateCategorizations < ActiveRecord::Migration
  def change
    create_table :categorizations do |t|
        t.belongs_to :genre
        t.belongs_to :movie
    end
  end
end
