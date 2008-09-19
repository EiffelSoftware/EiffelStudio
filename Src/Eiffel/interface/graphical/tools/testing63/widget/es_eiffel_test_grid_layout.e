indexing
	description: "[
		Objects representing a {ES_TAGABLE_GRID} layout for eiffel tests.
		
		See {ES_TAGABLE_GRID_LAYOUT} for more information.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EIFFEL_TEST_GRID_LAYOUT

inherit
	ES_TAGABLE_GRID_LAYOUT [!EIFFEL_TEST_I]
		redefine
			project,
			is_project_available,
			column_width,
			populate_item_row,
			column_count
		end

create
	make

feature {NONE} -- Initialization

	make (a_test_suite: like test_suite)
			-- Initialize `Current'.
			--
			-- `a_test_suite': Test suite from which project data is retrieved.
		do
			test_suite := a_test_suite
		ensure
			test_suite_set: test_suite = a_test_suite
		end

feature {NONE} -- Access

	project: !E_PROJECT
			-- <Precursor>
		do
			Result := test_suite.service.eiffel_project
		end

	test_suite: SERVICE_CONSUMER [EIFFEL_TEST_SUITE_S]
			-- Consumer for test suite service

feature -- Status report

	column_count: INTEGER = 3
			-- <Precursor>

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
				Result := 70
			when last_tested_column then
				Result := 100
			end
		end

feature -- Basic functionality

	populate_item_row (a_row: !EV_GRID_ROW; a_item: !EIFFEL_TEST_I) is
			-- <Precursor>
		local
			l_class: CLASS_I
			l_feature: E_FEATURE
			l_eitem: EB_GRID_EDITOR_TOKEN_ITEM
			l_label: EV_GRID_LABEL_ITEM
			l_tooltip: STRING
		do
			create l_tooltip.make_empty

			token_writer.new_line
			l_class := class_from_name (a_item.class_name, Void)
			if l_class /= Void then
				if l_class.is_compiled then
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
			l_eitem.set_tooltip (l_tooltip)
			a_row.set_item (1, l_eitem)

			if a_item.is_queued then
				create l_label.make_with_text ("?")
			elseif a_item.is_running then
				create l_label.make_with_text ("-->")
			else
				if a_item.is_outcome_available then
					if a_item.last_outcome.is_fail then
						create l_label
						l_label.set_pixmap (pixmaps.icon_pixmaps.general_delete_icon)
					elseif a_item.last_outcome.is_pass then
						create l_label
						l_label.set_pixmap (pixmaps.icon_pixmaps.general_tick_icon)
					else
						create l_label.make_with_text ("unresolved")
					end
				else
					create l_label.make_with_text ("not tested")
				end
			end
			l_label.set_tooltip (l_tooltip)
			a_row.set_item (status_column, l_label)

			if a_item.is_outcome_available then
				create l_label.make_with_text (a_item.last_outcome.date.out)
				l_label.align_text_right
			else
				create l_label
			end
			a_row.set_item (last_tested_column, l_label)
		end

feature {NONE} -- Constants

	status_column: INTEGER = 2
	last_tested_column: INTEGER = 3

end
