indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GTK_C_STRING

create
	make, make_from_pointer
	
	
feature {NONE} -- Initialization

	make (a_string: STRING) is
			-- Create a UTF8 string from `a_string'
		local
			a_string_value: ANY
		do
			a_string_value := a_string.to_c
				-- String count doesn't take the null character in to account
			create managed_data.make_from_pointer ($a_string_value, a_string.count + 1)
		end

	make_from_pointer (a_ptr: POINTER) is
			-- Set `Current' to use `a_ptr'
		local
			a_string: STRING
		do
			create a_string.make_from_c (a_ptr)
			make (a_string)
		end

feature -- Access

	item: POINTER is
			-- Pointer to the UTF8 string
		do
			Result := managed_data.item
		end

	string: STRING is
			-- Locale string representation of the UTF8 string
		do
			create Result.make_from_c (item)
		end	

feature {NONE} -- Implementation

	managed_data: MANAGED_POINTER
		-- Pointer to the UTF8 string
	

end -- class EV_GTK_C_STRING

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

