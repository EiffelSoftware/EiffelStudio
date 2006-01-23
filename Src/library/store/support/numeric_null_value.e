indexing
	description: "Object that defines the numeric value that codes a database%
			%NULL value."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class NUMERIC_NULL_VALUE


