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
			description: "[Set `assembly_descriptor' with `an_assembly_descriptor'.%
					%Set `dependancies' with `assembly_dependancies'.]"
			external_name: "Make"
		require
			non_void_assembly_descriptor: an_assembly_descriptor /= Void
			non_void_assembly_name: an_assembly_descriptor.name /= Void
			not_empty_assembly_name: an_assembly_descriptor.name.Length > 0
			non_void_dependancies: assembly_dependancies /= Void
		local
			return_value: INTEGER
		do
			make_form
			assembly_descriptor := an_assembly_descriptor
			dependancies := assembly_dependancies
			initialize_gui
			return_value := showdialog
		ensure
			assembly_descriptor_set: assembly_descriptor = an_assembly_descriptor
			dependancies_set: dependancies = assembly_dependancies
		end

feature -- Access

	non_removable_assemblies: SYSTEM_COLLECTIONS_ARRAYLIST is
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [ISE_REFLECTION_ASSEMBLYDESCRIPTOR]
		indexing
			description: "List of assemblies that cannot be removed from the Eiffel assembly cache"
			external_name: "NonRemovableAssemblies"
		local
			special_assemblies: SPECIAL_ASSEMBLIES
		once
			create special_assemblies
			Result := special_assemblies.non_removable_assemblies
		ensure
			non_removable_assemblies_created: Result /= Void
		end
		
	dependancies: ARRAY [SYSTEM_REFLECTION_ASSEMBLYNAME]
		indexing
			description: "Assembly dependancies"
			external_name: "Dependancies"
		end
		
	dictionary: REMOVE_DIALOG_DICTIONARY is
		indexing
			description: "Dictionary"
			external_name: "Dictionary"
		once
			create Result
		end
	
	question_label: SYSTEM_WINDOWS_FORMS_LABEL
		indexing
			description: "Question label"
			external_name: "QuestionLabel"
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

feature -- Status Setting

	is_non_removable_assembly (a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR): BOOLEAN is
		indexing
			description: "Is assembly corresponding to `a_descriptor' a non-removable assembly?"
			external_name: "IsNonRemovableAssembly"
		require
			non_void_descriptor: a_descriptor /= Void
		local
			i: INTEGER
			an_assembly_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR
		do
			from
			until
				i = non_removable_assemblies.count or Result
			loop
				an_assembly_descriptor ?= non_removable_assemblies.item (i)
				if an_assembly_descriptor /= Void then
					Result := an_assembly_descriptor.name.tolower.equals_string (a_descriptor.name.tolower) and
							an_assembly_descriptor.version.tolower.equals_string (a_descriptor.version.tolower) and
							an_assembly_descriptor.culture.tolower.equals_string (a_descriptor.culture.tolower) and
							an_assembly_descriptor.publickey.tolower.equals_string (a_descriptor.publickey.tolower) 
				end
				i := i + 1
			end
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
			a_font: SYSTEM_DRAWING_FONT
			on_yes_event_handler_delegate: SYSTEM_EVENTHANDLER
			on_no_event_handler_delegate: SYSTEM_EVENTHANDLER
		do
			set_Enabled (True)
			set_text (dictionary.Title)
			set_borderstyle (dictionary.Border_style)
			a_size.set_Width (dictionary.Window_width)
			a_size.set_Height (dictionary.Window_height)
			set_size (a_size)	
			set_icon (dictionary.Remove_icon)
			set_maximizebox (False)

				-- Assembly name
			create assembly_label.make_label
			assembly_label.set_text (assembly_descriptor.name)
			a_point.set_X (dictionary.Margin)
			a_point.set_Y (dictionary.Margin)
			assembly_label.set_location (a_point)
			a_size.set_Height (dictionary.Label_height)
			assembly_label.set_size (a_size)
			create label_font.make_font_10 (dictionary.Font_family_name, dictionary.Font_size,  dictionary.Bold_style) 
			assembly_label.set_font (label_font)
			
			create_assembly_labels

				-- Question to the user
			create question_label.make_label
			question_label.set_text (dictionary.Question_label_text)
			a_point.set_X (dictionary.Margin)
			a_point.set_Y (2 * dictionary.Margin +  4 * dictionary.Label_height)
			question_label.set_location (a_point)
			question_label.set_autosize (True)	
			question_label.set_font (label_font)
						
				-- Yes button
			create yes_button.make_button
			a_point.set_X ((dictionary.Window_width // 2) - dictionary.Button_width - (dictionary.Margin //2))
			a_point.set_Y (dictionary.Window_height - 3 * dictionary.Margin - dictionary.Button_height)
			yes_button.set_location (a_point)
			yes_button.set_height (dictionary.Button_height)
			yes_button.set_width (dictionary.Button_width)
			yes_button.set_text (dictionary.Yes_button_label)
			create on_yes_event_handler_delegate.make_eventhandler (Current, $on_yes_event_handler)
			yes_button.add_Click (on_yes_event_handler_delegate)

				-- No button
			create no_button.make_button
			a_point.set_X ((dictionary.Window_width // 2) + (dictionary.Margin //2))
			a_point.set_Y (dictionary.Window_height - 3 * dictionary.Margin - dictionary.Button_height)
			no_button.set_location (a_point)
			no_button.set_text (dictionary.No_button_label)
			no_button.set_height (dictionary.Button_height)
			no_button.set_width (dictionary.Button_width)
			create on_no_event_handler_delegate.make_eventhandler (Current, $on_no_event_handler)
			no_button.add_Click (on_no_event_handler_delegate)
			
				-- Addition of controls
			controls.add (assembly_label)
			controls.add (question_label)
			controls.add (yes_button)
			controls.add (no_button)
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
			warning_dialog: WARNING_DIALOG
			returned_value: INTEGER
			message_box: SYSTEM_WINDOWS_FORMS_MESSAGEBOX
		do
			if not is_non_removable_assembly (assembly_descriptor) then
				remove_assembly
				close
			else
				close
				returned_value := message_box.show_string_string_messageboxbuttons_messageboxicon (dictionary.Non_removable_assembly, dictionary.Error_caption, dictionary.Ok_message_box_button, dictionary.Error_icon)
			end
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
		
feature {NONE} -- Implementation
		
	remove_assembly is
		indexing
			description: "Remove the assembly corresponding to `assembly_descriptor'."
			external_name: "RemoveAssembly"
		require
			non_void_assembly_descriptor: assembly_descriptor /= Void
		local
			reflection_interface: ISE_REFLECTION_REFLECTIONINTERFACE
			retried: BOOLEAN
			returned_value: INTEGER
			message_box: SYSTEM_WINDOWS_FORMS_MESSAGEBOX
		do
			if not retried then
				create reflection_interface.make_reflectioninterface
				reflection_interface.MakeReflectionInterface
				reflection_interface.removeassembly (assembly_descriptor)
			else
				if reflection_interface.lasterror /= Void and then reflection_interface.lasterror.description /= Void and then reflection_interface.lasterror.description.length > 0 then
					returned_value := message_box.show_string_string_messageboxbuttons_messageboxicon (reflection_interface.lasterror.description, dictionary.Error_caption, dictionary.Ok_message_box_button, dictionary.Error_icon)
				end
			end
		rescue
			retried := True
			retry
		end
		
end -- class REMOVE_DIALOG
