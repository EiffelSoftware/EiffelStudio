note
	description: "[
		Grid row visualizing execution record/state.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_TEST_EXECUTION_GRID_ROW

inherit
	ES_TEST_SESSION_GRID_ROW [TEST_EXECUTION_I]
		redefine
			attach_session,
			detach_session
		end

	TEST_EXECUTION_OBSERVER
		redefine
			on_test_executed,
			on_test_removed
		end

create
	make

feature {NONE} -- Status report

	is_expandable: BOOLEAN = True
			-- <Precursor>

feature {NONE} -- Basic operations

	fill_row
			-- <Precursor>
		local
			l_label: EV_GRID_LABEL_ITEM
		do
			create l_label.make_with_text (record.creation_date.formatted_out (record.creation_date.default_format_string))
			row.set_item (1, l_label)
		end

	fill_subrows
			-- <Precursor>
		do
		end

feature {ES_TEST_SESSION_WIDGET} -- Status setting

	attach_session (a_session: like session)
			-- <Precursor>
		do
			Precursor (a_session)
			a_session.execution_connection.connect_events (Current)
		end

	detach_session
			-- <Precursor>
		do
			session.execution_connection.disconnect_events (Current)
			Precursor
		end

feature {TEST_EXECUTION_I} -- Events

	on_test_executed (a_session: TEST_EXECUTION_I; a_test: TEST_I; a_result: EQA_RESULT)
			-- <Precursor>
		local
			l_grid: detachable EV_GRID
			l_pos: INTEGER
			l_label: EV_GRID_LABEL_ITEM
		do
			l_grid := row.parent
			check l_grid /= Void end
			l_pos := row.index + 1 + row.subrow_count_recursive
			l_grid.insert_new_row_parented (l_pos, row)
			create l_label.make_with_text ((a_test.name + " " + a_result.tag).as_string_32)
			l_grid.row (l_pos).set_item (1, l_label)
		end

	on_test_removed (a_session: TEST_EXECUTION_I; a_test: TEST_I)
			-- <Precursor>
		local
			l_grid: detachable EV_GRID
			l_pos: INTEGER
			l_label: EV_GRID_LABEL_ITEM
		do
			l_grid := row.parent
			check l_grid /= Void end
			l_pos := row.index + 1 + row.subrow_count_recursive
			l_grid.insert_new_row_parented (l_pos, row)
			create l_label.make_with_text ((a_test.name + " aborted").as_string_32)
			l_grid.row (l_pos).set_item (1, l_label)
		end

feature {NONE} -- Clean up

	internal_recycle
			-- <Precursor>
		do
			if is_running then
				detach_session
			end
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
