indexing
	description: "Object that defines the numeric value that codes a database%
			%NULL value."
	date: "$Date$"
	revision: "$Revision$"

class
	NUMERIC_NULL_VALUE

feature {NONE} -- Access
	
	numeric_null_value: DOUBLE is
			-- Default value set to integer, double or real field instead of NULL.
			-- Real and integer values are TRUNCATED.
		do
			Result := numeric_null_value_ref.item
		end

	set_numeric_null_value (a_value: DOUBLE) is
			-- Set `a_value' to the default numeric NULL value.
		do
			numeric_null_value_ref.set_item (a_value)
		end

feature {NONE} -- Implementation

	numeric_null_value_ref: DOUBLE_REF is
			-- Reference to the value. 
		once
			create Result
			Result.set_item (0.0)
		end

end -- class NUMERIC_NULL_VALUE


--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

