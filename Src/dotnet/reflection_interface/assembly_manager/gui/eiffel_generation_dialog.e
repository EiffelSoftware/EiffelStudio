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
			description: "[
						Set `assembly_descriptor' with `an_assembly_descriptor'.
						Set `eiffel_path' with `an_eiffel_path'.
					  ]"
			external_name: "Make"
		require
			non_void_assembly_descriptor: an_assembly_descriptor /= Void
			non_void_assembly_name: an_assembly_descriptor.name /= Void
			not_empty_assembly_name: an_assembly_descriptor.name.count > 0
			non_void_eiffel_path: an_eiffel_path /= Void
		local
			return_value: WINFORMS_DIALOG_RESULT
		do
			create main_win.make_winforms_form
			assembly_descriptor := an_assembly_descriptor
			eiffel_path := an_eiffel_path
			initialize_gui
			return_value := main_win.show_dialog
		ensure
			assembly_descriptor_set: assembly_descriptor = an_assembly_descriptor
			eiffel_path_set: eiffel_path.is_equal (an_eiffel_path)
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
			a_size: DRAWING_SIZE
			a_point: DRAWING_POINT
			label_font: DRAWING_FONT
			a_font: DRAWING_FONT
			on_ok_event_handler_delegate: EVENT_HANDLER
			on_cancel_event_handler_delegate: EVENT_HANDLER
			support: CODE_GENERATION_SUPPORT
			retried: BOOLEAN
			returned_value: WINFORMS_DIALOG_RESULT
			message_box_buttons: WINFORMS_MESSAGE_BOX_BUTTONS
			message_box_icon: WINFORMS_MESSAGE_BOX_ICON 
			windows_message_box: WINFORMS_MESSAGE_BOX
			checked_changed_delegate: EVENT_HANDLER
		do	
			initialize
			main_win.set_text (dictionary.Title.to_cil)
			a_size.set_Height (dictionary.Window_height)
			a_size.set_Width (dictionary.Window_width)
			main_win.set_size (a_size)
			if not retried then
				main_win.set_icon (dictionary.Eiffel_generation_icon)
			else
				returned_value := windows_message_box.show_string_string_message_box_buttons_message_box_icon (dictionary.Pixmap_not_found_error.to_cil, dictionary.Error_caption.to_cil, message_box_buttons.Ok, message_box_icon.Error)
			end

			create support.make
			--support.make
			if not support.is_valid_directory_path ( to_reflection_string (eiffel_path) ) then
				support.create_folder ( to_reflection_string (eiffel_path) )
			end
			destination_path_text_box.set_text (eiffel_path.to_cil)

				-- Default path check box
			create default_path_check_box.make_winforms_check_box
			default_path_check_box.set_text (dictionary.Default_path_check_box_text.to_cil)
			default_path_check_box.set_font (a_font)
			a_point.set_X (dictionary.Margin)
			a_point.set_Y (4 * dictionary.Margin + 7 * dictionary.Label_height)
			default_path_check_box.set_location (a_point)
			a_size.set_height (dictionary.Label_height)
			a_size.set_width (dictionary.Window_width - 2 * dictionary.Margin)
			default_path_check_box.set_size (a_size)
			default_path_check_box.set_checked (True)
			default_path_check_box.set_auto_check (True)
			main_win.get_controls.add (default_path_check_box)
			create checked_changed_delegate.make_event_handler (Current, $on_check)
			default_path_check_box.add_checked_changed (checked_changed_delegate)
			
				-- OK button
			create ok_button.make_winforms_button
			a_point.set_X ((dictionary.Window_width // 2) - (dictionary.Margin //2) - dictionary.Button_width) 
			a_point.set_Y (5 * dictionary.Margin + 8 * dictionary.Label_height)
			ok_button.set_location (a_point)
			ok_button.set_text (dictionary.Ok_button_label.to_cil)
			ok_button.set_height (dictionary.Button_height)
			ok_button.set_width (dictionary.Button_width)
			create on_ok_event_handler_delegate.make_event_handler (Current, $on_ok_event_handler)
			ok_button.add_Click (on_ok_event_handler_delegate)

				-- Cancel button
			create cancel_button.make_winforms_button
			a_point.set_X ((dictionary.Window_width // 2) + (dictionary.Margin //2))
			a_point.set_Y (5 * dictionary.Margin + 8 * dictionary.Label_height)
			cancel_button.set_location (a_point)
			cancel_button.set_height (dictionary.Button_height)
			cancel_button.set_width (dictionary.Button_width)
			cancel_button.set_text (dictionary.Cancel_button_label.to_cil)
			create on_cancel_event_handler_delegate.make_event_handler (Current, $on_cancel_event_handler)
			cancel_button.add_Click (on_cancel_event_handler_delegate)
			
				-- Addition of get_controls
			main_win.get_controls.add (ok_button)
			main_win.get_controls.add (cancel_button)
		rescue
			retried := True
			retry
		end
		
feature -- Event handling

	on_ok_event_handler (sender: SYSTEM_OBJECT; arguments: EVENT_HANDLER) is
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
			generate_delegate: EVENT_HANDLER
		do
			create generate_delegate.make_event_handler (Current, $generate_classes)
			create message_box.make (dictionary.Assembly_generation_message, generate_delegate)
		end
	
	generate_classes (sender: SYSTEM_OBJECT; arguments: EVENT_HANDLER) is
		indexing
			description: "Generate Eiffel classes for the assembly corresponding to `assembly_descriptor' without its dependancies."
			external_name: "GenerateClasses"
		require	
			non_void_assembly_descriptor: assembly_descriptor /= Void
			non_void_sender: sender /= Void
		local
			support: REFLECTION_SUPPORT
			assembly_filename: STRING
			type_filename: STRING
			i: INTEGER
			code_generator_from_xml: EIFFEL_CODE_GENERATOR_FROM_XML
			reflection_interface: REFLECTION_INTERFACE
			eiffel_assembly: EIFFEL_ASSEMBLY
			assembly_types: LINKED_LIST [EIFFEL_CLASS]
			a_type: EIFFEL_CLASS
			returned_value: WINFORMS_DIALOG_RESULT
			message_box_buttons: WINFORMS_MESSAGE_BOX_BUTTONS
			message_box_icon: WINFORMS_MESSAGE_BOX_ICON
			windows_message_box: WINFORMS_MESSAGE_BOX	
			retried: BOOLEAN
			message_box: MESSAGE_BOX
		do	
			message_box ?= sender
			if message_box /= Void then
				message_box.main_win.refresh
				if not retried then
					main_win.close
					create support.make
					assembly_filename := support.Xml_assembly_filename (assembly_descriptor)
					assembly_filename.replace_substring_all (support.Eiffel_key, support.Eiffel_delivery_path)
					if assembly_filename /= Void and then assembly_filename.count > 0 then
						if destination_path_text_box.get_text /= Void and then destination_path_text_box.get_text.get_length > 0 then
							--code_generator_from_xml := create {EIFFEL_CODE_GENERATOR_FROM_XML}.make
							create reflection_interface.make_reflection_interface
							reflection_interface.search (assembly_descriptor)
							eiffel_assembly := reflection_interface.search_result
							if eiffel_assembly /= Void then
								assembly_types := eiffel_assembly.types
								if destination_path_text_box.get_text.to_lower.equals (eiffel_path.to_cil.to_lower) then
									create code_generator_from_xml.make_from_info (assembly_filename)
									from
										assembly_types.start
									until
										assembly_types.after
									loop
										a_type ?= assembly_types.item
										if a_type /= Void then
											type_filename := support.Xml_type_filename (assembly_descriptor, a_type.full_external_name)
											type_filename.replace_substring_all (support.Eiffel_key, support.Eiffel_delivery_path)
											code_generator_from_xml.generate_eiffel_code_from_xml (type_filename)
										end
										assembly_types.forth
									end
									message_box.main_win.close
								else								
									create code_generator_from_xml.make_from_info_and_path (assembly_filename, from_system_string (destination_path_text_box.get_text))
									from
										assembly_types.start
									until
										assembly_types.after
									loop
										a_type ?= assembly_types.item
										if a_type /= Void then
											type_filename :=  support.Xml_type_filename (assembly_descriptor, a_type.full_external_name)
											code_generator_from_xml.generate_eiffel_code_from_xml_and_path (type_filename, from_system_string (destination_path_text_box.get_text))
										end
										assembly_types.forth
									end
									message_box.main_win.close
								end
							end
						else
							message_box.main_win.close
							returned_value := windows_message_box.show_string_string_message_box_buttons_message_box_icon (dictionary.No_path.to_cil, dictionary.Error_caption.to_cil, message_box_buttons.Ok, message_box_icon.Error)
						end
					end
				else
					message_box.main_win.close
					returned_value := windows_message_box.show_string_string_message_box_buttons_message_box_icon (dictionary.Eiffel_generation_error.to_cil, dictionary.Error_caption.to_cil, message_box_buttons.Ok, message_box_icon.Error)
				end
			end
		rescue
			retried := True
			retry
		end
		
end -- class EIFFEL_GENERATION_DIALOG
