class CreatePrivatePlaces < ActiveRecord::Migration[5.0]
  def change
    create_table :private_places do |t|

      t.timestamps
    end
  end
end
