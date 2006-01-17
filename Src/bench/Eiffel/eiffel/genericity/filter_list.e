indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class FILTER_LIST

inherit
	ARRAYED_LIST [CL_TYPE_I]
		rename
			append as list_append,
			search as list_search,
			make as list_make
		export
			{ANY} start, item, forth, after, extend, cursor, go_to, extendible,
				readable, valid_cursor, valid_index, index, off, is_equal
			{FILTER_LIST} all
		end

create
	make

create {FILTER_LIST}
	make_filled

feature -- Initialization

	make is
		do
			list_make (2)
			compare_objects
		end

feature -- Search

	has_item (v: like item): BOOLEAN is
			-- Patch
		require
			v_not_void: v /= Void
		local
			l_area: like area
			i, nb: INTEGER
		do
			from
				l_area := area
				i := 0
				nb := count - 1
			until
				i > nb or else Result
			loop
				Result := l_area.item (i).same_as (v)
				i := i + 1
			end
		end

	clean is
			-- Clean the list of all the removed classes
		local
			l_area: like area
			l_new_area: like area
			i, nb, l_count: INTEGER
			l_item: like item
		do
			from
				l_area := area
				nb := count - 1
				list_make (count)
				l_new_area := area
				i := 0
			until
				i > nb
			loop
				l_item := l_area.item (i)
				if l_item.is_valid then
					l_new_area.put (l_item, l_count)
					l_count := l_count + 1
				end
				i := i + 1
			end
			count := l_count
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
