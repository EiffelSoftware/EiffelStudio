indexing
	description	: "Page in which the user choose..."
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
			create add_menu_bar.make_with_text ("Menu Bar")
			create add_tool_bar.make_with_text ("Tool Bar")
			create add_status_bar.make_with_text ("Status Bar")
			create add_about_dialog.make_with_text ("About DialogBox")

			create radio_box
			radio_box.extend (add_menu_bar)
			radio_box.disable_item_expand (add_menu_bar)
			radio_box.extend (add_tool_bar)
			radio_box.disable_item_expand (add_tool_bar)
			radio_box.extend (add_status_bar)
			radio_box.disable_item_expand (add_status_bar)
			radio_box.extend (add_about_dialog)
			radio_box.disable_item_expand (add_about_dialog)
			radio_box.extend (create {EV_CELL})

			if wizard_information.has_menu_bar then
				add_menu_bar.enable_select
			else
				add_menu_bar.disable_select
			end
			if wizard_information.has_tool_bar then
				add_tool_bar.enable_select
			else
				add_tool_bar.disable_select
			end
			if wizard_information.has_status_bar then
				add_status_bar.enable_select
			else
				add_status_bar.disable_select
			end
			if wizard_information.has_about_dialog then
				add_about_dialog.enable_select
			else
				add_about_dialog.disable_select
			end
				
			create preview_pixmap
			change_preview -- set the right pixmap depending on `dialog_information'.
			preview_pixmap.set_minimum_size (preview_pixmap.width, preview_pixmap.height)

			create hbox
			hbox.extend (radio_box)
			hbox.disable_item_expand (radio_box)
			hbox.extend (preview_pixmap)

			choice_box.extend (hbox)

			set_updatable_entries(<<
				add_menu_bar.select_actions, 
				add_tool_bar.select_actions,
				add_status_bar.select_actions,
				add_about_dialog.select_actions>>)

				-- Connect actions.
			add_menu_bar.select_actions.extend (~change_preview)
			add_tool_bar.select_actions.extend (~change_preview)
			add_status_bar.select_actions.extend (~change_preview)
			add_about_dialog.select_actions.extend (~change_preview)
		end

	change_preview is
			-- Change the pixmap used to preview the application.
		local
			fn: FILE_NAME
			bn: STRING
			index: INTEGER
		do
			create fn.make_from_string (wizard_pixmaps_path)
			bn := "Image0000"
				--| Number of characters in "Image"
			index := 5
			if add_menu_bar.is_selected then
				bn.put ('1', index + 1)
			end
			if add_tool_bar.is_selected then
				bn.put ('1', index + 2)
			end
			if add_status_bar.is_selected then
				bn.put ('1', index + 3)
			end
			if add_about_dialog.is_selected then
				bn.put ('1', index + 4)
			end
			fn.set_file_name (bn)
			fn.add_extension (pixmap_extension)
			preview_pixmap.set_with_named_file (fn)
		end

	proceed_with_current_info is 
		do
			Precursor
			proceed_with_new_state (create {WIZARD_FINAL_STATE}.make(wizard_information))
		end

	update_state_information is
			-- Check User Entries
		do
			wizard_information.set_has_menu_bar (add_menu_bar.is_selected)
			wizard_information.set_has_tool_bar (add_tool_bar.is_selected)
			wizard_information.set_has_status_bar (add_status_bar.is_selected)
			wizard_information.set_has_about_dialog (add_about_dialog.is_selected)
			Precursor
		end


feature {NONE} -- Implementation

	display_state_text is
		do
			title.set_text ("Vision2 Application Appearance")
			subtitle.set_text ("You can choose the appearance of your application.")
			message.set_text ("Click the checkboxes to change the appearance.")
		end

	add_menu_bar: EV_CHECK_BUTTON
			-- When checked, create a Dialog application

	add_status_bar: EV_CHECK_BUTTON
			-- When checked, create a Frame application

	add_tool_bar: EV_CHECK_BUTTON
			-- When checked, create a Frame application

	add_about_dialog: EV_CHECK_BUTTON
			-- When checked, create a Frame application

	vbox_dialog: EV_VERTICAL_BOX
			-- vbox that contains the dialog buttons

	preview_pixmap: EV_PIXMAP
			-- Pixmap used to preview the application.

end -- class WIZARD_FIRST_STATE
