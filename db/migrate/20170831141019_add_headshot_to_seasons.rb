class AddHeadshotToSeasons < ActiveRecord::Migration[5.1]
  def change
    add_column :seasons, :headshot, :string
  end
end
