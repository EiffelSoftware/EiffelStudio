indexing
	description: "Enable user to import a .NET assembly."
	external_name: "ISE.AssemblyManager.GenerationDialog"

deferred class
	GENERATION_DIALOG

inherit
	DIALOG
		redefine
			dictionary
		end
		
feature -- Access	
		
	dictionary: GENERATION_DIALOG_DICTIONARY is
		indexing
			description: "Dictionary"
			external_name: "Dictionary"
		once
			create Result
		end
		
	destination_path_label: SYSTEM_WINDOWS_FORMS_LABEL
		indexing
			description: "Destination path label"
			external_name: "DestinationPathLabel"
		end

	destination_path_text_box: SYSTEM_WINDOWS_FORMS_TEXTBOX
		indexing
			description: "Destination path text box"
			external_name: "DestinationPathTextBox"
		end
		
	browse_button: SYSTEM_WINDOWS_FORMS_BUTTON
		indexing
			description: "Browse button"
			external_name: "BrowseButton"
		end
		
	explanation_label: SYSTEM_WINDOWS_FORMS_LABEL
		indexing
			description: "Explanation label"
			external_name: "ExplanationLabel"
		end
		
	ok_button: SYSTEM_WINDOWS_FORMS_BUTTON
		indexing
			description: "OK button"
			external_name: "OkButton"
		end

	cancel_button: SYSTEM_WINDOWS_FORMS_BUTTON
		indexing
			description: "Cancel button"
			external_name: "CancelButton"
		end
	
	other_explanation_label: SYSTEM_WINDOWS_FORMS_LABEL
		indexing
			description: "Other explanation label"
			external_name: "OtherExplanationLabel"
		end
	
	default_path_check_box: SYSTEM_WINDOWS_FORMS_CHECKBOX
		indexing
			description: "Default path check box"
			external_name: "DefaultPathCheckBox"
		end
		
feature -- Basic Operations

	initialize is
		indexing
			description: "Initialize GUI."
			external_name: "Initialize"
		local
			a_size: SYSTEM_DRAWING_SIZE
			a_point: SYSTEM_DRAWING_POINT
			label_font: SYSTEM_DRAWING_FONT
			a_font: SYSTEM_DRAWING_FONT
			type: SYSTEM_TYPE
			on_browse_event_handler_delegate: SYSTEM_EVENTHANDLER
			on_cancel_event_handler_delegate: SYSTEM_EVENTHANDLER
			checked_changed_delegate: SYSTEM_EVENTHANDLER
		do
			set_enabled (True)
			set_borderstyle (dictionary.Border_style)	
			set_maximizebox (False)

				-- Assembly name
			create assembly_label.make_label
			assembly_label.set_text (assembly_descriptor.name)
			a_point.set_X (dictionary.Margin)
			a_point.set_Y (dictionary.Margin)
			assembly_label.set_location (a_point)
			assembly_label.set_autosize (True)
			create label_font.make_font_10 (dictionary.Font_family_name, dictionary.Font_size, dictionary.Bold_style) 
			assembly_label.set_font (label_font)
			controls.add (assembly_label)			
			
			create_assembly_labels
			
				-- `Destination_path: '
			create destination_path_label.make_label
			destination_path_label.set_text (dictionary.Destination_path_label_text)
			a_point.set_X (dictionary.Margin)
			a_point.set_Y (2 * dictionary.Margin + 4 * dictionary.Label_height)
			destination_path_label.set_location (a_point)
			destination_path_label.set_autosize (True)
			destination_path_label.set_font (label_font)
			controls.add (destination_path_label)

				-- Destination path text box
			create destination_path_text_box.make_textbox
			a_point.set_X (dictionary.Margin)
			a_point.set_Y (3 * dictionary.Margin + 5 * dictionary.Label_height)
			destination_path_text_box.set_location (a_point)
			a_size.set_Width (dictionary.Window_width - dictionary.Button_width - 3 * dictionary.Margin)
			a_size.set_Height (dictionary.Label_height)
			destination_path_text_box.set_size (a_size)
			destination_path_text_box.set_enabled (False)
			controls.add (destination_path_text_box)

				-- Browse button
			create browse_button.make_button
			a_point.set_X (dictionary.Window_width - dictionary.Margin - dictionary.Button_width) 
			a_point.set_Y (3 * dictionary.Margin + 5 * dictionary.Label_height)
			browse_button.set_location (a_point)
			browse_button.set_width (dictionary.Button_width)
			browse_button.set_height (dictionary.Button_height)
			browse_button.set_text (dictionary.Browse_button_label)
			browse_button.set_enabled (False)
			create on_browse_event_handler_delegate.make_eventhandler (Current, $on_browse_event_handler)
			browse_button.add_Click (on_browse_event_handler_delegate)
			controls.add (browse_button)
			
				-- Explanations for destination path
			create explanation_label.make_label
			explanation_label.set_text (dictionary.Explanation_label_text)
			explanation_label.set_font (a_font)
			a_point.set_X (dictionary.Margin)
			a_point.set_Y (4 * dictionary.Margin + 6 * dictionary.Label_height)
			explanation_label.set_location (a_point)
			explanation_label.set_autosize (True)
			controls.add (explanation_label)
			
			create other_explanation_label.make_label
			a_point.set_X (dictionary.Margin)
			a_point.set_Y (4 * dictionary.Margin + 7 * dictionary.Label_height)
			other_explanation_label.set_location (a_point)
			other_explanation_label.set_autosize (True)
			other_explanation_label.set_text (dictionary.Explanation_text)
			controls.add (other_explanation_label)

				-- Default path check box
			create default_path_check_box.make_checkbox
			default_path_check_box.set_text (dictionary.Default_path_check_box_text)
			default_path_check_box.set_font (a_font)
			a_point.set_X (dictionary.Margin)
			a_point.set_Y (4 * dictionary.Margin + 8 * dictionary.Label_height)
			default_path_check_box.set_location (a_point)
			a_size.set_height (dictionary.Label_height)
			a_size.set_width (dictionary.Window_width - 2 * dictionary.Margin)
			default_path_check_box.set_size (a_size)
			default_path_check_box.set_checked (True)
			default_path_check_box.set_autocheck (True)
			controls.add (default_path_check_box)
			create checked_changed_delegate.make_eventhandler (Current, $on_check)
			default_path_check_box.add_checkedchanged (checked_changed_delegate)
		end

feature -- Event handling

	on_check (sender: ANY; arguments: SYSTEM_EVENTARGS) is
		indexing
			description: "Action performed when the user checks or 'unchecks' the `default_path_text_box'"
			external_name: "OnCheck"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		do
			if default_path_check_box.checked then
				destination_path_text_box.set_enabled (False)
				browse_button.set_enabled (False)			
			else
				destination_path_text_box.set_enabled (True)
				browse_button.set_enabled (True)
			end
		end
		
	on_cancel_event_handler (sender: ANY; arguments: SYSTEM_EVENTARGS) is
		indexing
			description: "Process `cancel_button' activation."
			external_name: "OnCancelEventHandler"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		do
			close
		end

	on_browse_event_handler (sender: ANY; arguments: SYSTEM_EVENTARGS) is
		indexing
			description: "Process `browse_button' activation."
			external_name: "OnBrowseEventHandler"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		do
			ask_for_folder
			if last_folder /= Void and then last_folder.length > 0 then
				destination_path_text_box.set_text (last_folder)
			end
		end
		
feature {NONE} -- Implementation

	last_folder: STRING
		indexing
			description: "Last folder choosen by user (Void if `ask_for_folder' has not been called)"
			external_name: "LastFolder"
		end

	ask_for_folder is
		indexing
			description: "Ask user for a folder."
			external_name: "AskForFolder"
		local
			browser: FOLDERDIALOG
			retried: BOOLEAN
			current_path: STRING
			dir: SYSTEM_IO_DIRECTORY
		do
			if not retried then
				create browser.make
				current_path := destination_path_text_box.text
				if current_path /= Void and then current_path.length > 0 and then dir.Exists (current_path) then
					browser.set_start_folder (current_path)
				end
				browser.ask_for_folder
				last_folder := browser.last_folder
			end
		rescue
			retried := True
			retry
		end
		
end -- class GENERATION_DIALOG