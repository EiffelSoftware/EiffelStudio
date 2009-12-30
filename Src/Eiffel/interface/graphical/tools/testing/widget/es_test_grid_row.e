note
	description: "[
		Grid row that can be used as a subrow of {ES_TEST_RECORD_GRID_ROW} displaying a single test.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_TEST_GRID_ROW

inherit
	ES_SHARED_TEST_GRID_UTILITIES

	EB_SHARED_PIXMAPS

create
	make, make_attached

feature {NONE} -- Initialization

	make (a_test_name: like test_name; a_row: like row)
			-- Initialize `Current'.
			--
			-- `a_test_name': Name of test displayed by `Current'.
			-- `a_row': Grid row.
		require
			a_test_name_attached: a_test_name /= Void
			a_row_attached: a_row /= Void
		do
			test_name := a_test_name
			row := a_row
			row.set_data (Current)
			refresh
		ensure
			test_name_set: test_name = a_test_name
			row_set: row = a_row
		end

	make_attached (a_test: like test; a_row: like row)
			-- Initialize `Current' attached.
			--
			-- `a_test': Test displayed by `Current'.
			-- `a_row': Grid row.
		require
			a_test_attached: a_test /= Void
			a_row_attached: a_row /= Void
			a_test_usable: a_test.is_interface_usable
		do
			internal_test := a_test
			make (a_test.name, a_row)
		end

feature -- Access

	test_name: READABLE_STRING_8
			-- Name of test displayed in `Current'

	test: TEST_I
			-- Test displayed by `Current'
		require
			is_attached: is_attached
		local
			l_test: like internal_test
		do
			l_test := internal_test
			check l_test /= Void end
			Result := l_test
		ensure
			result_usable: Result.is_interface_usable
			result_valid: Result.name.same_string (test_name)
		end

	row: EV_GRID_ROW
			-- Row in which `test' is displayed

	pixmap: detachable EV_PIXMAP
			-- Pixmap shown in first item of `row'
		do
		end

feature {NONE} -- Access

	grid: EV_GRID
			-- <Precursor>
		do
			Result := row.parent
		end

	internal_test: detachable like test
			-- Internal storage for `test'

feature -- Status report

	is_attached: BOOLEAN
			-- Is a test instance attached to `Current'.
		do
			Result := internal_test /= Void
		end

feature -- Status setting

	attach_test (a_test: like test)
			-- Attached given test to `Current'.
			--
			-- `a_test': Test instance displayed by `Current'.
		require
			a_test_attached: a_test /= Void
			a_test_usable: a_test.is_interface_usable
			a_test_valid: a_test.name.same_string (test_name)
			not_attached: not is_attached
		do
			internal_test := a_test
			refresh
		ensure
			is_attached: is_attached
			test_set: test = a_test
		end

	detach_test
			-- Detach `test' from `Current'.
		require
			is_attached: is_attached
		do
			internal_test := Void
			refresh
		ensure
			not_attached: not is_attached
		end

feature {NONE} -- Implementation

	refresh
			-- Refresh contents of `row'.
		local
			l_token_writer: like token_writer
			l_eitem: EB_GRID_EDITOR_TOKEN_ITEM
		do
			l_token_writer := token_writer
			print_test
			create l_eitem
			l_eitem.set_text_with_tokens (l_token_writer.last_line.content)
			reset_token_writer
			if attached pixmap as l_pixmap then
				l_eitem.set_pixmap (l_pixmap)
			end
			row.set_item (1, l_eitem)
		end

	print_test
			-- Print test name to `token_writer'.
		do
			if is_attached then
				test.print_test (token_writer)
			else
				token_writer.process_basic_text (test_name.as_string_8)
			end
		end

invariant
	valid_test_name: attached internal_test as l_test implies
		(l_test.is_interface_usable and then l_test.name.same_string (test_name))

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
