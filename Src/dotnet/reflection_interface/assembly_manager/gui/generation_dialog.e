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
			-- Dictionary
		indexing
			external_name: "Dictionary"
		once
			create Result
		end
		
	destination_path_label: SYSTEM_WINDOWS_FORMS_LABEL
			-- Destination path label
		indexing
			external_name: "DestinationPathLabel"
		end

	destination_path_text_box: SYSTEM_WINDOWS_FORMS_TEXTBOX
			-- Destination path text box
		indexing
			external_name: "DestinationPathTextBox"
		end
		
	browse_button: SYSTEM_WINDOWS_FORMS_BUTTON
			-- Browse button
		indexing
			external_name: "BrowseButton"
		end
		
	explanation_label: SYSTEM_WINDOWS_FORMS_LABEL
			-- Explanationlabel
		indexing
			external_name: "ExplanationLabel"
		end
		
	ok_button: SYSTEM_WINDOWS_FORMS_BUTTON
			-- OK button
		indexing
			external_name: "OkButton"
		end

	cancel_button: SYSTEM_WINDOWS_FORMS_BUTTON
			-- Cancel button
		indexing
			external_name: "CancelButton"
		end
		
feature -- Basic Operations

	initialize is
			-- Initialize GUI.
		indexing
			external_name: "Initialize"
		local
			a_size: SYSTEM_DRAWING_SIZE
			a_point: SYSTEM_DRAWING_POINT
			label_font: SYSTEM_DRAWING_FONT
			a_font: SYSTEM_DRAWING_FONT
			type: SYSTEM_TYPE
			on_browse_event_handler_delegate: SYSTEM_EVENTHANDLER
			on_cancel_event_handler_delegate: SYSTEM_EVENTHANDLER
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
			controls.add (destination_path_text_box)

				-- Browse button
			create browse_button.make_button
			a_point.set_X (dictionary.Window_width - dictionary.Margin - dictionary.Button_width) 
			a_point.set_Y (3 * dictionary.Margin + 5 * dictionary.Label_height)
			browse_button.set_location (a_point)
			browse_button.set_width (dictionary.Button_width)
			browse_button.set_height (dictionary.Button_height)
			browse_button.set_text (dictionary.Browse_button_label)
			create on_browse_event_handler_delegate.make_eventhandler (Current, $on_browse_event_handler)
			browse_button.add_Click (on_browse_event_handler_delegate)
			controls.add (browse_button)
			
				-- Explanation for destination path
			create explanation_label.make_label
			explanation_label.set_text (dictionary.Explanation_label_text)
			explanation_label.set_font (a_font)
			a_point.set_X (dictionary.Margin)
			a_point.set_Y (4 * dictionary.Margin + 6 * dictionary.Label_height)
			explanation_label.set_location (a_point)
			explanation_label.set_autosize (True)
			controls.add (explanation_label)
		end

feature -- Event handling

	on_cancel_event_handler (sender: ANY; arguments: SYSTEM_EVENTARGS) is
			-- Process `cancel_button' activation.
		indexing
			external_name: "OnCancelEventHandler"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		do
			close
		end

	on_browse_event_handler (sender: ANY; arguments: SYSTEM_EVENTARGS) is
			-- Process `browse_button' activation.
		indexing
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
			-- Last folder choosen by user.
			-- Void if `ask_for_folder' has not been called.
		indexing
			external_name: "LastFolder"
		end

	ask_for_folder is
			-- Ask user for a folder.
		indexing
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