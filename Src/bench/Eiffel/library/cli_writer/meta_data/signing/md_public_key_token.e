indexing
	description: "A public key token"
	date: "$Date$"
	revision: "$Revision$"

class
	MD_PUBLIC_KEY_TOKEN

create
	make_from_array
	
feature {NONE} -- Initialize

	make_from_array (data: ARRAY [INTEGER_8]) is
			-- Initialize `item' with content of `data'.
		require
			data_not_void: data /= Void
		do
			create item.make_from_array (data)
		end
		
feature -- Access

	item: MANAGED_POINTER
			-- Store public key token.

invariant
	item_not_void: item /= Void
	
end -- class MD_PUBLIC_KEY_TOKEN
