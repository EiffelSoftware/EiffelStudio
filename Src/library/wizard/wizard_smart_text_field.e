indexing
	description	: "Text field which are used by the Wizard"
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	WIZARD_SMART_TEXT_FIELD

inherit
	WIZARD_SHARED

create	
	make

feature -- Initialization

	make (a_caller: WIZARD_STATE_WINDOW) is
			-- Initialize with `a_caller' as caller.
		do
			caller := a_caller
		end

	generate is
			-- Generate the Smart text field
		require
			not_yet_generated: not generated
		local
			textfield_widget: EV_WIDGET -- "Textfield" or "Textfield + Browse"
			textfield_box: EV_HORIZONTAL_BOX
			empty_space: EV_CELL
		do
			create label.make_with_text(label_string)
			if is_password then
				create {EV_PASSWORD_FIELD} textfield
			else
				create textfield
			end
			if textfield_string /= Void and then not textfield_string.is_empty then
				textfield.set_text (textfield_string)
			end

			if has_browse_button then
					-- Create the browse button
				create browse_button.make_with_text("Browse...")
				browse_button.select_actions.extend (browse_button_action)

				create textfield_box
				textfield_box.set_padding (dialog_unit_to_pixels(5))
				textfield_box.extend (textfield)
				textfield_box.extend (browse_button)
				textfield_box.disable_item_expand (browse_button)
				textfield_widget := textfield_box
			else
				textfield_widget := textfield
			end

			label.set_minimum_width (label_size)
			label.align_text_left
			if label_string /= Void then
				label.set_text (" "+label_string)
			end
			textfield.set_capacity (textfield_capacity)
			textfield.set_minimum_height (Default_button_height)
			textfield.return_actions.extend (caller~next)
			textfield.change_actions.extend (caller~change_entries)

			create empty_space
			empty_space.set_minimum_height (dialog_unit_to_pixels(2))

			create {EV_VERTICAL_BOX} internal_widget
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

	text: STRING is 
			-- Text of the textfield
		do
			if generated then
				Result := textfield.text
			else
				Result := textfield_string
			end
		end

	widget: EV_WIDGET is
			-- Widget representing Current.
		require
			generated: generated
		do
			Result := internal_widget
		ensure
			Result_not_void: Result /= Void
		end

	change_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions associated with the text field.
		require
			generated: generated
		do
			Result := textfield.change_actions
		end

	browse_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions associated with the browse button.
		require
			has_browse_button: has_browse_button
			generated: generated
		do
			Result := browse_button.select_actions
		end

feature -- Status report
	
	is_password: BOOLEAN
			-- Is the text in the text field replaced by stars (for passwords).

	has_browse_button: BOOLEAN
			-- Has the text field a browse button on his right.

	generated: BOOLEAN
			-- Has the widget been generated?

feature -- Settings
	
	set_text, set_textfield_string (a_string: STRING) is
			-- Set the text of the text field to `txt'.
		do
			if generated then 
				textfield.set_text (a_string)
			else
				textfield_string := a_string
			end
		end

	remove_text is
			-- Remove the text of the text field.
		do
			if generated then 
				textfield.remove_text
			else
				textfield_string := Void
			end
		end

	set_label_string_and_size (a_string: STRING; a_size: INTEGER) is
			-- Set the label text to `a_string' and the minimum width for
			-- the label to `a_size'.
		do
			if generated then
				label.set_text (a_string+":")
				label.set_minimum_width (a_size)
			else
				label_string := a_string+":"
				label_size := a_size
			end
		end

	set_textfield_string_and_capacity (a_string: STRING; a_capacity: INTEGER) is
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

	enable_directory_browse_button is
			-- Add a browse button near on the right of the text field,
			-- clicking on the browse button will display a dialog to
			-- choose a directory.
		require
			not_yet_generated: not generated
			not_has_browse_button: not has_browse_button
		do
			has_browse_button := True
			browse_button_action := ~browse_directory
		ensure
			has_browse_button: has_browse_button
		end

	enable_file_browse_button (a_filter: STRING) is
			-- Add a browse button near the right of the text field,
			-- clicking on the browse button will display a dialog to
			-- choose a file among `a_filter'.
		require
			not_yet_generated: not generated
			not_has_browse_button: not has_browse_button
			valid_filter: a_filter /= Void and then not a_filter.is_empty
		do
			has_browse_button := True
			browse_button_action := ~browse_file
			browse_file_filter := a_filter
		ensure
			has_browse_button: has_browse_button
		end

	disable_browse_button is
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

	enable_password is
			-- Set the text in the text field to be replaced by stars (for passwords)
		require
			not_password: not is_password
			not_yet_generated: not generated
		do
			is_password := True
		ensure
			is_password: is_password
		end

	disable_password is
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

	browse_file is
			-- Launch a file Browser.
		local
			file_selector: EV_FILE_OPEN_DIALOG  
		do
			create file_selector
			file_selector.set_filter (browse_file_filter)
			file_selector.open_actions.extend(agent file_selected (file_selector))
			file_selector.show_modal_to_window (caller.first_window)
		end

	browse_directory is
			-- Launch a computer directory Browser.
		local
			dir_selector: EV_DIRECTORY_DIALOG
			start_directory: STRING
			end_char: CHARACTER
		do
			create dir_selector

				-- Retrieve the string from the textfield, and set
				-- the starting directory with it if it's a directory.
			start_directory := clone (textfield.text)
			
			if start_directory /= Void then
				end_char := start_directory @ start_directory.count
				if end_char = '\' or end_char = '/' then
					start_directory.head (start_directory.count - 1)
				end
				if not start_directory.is_empty and then
					(create {DIRECTORY}.make (start_directory)).exists
				then
					dir_selector.set_start_directory (start_directory)
				end
			end
			dir_selector.ok_actions.extend (agent directory_selected(dir_selector))
			dir_selector.show_modal_to_window (caller.first_window)
		end

	directory_selected (dir_selector: EV_DIRECTORY_DIALOG) is
			-- The user selected a directory from the browser. 
			-- It updates the text fields accordingly.
		require
			selector_exists: dir_selector /= Void
		do
			textfield.set_text (dir_selector.directory)
		end

	file_selected (file_selector: EV_FILE_OPEN_DIALOG) is
			-- The user selected a file from the file dialog. 
			-- Updates the text field accordingly.
		require
			selector_exists: file_selector /= Void
		do
			textfield.set_text (file_selector.file_name)
		end

	internal_widget: EV_VERTICAL_BOX

	browse_file_filter: STRING
			-- File filter. Void if there is no browse button.

	textfield: EV_TEXT_FIELD
			-- Text field

	label: EV_LABEL
			-- Label defining the text field

	label_size: INTEGER
			-- Requested size for the label.
	
	label_string: STRING
			-- Requested Text for the Label.

	textfield_capacity: INTEGER
			-- Requested capacity for the text field.
	
	textfield_string: STRING
			-- Requested text for the text field.

	browse_button: EV_BUTTON
			-- Browse button (Void if none)

	font: EV_FONT
			-- Requested font for the textfield, the label and - if any -
			-- the browse button.

	caller: WIZARD_STATE_WINDOW
			-- Caller of this object.

	browse_button_action: PROCEDURE [ANY, TUPLE]
			-- Action for the browse button.

end -- class WIZARD_SMART_TEXT_FIELD


--|----------------------------------------------------------------
--| EiffelWizard: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

