indexing
	description: "Objects that redefine ACTION to store Eiffel objects converted %
		% from database in a list."
	author: "Cedric Reduron"
	date: "$Date$"
	revision: "$Revision$"

class
	DB_SUBSET_ACTION [G, H]

inherit
	DB_ACTION [G]
		redefine
			execute
		end

create
	make

feature -- Access

	valid_values: LIST [H]
			-- Valid values for a database object criterion value.

	extract_function: FUNCTION [ANY, TUPLE [G], H]
			-- Function to extract criterion value from a database result object.

feature -- Element change

	set_valid_values (a_valid_values: LIST [H]) is
			-- Assign `a_valid_values' to `valid_values'.
		require
			not_void: a_valid_values /= Void
		do
			valid_values := a_valid_values
			valid_values.compare_objects
		ensure
			valid_values_assigned: valid_values = a_valid_values
		end

	set_extract_function (a_extract_function: FUNCTION [ANY, TUPLE [G], H]) is
			-- Assign `a_extract_function' to `extract_function'.
		require
			not_void: a_extract_function /= Void
		do
			extract_function := a_extract_function
		ensure
			extract_function_assigned: extract_function = a_extract_function
		end

feature -- Actions

	execute is
			-- Update item with current
			-- selected item in the container.
		do
			selection.cursor_to_object			
			if valid_values.has (extract_function.item ([item])) then
				list.extend (deep_clone (item))
			end
		end

end -- class DB_ACTION

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
