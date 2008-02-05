indexing
	description: "List of existing tests"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	LIST_TEST

inherit
	DS_HASH_TABLE [STRING, STRING]
		rename
			make as table_make
		end

create
	make

feature -- Initialization

	make is
			-- Initialize
		do
			table_make(2)
		end

feature

	add_tests_from_compiler_results (cr : COMPILER_RESULTS) is
			-- add additional tests if not yet in list_test
		local
			l_key,name: STRING
			test_info: TEST_INFO
		do
			from
				cr.start
			until
				cr.after
			loop
				l_key := cr.key_for_iteration
				if not has (l_key) then
					test_info := cr.item (l_key)
					name := test_info.test_real_name
					add_single_test (l_key, name)
				end
				cr.forth
			end
		end

feature
	add_single_test (a_key, a_name : STRING) is
			-- add test if not present
		do
			if not has (a_key) then
				force_last (a_name, a_key)
			end
		end

indexing
	copyright: "Copyright (c) 1984-2007, Eiffel Software"
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
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class LIST_TEST
