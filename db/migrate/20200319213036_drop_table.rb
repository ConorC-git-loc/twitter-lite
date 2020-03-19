class DropTable < ActiveRecord::Migration[6.0]
  	def up
    drop_table :votes
    end

  
end
