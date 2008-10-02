indexing
	description: "Summary description for {ES_EIFFEL_TEST_WIZARD_INITIAL_WINDOW}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EIFFEL_TEST_WIZARD_INITIAL_WINDOW

inherit
	EB_WIZARD_INITIAL_STATE_WINDOW
		redefine
			build,
			wizard_information
		end

	ES_EIFFEL_TEST_WIZARD_WINDOW
		redefine
			wizard_information
		end

create
	make

feature {NONE} -- Initialization

	build
			-- <Precursor>
		local
			l_parent: EV_CONTAINER
		do
			Precursor

			l_parent := choice_box

			create new_class_button
			new_class_button.set_text (local_formatter.translation (b_new_class))
			new_class_button.enable_select
			new_class_button.select_actions.extend (agent on_class_button_change)
			new_class_button.set_background_color (white_color)
			l_parent.extend (new_class_button)

			create existing_class_button
			existing_class_button.set_text (local_formatter.translation (b_existing_class))
			existing_class_button.select_actions.extend (agent on_class_button_change)
			existing_class_button.set_background_color (white_color)
			l_parent.extend (existing_class_button)

			on_after_initialize
		end

	on_after_initialize
			-- Called after all widgets have been initialized.
		do
			if wizard_information.is_new_class then
				new_class_button.enable_select
			else
				existing_class_button.enable_select
			end
			update_next_button_status
		end

feature {NONE} -- Access

	wizard_information: ES_EIFFEL_TEST_WIZARD_INFORMATION
			-- Information user has provided to the wizard

feature {NONE} -- Access: widgets

	new_class_button: EV_RADIO_BUTTON
			-- Button for creating a new test class

	existing_class_button: EV_RADIO_BUTTON
			-- Button indicating that existing test class shall be used

feature {NONE} -- Status report

	is_valid: BOOLEAN = True
			-- <Precursor>

feature {NONE} -- Events

	on_class_button_change
			-- Called when `new_class_button' or `existing_class_button' are selected.
		do
			wizard_information.set_is_new_class (new_class_button.is_selected)
		end

feature -- Basic operations

	proceed_with_current_info
			-- <Precursor>
		do
			wizard_information.set_is_new_class (new_class_button.is_selected)
			if wizard_information.is_new_class then
				proceed_with_new_state(create {ES_EIFFEL_TEST_WIZARD_NEW_CLASS_WINDOW}.make (wizard_information))
			else
				proceed_with_new_state(create {ES_EIFFEL_TEST_WIZARD_CLASS_WINDOW}.make (wizard_information))
			end
		end

	display_state_text
			-- <Precursor>
		do
			title.set_text (local_formatter.translation (t_title))
			message.set_text (local_formatter.translation (m_message))
		end

feature {NONE} -- Constants

	t_title: STRING = "New eiffel test wizard"
	m_message: STRING = "This will create a new eiffel test"

	b_new_class: STRING = "Create new test class"
	b_existing_class: STRING = "Use existing test class"

end
