indexing
	description	: "Page in which the user choose between a dialog and frame based application."
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	WIZARD_SECOND_STATE

inherit
	BENCH_WIZARD_INTERMEDIARY_STATE_WINDOW
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
			radio_box: EV_VERTICAL_BOX
			hbox: EV_HORIZONTAL_BOX
		do 
			create win_application.make_with_text ("Frame application")
			create dialog_application.make_with_text ("Dialog application")

			create radio_box
			radio_box.extend (win_application)
			radio_box.disable_item_expand (win_application)
			radio_box.extend (dialog_application)
			radio_box.disable_item_expand (dialog_application)
			radio_box.extend (create {EV_CELL})

			create preview_pixmap
				-- Set the right pixmap depending on `dialog_information' and 
				-- select the right radio button
			if wizard_information.dialog_application then
				preview_pixmap.set_with_named_file (Preview_dialog_pixmap)
				dialog_application.enable_select
			else
				preview_pixmap.set_with_named_file (Preview_frame_pixmap)
				win_application.enable_select
			end
			preview_pixmap.set_minimum_size (preview_pixmap.width, preview_pixmap.height)

			create hbox
			hbox.extend (radio_box)
			hbox.extend (preview_pixmap)
			choice_box.extend (hbox)
			choice_box.disable_item_expand (hbox)

			set_updatable_entries(<<win_application.select_actions, dialog_application.select_actions>>)

				-- Connect actions.
			win_application.select_actions.extend (~change_preview)
			dialog_application.select_actions.extend (~change_preview)
		end

	change_preview is
			-- Change the pixmap used to preview the application.
		do
			if dialog_application.is_selected then
				preview_pixmap.set_with_named_file (Preview_dialog_pixmap)
			else
				preview_pixmap.set_with_named_file (Preview_frame_pixmap)
			end
		end

	proceed_with_current_info is 
		do
			Precursor
			if dialog_application.is_selected then
				proceed_with_new_state (create {WIZARD_FINAL_STATE}.make(wizard_information))
			else
				proceed_with_new_state (create {WIZARD_THIRD_STATE}.make(wizard_information))
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
			title.set_text ("WEL Application Type")
			subtitle.set_text ("You can choose the type of your application between%N a Frame-based or a Dialog based window")
			message.set_text ("A Frame-Based Application uses a main window, or %"frame%", which can have %
								%%Nmenus, subwindows, etc. (EiffelStudio is an example of Frame-Based Application.)%
								%%N%NA Dialog-Based Application uses a sequence of dialogs.%
								%%N(This wizard is an example of Dialog-Based Application.)%
								%")
		end

feature {NONE} -- Constants

	Preview_dialog_pixmap: FILE_NAME is
			-- Filename for the pixmap representing a dialog-based application 
		once
			create Result.make_from_string (wizard_pixmaps_path)
			Result.set_file_name ("dialog_application")
			Result.add_extension (pixmap_extension)
		end

	Preview_frame_pixmap: FILE_NAME is
			-- Filename for the pixmap representing a frame-based application 
		once
			create Result.make_from_string (wizard_pixmaps_path)
			Result.set_file_name ("frame_application")
			Result.add_extension (pixmap_extension)
		end

feature {NONE} -- Vision2 layout

	dialog_application: EV_RADIO_BUTTON
			-- When checked, create a Dialog application

	win_application: EV_RADIO_BUTTON
			-- When checked, create a Frame application

	vbox_dialog: EV_VERTICAL_BOX
			-- vbox that contains the dialog buttons

	preview_pixmap: EV_PIXMAP
			-- Pixmap used to preview the application.

end -- class WIZARD_FIRST_STATE
