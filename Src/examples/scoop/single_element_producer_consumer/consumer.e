class CONSUMER

create
	make

feature

 	make (a_item_count: INTEGER; a_inventory: separate INVENTORY)
 			-- Initialize to consume `a_item_count' items from `a_inventory'.
 		require
 			valid_item_count: a_item_count > 0
		do
			print ("Consumer: Initializing to consume " + a_item_count.out + " items.%N")
			inventory := a_inventory
			item_count := a_item_count
		end

feature -- Access

	item_count: INTEGER
			-- Items to consume

feature -- Basic operations

	live
			-- Lifecycle.
		do
			across (1 |..| item_count) as ic loop
				print ("Consumer: Attempting to consume inventory ... %N")
				consume (inventory)
			end
		end

feature {NONE} -- Implementation

	consume (a_inventory: separate INVENTORY)
			-- Consume the item held in `a_inventory'.
		require
			full_inventory: a_inventory.has_item
		local
			l_consumed_item: INTEGER
		do
			l_consumed_item := a_inventory.item
			a_inventory.remove
			print ("Consumer: Consumed " + l_consumed_item.out + ".%N")
		end

	inventory: separate INVENTORY
			-- Shared inventory.

end
