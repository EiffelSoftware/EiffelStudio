indexing
	description: "Enable user to import a .NET assembly."
	external_name: "ISE.AssemblyManager.EiffelGenerationDialog"

class
	EIFFEL_GENERATION_DIALOG

inherit
	GENERATION_DIALOG
		redefine
			dictionary
		end
		
create
	make

feature {NONE} -- Initialization

	make (an_assembly_descriptor: like assembly_descriptor; an_eiffel_path: like eiffel_path) is
			-- Set `assembly_descriptor' with `an_assembly_descriptor'.
			-- Set `eiffel_path' with `an_eiffel_path'.
		indexing
			external_name: "Make"
		require
			non_void_assembly_descriptor: an_assembly_descriptor /= Void
			non_void_assembly_name: an_assembly_descriptor.name /= Void
			not_empty_assembly_name: an_assembly_descriptor.name.length > 0
			non_void_eiffel_path: an_eiffel_path /= Void
		local
			return_value: INTEGER
		do
			make_form
			assembly_descriptor := an_assembly_descriptor
			eiffel_path := an_eiffel_path
			initialize_gui
			return_value := showdialog
		ensure
			assembly_descriptor_set: assembly_descriptor = an_assembly_descriptor
			eiffel_path_set: eiffel_path.equals_string (an_eiffel_path)
		end
		
feature -- Access
		
	dictionary: EIFFEL_GENERATION_DIALOG_DICTIONARY is
			-- Dictionary
		indexing
			external_name: "Dictionary"
		once
			create Result
		end

	eiffel_path: STRING 
		indexing
			description: "Path to Eiffel sources"
			external_name: "EiffelPath"
		end
		
feature -- Basic Operations

	initialize_gui is
			-- Initialize GUI.
		indexing
			external_name: "InitializeGUI"
		local
			a_size: SYSTEM_DRAWING_SIZE
			a_point: SYSTEM_DRAWING_POINT
			label_font: SYSTEM_DRAWING_FONT
			a_font: SYSTEM_DRAWING_FONT
			on_ok_event_handler_delegate: SYSTEM_EVENTHANDLER
			on_cancel_event_handler_delegate: SYSTEM_EVENTHANDLER
			support: ISE_REFLECTION_CODEGENERATIONSUPPORT
		do	
			initialize
			set_text (dictionary.Title)
			a_size.set_Height (dictionary.Window_height)
			a_size.set_Width (dictionary.Window_width)
			set_size (a_size)
			set_icon (dictionary.Eiffel_generation_icon)
			
			create support.make_codegenerationsupport
			support.make
			if not support.validpath (eiffel_path) then
				support.createfolder (eiffel_path)
			end
			destination_path_text_box.set_text (eiffel_path)
			
				-- OK button
			create ok_button.make_button
			a_point.set_X ((dictionary.Window_width // 2) - (dictionary.Margin //2) - dictionary.Button_width) 
			a_point.set_Y (5 * dictionary.Margin + 8 * dictionary.Label_height)
			ok_button.set_location (a_point)
			ok_button.set_text (dictionary.Ok_button_label)
			ok_button.set_height (dictionary.Button_height)
			ok_button.set_width (dictionary.Button_width)
			create on_ok_event_handler_delegate.make_eventhandler (Current, $on_ok_event_handler)
			ok_button.add_Click (on_ok_event_handler_delegate)

				-- Cancel button
			create cancel_button.make_button
			a_point.set_X ((dictionary.Window_width // 2) + (dictionary.Margin //2))
			a_point.set_Y (5 * dictionary.Margin + 8 * dictionary.Label_height)
			cancel_button.set_location (a_point)
			cancel_button.set_height (dictionary.Button_height)
			cancel_button.set_width (dictionary.Button_width)
			cancel_button.set_text (dictionary.Cancel_button_label)
			create on_cancel_event_handler_delegate.make_eventhandler (Current, $on_cancel_event_handler)
			cancel_button.add_Click (on_cancel_event_handler_delegate)
			
				-- Addition of controls
			controls.add (ok_button)
			controls.add (cancel_button)
		end
		
feature -- Event handling

	on_ok_event_handler (sender: ANY; arguments: SYSTEM_EVENTARGS) is
			-- Process `ok_button' activation.
		indexing
			external_name: "OnOkEventHandler"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		do
			generate_eiffel_classes
		end

feature {NONE} -- Implementation

	generate_eiffel_classes is
			-- Generate Eiffel classes for the assembly corresponding to `assembly_descriptor' without its dependancies.
		indexing
			external_name: "GenerateEiffelClasses"
		require	
			non_void_assembly_descriptor: assembly_descriptor /= Void
		local
			assembly_name: SYSTEM_REFLECTION_ASSEMBLYNAME
			assembly: SYSTEM_REFLECTION_ASSEMBLY
			conversion_support: ISE_REFLECTION_CONVERSIONSUPPORT
			emitter: NEWEIFFELCLASSGENERATOR
			returned_value: INTEGER
			message_box: SYSTEM_WINDOWS_FORMS_MESSAGEBOX	
			retried: BOOLEAN
		do
			if not retried then
				create conversion_support.make_conversionsupport
				assembly_name := conversion_support.assemblynamefromdescriptor (assembly_descriptor)
				assembly := assembly.load (assembly_name)
				returned_value := message_box.show_string_string_messageboxbuttons_messageboxicon (dictionary.Assembly_generation_message, dictionary.Confirmation_caption, dictionary.Ok_cancel_message_box_buttons, dictionary.Question_icon)
				close
				if returned_value /= dictionary.Cancel then
					create emitter.make_neweiffelclassgenerator
					if destination_path_text_box.text /= Void and then destination_path_text_box.text.length > 0 then
						put_environment_variable
						if destination_path_text_box.text.tolower.equals_string (eiffel_path.tolower) then
							emitter.generateeiffelclassesfromxml (assembly)
						else
						--	Pb: Update xml files (with correct path to Eiffel sources)
						end
					else
						returned_value := message_box.show_string_string_messageboxbuttons_messageboxicon (dictionary.No_path, dictionary.Error_caption, dictionary.Ok_message_box_button, dictionary.Error_icon)
					end	
				end
			else
				returned_value := message_box.show_string_string_messageboxbuttons_messageboxicon (dictionary.Eiffel_generation_error, dictionary.Error_caption, dictionary.Ok_message_box_button, dictionary.Error_icon)
			end
		rescue
			retried := True
			retry
		end
	
	put_environment_variable is
		indexing
			description: "Put an environment variable corresponding to the selected path"
			external_name: "PutEnvironmentVariable"
		require
			non_void_path: destination_path_text_box.text /= Void
			not_empty_path: destination_path_text_box.text.length > 0
		local
			process_info: SYSTEM_DIAGNOSTICS_PROCESSSTARTINFO
		do
			create process_info.make
			if process_info.environmentvariables.containskey (dictionary.Path_key) then
				process_info.environmentvariables.remove (dictionary.Path_key)
			end
			process_info.environmentvariables.add (dictionary.Path_key, destination_path_text_box.text)
		end
		
end -- class EIFFEL_GENERATION_DIALOG