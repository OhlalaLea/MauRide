class AddVehiculesReferenceToRides < ActiveRecord::Migration[7.0]
  def change
    add_reference :rides, :vehicule, null: false, foreign_key: true
  end
end
