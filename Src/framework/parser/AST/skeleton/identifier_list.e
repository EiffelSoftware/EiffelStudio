note
	description: "Objects that represent a list of identifiers"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	IDENTIFIER_LIST

inherit
	CONSTRUCT_LIST [INTEGER]

create
	make,
	make_filled_with

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

	reverse_extend_separator (a: LEAF_AS)
			-- Put `a` to `separator_list` in reverse order.
		require
			capacity > 1
		local
			l: like separator_list
		do
			l := separator_list
			if attached l then
				l.reverse_extend (a.index)
			else
				create l.make_filled_with (a.index, capacity - 1)
				separator_list := l
			end
		end

	reverse_extend_identifier (l_as: ID_AS)
			-- Put `a` to the end of `id_list`.
		require
			capacity > 0
		local
			l: like id_list
		do
			l := id_list
			if attached l then
				l.reverse_extend (l_as.index)
			else
				create l.make_filled_with (l_as.index, capacity)
				id_list := l
			end
		end

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software"
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
