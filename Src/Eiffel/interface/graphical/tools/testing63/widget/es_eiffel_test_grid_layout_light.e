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
				Result := 100
			end
		end

feature -- Basic functionality

	populate_header (a_header: !EV_GRID_HEADER) is
			-- <Precursor>
		do
			a_header.i_th (tests_column).set_text (t_tests)
			a_header.i_th (status_column).set_text (t_status)
		end

	populate_item_row (a_row: !EV_GRID_ROW; a_item: !EIFFEL_TEST_I) is
			-- <Precursor>
		local
			l_class: CLASS_I
			l_feature: E_FEATURE
			l_eitem: EB_GRID_EDITOR_TOKEN_ITEM
			l_label: EV_GRID_LABEL_ITEM
			l_tooltip: STRING
		do
			token_writer.new_line
			l_class := class_from_name (a_item.class_name, Void)
			if l_class /= Void then
				if l_class.is_compiled and then l_class.compiled_class.has_feature_table then
					l_feature := l_class.compiled_class.feature_with_name (a_item.name)
					if l_feature /= Void then
						token_writer.add_feature (l_feature, a_item.name)
					end
				end
				if token_writer.last_line.empty then
					token_writer.add_classi (l_class, a_item.name)
				end
			else
				token_writer.add (a_item.name)
			end
			create l_eitem
			l_eitem.set_text_with_tokens (token_writer.last_line.content)
			l_eitem.set_pixmap (pixmaps.icon_pixmaps.feature_routine_icon)

			create l_tooltip.make (20)
			l_tooltip.append_character ('{')
			l_tooltip.append (a_item.class_name)
			l_tooltip.append_character ('}')
			l_tooltip.append_character ('.')
			l_tooltip.append (a_item.name)
			l_eitem.set_tooltip (l_tooltip)
			a_row.set_item (1, l_eitem)

			if a_item.is_queued then
				create l_label.make_with_text ("?")
				l_tooltip := "Queued"
			elseif a_item.is_running then
				create l_label.make_with_text ("-->")
				l_tooltip := "Running"
			else
				if a_item.is_outcome_available then
					if a_item.last_outcome.is_fail then
						create l_label
						l_label.set_pixmap (pixmaps.icon_pixmaps.general_error_icon)
						l_tooltip := "Fails"
					elseif a_item.last_outcome.is_pass then
						create l_label
						l_label.set_pixmap (pixmaps.icon_pixmaps.general_tick_icon)
						l_tooltip := "Passes"
					else
						create l_label
						l_label.set_pixmap (pixmaps.icon_pixmaps.general_warning_icon)
						l_tooltip := "Unresolved"
					end
				else
					create l_label.make_with_text ("not tested")
					l_tooltip := "Test has not been executed yet"
				end
			end
			l_label.set_tooltip (l_tooltip)
			a_row.set_item (status_column, l_label)
		end


feature {NONE} -- Constants


	t_tests: STRING = "Tests"
	t_status: STRING = "Status"

	tests_column: INTEGER = 1
	status_column: INTEGER = 2


end
