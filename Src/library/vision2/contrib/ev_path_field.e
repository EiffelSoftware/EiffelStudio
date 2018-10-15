note
	description: "Provide a text field with a browse button on its right."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_PATH_FIELD

inherit
	EV_VERTICAL_BOX

create
	make,
	make_with_text,
	make_with_parent,
	make_with_text_and_parent

feature {NONE} -- Initialization

	make
			-- Create a widget that is made to browse for directory.
		do
			make_with_text (Void)
		end

	make_with_text (t: detachable READABLE_STRING_GENERAL)
			-- Create a widget that is made to browse for directory.
		do
			create default_start_path.make_empty
			default_create
			build_widget (t)
		end

	make_with_parent (win: like parent_window)
			-- Create a widget that is made to browse for directory.
		require
			win_not_void: win /= Void
		do
			make_with_text_and_parent (Void, win)
		end

	make_with_text_and_parent (t: detachable READABLE_STRING_GENERAL; win: like parent_window)
			-- Create a widget that is made to browse for directory.
		require
			win_not_void: win /= Void
		do
			make_with_text (t)
			set_parent_window (win)
		ensure
			parent_window_set: parent_window = win
		end

feature -- Access

	field: detachable EV_TEXT_FIELD
			-- Text field holding path value.

	parent_window: EV_WINDOW
			-- Window to which browsing dialog will be modal.
		local
			l_result: detachable EV_WINDOW
		do
			l_result := internal_parent_window
			if l_result = Void then
				l_result := parent_window_of (Current)
			end
			check l_result /= Void then end
			Result := l_result
		ensure
			Result_not_void: Result /= Void
		end

	default_start_directory: STRING_32
			-- Default start directory for browsing dialog.
		obsolete
			"Use `default_start_path' instead. [2017-05-31]"
		do
			create Result.make_from_string (default_start_path.name)
		end

	default_start_path: PATH
			-- Default start directory for browsing dialog.

feature -- Status

	text, path: STRING_32
			-- Current path set by user.
		obsolete
			"Use `file_path.name' instead. [2017-05-31]"
		require
			not_destroyed: not is_destroyed
		do
			create Result.make_from_string (file_path.name)
		ensure
			result_not_void: Result /= Void
		end

	file_path: PATH
			-- Current path set by user.
		require
			not_destroyed: not is_destroyed
		local
			l_field: like field
		do
			l_field := field
			check l_field /= Void then end
			create Result.make_from_string (l_field.text)
		ensure
			result_not_void: Result /= Void
		end

feature -- Settings

	set_parent_window (win: EV_WINDOW)
			-- Set `internal_parent_window' with `win'
		do
			internal_parent_window := win
		end

	set_text, set_path (p: READABLE_STRING_GENERAL)
			-- Assign `p' to `path'.
		obsolete
			"Use `set_file_path' instead. [2017-05-31]"
		require
			not_destroyed: not is_destroyed
			p_not_void: p /= Void
		local
			l_field: like field
		do
			l_field := field
			check l_field /= Void then end
			l_field.set_text (p)
		ensure
			path_set: path.same_string_general (p)
		end

	set_file_path (p: PATH)
			-- Assign `p' to `file_path'.
		require
			not_destroyed: not is_destroyed
			p_not_void: p /= Void
		local
			l_field: like field
		do
			l_field := field
			check l_field /= Void then end
			l_field.set_text (p.name)
		ensure
			path_set: file_path.name ~ p.name
		end

	set_browse_for_file (filter: READABLE_STRING_GENERAL)
			-- Force file browsing dialog to appear when user
			-- click on `browse_button'.
		obsolete "Please use `set_browse_for_open_file' or `set_browse_for_save_file'. [2017-05-31]"
		do
			set_browse_for_open_file (filter)
		end

	set_browse_for_open_file (filter: READABLE_STRING_GENERAL)
			-- Force file browsing dialog to appear when user
			-- click on `browse_button'.
		local
			l_browse_button: like browse_button
		do
			l_browse_button := browse_button
			check l_browse_button /= Void then end
			l_browse_button.select_actions.wipe_out
			l_browse_button.select_actions.extend (agent browse_for_open_file (filter))
		end

	set_browse_for_save_file (filter: READABLE_STRING_GENERAL)
			-- Force file browsing dialog to appear when user
			-- click on `browse_button'.
		local
			l_browse_button: like browse_button
		do
			l_browse_button := browse_button
			check l_browse_button /= Void then end
			l_browse_button.select_actions.wipe_out
			l_browse_button.select_actions.extend (agent browse_for_save_file (filter))
		end

	set_browse_for_directory
			-- Force directory browsing dialog to appear when user
			-- click on `browse_button'.
		local
			l_browse_button: like browse_button
		do
			l_browse_button := browse_button
			check l_browse_button /= Void then end
			l_browse_button.select_actions.wipe_out
			l_browse_button.select_actions.extend (agent browse_for_directory)
		end

	set_default_start_directory (t: STRING_32)
			-- Set Default start directory for browsing dialog
		obsolete
			"Use `set_default_start_path' instead. [2017-05-31]"
		do
			create default_start_path.make_from_string (t)
		end

	set_default_start_path (a_path: PATH)
			-- Set Default start directory for browsing dialog
		do
			default_start_path := a_path
		ensure
			default_start_path_set: default_start_path = a_path
		end

feature -- Removal

	remove_text, remove_path
			-- Remove printed path from screen.
		do
			if attached field as l_field then
				l_field.remove_text
			end
		ensure
			path_cleared: file_path.is_empty
		end

feature {NONE} -- GUI building

	build_widget (t: detachable READABLE_STRING_GENERAL)
			-- Create Current using `t' as text label.
		local
			l_label: EV_LABEL
			l_hbox: EV_HORIZONTAL_BOX
			l_browse_button: like browse_button
			l_field: like field
		do
			if t /= Void then
				create l_label.make_with_text (t)
				l_label.align_text_left
				extend (l_label)
				disable_item_expand (l_label)
			end

			create l_hbox
			l_hbox.set_padding ((create {EV_LAYOUT_CONSTANTS}).Small_padding_size)

			create field
			create l_browse_button.make_with_text_and_action (Label_browse, agent browse_for_directory)
			browse_button := l_browse_button

			l_field := field
			check l_field /= Void then end
			l_hbox.extend (l_field)
			l_hbox.extend (l_browse_button)
			l_hbox.disable_item_expand (l_browse_button)

			extend (l_hbox)
		end

	browse_button: detachable EV_BUTTON
			-- Browse for a file or a directory.

	browse_for_directory
			-- Popup a "select directory" dialog.
		local
			dd: EV_DIRECTORY_DIALOG
			l_start_path: like start_path
		do
			create dd
			dd.set_title (Label_select_directory)
			l_start_path := start_path
			if
				not l_start_path.is_empty and then
				(create {DIRECTORY}.make_with_path (l_start_path)).exists
			then
				dd.set_start_path (l_start_path)
			end

			dd.show_modal_to_window (parent_window)
			if dd.path /= Void and then not dd.path.is_empty and then attached field as l_field then
				l_field.set_text (dd.path.name)
			end
		end

	browse_for_save_file (filter: READABLE_STRING_GENERAL)
			-- Popup a "select save file" dialog
		do
			browse_for_file (filter, True)
		end

	browse_for_open_file (filter: READABLE_STRING_GENERAL)
			-- Popup a "select open file" dialog
		do
			browse_for_file (filter, False)
		end

	browse_for_file (filter: READABLE_STRING_GENERAL; allow_new: BOOLEAN)
			-- Popup a open or save "select file" dialog according to `allow_new' value
		local
			fd: EV_FILE_DIALOG
			l_start_path: like start_path
		do
			if allow_new then
				create {EV_FILE_SAVE_DIALOG} fd
			else
				create {EV_FILE_OPEN_DIALOG} fd
			end
			if filter /= Void then
				fd.filters.extend ([filter.as_string_32, Label_files_of_type (filter)])
				fd.filters.extend ([("*.*").as_string_32, Label_all_files.as_string_32])
			end
			fd.set_title (Label_select_file)
			l_start_path := start_path
			if
				l_start_path /= Void and then
				not l_start_path.is_empty and then
				(create {DIRECTORY}.make_with_path (l_start_path)).exists
			then
				fd.set_start_path (l_start_path)
			end
			fd.show_modal_to_window (parent_window)
			if not fd.full_file_path.is_empty and then attached field as l_field then
				l_field.set_text (fd.full_file_path.name)
			end
		end

	start_path: PATH
			-- Start directory for browsing dialog.
		local
			l_field: like field
		do
			l_field := field
			check l_field /= Void then end
			create Result.make_from_string (l_field.text)
			if Result.is_empty then
				Result := default_start_path
			end
		end

feature {NONE} -- Interface names

	Label_browse: STRING = "Browse..."
	Label_select_directory: STRING = "Select a directory"
	Label_select_file: STRING = "Select a file"
	Label_all_files: STRING = "All Files (*.*)"
	Label_files_of_type (f: READABLE_STRING_GENERAL): STRING_32
		require
			f_not_void: f /= Void
		do
			create Result.make_from_string_general ("Files of type (")
			Result.append_string_general (f)
			Result.append_character (')')
		end

feature {NONE} -- Parent window

	parent_window_of (w: detachable EV_WIDGET): detachable EV_WINDOW
			-- Window to which browsing dialog will be modal.
		do
			if w /= Void then
				if attached {EV_WINDOW} w as win then
					Result := win
				else
					Result := parent_window_of (w.parent)
				end
			end
		end

	internal_parent_window: detachable EV_WINDOW
			-- Window to which browsing dialog will be modal.

invariant
	field_not_void: field /= Void
	browse_button_not_void: browse_button /= Void

note
	copyright:	"Copyright (c) 1984-2017, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class EV_PATH_FIELD




