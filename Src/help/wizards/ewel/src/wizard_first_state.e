indexing
	description: "Page in which the user choose where he wants to generate the sources."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_FIRST_STATE

inherit
	INTERMEDIARY_STATE_WINDOW
		redefine
			update_state_information,
			proceed_with_current_info,
			build
		end

create
	make

feature -- Basic Operation

	build is 
			-- Build entries.
				local
			browse_b: EV_BUTTON
			h1: EV_HORIZONTAL_BOX
			v1: EV_VERTICAL_BOX
		do 
			create v1
			create win_application.make_with_text ("Frame application")
			v1.extend (win_application)
			create dialog_application.make_with_text ("Dialog application")
			v1.extend (dialog_application)
			choice_box.extend (v1)
			choice_box.disable_item_expand (v1)
--			choice_box.extend (create {EV_CELL})

			if wizard_information.dialog_application then
				dialog_application.enable_select
			else
				win_application.enable_select
			end

			set_updatable_entries(<<win_application.select_actions, dialog_application.select_actions>>)

		end

	proceed_with_current_info is 
		local
			dir: DIRECTORY
		do
			Precursor
			if dialog_application.is_selected then
				proceed_with_new_state(Create {WIZARD_RESOURCE_BENCH_STATE}.make(wizard_information))
			else
				proceed_with_new_state(Create {WIZARD_SECOND_STATE}.make(wizard_information))
			end
		end

	update_state_information is
			-- Check User Entries
		do
			wizard_information.set_dialog_application (dialog_application.is_selected)
			Precursor
		end


feature {NONE} -- Implementation

	display_state_text is
		do
			title.set_text ("CHOOSE TYPE OF WEL APPLICATION")
			message.set_text ("%NTo build a WEL application, you first need to choose its type.%N%
								%%NIt can either be a frame based application or a dialog based application.%
								%%N%NIn most cases, you will probably want to create a frame based application %
								%which will generate a few basics classes in order to begin your project.%
								%%N%NTo create a dialog based application, you will have to%
								%provide a ressource file.%NThen this wizard will generate the eiffel%
								% classes according to your dialogs.")
		end

	dialog_application, win_application: EV_RADIO_BUTTON

end -- class WIZARD_FIRST_STATE
