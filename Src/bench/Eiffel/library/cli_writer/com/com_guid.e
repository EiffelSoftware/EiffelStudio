indexing
	description: "Abstraction of a GUID data structure."
	date: "$Date$"
	revision: "$Revision$"

class
	COM_GUID

create
	make,
	make_empty
	
feature {NONE} -- Initialization

	make (data1: INTEGER; data2, data3: INTEGER_16; data4: ARRAY [INTEGER_8]) is
			-- Create Current using provided above information.
		require
			data4_not_void: data4 /= Void
			data4_valid_count: data4.count = 8
		do
			create item.make (size)
			item.put_integer_32 (data1, 0)
			item.put_integer_16 (data2, 4)
			item.put_integer_16 (data3, 6)
			item.put_array (data4, 8)
		end

	make_empty is
			-- Create a GUID with null data.
		do
			make (0, 0, 0, <<0,0,0,0,0,0,0,0>>)
		end

feature -- Access

	item: MANAGED_POINTER
			-- To hold data of Current.
			
	size: INTEGER is 16
			-- Size of structure.

invariant
	item_not_void: item /= Void

end -- class COM_GUID
