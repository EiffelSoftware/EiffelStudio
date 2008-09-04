indexing
	description: "[
		Objects representing a {ES_TBT_GRID} layout for eiffel tests.
		
		See {ES_TBT_GRID_LAYOUT} for more information.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EIFFEL_TEST_GRID_LAYOUT

inherit
	ES_TBT_GRID_LAYOUT [EIFFEL_TEST_I]
		redefine
			project,
			is_project_available,
			populate_item_row,
			column_count
		end

create
	make

feature {NONE} -- Initialization

	make (a_test_suite: like test_suite)
			-- Initialize `Current'.
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

	column_count: NATURAL = 2

	is_project_available: BOOLEAN
			-- <Precursor>
		do
			Result := test_suite.is_service_available and then
				test_suite.service.is_project_initialized
		end

feature -- Factory

	populate_item_row (a_row: !EV_GRID_ROW; a_item: !EIFFEL_TEST_I) is
			-- <Precursor>
		local
			l_class: CLASS_I
			l_feature: E_FEATURE
			l_eitem: EB_GRID_EDITOR_TOKEN_ITEM
			l_label: EV_GRID_LABEL_ITEM
			l_tooltip: STRING
			l_outcome: TEST_OUTCOME
		do
			create l_tooltip.make_empty
			if a_item.is_outcome_available then
				l_outcome := a_item.last_outcome
				if l_outcome.setup_response /= Void then
					l_tooltip.append ("setup: ")
					append_response (l_tooltip, {!TEST_INVOCATION_RESPONSE} #? l_outcome.setup_response)
					if l_outcome.test_response /= Void then
						l_tooltip.append ("test: ")
						append_response (l_tooltip, {!TEST_INVOCATION_RESPONSE} #? l_outcome.test_response)
						if l_outcome.teardown_response /= Void then
							l_tooltip.append ("teardown: ")
							append_response (l_tooltip, {!TEST_INVOCATION_RESPONSE} #?  l_outcome.teardown_response)
						end
					end
				else
					l_tooltip.append ("execution failed...")
				end
			else
				l_tooltip.append ("not tested yet")
			end

			token_writer.new_line
			l_class := class_of_name (a_item.class_name)
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
						create l_label.make_with_text ("failing")
					elseif a_item.last_outcome.is_pass then
						create l_label.make_with_text ("passing")
					else
						create l_label.make_with_text ("unresolved")
					end
				else
					create l_label.make_with_text ("not tested")
				end
			end
			l_label.set_tooltip (l_tooltip)
			a_row.set_item (2, l_label)
		end

	append_response (a_string: !STRING; a_response: !TEST_INVOCATION_RESPONSE) is
			-- Append texual representation for `a_responce'.
		local
			l_exception: TEST_INVOCATION_EXCEPTION
		do
			if a_response.is_exceptional then
				a_string.append ("exceptional%N{")
				l_exception := a_response.exception
				a_string.append (l_exception.class_name)
				a_string.append ("}.")
				a_string.append (l_exception.recipient_name)
				a_string.append (" ")
				a_string.append_integer (l_exception.code)
				a_string.append (":")
				a_string.append (l_exception.tag_name)
				a_string.append ("%N%N")
			else
				a_string.append ("normal%N%N")
			end
			if not a_response.output.is_empty then
				a_string.append ("output:%N")
				a_string.append ("--------------------------------%N")
				a_string.append (a_response.output)
				a_string.append ("%N--------------------------------")
				a_string.append ("%N%N")
			end
		end

end
