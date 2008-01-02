indexing
	description: "Dialog to Open a project"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_OPEN_PROJECT_DIALOG

inherit
	ANY

	EB_CONSTANTS
		export
			{NONE} all
		end

	EB_SHARED_PREFERENCES
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_parent: like parent_window) is
			-- Create dialog based on `a_parent'.
		require
			a_parent_not_void: a_parent /= Void
			a_parent_not_destroyed: not a_parent.is_destroyed
		local
			l_frame: EV_FRAME
			l_main_container: EV_VERTICAL_BOX
			l_buttons_box, l_hbox: EV_HORIZONTAL_BOX
		do
			parent_window := a_parent

			create dialog
			dialog.set_title (interface_names.l_open_project)
			dialog.set_icon_pixmap (pixmaps.icon_pixmaps.general_dialog_icon)
			create ok_button.make_with_text (interface_names.b_open)

			create open_project.make (dialog)
			open_project.select_actions.force_extend (agent ok_button.enable_sensitive)
			open_project.deselect_actions.force_extend (agent on_item_deselected)

			create l_frame.make_with_text (Interface_names.l_open_project)
			l_frame.extend (open_project.widget)
			create l_main_container
			l_main_container.set_border_width (Layout_constants.Small_border_size)
			l_main_container.set_padding (Layout_constants.Small_border_size)
			l_main_container.extend (l_frame)

				--| Action buttons box
			ok_button.select_actions.extend (agent on_ok)
			ok_button.set_pixmap (pixmaps.icon_pixmaps.general_open_icon)
			Layout_constants.set_default_width_for_button (ok_button)
			create cancel_button.make_with_text_and_action (Interface_names.b_Cancel, agent on_cancel)
			Layout_constants.set_default_width_for_button (cancel_button)
			create l_buttons_box
			l_buttons_box.set_padding (Layout_constants.Small_padding_size)
			l_buttons_box.enable_homogeneous
			l_buttons_box.extend (ok_button)
			l_buttons_box.extend (cancel_button)
			create l_hbox
			l_hbox.extend (create {EV_CELL})
			l_hbox.extend (l_buttons_box)
			l_hbox.disable_item_expand (l_buttons_box)
			l_main_container.extend (l_hbox)
			l_main_container.disable_item_expand (l_hbox)
			dialog.extend (l_main_container)

				--| Setting default buttons
			dialog.set_default_push_button (ok_button)
			dialog.set_default_cancel_button (cancel_button)

			dialog.set_size (preferences.dialog_data.open_project_dialog_width,
				preferences.dialog_data.open_project_dialog_height)
				--| Ensure `open_project' has focu when opened.
			dialog.show_actions.extend (agent open_project.set_focus)
		ensure
			parent_window_set: parent_window = a_parent
		end

feature -- Action

	show is
			-- Show Current to `parent_window'.
		do
			if open_project.is_empty then
				open_project.remove_selection
				ok_button.disable_sensitive
			end
			dialog.show_modal_to_window (parent_window)
		end

feature {NONE} -- Implementation: Access

	dialog: EV_DIALOG
			-- Current dialog.

	parent_window: EV_WINDOW
			-- Window used to display modally `dialog'.

	open_project: EB_OPEN_PROJECT_WIDGET
			-- Content of `dialog'.

	ok_button, cancel_button: EV_BUTTON
			-- Button for closing dialogs.

feature {NONE} -- Actions

	on_item_deselected is
			-- Handle case when an item has been deselected and whether or not
			-- the `OK' button should be activated.
		do
			if not open_project.has_selected_item then
				ok_button.disable_sensitive
			else
				ok_button.enable_sensitive
			end
		end

	on_cancel is
			-- Cancel button has been pressed
		do
			update_preferences
			dialog.destroy
		end

	on_ok is
			-- Ok button has been pressed
		local
			l_pointer: EV_POINTER_STYLE
			retried: BOOLEAN
		do
			if not retried then
				l_pointer := dialog.pointer_style
				dialog.set_pointer_style (create {EV_POINTER_STYLE}.make_predefined ({EV_POINTER_STYLE_CONSTANTS}.busy_cursor))

				update_preferences

					-- Open an existing project
				if open_project.has_selected_item and not open_project.has_error then
					open_project.open_project
				else
					check no_item_selected: False end
				end
			else
				if l_pointer /= Void then
					dialog.set_pointer_style (l_pointer)
				end
			end
		end

	update_preferences is
			-- Update size preferences.
		require
			dialog_not_void: dialog /= Void
			dialog_not_destroyed: not dialog.is_destroyed
		do
			preferences.dialog_data.open_project_dialog_width_preference.set_value (dialog.width)
			preferences.dialog_data.open_project_dialog_height_preference.set_value (dialog.height)
		end

invariant
	dialog_not_void: dialog /= Void
	parent_window_not_void: parent_window /= Void
	open_project_not_void: open_project /= Void
	ok_button_not_void: ok_button /= Void
	cancel_button_not_void: cancel_button /= Void

end
