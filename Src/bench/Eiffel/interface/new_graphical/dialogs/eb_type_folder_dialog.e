indexing
	description	: "Dialog to type the name of a folder."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_TYPE_FOLDER_DIALOG

inherit
	EV_DIALOG
		export
			{NONE} all
			{ANY} show_modal_to_window
		end

	EB_CONSTANTS
		export
			{NONE} all
		undefine
			default_create, copy
		end

	EB_VISION2_FACILITIES
		export
			{NONE} all
		undefine
			default_create, copy
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize the dialog
		do
			default_create
			set_title (Interface_names.t_Choose_folder_name)
			prepare
		end

	prepare is
			-- Create the controls and setup the layout
		local
			buttons_box: EV_VERTICAL_BOX
			controls_box: EV_VERTICAL_BOX
			hb: EV_HORIZONTAL_BOX
			label: EV_LABEL
		do
				-- Create the button box
			create buttons_box
			buttons_box.set_padding (Layout_constants.Default_padding_size)
			buttons_box.set_border_width (Layout_constants.Default_padding_size)
	
			create ok_button.make_with_text_and_action (Interface_names.b_Ok, ~on_ok)
			extend_button (buttons_box, ok_button)

			create cancel_button.make_with_text_and_action (Interface_names.b_Cancel, ~on_cancel)
			extend_button (buttons_box, cancel_button)

				-- Create the controls
			create folder_name_entry
			create label.make_with_text (Interface_names.l_Enter_folder_name)
			
				-- Create the left panel: a Combo Box to type the name of the class
				-- and a tree to select the class.
			create controls_box
			controls_box.set_padding (Layout_constants.Small_padding_size)
			controls_box.set_border_width (Layout_constants.Default_padding_size)
			extend_no_expand (controls_box, label)
			extend_no_expand (controls_box, folder_name_entry)
			controls_box.extend (create {EV_CELL})

				-- Pack the buttons_box and the controls.
			create hb
			hb.extend (controls_box)
			extend_no_expand (hb, buttons_box)
			extend (hb)
			set_default_push_button (ok_button)
			set_default_cancel_button (cancel_button)
			show_actions.extend (folder_name_entry~set_focus)
		end

feature -- Access

	selected: BOOLEAN
			-- Has the user selected a class (True) or pushed
			-- the cancel button (False)

	folder_name: STRING
			-- Folder name entered by the user, if any.

feature {NONE} -- Vision2 events

	on_ok is
			-- Terminate the dialog
		local
			wd: EV_WARNING_DIALOG
		do
			folder_name := folder_name_entry.text
			if folder_name = Void then
				create wd.make_with_text (Warning_messages.w_Invalid_folder_name)
				wd.show_modal_to_window (Current)
			else
				selected := True
				destroy
			end
		end

	on_cancel is
			-- Terminate the dialog and clear the selection.
		do
			selected := False
			folder_name := ""
			destroy
		end

feature {NONE} -- Controls

	ok_button: EV_BUTTON
			-- "Ok" button

	cancel_button: EV_BUTTON
			-- "Cancel" button

	folder_name_entry: EV_TEXT_FIELD
			-- Text field where the user can type its folder name.

end -- class EB_TYPE_FOLDER_DIALOG
	
