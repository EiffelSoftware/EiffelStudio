note
	description: "[
		TTY command displaying tests in a sorted list.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EWB_TEST_LIST_VIEW

inherit
	EWB_TEST_CMD

feature -- Access

	name: STRING_8
			-- <Precursor>
		do
			Result := "List view"
		end

	abbreviation: CHARACTER
			-- <Precursor>
		do
			Result := 'l'
		end

	help_message: STRING_GENERAL
			-- <Precursor>
		do
			Result := locale.translation (h_display_list)
		end

feature {NONE} -- Query

	item_sorter: DS_SORTER [!TEST_I]
			-- Sorter for {TEST_I}.
			--
			-- Note: this sorter also takes class names in account.
		local
			l_cache: like item_sorter_cache
			l_comparator: AGENT_BASED_EQUALITY_TESTER [!TEST_I]
			l_sorter: DS_QUICK_SORTER [!TEST_I]
		do
			l_cache := item_sorter_cache
			if l_cache = Void then
				create l_comparator.make (
					agent (a_test1, a_test2: !TEST_I): BOOLEAN
						do
							if a_test1.class_name.same_string (a_test2.class_name) then
								Result := a_test1.name < a_test2.name
							else
								Result := a_test1.class_name < a_test2.class_name
							end
						end)
				create l_sorter.make (l_comparator)
				item_sorter_cache := l_sorter
				Result := l_sorter
			else
				Result := l_cache
			end
		ensure
			result_attached: Result /= Void
		end

	item_sorter_cache: ?like item_sorter
			-- Cache for `node_sorter'

feature {NONE} -- Basic operations

	execute_with_test_suite (a_test_suite: !TEST_SUITE_S)
			-- <Precursor>
		local
			l_items: DS_ARRAYED_LIST [!TEST_I]
			l_item: !TEST_I
		do
			print_current_expression (a_test_suite, False)
			create l_items.make_from_linear (filtered_tests (a_test_suite).items)
			l_items.sort (item_sorter)
			if not l_items.is_empty then
				print_string ("%N")
			end
			from
				l_items.start
			until
				l_items.after
			loop
				l_item := l_items.item_for_iteration
				print_test (l_item, l_item.class_name + ".", tab_count)
				l_items.forth
			end
			print_statistics (a_test_suite, True)
		end

feature {NONE} -- Internationalization

	h_display_list: STRING = "Display tests in a list"

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
