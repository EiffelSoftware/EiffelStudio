note
	description: "Filter all available types in system."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class FILTER_LIST

inherit
	SEARCH_TABLE [CL_TYPE_A]
		rename
			has as has_item,
			make as table_make
		export
			{ANY}
				start, item_for_iteration, forth, after, put, has_item, cursor, go_to, valid_key, count, content,
				is_deep_equal, is_equal, standard_is_equal, copy, deep_copy, valid_cursor, deleted_marks, same_type,
				deep_twin, wipe_out
			{FILTER_LIST} all
		redefine
			same_keys
		end

create
	make

create {FILTER_LIST}
	make_with_key_tester

feature {NONE} -- Initialization

	make
		do
			table_make (2)
		end

feature -- Comparison

	same_keys (a_search_key, a_key: CL_TYPE_A): BOOLEAN
		do
			Result := a_search_key.same_as (a_key)
		end

feature -- Cleaning

	clean (a_class: CLASS_C)
			-- Clean the list of all the removed classes
		local
			i, nb: INTEGER
			l_default: detachable CL_TYPE_A
			local_content: like content
			l_is_valid: BOOLEAN
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
				if attached local_content [i] as l_type then
					l_is_valid := l_type.is_valid
					if l_is_valid and l_type.generics /= Void then
						l_type.reset_constraint_error_list
						l_type.check_constraints (a_class, Void, False)
						l_is_valid := l_type.constraint_error_list.is_empty
					end
					if not l_is_valid then
						local_content.put (l_default, i)
						deleted_marks.put (True, i)
						count := count - 1
					end
				end
				i := i + 1
			end
		end

note
	copyright:	"Copyright (c) 1984-2010, Eiffel Software"
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
