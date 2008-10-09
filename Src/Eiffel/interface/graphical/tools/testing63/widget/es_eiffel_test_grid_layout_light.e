indexing
	description: "Summary description for {ES_EIFFEL_TEST_GRID_LAYOUT_LIGHT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EIFFEL_TEST_GRID_LAYOUT_LIGHT

inherit
	ES_TAGABLE_GRID_LAYOUT [!EIFFEL_TEST_I]
		redefine
			project,
			is_project_available,
			column_width,
			populate_item_row,
			column_count,
			populate_header
		end

	ES_SHARED_EIFFEL_TEST_SERVICE
		export
			{NONE} all
		end

	EV_STOCK_COLORS
		export
			{NONE} all
		end

	ES_SHARED_LOCALE_FORMATTER
		export
			{NONE} all
		end

feature {NONE} -- Access

	project: !E_PROJECT
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
			end
		end

feature {NONE} -- Query

	status_icon (a_test: !EIFFEL_TEST_I): ?EV_PIXMAP
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

	status_text (a_test: !EIFFEL_TEST_I): !STRING_32
			-- Status text for `a_test'.
		local
			l_outcome: EQA_TEST_OUTCOME
		do
			if a_test.is_queued then
				Result := local_formatter.translation (l_queued)
			elseif a_test.is_running then
				Result := local_formatter.translation (l_running)
			else
				if a_test.is_outcome_available then
					l_outcome := a_test.last_outcome
					if not l_outcome.is_pass then
						if l_outcome.is_setup_clean then
							Result := exception_text (l_outcome.test_response.exception)
						else
							Result := exception_text (l_outcome.setup_response.exception)
						end
					else
						create Result.make_empty
					end
				else
					Result := local_formatter.translation (l_not_tested)
				end
			end
		end

	exception_text (a_exception: !EQA_TEST_INVOCATION_EXCEPTION): !STRING_32
			-- Text describing for given expception
		do
			create Result.make (a_exception.tag_name.count + 2)
			Result.append_character (' ')
			Result.append_character ('(')
			Result.append (a_exception.tag_name)
			Result.append_character (')')
		end

	status_tooltip (a_test: !EIFFEL_TEST_I): !STRING_32
			-- Tooltip for status of `a_test'.
		local
			l_outcome: EQA_TEST_OUTCOME
		do
			if a_test.is_queued then
				Result := local_formatter.translation (tt_queued)
			elseif a_test.is_running then
				Result := local_formatter.translation (tt_running)
			else
				if a_test.is_outcome_available then
					l_outcome := a_test.last_outcome
					if not l_outcome.is_pass then
						create Result.make (20)
						if l_outcome.is_setup_clean then
							Result.append (local_formatter.translation (tt_fails))
							Result.append (exception_text (l_outcome.test_response.exception))
						else
							Result.append (local_formatter.translation (tt_unresolved))
							Result.append (exception_text (l_outcome.setup_response.exception))
						end
					else
						Result := local_formatter.translation (tt_passes)
					end
				else
					Result := local_formatter.translation (tt_not_tested)
				end
			end
		end

feature -- Basic functionality

	populate_header (a_header: !EV_GRID_HEADER) is
			-- <Precursor>
		do
			a_header.i_th (tests_column).set_text (local_formatter.translation (t_tests))
			a_header.i_th (status_column).set_text (local_formatter.translation (t_status))
		end

	populate_item_row (a_row: !EV_GRID_ROW; a_item: !EIFFEL_TEST_I) is
			-- <Precursor>
		do
			a_row.set_item (tests_column, test_item (a_item))
			a_row.set_item (status_column, status_item (a_item))
		end

feature {NONE} -- Implementation

	test_item (a_test: !EIFFEL_TEST_I): EV_GRID_ITEM
			-- Item representing `a_test'.
		local
			l_class: CLASS_I
			l_feature: E_FEATURE
			l_eitem: EB_GRID_EDITOR_TOKEN_ITEM
			l_tooltip: STRING
		do
			token_writer.new_line
			if test_suite.is_service_available and then test_suite.service.is_project_initialized then
				l_class := test_suite.service.class_for_test (a_test)
			end
			if l_class /= Void then
				if l_class.is_compiled and then l_class.compiled_class.has_feature_table then
					l_feature := l_class.compiled_class.feature_with_name (a_test.name)
					if l_feature /= Void then
						token_writer.add_feature (l_feature, a_test.name)
					end
				end
				if token_writer.last_line.empty then
					token_writer.add_classi (l_class, a_test.name)
				end
			else
				token_writer.add (a_test.name)
			end

			create l_eitem
			l_eitem.set_text_with_tokens (token_writer.last_line.content)
			l_eitem.set_pixmap (pixmaps.icon_pixmaps.feature_routine_icon)

			create l_tooltip.make (20)
			l_tooltip.append_character ('{')
			l_tooltip.append (a_test.class_name)
			l_tooltip.append_character ('}')
			l_tooltip.append_character ('.')
			l_tooltip.append (a_test.name)
			l_eitem.set_tooltip (l_tooltip)
			Result := l_eitem
		end

	status_item (a_test: !EIFFEL_TEST_I): EV_GRID_ITEM
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

feature {NONE} -- Constants

	t_tests: STRING = "Tests"
	t_status: STRING = "Status"

	l_queued: STRING = "?"
	tt_queued: STRING = "Queued"
	l_running: STRING = "-->"
	tt_running: STRING = "Running"
	tt_passes: STRING = "Passes"
	tt_fails: STRING = "Fails"
	tt_unresolved: STRING = "Unresolved"
	l_not_tested: STRING = "not tested"
	tt_not_tested: STRING = "Test has not been executed yet"

	tests_column: INTEGER = 1
	status_column: INTEGER = 2

	exception_tag_color: EV_COLOR
			-- Color for displaying exception tag
		do
			Result := grey
		end

end
