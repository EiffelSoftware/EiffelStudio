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
		
	destination_path_label: WINFORMS_LABEL
		indexing
			description: "Destination path label"
			external_name: "DestinationPathLabel"
		end

	destination_path_text_box: WINFORMS_TEXT_BOX
		indexing
			description: "Destination path text box"
			external_name: "DestinationPathTextBox"
		end
		
	browse_button: WINFORMS_BUTTON
		indexing
			description: "Browse button"
			external_name: "BrowseButton"
		end
		
	explanation_label: WINFORMS_LABEL
		indexing
			description: "Explanation label"
			external_name: "ExplanationLabel"
		end
		
	ok_button: WINFORMS_BUTTON
		indexing
			description: "OK button"
			external_name: "OkButton"
		end

	cancel_button: WINFORMS_BUTTON
		indexing
			description: "Cancel button"
			external_name: "CancelButton"
		end
	
	other_explanation_label: WINFORMS_LABEL
		indexing
			description: "Other explanation label"
			external_name: "OtherExplanationLabel"
		end
	
	default_path_check_box: WINFORMS_CHECK_BOX
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
			a_size: DRAWING_SIZE
			a_point: DRAWING_POINT
			label_font: DRAWING_FONT
			a_font: DRAWING_FONT
			type: TYPE
			on_browse_event_handler_delegate: EVENT_HANDLER
			on_cancel_event_handler_delegate: EVENT_HANDLER
			style: DRAWING_FONT_STYLE
			border_style: WINFORMS_FORM_BORDER_STYLE
		do
			main_win.set_enabled (True)
			main_win.set_form_border_style (border_style.fixed_single)	
			main_win.set_maximize_box (False)

				-- Assembly name
			create assembly_label.make_winforms_label
			assembly_label.set_text (assembly_descriptor.name.to_cil)
			a_point.set_X (dictionary.Margin)
			a_point.set_Y (dictionary.Margin)
			assembly_label.set_location (a_point)
			assembly_label.set_auto_size (True)
			create label_font.make_drawing_font_10 (dictionary.Font_family_name.to_cil, dictionary.Font_size, style.Bold) 
			assembly_label.set_font (label_font)
			main_win.get_controls.add (assembly_label)			
			
			create_assembly_labels
			
				-- `Destination_path: '
			create destination_path_label.make_winforms_label
			destination_path_label.set_text (dictionary.Destination_path_label_text.to_cil)
			a_point.set_X (dictionary.Margin)
			a_point.set_Y (2 * dictionary.Margin + 4 * dictionary.Label_height)
			destination_path_label.set_location (a_point)
			destination_path_label.set_auto_size (True)
			destination_path_label.set_font (label_font)
			main_win.get_controls.add (destination_path_label)

				-- Destination path text box
			create destination_path_text_box.make_winforms_text_box
			a_point.set_X (dictionary.Margin)
			a_point.set_Y (3 * dictionary.Margin + 5 * dictionary.Label_height)
			destination_path_text_box.set_location (a_point)
			a_size.set_Width (dictionary.Window_width - dictionary.Button_width - 3 * dictionary.Margin)
			a_size.set_Height (dictionary.Label_height)
			destination_path_text_box.set_size (a_size)
			destination_path_text_box.set_enabled (False)
			main_win.get_controls.add (destination_path_text_box)

				-- Browse button
			create browse_button.make_winforms_button
			a_point.set_X (dictionary.Window_width - dictionary.Margin - dictionary.Button_width) 
			a_point.set_Y (3 * dictionary.Margin + 5 * dictionary.Label_height)
			browse_button.set_location (a_point)
			browse_button.set_width (dictionary.Button_width)
			browse_button.set_height (dictionary.Button_height)
			browse_button.set_text (dictionary.Browse_button_label.to_cil)
			browse_button.set_enabled (False)
			create on_browse_event_handler_delegate.make_event_handler (Current, $on_browse_event_handler)
			browse_button.add_Click (on_browse_event_handler_delegate)
			main_win.get_controls.add (browse_button)
			
				-- Explanations for destination path
			create explanation_label.make_winforms_label
			explanation_label.set_text (dictionary.Explanation_label_text.to_cil)
			explanation_label.set_font (a_font)
			a_point.set_X (dictionary.Margin)
			a_point.set_Y (4 * dictionary.Margin + 6 * dictionary.Label_height)
			explanation_label.set_location (a_point)
			explanation_label.set_auto_size (True)
			main_win.get_controls.add (explanation_label)
		end

feature -- Event handling

	on_check (sender: SYSTEM_OBJECT; arguments: EVENT_ARGS) is
		indexing
			description: "Action performed when the user checks or 'unchecks' the `default_path_text_box'"
			external_name: "OnCheck"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		do
			if default_path_check_box.get_checked then
				destination_path_text_box.set_enabled (False)
				browse_button.set_enabled (False)			
			else
				destination_path_text_box.set_enabled (True)
				browse_button.set_enabled (True)
			end
		end
		
	on_cancel_event_handler (sender: SYSTEM_OBJECT; arguments: EVENT_ARGS) is
		indexing
			description: "Process `cancel_button' activation."
			external_name: "OnCancelEventHandler"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		do
			main_win.close
		end

	on_browse_event_handler (sender: SYSTEM_OBJECT; arguments: EVENT_ARGS) is
		indexing
			description: "Process `browse_button' activation."
			external_name: "OnBrowseEventHandler"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		do
			ask_for_folder
			if last_folder /= Void and then last_folder.count > 0 then
				destination_path_text_box.set_text (last_folder.to_cil)
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
			browser: FOLDER_DIALOG
			retried: BOOLEAN
			current_path: STRING
			dir: DIRECTORY
		do
			if not retried then
				create browser.make
				current_path := from_system_string (destination_path_text_box.get_text)
				if current_path /= Void and then current_path.count > 0 then 
					create dir.make (current_path)
					if dir.exists then
						browser.set_starting_folder (current_path.to_cil)
					end
				end
				browser.ask_for_folder
				if browser.last_folder /= Void then
					create last_folder.make_from_cil (browser.last_folder)
				end

			end
		rescue
			retried := True
			retry
		end
		
end -- class GENERATION_DIALOG
