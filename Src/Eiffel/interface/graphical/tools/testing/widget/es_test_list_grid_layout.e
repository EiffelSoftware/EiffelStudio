note
	description: "Summary description for {ES_TEST_LIST_GRID_LAYOUT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_TEST_LIST_GRID_LAYOUT

inherit
	ES_TAGABLE_GRID_LAYOUT [TEST_I]
		redefine
			project,
			is_project_available,
			column_width,
			populate_item_row,
			column_count,
			populate_header
		end

	SHARED_TEST_SERVICE

	EV_STOCK_COLORS
		export
			{NONE} all
		end

	ES_SHARED_LOCALE_FORMATTER
		export
			{NONE} all
		end

	EB_SHARED_WINDOW_MANAGER
		export
			{NONE} all
		end

	EXCEPTION_CODE_MEANING
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_icon_provider: like icon_provider)
			-- Initialize `Current'.
		require
			a_icon_provider_usable: a_icon_provider.is_interface_usable
		do
			icon_provider := a_icon_provider
		ensure
			icon_provider_set: icon_provider = a_icon_provider
		end

feature {NONE} -- Access

	project: E_PROJECT
			-- <Precursor>
		do
			Result := test_suite.service.eiffel_project
		end

feature -- Status report

	column_count: INTEGER
			-- <Precursor>
		do
			Result := 2
		end

	is_project_available: BOOLEAN
			-- <Precursor>
		do
			Result := test_suite.is_service_available and then
				test_suite.service.is_project_initialized
		end

	column_width (a_index: INTEGER): INTEGER
			-- <Precursor>
		do
			inspect
				a_index
			when status_column then
				Result := 190
			else

			end
		end

feature {NONE} -- Query

	status_icon (a_test: TEST_I): detachable EV_PIXMAP
			-- Icon representing status of `a_test'.
		do
			if not (a_test.is_queued or a_test.is_running) and a_test.is_outcome_available then
				if a_test.last_outcome.is_pass then
					Result := pixmaps.icon_pixmaps.general_tick_icon
				elseif a_test.last_outcome.is_fail then
					Result := pixmaps.icon_pixmaps.general_error_icon
				else
					Result := pixmaps.icon_pixmaps.general_warning_icon
				end
			end
		end

	status_text (a_test: TEST_I): STRING_32
			-- Status text for `a_test'.
		local
			l_outcome: EQA_TEST_RESULT
		do
			if a_test.is_queued then
				Result := locale_formatter.translation (l_queued)
			elseif a_test.is_running then
				Result := locale_formatter.translation (l_running)
			else
				if a_test.is_outcome_available then
					l_outcome := a_test.last_outcome
					if not l_outcome.is_pass then
						if l_outcome.has_response then
							if l_outcome.is_setup_clean then
								Result := exception_text (l_outcome.test_response.exception)
							else
								Result := exception_text (l_outcome.setup_response.exception)
							end
						else
							if l_outcome.is_user_abort then
								Result := locale_formatter.translation (l_user_aborted)
							elseif l_outcome.is_communication_error then
									-- TODO: use `locale_formatter' for this in 6.5
								Result := ("communication error").to_string_32
							else
								Result := locale_formatter.translation (l_aborted)
							end
						end
					else
						create Result.make_empty
					end
				else
					Result := locale_formatter.translation (l_not_tested)
				end
			end
		end

	exception_text (a_exception: EQA_TEST_INVOCATION_EXCEPTION): STRING_32
			-- Text describing for given expception
		require
			a_exception_attached: a_exception /= Void
		local
			l_tag: READABLE_STRING_8
		do
			create Result.make (a_exception.tag_name.count + 2)
			Result.append_character (' ')
			Result.append_character ('(')
			l_tag := a_exception.tag_name
			if l_tag.is_empty then
				Result.append (exception_code_meaning (a_exception.code))
			else
				Result.append (l_tag)
			end
			Result.append_character (')')
		end

	status_tooltip (a_test: TEST_I): STRING_32
			-- Tooltip for status of `a_test'.
		local
			l_outcome: EQA_TEST_RESULT
		do
			if a_test.is_queued then
				Result := locale_formatter.translation (tt_queued)
			elseif a_test.is_running then
				Result := locale_formatter.translation (tt_running)
			else
				if a_test.is_outcome_available then
					l_outcome := a_test.last_outcome
					if not l_outcome.is_pass then
						create Result.make (20)
						if l_outcome.has_response then
							if l_outcome.is_setup_clean then
								Result.append (locale_formatter.translation (tt_fails))
								Result.append (exception_text (l_outcome.test_response.exception))
							else
								Result.append (locale_formatter.translation (tt_unresolved))
								Result.append (exception_text (l_outcome.setup_response.exception))
							end
						else
							if l_outcome.is_user_abort then
								Result.append (locale_formatter.translation (tt_user_aborted))
							elseif l_outcome.is_communication_error then
									-- TODO: use `locale_formatter' for this in 6.5
								Result.append_string_general ("communication error")
							else
								Result.append (locale_formatter.translation (tt_aborted))
							end
						end
					else
						Result := locale_formatter.translation (tt_passes)
					end
				else
					Result := locale_formatter.translation (tt_not_tested)
				end
			end
		end

feature {NONE} -- Helpers

	icon_provider: ES_TOOL_ICONS_PROVIDER_I [ES_TESTING_TOOL_ICONS]
			-- Access to the icons provided by the testing tool.

feature -- Basic operations

	populate_header (a_header: EV_GRID_HEADER)
			-- <Precursor>
		do
			a_header.i_th (tests_column).set_text (locale_formatter.translation (t_tests))
			a_header.i_th (status_column).set_text (locale_formatter.translation (t_status))
		end

	populate_item_row (a_row: EV_GRID_ROW; a_item: TEST_I)
			-- <Precursor>
		do
			a_row.set_item (tests_column, test_item (a_item))
			a_row.set_item (status_column, status_item (a_item))
		end

feature {NONE} -- Implementation

	test_item (a_test: TEST_I): EV_GRID_ITEM
			-- Item representing `a_test'.
		local
			l_class: CLASS_I
			l_feature: E_FEATURE
			l_eitem: EB_GRID_EDITOR_TOKEN_ITEM
			l_tooltip: STRING
		do
			token_writer.new_line
			if test_suite.is_service_available and then test_suite.service.is_project_initialized then
				--l_class := test_suite.service.class_for_test (a_test)
			end
			if l_class /= Void then
				if l_class.is_compiled and then l_class.compiled_class.has_feature_table then
					l_feature := l_class.compiled_class.feature_with_name (a_test.routine_name.as_string_8)
					if l_feature /= Void then
						token_writer.add_feature (l_feature, a_test.routine_name.as_string_8)
					end
				end
				if token_writer.last_line.empty then
					token_writer.add_classi (l_class, a_test.routine_name.as_string_8)
				end
			else
				token_writer.add (a_test.routine_name.as_string_8)
			end

			append_class_name (a_test)

			create l_eitem
			l_eitem.set_text_with_tokens (token_writer.last_line.content)
			l_eitem.set_pixmap (icon_provider.icons.test_routine_icon)

			create l_tooltip.make (20)
			l_tooltip.append_character ('{')
			l_tooltip.append (a_test.class_name)
			l_tooltip.append_character ('}')
			l_tooltip.append_character ('.')
			l_tooltip.append (a_test.routine_name.as_string_8)
			l_eitem.set_tooltip (l_tooltip)
			Result := l_eitem
		end

	status_item (a_test: TEST_I): EV_GRID_ITEM
			-- Add status item to row for given tast at index `status_column'.
		local
			l_tooltip: STRING
			l_label: EV_GRID_LABEL_ITEM
			l_icon: EV_PIXMAP
		do
			create l_label
			l_label.set_foreground_color (exception_tag_color)
			l_label.set_text (status_text (a_test))
			l_label.set_tooltip (status_text (a_test))
			l_icon := status_icon (a_test)
			if l_icon /= Void then
				l_label.set_pixmap (l_icon)
			end
			l_label.set_tooltip (l_tooltip)
			Result := l_label
		end

	append_class_name (a_test: TEST_I)
			-- Item showing class for `a_test'.
		local
			l_class: detachable EIFFEL_CLASS_I
		do
			token_writer.add_space
			token_writer.add_char ('(')
			--l_class := test_suite.service.class_for_test (a_test)
			if l_class /= Void then
				token_writer.add_class (l_class)
			else
				token_writer.add_string (a_test.class_name)
			end
			token_writer.add_char (')')
		end

feature {NONE} -- Internationalization

	t_tests: STRING = "Tests"
	t_status: STRING = "Status"

	tt_queued: STRING = "Queued"
	tt_running: STRING = "Running"
	tt_passes: STRING = "Passes"
	tt_fails: STRING = "Fails"
	tt_unresolved: STRING = "Unresolved"
	l_not_tested: STRING = "not tested"
	tt_not_tested: STRING = "Test has not been executed yet"
	l_aborted: STRING = "no response"
	tt_aborted: STRING = "Testing tool was unable to retrieve any response for test"
	l_user_aborted: STRING = "user abort"
	tt_user_aborted: STRING = "Test execution was canceled by user"

feature {NONE} -- Constants

	l_queued: STRING = "?"
	l_running: STRING = "-->"

	tests_column: INTEGER = 1
	status_column: INTEGER = 2

	exception_tag_color: EV_COLOR
			-- Color for displaying exception tag
		do
			Result := grey
		end

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
