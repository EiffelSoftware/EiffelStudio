indexing
	description: "Object that defines the numeric value that codes a database%
			%NULL value."
	date: "$Date$"
	revision: "$Revision$"

class
	DEFAULT_NULL_VALUE

feature -- Access
	
	default_null_value: DOUBLE is
			-- Default value set to integer, double or real field instead of NULL.
		do
			Result := default_null_value_ref.item
		end

	set_default_null_value (a_value: DOUBLE) is
			-- Set `a_value' to the default numeric NULL value.
		do
			default_null_value_ref.set_item (a_value)
		end

feature -- Implementation

	default_null_value_ref: DOUBLE_REF is
			-- Reference to the value. 
		once
			create Result
			Result.set_item (0.0)
		end

end -- class DEFAULT_NULL_VALUE

--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
