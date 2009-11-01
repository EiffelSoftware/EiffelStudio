note
	description: "[
		Grid row visualizing creation record/state.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_TEST_CREATION_GRID_ROW

inherit
	ES_TEST_RECORD_GRID_ROW [TEST_CREATION_I, TEST_CREATION_RECORD]
		redefine
			make_running,
			detach_session,
			show_content
		end

	TEST_CREATION_OBSERVER
		redefine
			on_test_created
		end

create
	make, make_running

feature {NONE} -- Initialization

	make_running (a_session: like session; a_row: like row; a_icons_provider: like icons_provider)
			-- <Precursor>
		do
			Precursor (a_session, a_row, a_icons_provider)
			session.creation_connection.connect_events (Current)
		end

feature {NONE} -- Access

	pixmap: EV_PIXMAP
			-- <Precursor>
		do
			Result := icons_provider.icons.general_test_icon
		end

	label: STRING
			-- <Precursor>
		do
			if is_running then
				if attached {TEST_GENERATOR} session then
					Result := "Test Generation"
				elseif attached {ETEST_EXTRACTION} session then
					Result := "Test Extraction"
				else
					Result := "Manual Test Creation"
				end
			else
				Result := "Created " + record.tests.count.out + " tests"
			end
		end

feature {NONE} -- Status report

	is_expandable: BOOLEAN = True

feature {ES_TEST_CREATION_WIDGET} -- Basic operations

	show_content
			-- <Precursor>
		do
			Precursor
			record.tests.do_all (
				agent (a_test_name: READABLE_STRING_8)
					do
						add_creation (a_test_name)
					end)
		end

feature {ES_TEST_RECORDS_TAB} -- Status setting

	detach_session
			-- <Precursor>
		do
			session.creation_connection.disconnect_events (Current)
			Precursor
		end

feature {TEST_CREATION_I} -- Events

	on_test_created (a_session: TEST_CREATION_I; a_test: READABLE_STRING_8)
			-- <Precursor>
		local
			l_row: like row
		do
			if is_expanded then
				add_creation (a_test)
				l_row := row
				if not l_row.is_expanded and l_row.is_expandable then
					l_row.expand
				end
			end
		end

feature {NONE} -- Implementation

	add_creation (a_test_name: READABLE_STRING_8)
			-- Add subrow to `row'.
		require
			a_test_name_attached: a_test_name /= Void
			is_expanded: is_expanded
		local
			l_pos: INTEGER
			l_row: like row
			l_test: detachable TEST_I
			l_subrow: ES_TEST_GRID_ROW
		do
			l_row := row
			l_pos := l_row.subrow_count + 1
			l_row.insert_subrow (l_pos)
			if a_test_name /= Void then
				l_test := test_from_name (a_test_name)
			end
			if l_test /= Void then
				create l_subrow.make_attached (l_test, l_row.subrow (l_pos))
			else
				create l_subrow.make (a_test_name, l_row.subrow (l_pos))
			end
			subrows.force_last (l_subrow, a_test_name)
		end

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
