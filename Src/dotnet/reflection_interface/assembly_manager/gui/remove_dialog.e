indexing
	description: "Dialog showing dependancies of a .NET assembly"
	external_name: "ISE.AssemblyManager.RemoveDialog"

class
	REMOVE_DIALOG
	
inherit
	DIALOG
		redefine
			dictionary
		end
		
create
	make

feature {NONE} -- Initialization

	make (an_assembly_descriptor: like assembly_descriptor; assembly_dependancies: like dependancies) is
		indexing
			description: "[
						Set `assembly_descriptor' with `an_assembly_descriptor'.
						Set `dependancies' with `assembly_dependancies'.
					  ]"
			external_name: "Make"
		require
			non_void_assembly_descriptor: an_assembly_descriptor /= Void
			non_void_assembly_name: an_assembly_descriptor.name /= Void
			not_empty_assembly_name: an_assembly_descriptor.name.count > 0
			non_void_dependancies: assembly_dependancies /= Void
		local
			return_value: WINFORMS_DIALOG_RESULT
		do
			create main_win.make_winforms_form
			assembly_descriptor := an_assembly_descriptor
			dependancies := assembly_dependancies
			initialize_gui
			return_value := main_win.show_dialog
		ensure
			assembly_descriptor_set: assembly_descriptor = an_assembly_descriptor
			dependancies_set: dependancies = assembly_dependancies
		end

feature -- Access
		
	dependancies: ARRAY [CLI_CELL [ASSEMBLY_NAME]]
		indexing
			description: "Assembly dependancies"
			external_name: "Dependancies"
		end

	non_removable_assemblies: LINKED_LIST [STRING] is
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [STRING]
		indexing
			description: "Non removable assemblies"
			external_name: "NonRemovableAssemblies"
		once
			create Result.make
			Result.extend (dictionary.Mscorlib_assembly_name)
			Result.extend (dictionary.System_assembly_name)
		ensure
			list_created: Result /= Void
			valid_list: Result.count = 2
		end
		
	dictionary: REMOVE_DIALOG_DICTIONARY is
		indexing
			description: "Dictionary"
			external_name: "Dictionary"
		once
			create Result
		end
	
	question_label: WINFORMS_LABEL
		indexing
			description: "Question label"
			external_name: "QuestionLabel"
		end
	
	yes_button: WINFORMS_BUTTON
		indexing
			description: "Yes button"
			external_name: "YesButton"
		end

	no_button: WINFORMS_BUTTON
		indexing
			description: "No button"
			external_name: "NoButton"
		end

feature -- Status Setting

	is_non_removable_assembly (a_descriptor: ASSEMBLY_DESCRIPTOR): BOOLEAN is
		indexing
			description: "Is assembly corresponding to `a_descriptor' a non-removable assembly?"
			external_name: "IsNonRemovableAssembly"
		require
			non_void_descriptor: a_descriptor /= Void
		local
			name: STRING
		do
			name := from_reflection_string (a_descriptor.name)
			name.to_lower
			Result := non_removable_assemblies.has (name)
		end
		
feature -- Basic Operations

	initialize_gui is
		indexing
			description: "Initialize GUI."
			external_name: "InitializeGUI"
		local
			a_size: DRAWING_SIZE
			a_point: DRAWING_POINT
			label_font: DRAWING_FONT
			a_font: DRAWING_FONT
			on_yes_event_handler_delegate: EVENT_HANDLER
			on_no_event_handler_delegate: EVENT_HANDLER
			border_style: WINFORMS_FORM_BORDER_STYLE
			style: DRAWING_FONT_STYLE
			retried: BOOLEAN
			returned_value: WINFORMS_DIALOG_RESULT
			message_box_buttons: WINFORMS_MESSAGE_BOX_BUTTONS
			message_box_icon: WINFORMS_MESSAGE_BOX_ICON 
			windows_message_box: WINFORMS_MESSAGE_BOX	
		do
			main_win.set_Enabled (True)
			main_win.set_text (dictionary.Title.to_cil)
			main_win.set_form_border_style (border_style.fixed_single)
			a_size.set_Width (dictionary.Window_width)
			a_size.set_Height (dictionary.Window_height)
			main_win.set_size (a_size)				
			if not retried then
				main_win.set_icon (dictionary.Remove_icon)
			else
				returned_value := windows_message_box.show_string_string_message_box_buttons_message_box_icon (dictionary.Pixmap_not_found_error.to_cil, dictionary.Error_caption.to_cil, message_box_buttons.Ok, message_box_icon.Error)
			end
			main_win.set_maximize_box (False)

				-- Assembly name
			create assembly_label.make_winforms_label
			assembly_label.set_text (assembly_descriptor.name.to_cil)
			a_point.set_X (dictionary.Margin)
			a_point.set_Y (dictionary.Margin)
			assembly_label.set_location (a_point)
			a_size.set_Height (dictionary.Label_height)
			assembly_label.set_size (a_size)
			create label_font.make_drawing_font_10 (dictionary.Font_family_name.to_cil, dictionary.Font_size, style.Bold) 
			assembly_label.set_font (label_font)
			
			create_assembly_labels

				-- Question to the user
			create question_label.make_winforms_label
			question_label.set_text (dictionary.Question_label_text.to_cil)
			a_point.set_X (dictionary.Margin)
			a_point.set_Y (2 * dictionary.Margin +  4 * dictionary.Label_height)
			question_label.set_location (a_point)
			question_label.set_auto_size (True)	
			question_label.set_font (label_font)
						
				-- Yes button
			create yes_button.make_winforms_button
			a_point.set_X ((dictionary.Window_width // 2) - dictionary.Button_width - (dictionary.Margin //2))
			a_point.set_Y (dictionary.Window_height - 3 * dictionary.Margin - dictionary.Button_height)
			yes_button.set_location (a_point)
			yes_button.set_height (dictionary.Button_height)
			yes_button.set_width (dictionary.Button_width)
			yes_button.set_text (dictionary.Yes_button_label.to_cil)
			create on_yes_event_handler_delegate.make_event_handler (Current, $on_yes_event_handler)
			yes_button.add_Click (on_yes_event_handler_delegate)

				-- No button
			create no_button.make_winforms_button
			a_point.set_X ((dictionary.Window_width // 2) + (dictionary.Margin //2))
			a_point.set_Y (dictionary.Window_height - 3 * dictionary.Margin - dictionary.Button_height)
			no_button.set_location (a_point)
			no_button.set_text (dictionary.No_button_label.to_cil)
			no_button.set_height (dictionary.Button_height)
			no_button.set_width (dictionary.Button_width)
			create on_no_event_handler_delegate.make_event_handler (Current, $on_no_event_handler)
			no_button.add_Click (on_no_event_handler_delegate)
			
				-- Addition of get_controls
			main_win.get_controls.add (assembly_label)
			main_win.get_controls.add (question_label)
			main_win.get_controls.add (yes_button)
			main_win.get_controls.add (no_button)
		rescue
			retried := True
			retry
		end

feature -- Event handling

	on_yes_event_handler (sender: SYSTEM_OBJECT; arguments: EVENT_ARGS) is
		indexing
			description: "Process `yes_button' activation."
			external_name: "OnYesEventHandler"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		local
			warning_dialog: WARNING_DIALOG
			returned_value: WINFORMS_DIALOG_RESULT
			message_box_buttons: WINFORMS_MESSAGE_BOX_BUTTONS
			message_box_icon: WINFORMS_MESSAGE_BOX_ICON
			message_box: WINFORMS_MESSAGE_BOX
		do
			if not is_non_removable_assembly (assembly_descriptor) then
				remove_assembly
				main_win.close
			else
				main_win.close
				returned_value := message_box.show_string_string_message_box_buttons_message_box_icon (dictionary.Non_removable_assembly.to_cil, dictionary.Error_caption.to_cil, message_box_buttons.Ok, message_box_icon.Error)
			end
		end

	on_no_event_handler (sender: SYSTEM_OBJECT; arguments: EVENT_ARGS) is
		indexing
			description: "Process `no_button' activation."
			external_name: "OnNoEventHandler"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		do
			main_win.close
		end
		
feature {NONE} -- Implementation
		
	remove_assembly is
		indexing
			description: "Remove the assembly corresponding to `assembly_descriptor'."
			external_name: "RemoveAssembly"
		require
			non_void_assembly_descriptor: assembly_descriptor /= Void
		local
			reflection_interface: REFLECTION_INTERFACE
			retried: BOOLEAN
			returned_value: WINFORMS_DIALOG_RESULT
			message_box_buttons: WINFORMS_MESSAGE_BOX_BUTTONS
			message_box_icon: WINFORMS_MESSAGE_BOX_ICON
			message_box: WINFORMS_MESSAGE_BOX
		do
			if not retried then
				create reflection_interface.make_reflection_interface
				--reflection_interface.Make_Reflection_Interface
				reflection_interface.remove_assembly (assembly_descriptor)
			else
				if reflection_interface.last_error /= Void and then reflection_interface.last_error.description /= Void and then reflection_interface.last_error.description.count > 0 then
					returned_value := message_box.show_string_string_message_box_buttons_message_box_icon (reflection_interface.last_error.description.to_cil, dictionary.Error_caption.to_cil, message_box_buttons.Ok, message_box_icon.Error)
				end
			end
		rescue
			retried := True
			retry
		end
		
end -- class REMOVE_DIALOG
