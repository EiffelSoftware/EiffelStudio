indexing
	description: "Summary description for {ES_EIFFEL_TEST_WIZARD_AUTO_TEST_WINDOW}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EIFFEL_TEST_WIZARD_AUTO_TEST_WINDOW

inherit
	ES_EIFFEL_TEST_WIZARD_FINAL_WINDOW
		redefine
			make_window
		end

create
	make_window

feature {NONE} -- Initialization

	make_window (a_development_window: like development_window; a_wizard_info: like wizard_information)
			-- <Precursor>
		do
			Precursor (a_development_window, a_wizard_info)
			create splitter.make_with_separators (" ")
		end

	build
			-- <Precursor>
		local
			l_parent: EV_BOX
			l_vb: EV_VERTICAL_BOX
			l_text_field: EV_TEXT_FIELD
		do
			l_parent := initialize_container (choice_box)
			create l_vb

			create l_text_field
			create arguments.make (l_text_field, agent on_validate_arguments)
			l_vb.extend (arguments)
			l_vb.disable_item_expand (arguments)

			l_vb.extend (create {EV_CELL})

			l_parent.extend (l_vb)
		end

feature {NONE} -- Access

	arguments: ES_VALIDATION_TEXT_FIELD
			-- Text field for new test class name

	splitter: ST_SPLITTER
			-- Splitter for `arguments'

	factory_type: !TYPE [EIFFEL_TEST_FACTORY_I]
			-- <Precursor>
		do
			Result := generator_factory_type
		end

feature {NONE} -- Status report

	is_valid: BOOLEAN
			-- <Precursor>
		do
			Result := not wizard_information.arguments.is_empty
		end

feature {NONE} -- Events

	on_validate_arguments (a_input: !STRING_32): !TUPLE [BOOLEAN, ?STRING_32]
		local
			l_list: DS_LIST [STRING]
		do
			wizard_information.arguments.wipe_out
			from
				l_list := splitter.split (a_input)
				l_list.start
			until
				l_list.after
			loop
				wizard_information.arguments.force_last (l_list.item_for_iteration.as_attached)
				l_list.forth
			end
			Result := [True, Void]
		end

feature {NONE} -- Constants

	t_title: !STRING = "Generate tests through AutoTest"
	t_subtitle: !STRING = "Define commands to run auto test"

end
