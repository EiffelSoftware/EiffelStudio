indexing
	description: "Dialog showing dependancies of a .NET assembly"
	external_name: "ISE.AssemblyManager.WarningDialog"

class
	WARNING_DIALOG
	
inherit
	DEPENDANCY_DIALOG
		redefine
			dictionary
		end
		
create
	make

feature {NONE} -- Initialization

	make (an_assembly_descriptor: like assembly_descriptor; assembly_dependancies: like dependancies; a_question: like question_label_text; a_caption_text: like caption_text; a_call_back: like call_back) is
		indexing
			description: "[
						Set `assembly_descriptor' with `an_assembly_descriptor'.
						Set `dependancies' with `assembly_dependancies'.
						Set `question_label_text' with `a_question'.
						Set `caption_text' with `a_caption_text'.
						Set `call_back' with `a_call_back'.
					  ]"
			external_name: "Make"
		require
			non_void_assembly_descriptor: an_assembly_descriptor /= Void
			non_void_assembly_name: an_assembly_descriptor.get_name /= Void
			not_empty_assembly_name: an_assembly_descriptor.get_name.get_length > 0
			non_void_dependancies: assembly_dependancies /= Void
			not_empty_dependancies: assembly_dependancies.count > 0
			non_void_question: a_question /= Void
			not_empty_question: a_question.get_length > 0
			non_void_caption_text: a_caption_text /= Void
			not_empty_caption_text: a_caption_text.get_length > 0
			non_void_call_back: a_call_back /= Void
		local
			return_value: SYSTEM_WINDOWS_FORMS_DIALOGRESULT
		do
			make_form
			assembly_descriptor := an_assembly_descriptor
			dependancies := assembly_dependancies
			question_label_text := a_question
			caption_text := a_caption_text
			call_back := a_call_back
			build_dependancies_list
			initialize_gui
			return_value := show_dialog
		ensure
			assembly_descriptor_set: assembly_descriptor = an_assembly_descriptor
			dependancies_set: dependancies = assembly_dependancies
			question_set: question_label_text.equals_string (a_question)
			caption_text_set: caption_text.equals_string (a_caption_text)
			call_back_set: call_back = a_call_back
			non_void_dependancies_list: dependancies_list /= Void
		end

feature -- Access
	
	dictionary: WARNING_DIALOG_DICTIONARY is
		indexing
			description: "Dictionary"
			external_name: "Dictionary"
		once
			create Result
		end
		
	question_label_text: STRING 
		indexing
			description: "Question to the user"
			external_name: "QuestionLabelText"
		end
		
	call_back: SYSTEM_EVENTHANDLER
		indexing
			description: "Call back agent"
			external_name: "CallBack"
		end

	question_label: SYSTEM_WINDOWS_FORMS_LABEL
		indexing
			description: "Question label"
			external_name: "QuestionLabel"
		end
	
	caption_text: STRING
		indexing
			description: "Text that appears in the blue header of the data grid"
			external_name: "CaptionText"
		end
		
	yes_button: SYSTEM_WINDOWS_FORMS_BUTTON
		indexing
			description: "Yes button"
			external_name: "YesButton"
		end

	no_button: SYSTEM_WINDOWS_FORMS_BUTTON
		indexing
			description: "No button"
			external_name: "NoButton"
		end
		
feature -- Basic Operations

	initialize_gui is
		indexing
			description: "Initialize GUI."
			external_name: "InitializeGUI"
		local
			a_size: SYSTEM_DRAWING_SIZE
			a_point: SYSTEM_DRAWING_POINT
			label_font: SYSTEM_DRAWING_FONT
			on_yes_event_handler_delegate: SYSTEM_EVENTHANDLER
			on_no_event_handler_delegate: SYSTEM_EVENTHANDLER
			border_style: SYSTEM_WINDOWS_FORMS_FORMBORDERSTYLE
			style: SYSTEM_DRAWING_FONTSTYLE
			retried: BOOLEAN
			returned_value: SYSTEM_WINDOWS_FORMS_DIALOGRESULT
			message_box_buttons: SYSTEM_WINDOWS_FORMS_MESSAGEBOXBUTTONS
			message_box_icon: SYSTEM_WINDOWS_FORMS_MESSAGEBOXICON 
			windows_message_box: SYSTEM_WINDOWS_FORMS_MESSAGEBOX	
		do
			set_Enabled (True)
			set_text (dictionary.Title)
			set_border_style (border_style.fixed_single)
			a_size.set_Width (dictionary.Window_width)
			a_size.set_Height (dictionary.Window_height)
			set_size (a_size)	
			if not retried then
				set_icon (dictionary.Assembly_manager_icon)
			else
				returned_value := windows_message_box.show_string_string_message_box_buttons_message_box_icon (dictionary.Pixmap_not_found_error, dictionary.Error_caption, message_box_buttons.Ok, message_box_icon.Error)
			end
			set_maximize_box (False)

				-- Assembly name
			create assembly_label.make_label
			assembly_label.set_text (assembly_descriptor.get_name)
			a_point.set_X (dictionary.Margin)
			a_point.set_Y (dictionary.Margin)
			assembly_label.set_location (a_point)
			a_size.set_Height (dictionary.Label_height)
			assembly_label.set_size (a_size)
			create label_font.make_font_10 (dictionary.Font_family_name, dictionary.Font_size, style.Bold)  
			assembly_label.set_font (label_font)
			
			create_assembly_labels
			
				-- `Dependancies: '
			build_table
			a_size.set_width (dictionary.Window_width - dictionary.Margin // 2)
			a_size.set_height (dictionary.Window_height - 7 * Dictionary.Margin - 4 * dictionary.Label_height - dictionary.Button_height)
			data_grid.set_Size (a_size)
			data_grid.set_caption_text (caption_text)
			display_dependancies
			get_controls.extend (data_grid)

				-- Question to the user
			create question_label.make_label
			question_label.set_text (Question_label_text)
			a_point.set_X (dictionary.Margin)
			a_point.set_Y (dictionary.Window_height - 4 * dictionary.Margin - dictionary.Label_height - dictionary.Button_height)
			question_label.set_location (a_point)
			question_label.set_auto_size (True)	
			question_label.set_font (label_font)
			
				-- Yes button
			create yes_button.make_button
			a_point.set_X ((dictionary.Window_width // 2) - dictionary.Button_width - (dictionary.Margin //2))
			a_point.set_Y (dictionary.Window_height - 3 * dictionary.Margin - dictionary.Button_height)
			yes_button.set_location (a_point)
			yes_button.set_width (dictionary.Button_width)
			yes_button.set_height (dictionary.Button_height)
			yes_button.set_text (dictionary.Yes_button_label)
			create on_yes_event_handler_delegate.make_eventhandler (Current, $on_yes_event_handler)
			yes_button.add_Click (on_yes_event_handler_delegate)

				-- No button
			create no_button.make_button
			a_point.set_X ((dictionary.Window_width // 2) + (dictionary.Margin //2))
			a_point.set_Y (dictionary.Window_height - 3 * dictionary.Margin - dictionary.Button_height)
			no_button.set_location (a_point)
			no_button.set_width (dictionary.Button_width)
			no_button.set_height (dictionary.Button_height)
			no_button.set_text (dictionary.No_button_label)
			create on_no_event_handler_delegate.make_eventhandler (Current, $on_no_event_handler)
			no_button.add_Click (on_no_event_handler_delegate)
			
				-- Addition of get_controls
			get_controls.extend (assembly_label)
			get_controls.extend (dependancies_label)
			get_controls.extend (question_label)
			get_controls.extend (yes_button)
			get_controls.extend (no_button)
		rescue
			retried := True
			retry
		end

feature -- Event handling

	on_yes_event_handler (sender: ANY; arguments: SYSTEM_EVENTARGS) is
		indexing	
			description: "Process `yes_button' activation."
			external_name: "OnYesEventHandler"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		local
			an_array: ARRAY [ANY]
			object_invoked: ANY
			retried: BOOLEAN
		do
			close
			if not retried then
				create an_array.make (0)
				object_invoked := call_back.dynamic_invoke (an_array)
			end
		rescue
			retried := True
			retry
		end

	on_no_event_handler (sender: ANY; arguments: SYSTEM_EVENTARGS) is
		indexing
			description: "Process `no_button' activation."
			external_name: "OnNoEventHandler"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		do
			close
		end
			
end -- class WARNING_DIALOG
