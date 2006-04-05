indexing
	description: "Objects that redefine ACTION to store Eiffel objects converted %
		% from database in a list."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end -- class DB_ACTION

