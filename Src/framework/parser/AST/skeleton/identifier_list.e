note
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
	make,
	make_filled

feature -- Access

	id_list: detachable CONSTRUCT_LIST [INTEGER]
			-- List to store ID_AS objects in this structure.

	separator_list: detachable CONSTRUCT_LIST [INTEGER]
			-- List to store terminals that appear in between every 2 items of this list

	separator_list_i_th (i: INTEGER; a_list: LEAF_AS_LIST): detachable LEAF_AS
			-- Terminals at position `i' in `separator_list' using `a_list'.
		require
			valid_index: attached separator_list as l_list and then l_list.valid_index (i)
			a_list_not_void: a_list /= Void
		local
			n: INTEGER
		do
			if attached separator_list as l_sep_list then
				n := l_sep_list.i_th (i)
				if a_list.valid_index (n) then
					Result := a_list.i_th (n)
				end
			end
		end

	reverse_extend_separator (l_as: LEAF_AS)
			-- Add `l_as' into `separator_list'.
		require
			capacity_large_enough: capacity >= 2
		local
			l_sep_list: like separator_list
		do
			l_sep_list := separator_list
			if l_sep_list = Void then
				check enough_capacity: capacity >= 2 end
				create l_sep_list.make_filled (capacity - 1)
				separator_list := l_sep_list
			end
			l_sep_list.reverse_extend (l_as.index)
		end

	reverse_extend_identifier (l_as: ID_AS)
			-- Add `l_as' into `id_list'.
		local
			l_id_list: like id_list
		do
			l_id_list := id_list
			if l_id_list = Void then
				create l_id_list.make_filled (capacity)
				id_list := l_id_list
			end
			l_id_list.reverse_extend (l_as.index)
		end

note
	copyright:	"Copyright (c) 1984-2013, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
