class PRODUCER

create
	make

feature -- Initialization

	make (a_item_count: INTEGER; a_inventory: separate INVENTORY)
			-- Initialize to produce `a_item_count' items.
		require
			valid_item_count: a_item_count > 0
		do
			print ("Producer: Initializing to produce " + a_item_count.out + " items.%N")
			item_count := a_item_count
			inventory := a_inventory
			value := 0
		end

feature -- Access

	item_count: INTEGER
			-- Items to produce.

feature -- Basic operations

	live
			-- Lifecycle.
		local
			i: INTEGER
		do
			across (1 |..| item_count) as ic loop produce (inventory) end
		end

	produce (a_inventory: separate INVENTORY)
			-- Produce an item into `a_inventory'.
		require
			empty_inventory: not a_inventory.has_item
		do
			value := value + 1
			a_inventory.put (value)
			io.put_string ("Producer: Produced " + value.out + ".%N")
		end

feature {NONE} -- Implementation

	inventory: separate INVENTORY
			-- Shared inventory.

	value: INTEGER
			-- Value of current item.

end
