indexing
	description: "Object that retrieve an integer from the database%
			%with a 'select' query."
	author: "Cedric Reduron"
	date: "$Date$"
	revision: "$Revision$"

class
	DATABASE_INTEGER_SELECTION [G -> DATABASE create default_create end]

inherit
	HANDLE_SPEC [G]

	TYPES [G]

create
	default_create

feature -- Basic operations

	execute_query (a_query: STRING): INTEGER is
			-- Execute `last_query' set.
		local
			double_value: DOUBLE_REF
		do
			descriptor := db_spec.new_descriptor
			db_spec.init_order (descriptor, a_query)
			db_spec.start_order (descriptor)
			db_spec.next_row (descriptor)
			check
				db_spec.get_col_type (descriptor, 1) = float_type_database
			end
			create double_value
			double_value.set_item (db_spec.get_float_data (descriptor, 1))
			Result := double_value.truncated_to_integer
		end

	terminate is
			-- Terminate operation.
		do
			db_spec.terminate_order (descriptor)
		end

feature {NONE} -- Implementation

	descriptor: INTEGER
			-- Database descriptor.

end -- class DATABASE_INTEGER_SELECTION

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
