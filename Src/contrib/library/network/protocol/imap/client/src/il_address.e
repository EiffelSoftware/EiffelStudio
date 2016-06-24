note
	description: "An address"
	author: "Basile Maret"

class
	IL_ADDRESS

create
	make_with_name_and_address, make_empty

feature {NONE} -- Initialization

	make_with_name_and_address (a_name: STRING; a_address: STRING)
			-- Create with `a_name' and `a_address'.
		require
			a_name_not_void: a_name /= Void
			a_address_not_void: a_address /= Void
		do
			name := a_name
			address := a_address
		ensure
			name_set: name = a_name
			address_set: address = a_address
		end

	make_empty
			-- Create with empty name and addresses.
		do
			create name.make_empty
			create address.make_empty
		end

feature -- Access

	name: STRING
			-- The name of the address owner.

	address: STRING
			-- The address.


;note
	copyright: "2015-2016, Maret Basile, Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
