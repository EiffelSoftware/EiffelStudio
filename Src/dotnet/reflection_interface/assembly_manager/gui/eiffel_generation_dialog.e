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
		indexing
			description: "[Set `assembly_descriptor' with `an_assembly_descriptor'.%
					%Set `eiffel_path' with `an_eiffel_path'.]"
			external_name: "Make"
		require
			non_void_assembly_descriptor: an_assembly_descriptor /= Void
			non_void_assembly_name: an_assembly_descriptor.get_name /= Void
			not_empty_assembly_name: an_assembly_descriptor.get_name.get_length > 0
			non_void_eiffel_path: an_eiffel_path /= Void
		local
			return_value: SYSTEM_WINDOWS_FORMS_DIALOGRESULT
		do
			make_form
			assembly_descriptor := an_assembly_descriptor
			eiffel_path := an_eiffel_path
			initialize_gui
			return_value := show_dialog
		ensure
			assembly_descriptor_set: assembly_descriptor = an_assembly_descriptor
			eiffel_path_set: eiffel_path.equals_string (an_eiffel_path)
		end
		
feature -- Access
		
	dictionary: EIFFEL_GENERATION_DIALOG_DICTIONARY is
		indexing
			description: "Dictionary"
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
		indexing
			description: "Initialize GUI."
			external_name: "InitializeGUI"
		local
			a_size: SYSTEM_DRAWING_SIZE
			a_point: SYSTEM_DRAWING_POINT
			label_font: SYSTEM_DRAWING_FONT
			a_font: SYSTEM_DRAWING_FONT
			on_ok_event_handler_delegate: SYSTEM_EVENTHANDLER
			on_cancel_event_handler_delegate: SYSTEM_EVENTHANDLER
			support: ISE_REFLECTION_CODEGENERATIONSUPPORT
			retried: BOOLEAN
			returned_value: SYSTEM_WINDOWS_FORMS_DIALOGRESULT
			message_box_buttons: SYSTEM_WINDOWS_FORMS_MESSAGEBOXBUTTONS
			message_box_icon: SYSTEM_WINDOWS_FORMS_MESSAGEBOXICON 
			windows_message_box: SYSTEM_WINDOWS_FORMS_MESSAGEBOX
		do	
			initialize
			set_text (dictionary.Title)
			a_size.set_Height (dictionary.Window_height)
			a_size.set_Width (dictionary.Window_width)
			set_size (a_size)
			if not retried then
				set_icon (dictionary.Eiffel_generation_icon)
			else
				returned_value := windows_message_box.show_string_string_message_box_buttons_message_box_icon (dictionary.Pixmap_not_found_error, dictionary.Error_caption, message_box_buttons.Ok, message_box_icon.Error)
			end

			create support.make_codegenerationsupport
			support.make
			if not support.valid_path (eiffel_path) then
				support.create_folder (eiffel_path)
			end
			destination_path_text_box.set_text (eiffel_path)
			
				-- OK button
			create ok_button.make_button
			a_point.set_X ((dictionary.Window_width // 2) - (dictionary.Margin //2) - dictionary.Button_width) 
			a_point.set_Y (5 * dictionary.Margin + 9 * dictionary.Label_height)
			ok_button.set_location (a_point)
			ok_button.set_text (dictionary.Ok_button_label)
			ok_button.set_height (dictionary.Button_height)
			ok_button.set_width (dictionary.Button_width)
			create on_ok_event_handler_delegate.make_eventhandler (Current, $on_ok_event_handler)
			ok_button.add_Click (on_ok_event_handler_delegate)

				-- Cancel button
			create cancel_button.make_button
			a_point.set_X ((dictionary.Window_width // 2) + (dictionary.Margin //2))
			a_point.set_Y (5 * dictionary.Margin + 9 * dictionary.Label_height)
			cancel_button.set_location (a_point)
			cancel_button.set_height (dictionary.Button_height)
			cancel_button.set_width (dictionary.Button_width)
			cancel_button.set_text (dictionary.Cancel_button_label)
			create on_cancel_event_handler_delegate.make_eventhandler (Current, $on_cancel_event_handler)
			cancel_button.add_Click (on_cancel_event_handler_delegate)
			
				-- Addition of get_controls
			get_controls.add (ok_button)
			get_controls.add (cancel_button)
		rescue
			retried := True
			retry
		end
		
feature -- Event handling

	on_ok_event_handler (sender: ANY; arguments: SYSTEM_EVENTARGS) is
		indexing
			description: "Process `ok_button' activation."
			external_name: "OnOkEventHandler"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		do
			generate_eiffel_classes
		end

feature {NONE} -- Implementation

	generate_eiffel_classes is
		indexing
			description: "Generate Eiffel classes for the assembly corresponding to `assembly_descriptor' without its dependancies."
			external_name: "GenerateEiffelClasses"
		require	
			non_void_assembly_descriptor: assembly_descriptor /= Void
		local
			message_box: MESSAGE_BOX	
			generate_delegate: SYSTEM_EVENTHANDLER
		do
			create generate_delegate.make_eventhandler (Current, $generate_classes)
			create message_box.make (dictionary.Assembly_generation_message, generate_delegate)
		end
	
	generate_classes (sender: ANY; arguments: SYSTEM_EVENTARGS) is
		indexing
			description: "Generate Eiffel classes for the assembly corresponding to `assembly_descriptor' without its dependancies."
			external_name: "GenerateClasses"
		require	
			non_void_assembly_descriptor: assembly_descriptor /= Void
			non_void_sender: sender /= Void
		local
			support: ISE_REFLECTION_REFLECTIONSUPPORT
			assembly_filename: STRING
			type_filename: STRING
			i: INTEGER
			code_generator_from_xml: ISE_REFLECTION_EIFFELCODEGENERATORFROMXML
			reflection_interface: ISE_REFLECTION_REFLECTIONINTERFACE
			eiffel_assembly: ISE_REFLECTION_EIFFELASSEMBLY
			assembly_types: SYSTEM_COLLECTIONS_ARRAYLIST
			a_type: ISE_REFLECTION_EIFFELCLASS
			returned_value: SYSTEM_WINDOWS_FORMS_DIALOGRESULT
			message_box_buttons: SYSTEM_WINDOWS_FORMS_MESSAGEBOXBUTTONS
			message_box_icon: SYSTEM_WINDOWS_FORMS_MESSAGEBOXICON
			windows_message_box: SYSTEM_WINDOWS_FORMS_MESSAGEBOX	
			retried: BOOLEAN
			message_box: MESSAGE_BOX
		do	
			message_box ?= sender
			if message_box /= Void then
				message_box.refresh
				if not retried then
					close
					create support.make_reflectionsupport
					support.make
					assembly_filename := support.Xml_assembly_filename (assembly_descriptor)
					assembly_filename := assembly_filename.replace (support.Eiffel_key, support.Eiffel_delivery_path)
					if assembly_filename /= Void and then assembly_filename.get_length > 0 then
						if destination_path_text_box.get_text /= Void and then destination_path_text_box.get_text.get_length > 0 then
							create code_generator_from_xml.make1
							create reflection_interface.make_reflectioninterface
							reflection_interface.make_reflection_interface
							reflection_interface.search (assembly_descriptor)
							eiffel_assembly := reflection_interface.get_search_result
							if eiffel_assembly /= Void then
								assembly_types := eiffel_assembly.types
								if destination_path_text_box.get_text.to_lower.equals_string (eiffel_path.to_lower) then
									code_generator_from_xml.make_from_info (assembly_filename)
									from
									until
										i = assembly_types.get_count
									loop
										a_type ?= assembly_types.get_item (i)
										if a_type /= Void then
											type_filename := support.Xml_type_filename (assembly_descriptor, a_type.get_full_external_name)
											type_filename := type_filename.replace (support.Eiffel_key, support.Eiffel_delivery_path)
											code_generator_from_xml.generate_eiffel_code_from_xml (type_filename)
										end
										i := i + 1
									end
									message_box.close
								else								
									code_generator_from_xml.make_from_info_and_path (assembly_filename, destination_path_text_box.get_text)
									from
									until
										i = assembly_types.get_count
									loop
										a_type ?= assembly_types.get_item (i)
										if a_type /= Void then
											type_filename := support.Xml_type_filename (assembly_descriptor, a_type.get_full_external_name)
											code_generator_from_xml.generate_eiffel_code_from_xml_and_path (type_filename, destination_path_text_box.get_text)
										end
										i := i + 1
									end
									message_box.close
								end
							end
						else
							message_box.close
							returned_value := windows_message_box.show_string_string_message_box_buttons_message_box_icon (dictionary.No_path, dictionary.Error_caption, message_box_buttons.Ok, message_box_icon.Error)
						end
					end
				else
					message_box.close
					returned_value := windows_message_box.show_string_string_message_box_buttons_message_box_icon (dictionary.Eiffel_generation_error, dictionary.Error_caption, message_box_buttons.Ok, message_box_icon.Error)
				end
			end
		rescue
			retried := True
			retry
		end
		
end -- class EIFFEL_GENERATION_DIALOG