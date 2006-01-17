indexing
	description: "Leaf for Eiffel syntax node."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	LEAF_AS

inherit
	AST_EIFFEL
		undefine
			number_of_breakpoint_slots
		redefine
			text
		end

	LOCATION_AS
		rename
			make as make_with_location
		end

feature -- Roundtrip/Location

	complete_start_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			Result := Current
		end

	complete_end_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			Result := Current
		end

feature -- Roundtrip

	text (a_list: LEAF_AS_LIST): STRING is
			-- Literal text of this token, which is stored in `a_list'
		require else
			a_list_can_be_void: a_list = Void
		do
			Result := a_list.i_th (index).text (Void)
		end

	index: INTEGER
			-- Index in `match_list', a structure to store all tokens (including breaks and comments).

	set_index (i: INTEGER) is
			-- Set `index' with `i'.
		require
			i_not_negative: i >= 0
		do
			index := i
		ensure
			index_set: index = i
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end
