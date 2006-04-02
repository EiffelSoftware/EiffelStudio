indexing
	description	: "Command to create a new project."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_NEW_PROJECT_COMMAND

inherit
	EB_COMMAND

	PROJECT_CONTEXT
		export
			{NONE} all
		end

	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		end

	EB_SHARED_WINDOW_MANAGER
		export
			{NONE} all
		end

	EB_CONSTANTS
		export
			{NONE} all
		end

	COMMAND_EXECUTOR
		rename
			execute as launch_ebench
		export
			{NONE} all
		end

	EIFFEL_ENV
		export
			{NONE} all
		end

	EV_SHARED_APPLICATION
		export
			{NONE} all
		end

	EB_SHARED_PREFERENCES
		export
			{NONE} all
		end

create
	make_with_parent

feature {NONE} -- Initialization

	make_with_parent (a_window: EV_WINDOW) is
			-- Create the command relative to the parent window `a_window'
		require
			a_window_not_void: a_window /= Void
		do
			internal_parent_window := a_window
		ensure
			internal_parent_window_valid: internal_parent_window /= Void
		end

feature -- Execution

	execute is
			-- Let the user choose the kind of new project he wants to create.
		local
			new_project_dialog: EB_STARTING_DIALOG
		do
			create new_project_dialog.make_without_open_project_frame
			new_project_dialog.show_modal_to_window (parent_window)
		end

feature {NONE} -- Implementation

	build_deleting_dialog is
			-- Build the dialog displayed to have the user wait during the
			-- deletion of a directory.
		local
			label_font: EV_FONT
			pixmap: EV_PIXMAP
			hb: EV_HORIZONTAL_BOX
			vb: EV_VERTICAL_BOX
			pixmap_box: EV_CELL
			button_box: EV_HORIZONTAL_BOX
			cancel_button: EV_BUTTON
		do
				-- Create and display a dialog to have the user wait.
			pixmap := (create {EV_STOCK_PIXMAPS}).Information_pixmap.twin
			create pixmap_box
			pixmap_box.extend (pixmap)
			pixmap_box.set_minimum_size (pixmap.width, pixmap.height)

			create deleting_dialog_label
			deleting_dialog_label.align_text_left
			deleting_dialog_label.set_text (Interface_names.l_Deleting_dialog_default)
			label_font := deleting_dialog_label.font
			deleting_dialog_label.set_minimum_size (
				label_font.width * Minimum_width_of_Deleting_dialog,
				label_font.height * Minimum_height_of_Deleting_dialog
				)

			create cancel_button.make_with_text (Interface_names.b_Cancel)
			Layout_constants.set_default_size_for_button (cancel_button)
			cancel_button.select_actions.extend (agent on_cancel_button_pushed)

			create hb
			hb.set_border_width (Layout_constants.Default_border_size)
			hb.set_padding (Layout_constants.Default_padding_size)
			hb.extend (pixmap_box)
			hb.disable_item_expand (pixmap_box)
			hb.extend (deleting_dialog_label)

			create button_box
			button_box.set_padding (Layout_constants.Default_padding_size)
			button_box.set_border_width (Layout_constants.Default_border_size)
			button_box.extend (create {EV_CELL})
			button_box.extend (cancel_button)
			button_box.disable_item_expand (cancel_button)
			button_box.extend (create {EV_CELL})

			create vb
			vb.extend (hb)
			vb.extend (button_box)
			vb.disable_item_expand (button_box)

			create deleting_dialog
			deleting_dialog.extend (vb)
			deleting_dialog.set_default_cancel_button (cancel_button)
			deleting_dialog.set_title (Interface_names.t_Deleting_files)
			deleting_dialog.set_icon_pixmap (pixmaps.icon_dialog_window)
			deleting_dialog.show_relative_to_window (parent_window)
		end

	on_delete_directory (deleted_files: ARRAYED_LIST [STRING]) is
			-- The files in `deleted_files' have just been deleted.
			-- Display
		local
			ise_directory_utils: ISE_DIRECTORY_UTILITIES
			deleted_file_pathname: STRING
		do
			if deleting_dialog = Void then
				build_deleting_dialog
				parent_window.disable_sensitive
			end
			create ise_directory_utils
			deleted_file_pathname := ise_directory_utils.path_ellipsis (deleted_files.first, Path_ellipsis_width)
			check
				deleting_dialog_label_exists: deleting_dialog_label /= Void
			end
			deleting_dialog_label.set_text (deleted_file_pathname)
			deleting_dialog_label.refresh_now
			ev_application.process_events
		end

	on_cancel_operation: BOOLEAN is
			-- Has the user pushed the "Cancel" in the deleting dialog?
		do
			Result := cancel_button_pushed
		end

	on_cancel_button_pushed is
			-- The user has just pushed the "Cancel" in the deleting dialog.
		do
			cancel_button_pushed := True
		end

feature {NONE} -- Callbacks

	parent_window: EV_WINDOW is
			-- Parent window.
		local
			dev_window: EB_DEVELOPMENT_WINDOW
		do
			if internal_parent_window /= Void then
				Result := internal_parent_window
			else
				dev_window := window_manager.last_focused_development_window
				if dev_window /= Void then
					Result := dev_window.window
				else
					create Result
				end
			end
		ensure
			Result_not_void: Result /= Void
		end

	internal_parent_window: EV_WINDOW
			-- Parent window if any, Void if none.

feature {NONE} -- Implementation / Private attributes

	deleting_dialog: EV_DIALOG
			-- Dialog displaying that the program is currently deleting
			-- some files.

	deleting_dialog_label: EV_LABEL
			-- Label displaying the file currently being deleted

	choose_again: BOOLEAN
			-- We need to choose again the file

	cancel_button_pushed: BOOLEAN
			-- Has the cancel button beem pushed?

feature {NONE} -- Implementation / Private constants.

	Minimum_width_of_Deleting_dialog: INTEGER is 70
			-- Minimum width of the deleting dialog in characters.

	Minimum_height_of_Deleting_dialog: INTEGER is 2
			-- Minimum height of the deleting dialog in characters.

	Path_ellipsis_width: INTEGER is
			-- Maximum number of characters per item.
		once
			Result := Minimum_width_of_Deleting_dialog - 10
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.

			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).

			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.

			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class EB_NEW_PROJECT_CMD
