indexing
	description: "A scrollable list element that represents %
			% only a string"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	STRING_SCROLLABLE_ELEMENT
	
	--| FIXME extracted form build
	--| main modification inheritance from `EV_LIST_ITEM'.

inherit

	EV_LIST_ITEM
		rename
			is_equal as ev_list_item_is_equal
		undefine
			out
		end
	
	STRING
		undefine
			default_create, copy, is_equal
		redefine
			make
		select
			is_equal
		end

creation
	make

feature -- Initialization is

	make (n: INTEGER) is
			-- Create `Current' with space for `n' characters.
		do
			default_create
			Precursor {STRING} (n)
		end

feature -- Implementation

	value: STRING is
			-- `Result' is `STRING' representing value of `Current'.
		do
			create Result.make (count)
			Result.append (Current)
		end

	is_equal (other: like Current): BOOLEAN is
			-- Test equality based on values of each `value'.
		do
			Result := value.is_equal (other.value)
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


end -- class STRING_SCROLLABLE_ELEMENT
