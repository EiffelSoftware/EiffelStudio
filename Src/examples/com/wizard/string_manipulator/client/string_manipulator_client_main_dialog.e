indexing 
	description:	"String Manipulator component client, for simpliciy business and GUI codes are in the same class"
	note:			"STRING_MANIPULATOR_CLIENT_MAIN_DIALOG class created by Resource Bench."

class 
	STRING_MANIPULATOR_CLIENT_MAIN_DIALOG

inherit
	WEL_MAIN_DIALOG
		redefine
			setup_dialog,
			notify
		end

	APPLICATION_IDS
		export
			{NONE} all
		end

	EXCEPTIONS
		rename
			class_name as exception_class_name
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Create dialog.
		do
			make_by_id (String_manipulator_client_dialog_box_constant)
			create set_string_edit.make_by_id (Current, Set_string_edit_constant)
			create prune_all_edit.make_by_id (Current, Prune_all_edit_constant)
			create replace_substring_index_1_edit.make_by_id (Current, Replace_substring_index_1_edit_constant)
			create replace_substring_index_2_edit.make_by_id (Current, Replace_substring_index_2_edit_constant)
			create replace_substring_edit.make_by_id (Current, Replace_substring_edit_constant)
			create current_string_display.make_by_id (Current, Current_string_display_constant)
			create id_cancel.make_by_id (Current, Idcancel)
			create set_string_button.make_by_id (Current, Set_string_button_constant)
			create replace_substring_button.make_by_id (Current, Replace_substring_button_constant)
			create prune_button.make_by_id (Current, Prune_button_constant)
		end

feature -- Access

	string_manipulator_proxy: MY_STRING_MANIPULATOR
			-- String manipulator component proxy
			
feature -- Behavior

	setup_dialog is
			-- Create component proxy
		local
			retried: BOOLEAN
			msg_box: WEL_MSG_BOX
		do
			if not retried then
				create string_manipulator_proxy.make
				string_manipulator_proxy.set_string (Initial_string_value)
			end
		rescue
			retried := True
			create msg_box.make
			msg_box.error_message_box (Current, error_message (exception), Error_message_title)
			retry
		end

	notify (control: WEL_CONTROL; notify_code: INTEGER) is
			-- Process button activation
		local
			retried: BOOLEAN
			msg_box: WEL_MSG_BOX
		do
			if not retried then
				-- Set string
				if control = set_string_button then
					if set_string_edit.text /= Void and then not set_string_edit.text.empty then
						string_manipulator_proxy.set_string (set_string_edit.text)
					end
			
				-- Prune all
				elseif control = prune_button then
					if prune_all_edit.text /= Void and then not prune_all_edit.text.empty then
						string_manipulator_proxy.prune_all (prune_all_edit.text.item (1))
					end

				-- Replace substring
				elseif control = replace_substring_button then
					if replace_substring_edit.text /= Void and then not replace_substring_edit.text.empty and
						replace_substring_index_1_edit.text /= Void and then not replace_substring_index_1_edit.text.empty and
						replace_substring_index_2_edit.text /= Void and then not replace_substring_index_2_edit.text.empty then
						string_manipulator_proxy.replace_substring (replace_substring_edit.text, replace_substring_index_1_edit.text.to_integer, replace_substring_index_2_edit.text.to_integer)
					end
				end

				-- Update displayed string
				current_string_display.set_text (string_manipulator_proxy.string)
			end
		rescue
			retried := True
			create msg_box.make
			msg_box.error_message_box (Current, error_message (exception), Error_message_title)
			retry
		end

feature -- GUI elements

	set_string_edit: WEL_SINGLE_LINE_EDIT
			-- String edit

	prune_all_edit: WEL_SINGLE_LINE_EDIT
			-- Character used for `prune_all' edit
			
	replace_substring_index_1_edit: WEL_SINGLE_LINE_EDIT
			-- `replace_substring' first index edit
			
	replace_substring_index_2_edit: WEL_SINGLE_LINE_EDIT
			-- `replace_substring' second index edit

	replace_substring_edit: WEL_SINGLE_LINE_EDIT
			-- `replace_substring' edit

	current_string_display: WEL_STATIC
			-- Current manipulated string
			
	id_cancel: WEL_PUSH_BUTTON
			-- Quit button

	set_string_button: WEL_PUSH_BUTTON
			-- Set string button

	replace_substring_button: WEL_PUSH_BUTTON
			-- Replace substring button

	prune_button: WEL_PUSH_BUTTON
			-- Prune all button

feature {NONE} -- Implementation

	Initial_string_value: STRING is "Initial value"
			-- Initial string value

	error_message (an_exception_code: INTEGER): STRING is
			-- Error message for exception `an_exception_code'.
		do
			Result := "Error "
			Result.append_integer (an_exception_code)
			Result.append (": ")
			Result.append (original_tag_name)
		end
	
	Error_message_title: STRING is "Component Call Failure"
			-- Error message box title

end -- class STRING_MANIPULATOR_CLIENT_MAIN_DIALOG

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--| Based on WINE library, copyright (C) Object Tools, 1996-2001.
--| Modifications and extensions: copyright (C) ISE, 2001.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

