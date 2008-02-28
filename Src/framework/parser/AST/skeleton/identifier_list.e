indexing
	description: "Objects that represent a list of identifiers"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	IDENTIFIER_LIST

inherit
	CONSTRUCT_LIST [INTEGER]

create
	make

create {IDENTIFIER_LIST}
	make_filled


feature -- Access

	id_list: CONSTRUCT_LIST [INTEGER]
			-- List to store ID_AS objects in this structure.

	separator_list: CONSTRUCT_LIST [INTEGER]
			-- List to store terminals that appear in between every 2 items of this list

	separator_list_i_th (i: INTEGER; a_list: LEAF_AS_LIST): LEAF_AS is
			-- Terminals at position `i' in `separator_list' using `a_list'.
		require
			valid_index: separator_list.valid_index (i)
			a_list_not_void: a_list /= Void
		local
			n: INTEGER
		do
			n := separator_list.i_th (i)
			if a_list.valid_index (n) then
				Result ?= a_list.i_th (n)
			end
		end

	reverse_extend_separator (l_as: LEAF_AS) is
			-- Add `l_as' into `separator_list'.
		do
			if separator_list = Void then
				if capacity >= 2 then
					create separator_list.make (capacity - 1)
				else
						-- One should never get here as this will yield in a call on void.
					check one_should_never_get_here: false end
				end
			end
			separator_list.reverse_extend (l_as.index)
		end

	reverse_extend_identifier (l_as: ID_AS) is
			-- Add `l_as' into `id_list'.
		do
			if id_list = Void then
				create id_list.make (capacity)
			end
			id_list.reverse_extend (l_as.index)
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

end
