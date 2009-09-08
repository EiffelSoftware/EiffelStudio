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
	ES_TEST_RECORD_GRID_ROW [TEST_CREATION_I]
		redefine
			attach_session,
			detach_session
		end

	TEST_CREATION_OBSERVER
		redefine
			on_test_created
		end

create
	make

feature {NONE} -- Status report

	is_expandable: BOOLEAN = True

feature {NONE} -- Basic operations

	fill_subrows
			-- <Precursor>
		do

		end

feature {ES_TEST_RECORDS_TAB} -- Status setting

	attach_session (a_session: like session)
			-- <Precursor>
		do
			Precursor (a_session)
			a_session.creation_connection.connect_events (Current)
		end

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
			l_pos: INTEGER
			l_label: EV_GRID_LABEL_ITEM
		do
			l_pos := 1 + row.subrow_count_recursive
			row.insert_subrow (l_pos)
			create l_label.make_with_text (a_test.as_string_8)
			row.subrow (l_pos).set_item (1, l_label)
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
