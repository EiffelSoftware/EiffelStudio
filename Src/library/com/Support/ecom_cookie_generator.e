indexing
	description: "Cookie generator."
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_COOKIE_GENERATOR


create
	default_create


feature -- Access

	counter: INTEGER
			-- Current biggest key.
	
	available_key_pool: LINKED_LIST [INTEGER]
			-- Pool of available keys.
	

feature -- Basic operations

	next_key: INTEGER is 
			-- Next available key.
		do
			if 
				available_key_pool = Void or else
				available_key_pool.empty
			then
				counter := counter + 1
				Result := counter
			else
				Result := available_key_pool.first
				available_key_pool.start
				available_key_pool.remove
			end
		ensure
			valid_counter: 0 < counter
			valid_key: Result <= counter
		end

	add_key_to_pool (a_key: INTEGER) is
			-- Add `a_key' to available key pool.
		require
			valid_key: a_key >= 0 and a_key <= counter
		do
			if available_key_pool = Void then
				create available_key_pool.make
			end
			available_key_pool.force (a_key)
		ensure
			non_void_pool: available_key_pool /= Void
			pool_extended: available_key_pool.has (a_key)
		end
		
end -- class ECOM_COOKIE_GENERATOR

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support http://support.eiffel.com
--| For latest info see award-winning pages: http://eiffel.com
--|----------------------------------------------------------------
