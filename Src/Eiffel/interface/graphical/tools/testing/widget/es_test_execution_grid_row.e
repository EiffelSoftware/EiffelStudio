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
	ES_TEST_RECORD_GRID_ROW [TEST_EXECUTION_I, TEST_EXECUTION_RECORD]
		redefine
			make_running,
			detach_session,
			show_content
		end

	TEST_EXECUTION_OBSERVER
		redefine
			on_test_executed,
			on_test_removed
		end

	SHARED_TEST_SERVICE

create
	make, make_running

feature {NONE} -- Initialization

	make_running (a_session: like session; a_row: like row; a_icons_provider: like icons_provider)
			-- <Precursor>
		do
			Precursor (a_session, a_row, a_icons_provider)
			session.execution_connection.connect_events (Current)
		end

feature {NONE} -- Access

	pixmap: EV_PIXMAP
			-- <Precursor>
		do
			Result := icon_pixmaps.debug_run_icon
		end

	label: STRING
			-- <Precursor>
		local
			l_count: INTEGER
		do
			if is_running then
				l_count := session.initial_test_count.to_integer_32
			else
				l_count := record.tests.count
			end
			Result := "Execute " + l_count.out + " Tests"
		end

feature {NONE} -- Status report

	is_expandable: BOOLEAN = True
			-- <Precursor>

feature {NONE} -- Basic operations

	show_content
			-- <Precursor>
		do
			Precursor
			record.tests.do_all (
				agent (a_test_name: READABLE_STRING_8)
					do
						append_result (a_test_name, record.result_for_name (a_test_name))
					end)
		end

feature {ES_TEST_RECORDS_TAB} -- Status setting

	detach_session
			-- <Precursor>
		do
			session.execution_connection.disconnect_events (Current)
			Precursor
		end

feature {TEST_EXECUTION_I} -- Events

	on_test_executed (a_session: TEST_EXECUTION_I; a_test: TEST_I; a_result: EQA_RESULT)
			-- <Precursor>
		do
			append_result (a_test.name, a_result)
		end

	on_test_removed (a_session: TEST_EXECUTION_I; a_test: TEST_I)
			-- <Precursor>
		do
			append_result (a_test.name, Void)
		end

feature {NONE} -- Implementation

	append_result (a_test: READABLE_STRING_8; a_result: detachable EQA_RESULT)
		local
			l_row: like row
			l_pos: INTEGER
			l_label: EV_GRID_LABEL_ITEM
			l_do_expansion: BOOLEAN
			l_pixmap: detachable EV_PIXMAP
		do
			if is_expanded then
				l_row := row
				l_do_expansion := l_row.subrow_count_recursive = 0 and not l_row.is_expanded
				l_pos := 1 + l_row.subrow_count
				l_row.insert_subrow (l_pos)

				if a_result /= Void then
					create l_label.make_with_text (a_result.tag.as_string_8)
					if a_result.is_pass then
						l_pixmap := icon_pixmaps.general_tick_icon
					elseif a_result.is_fail then
						l_pixmap := icon_pixmaps.general_error_icon
					else
						l_pixmap := icon_pixmaps.general_warning_icon
					end
				else
					create l_label.make_with_text ("aborted")
				end
				perform_with_test_suite (agent assign_item (a_test, l_pixmap, l_row.subrow (l_pos), ?))
				l_row.subrow (l_pos).set_item (2, l_label)

				if l_do_expansion then
					l_row.expand
				end
			end
		end

	assign_item (a_test: READABLE_STRING_GENERAL; a_pixmap: detachable EV_PIXMAP; a_row: EV_GRID_ROW; a_test_suite: TEST_SUITE_S)
		local
			l_eitem: EB_GRID_EDITOR_TOKEN_ITEM
			l_test: TEST_I
		do
			create l_eitem
			token_writer.wipe_out_lines
			if a_test_suite.has_test (a_test) then
				l_test := a_test_suite.test (a_test)
				l_test.print_test (token_writer)
			else
				token_writer.process_basic_text (a_test.as_string_8)
			end
			l_eitem.set_text_with_tokens (token_writer.last_line.content)
			if a_pixmap /= Void then
				l_eitem.set_pixmap (a_pixmap)
			end
			a_row.set_item (1, l_eitem)
		end

feature {NONE}

	token_writer: EB_EDITOR_TOKEN_GENERATOR
		once
			create Result.make
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
