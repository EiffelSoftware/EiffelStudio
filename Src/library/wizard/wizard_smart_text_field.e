note
	description: "Text field which are used by the Wizard"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	revised_by: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_SMART_TEXT_FIELD

inherit
	WIZARD_SHARED

create
	make

feature -- Initialization

	make (a_caller: WIZARD_STATE_WINDOW)
			-- Initialize with `a_caller' as caller.
		do
			caller := a_caller
			create internal_widget
			create label
			create textfield
		end

	generate
			-- Generate the Smart text field
		require
			not_yet_generated: not generated
		local
			textfield_widget: EV_WIDGET -- "Textfield" or "Textfield + Browse"
			textfield_box: EV_HORIZONTAL_BOX
			empty_space: EV_CELL
			b: like browse_button
		do
			if attached label_string as l_label_string then
				label.set_text (l_label_string)
			else
				label.remove_text
			end
			if is_password then
				create {EV_PASSWORD_FIELD} textfield
			else
				create textfield
			end
			if attached textfield_string as s and then not s.is_empty then
				textfield.set_text (s)
			end

			if has_browse_button then
					-- Create the browse button
				create b.make_with_text(b_browse)
				browse_button := b
				if attached browse_button_action as a then
					b.select_actions.extend (a)
				end

				create textfield_box
				textfield_box.set_padding (dialog_unit_to_pixels(5))
				textfield_box.extend (textfield)
				textfield_box.extend (b)
				textfield_box.disable_item_expand (b)
				textfield_widget := textfield_box
			else
				textfield_widget := textfield
			end

			label.set_minimum_width (label_size)
			label.align_text_left
			if attached label_string as s then
				label.set_text (({STRING_32} " ") + s)
			end
			textfield.set_capacity (textfield_capacity)
			textfield.return_actions.extend (agent caller.next)
			textfield.change_actions.extend (agent caller.change_entries)

			create empty_space
			empty_space.set_minimum_height (dialog_unit_to_pixels(2))

			internal_widget.extend (label)
			internal_widget.extend (empty_space)
			internal_widget.disable_item_expand (empty_space)
			internal_widget.extend (textfield_widget)

				-- We don't need that anymore.
			label_string := Void
			textfield_string := Void
			font := Void
			browse_button_action := Void

				-- Set generated to True.
			generated := True
		ensure
			generated: generated
		end

feature -- Access

	text_32: STRING_32
			-- Text of the textfield
		do
			if generated then
				Result := textfield.text
			elseif attached textfield_string as t then
				Result := t.as_string_32
			else
				create Result.make_empty
			end
		end

	widget: EV_WIDGET
			-- Widget representing Current.
		require
			generated: generated
		do
			Result := internal_widget
		ensure
			Result_not_void: Result /= Void
		end

	change_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions associated with the text field.
		require
			generated: generated
		do
			Result := textfield.change_actions
		end

	browse_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions associated with the browse button.
		require
			has_browse_button: has_browse_button
			generated: generated
		do
			check attached browse_button as b then
				Result := b.select_actions
			end
		end

feature -- Status report

	is_password: BOOLEAN
			-- Is the text in the text field replaced by stars (for passwords).

	has_browse_button: BOOLEAN
			-- Has the text field a browse button on his right.

	generated: BOOLEAN
			-- Has the widget been generated?

feature -- Settings

	set_text, set_textfield_string (a_string: READABLE_STRING_GENERAL)
			-- Set the text of the text field to `txt'.
		do
			if generated then
				textfield.set_text (a_string)
			else
				textfield_string := a_string
			end
		end

	remove_text
			-- Remove the text of the text field.
		do
			if generated then
				textfield.remove_text
			else
				textfield_string := Void
			end
		end

	set_label_string_and_size (a_string: READABLE_STRING_GENERAL; a_size: INTEGER)
			-- Set the label text to `a_string' and the minimum width for
			-- the label to `a_size'.
		do
			if generated then
				label.set_text (a_string.as_string_32 + ":")
				label.set_minimum_width (a_size)
			else
				label_string := a_string.as_string_32 + ":"
				label_size := a_size
			end
		end

	set_textfield_string_and_capacity (a_string: READABLE_STRING_GENERAL; a_capacity: INTEGER)
			-- Set the textfield text to `a_string' and the capacity (max
			-- number of characters) for the textfield to `a_capacity'.
		do
			if generated then
				textfield.set_text (a_string)
				textfield.set_capacity (a_capacity)
			else
				textfield_string := a_string
				textfield_capacity := a_capacity
			end
		end

	enable_directory_browse_button
			-- Add a browse button near on the right of the text field,
			-- clicking on the browse button will display a dialog to
			-- choose a directory.
		require
			not_yet_generated: not generated
			not_has_browse_button: not has_browse_button
		do
			has_browse_button := True
			browse_button_action := agent browse_directory
		ensure
			has_browse_button: has_browse_button
		end

	enable_file_browse_button (a_filter: STRING)
			-- Add a browse button near the right of the text field,
			-- clicking on the browse button will display a dialog to
			-- choose a file among `a_filter'.
		require
			not_yet_generated: not generated
			not_has_browse_button: not has_browse_button
			valid_filter: a_filter /= Void and then not a_filter.is_empty
		do
			has_browse_button := True
			browse_button_action := agent browse_file
			browse_file_filter := a_filter
		ensure
			has_browse_button: has_browse_button
		end

	disable_browse_button
			-- Remove a browse button near the right of the text field.
		require
			not_yet_generated: not generated
			has_browse_button: has_browse_button
		do
			has_browse_button := False
			browse_button_action := Void
		ensure
			not_has_browse_button: not has_browse_button
		end

	enable_password
			-- Set the text in the text field to be replaced by stars (for passwords)
		require
			not_password: not is_password
			not_yet_generated: not generated
		do
			is_password := True
		ensure
			is_password: is_password
		end

	disable_password
			-- Set the text in the text field not to be replaced by stars
		require
			is_password: is_password
			not_yet_generated: not generated
		do
			is_password := False
		ensure
			not_password: not is_password
		end

feature {NONE} -- Implementation

	browse_file
			-- Launch a file Browser.
		local
			file_selector: EV_FILE_OPEN_DIALOG
		do
			create file_selector
			if attached browse_file_filter as filt then
				file_selector.filters.extend ([filt, filt])
			end
			file_selector.open_actions.extend (agent file_selected (file_selector))
			if not text_32.is_empty then
				file_selector.set_start_directory (text_32)
			end
			file_selector.show_modal_to_window (caller.first_window)
		end

	browse_directory
			-- Launch a computer directory Browser.
		local
			dir_selector: EV_DIRECTORY_DIALOG
			start_directory: STRING_32
			end_char: CHARACTER_32
		do
			create dir_selector
			dir_selector.set_title (t_choose_directory)
				-- Retrieve the string from the textfield, and set
				-- the starting directory with it if it's a directory.
			start_directory := textfield.text.twin

			if not start_directory.is_empty then
				end_char := start_directory [start_directory.count]
				if end_char = '\' or end_char = '/' then
					start_directory.keep_head (start_directory.count - 1)
				end
				if not start_directory.is_empty and then
					(create {DIRECTORY}.make (start_directory)).exists
				then
					dir_selector.set_start_path (create {PATH}.make_from_string (start_directory))
				end
			end
			dir_selector.ok_actions.extend (agent directory_selected(dir_selector))
			dir_selector.show_modal_to_window (caller.first_window)
		end

	directory_selected (dir_selector: EV_DIRECTORY_DIALOG)
			-- The user selected a directory from the browser.
			-- It updates the text fields accordingly.
		require
			selector_exists: dir_selector /= Void
		do
			textfield.set_text (dir_selector.path.name)
		end

	file_selected (file_selector: EV_FILE_OPEN_DIALOG)
			-- The user selected a file from the file dialog.
			-- Updates the text field accordingly.
		require
			selector_exists: file_selector /= Void
		do
			textfield.set_text (file_selector.full_file_path.name)
		end

	internal_widget: EV_VERTICAL_BOX

	browse_file_filter: detachable STRING
			-- File filter. Void if there is no browse button.

	textfield: EV_TEXT_FIELD
			-- Text field

	label: EV_LABEL
			-- Label defining the text field

	label_size: INTEGER
			-- Requested size for the label.

	label_string: detachable READABLE_STRING_GENERAL
			-- Requested Text for the Label.

	textfield_capacity: INTEGER
			-- Requested capacity for the text field.

	textfield_string: detachable READABLE_STRING_GENERAL
			-- Requested text for the text field.

	browse_button: detachable EV_BUTTON
			-- Browse button (Void if none)

	font: detachable EV_FONT
			-- Requested font for the textfield, the label and - if any -
			-- the browse button.

	caller: WIZARD_STATE_WINDOW
			-- Caller of this object.

	browse_button_action: detachable PROCEDURE;
			-- Action for the browse button.

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
