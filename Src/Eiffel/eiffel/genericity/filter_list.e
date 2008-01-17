indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class FILTER_LIST

inherit
	SEARCH_TABLE [CL_TYPE_I]
		rename
			has as has_item,
			make as table_make
		export
			{ANY} start, item_for_iteration, forth, after, put, has_item, cursor, go_to
			{NONE} all
		end

create
	make

feature -- Initialization

	make is
		do
			table_make (2)
		end

feature -- Search

	clean is
			-- Clean the list of all the removed classes
		local
			i, nb: INTEGER
			l_item: CL_TYPE_I
			l_default: CL_TYPE_I
			local_content: like content
		do
				-- Note: we cannot search items in the table because they might be
				-- inconsistent and `is_equal' won't work (see eweasel test#incr234).
				-- This is why we do it the complicated way by traversing `content'
				-- and removing inconsistent elements as we see them.
				-- It is also important to not recreate object since `clean' might be called
				-- while Current is being traversed.
			from
				local_content := content
				nb := local_content.count
			until
				i >= nb
			loop
				l_item := local_content.item (i)
				if valid_key (l_item) and then not l_item.is_consistent then
					local_content.put (l_default, i)
					deleted_marks.put (True, i)
					count := count - 1
				end
				i := i + 1
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

end
