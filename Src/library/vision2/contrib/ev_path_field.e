indexing
	description: "Provide a text field with a browse button on its left."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_PATH_FIELD

inherit
	EV_VERTICAL_BOX

create
	make_with_text_and_parent

feature {NONE} -- Initialization

	make_with_text_and_parent (t: STRING; win: like parent_window) is
			-- Create a widget that is made to browse for directory.
		require
			t_not_void: t /= Void
			win_not_void: win /= Void
		do
			default_create
			build_widget (t)
			parent_window := win
		ensure
			parent_window_set: parent_window = win
		end

feature -- Access

	field: EV_TEXT_FIELD
			-- Text field holding path value.

	parent_window: EV_WINDOW
			-- Window to which browsing dialog will be modal.

feature -- Status

	text, path: STRING is
			-- Current path set by user.
		require
			not_destroyed: not is_destroyed
		do
			Result := field.text
		ensure
			result_not_void: Result /= Void
		end
			
feature -- Settings

	set_text, set_path (p: STRING) is
			-- Assign `p' to `path'.
		require
			not_destroyed: not is_destroyed
			p_not_void: p /= Void
		do
			field.set_text (p)
		ensure
			path_set: path.is_equal (p)
		end

	set_browse_for_file (filter: STRING) is
			-- Force file browsing dialog to appear when user
			-- click on `browse_button'.
		do
			browse_button.select_actions.wipe_out
			browse_button.select_actions.extend (agent browse_for_file (filter))
		end

	set_browse_for_directory is
			-- Force directory browsing dialog to appear when user
			-- click on `browse_button'.
		do
			browse_button.select_actions.wipe_out
			browse_button.select_actions.extend (agent browse_for_directory)
		end

feature -- Removal

	remove_text, remove_path is
			-- Remove printed path from screen.
		do
			field.remove_text
		ensure
			path_cleared: path.is_empty
		end

feature {NONE} -- GUI building

	build_widget (t: STRING) is
		local
			l_label: EV_LABEL
			l_hbox: EV_HORIZONTAL_BOX
		do
			create l_label.make_with_text (t)
			l_label.align_text_left
			extend (l_label)
			disable_item_expand (l_label)
			
			create l_hbox
			l_hbox.set_padding ((create {EV_LAYOUT_CONSTANTS}).Small_padding_size)

			create field
			create browse_button.make_with_text_and_action ("Browse...", ~browse_for_directory)

			l_hbox.extend (field)
			l_hbox.extend (browse_button)
			l_hbox.disable_item_expand (browse_button)
			
			extend (l_hbox)
		end

	browse_button: EV_BUTTON
			-- Browse for a file or a directory.

feature {NONE} -- Actions

	browse_for_directory is
			-- Popup a "select directory" dialog.
		local
			dd: EV_DIRECTORY_DIALOG
			start_directory: STRING
		do
			create dd
			dd.set_title ("Select a directory")
			start_directory := field.text
			if
				start_directory /= Void and then
				not start_directory.is_empty and then
				(create {DIRECTORY}.make (start_directory)).exists
			then
				dd.set_start_directory(start_directory)
			end
			dd.show_modal_to_window (parent_window)
			if dd.directory /= Void and then not dd.directory.is_empty then
				field.set_text (dd.directory)
			end
		end

	browse_for_file (filter: STRING) is
			-- Popup a "select directory" dialog.
		local
			fd: EV_FILE_OPEN_DIALOG
			start_directory: STRING
		do
			create fd
			if filter /= Void then
				fd.set_filter (filter)
			end
			fd.set_title ("Select a file")
			start_directory := field.text
			if
				start_directory /= Void and then
				not start_directory.is_empty and then
				(create {DIRECTORY}.make (start_directory)).exists
			then
				fd.set_start_directory(start_directory)
			end
			fd.show_modal_to_window (parent_window)
			if fd.file_name /= Void and then not fd.file_name.is_empty then
				field.set_text (fd.file_name)
			end
		end

invariant
	field_not_void: field /= Void
	parent_window_not_void: parent_window /= Void
	browse_button_not_void: browse_button /= Void

end -- class EV_PATH_FIELD
