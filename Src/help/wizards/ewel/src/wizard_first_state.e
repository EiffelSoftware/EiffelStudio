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
			v1, v3: EV_VERTICAL_BOX
			cell: EV_CELL
		do 
			create v1
			create win_application.make_with_text ("Frame application")
			win_application.select_actions.extend (~check_sensitivity)
			v1.extend (win_application)
			create dialog_application.make_with_text ("Dialog application")
			dialog_application.select_actions.extend (~check_sensitivity)
			v1.extend (dialog_application)
			create cell
			cell.set_minimum_height (25)
			v1.extend (cell)


			create vbox_dialog
			create dialog_with_rc.make_with_text ("With a ressource file")
			vbox_dialog.extend (dialog_with_rc)
			create dialog_with_no_rc.make_with_text ("Without a ressource file")
			vbox_dialog.extend (dialog_with_no_rc)

			create h1
			h1.extend (v1)

			create v3
			create cell
			cell.set_minimum_height (25)
			v3.extend (cell)
			v3.extend (vbox_dialog)

			h1.extend (v3)
			h1.disable_item_expand (v3)

			create cell
			cell.set_minimum_width (140)
			h1.extend (cell)

			choice_box.extend (h1)
			choice_box.disable_item_expand (h1)

			if wizard_information.dialog_application then
				dialog_application.enable_select
				if wizard_information.dialog_with_no_rc then
					dialog_with_no_rc.enable_select
				end
			else
				win_application.enable_select
			end
			check_sensitivity

			set_updatable_entries(<<win_application.select_actions, dialog_application.select_actions,
									dialog_with_rc.select_actions, dialog_with_no_rc.select_actions>>)

		end

	proceed_with_current_info is 
		local
			dir: DIRECTORY
		do
			Precursor
			if dialog_application.is_selected then
				if dialog_with_no_rc.is_selected then
					proceed_with_new_state (create {WIZARD_SECOND_STATE}.make(wizard_information))
				else
					proceed_with_new_state (create {WIZARD_RESOURCE_BENCH_STATE}.make(wizard_information))
				end
			else
				proceed_with_new_state (create {WIZARD_SECOND_STATE}.make(wizard_information))
			end
		end

	update_state_information is
			-- Check User Entries
		do
			wizard_information.set_dialog_with_no_rc (dialog_with_no_rc.is_selected)
			wizard_information.set_dialog_application (dialog_application.is_selected)
			Precursor
		end


feature {NONE} -- Implementation

	display_state_text is
		do
			title.set_text ("CHOOSE TYPE OF WEL APPLICATION")
			message.set_text ("%NTo build a WEL application, you need to choose its type: Frame-Based or Dialog-Based.%N%
								%%N+ A Frame-Based Application uses a main window, or %"frame%", which can have %
								%%Nmenus, subwindows, etc. (Eiffelbench is an example of Frame-Based Application.)%
								%%NIn this case, the wizard will generate a resource file.%
								%%N%N+ A Dialog-Based Application uses a sequence of dialogs.%
								%%N(This wizard is an example of Dialog-Based Application.)%
								%%NIn this case you may specify your own resource file.%
								%")
		end

	dialog_application, win_application: EV_RADIO_BUTTON
		-- Radio buttons

	dialog_with_no_rc: EV_RADIO_BUTTON

	dialog_with_rc: EV_RADIO_BUTTON

	vbox_dialog: EV_VERTICAL_BOX
		-- vbox that contains the dialog buttons

feature -- Tool

	check_sensitivity is
			-- check and change the sensitivity for the dialog radio buttons
		do
			if win_application.is_selected then
				vbox_dialog.disable_sensitive
			else
				vbox_dialog.enable_sensitive
			end
		end

end -- class WIZARD_FIRST_STATE
