indexing
	description: "Enable user to import a .NET assembly."
	external_name: "ISE.AssemblyManager.ImportDialog"

class
	IMPORT_DIALOG

inherit
	GENERATION_DIALOG
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
						Set `assembly_dependancies' with `dependancies'.
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
		
	dictionary: IMPORT_DIALOG_DICTIONARY is
		indexing
			description: "Dictionary"
			external_name: "Dictionary"
		once
			create Result
		end

	dependancies: ARRAY [CLI_CELL [ASSEMBLY_NAME]]
		indexing
			description: "Assembly dependancies"
			external_name: "Dependancies"
		end
	
	dependancies_check_box: WINFORMS_CHECK_BOX
		indexing
			description: "Dependancies check box"
			external_name: "DependanciesCheckBox"
		end
	
	non_imported_dependancies: ARRAY [CLI_CELL [ASSEMBLY_NAME]]
		indexing
			description: "Non imported dependancies; Result of `dependancies_imported'"
			external_name: "NonImportedDependancies"
		end

	eiffel_names_check_box: WINFORMS_CHECK_BOX
		indexing
			description: "Check box enabling user to launch Eiffel code generation with Eiffel-friendly names"
			external_name: "EiffelNamesCheckBox"
		end
		
feature -- Status Report

	dependancies_imported: BOOLEAN is
		indexing
			description: "Are dependancies already imported? Build `non_imported_dependancies'."
			external_name: "DependanciesImported"
		local
			i: INTEGER
			an_assembly_name: ASSEMBLY_NAME
			support: CONVERSION_SUPPORT
			reflection_interface: REFLECTION_INTERFACE
			a_descriptor: ASSEMBLY_DESCRIPTOR
			retried: BOOLEAN
			item: CLI_CELL [ASSEMBLY_NAME]
		do
			if not retried then
				support := create {CONVERSION_SUPPORT}
				reflection_interface := create {REFLECTION_INTERFACE}.make_reflection_interface
				from
					i := 1
					Result := True
					create non_imported_dependancies.make (1, dependancies.count)
				until
					i >= dependancies.count 
				loop
					item := dependancies.item (i)
					if item /= Void then 
						an_assembly_name := item.item
						if an_assembly_name /= Void then 
							a_descriptor := support.assembly_descriptor_from_name (an_assembly_name)
							if a_descriptor /= Void then
								reflection_interface.search (a_descriptor)
								if not reflection_interface.found then
									non_imported_dependancies.put (item, i)
								end
								Result := Result and reflection_interface.found
							end						
						end
					end
					i := i + 1
				end
			else
				Result := False
			end
		rescue
			retried := True
			retry
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
				main_win.set_icon (dictionary.Import_icon)
			else
				returned_value := windows_message_box.show_string_string_message_box_buttons_message_box_icon (dictionary.Pixmap_not_found_error.to_cil, dictionary.Error_caption.to_cil, message_box_buttons.Ok, message_box_icon.Error)
			end						
			destination_path_text_box.set_text (dictionary.Default_generation_path.to_cil)

			create other_explanation_label.make_winforms_label
			a_point.set_X (dictionary.Margin)
			a_point.set_Y (4 * dictionary.Margin + 7 * dictionary.Label_height)
			other_explanation_label.set_location (a_point)
			other_explanation_label.set_auto_size (True)
			other_explanation_label.set_text (dictionary.Explanation_text.to_cil)
			main_win.get_controls.add (other_explanation_label)

				-- Default path check box
			create default_path_check_box.make_winforms_check_box
			default_path_check_box.set_text (dictionary.Default_path_check_box_text.to_cil)
			default_path_check_box.set_font (a_font)
			a_point.set_X (dictionary.Margin)
			a_point.set_Y (4 * dictionary.Margin + 8 * dictionary.Label_height)
			default_path_check_box.set_location (a_point)
			a_size.set_height (dictionary.Label_height)
			a_size.set_width (dictionary.Window_width - 2 * dictionary.Margin)
			default_path_check_box.set_size (a_size)
			default_path_check_box.set_checked (True)
			default_path_check_box.set_auto_check (True)
			main_win.get_controls.add (default_path_check_box)
			create checked_changed_delegate.make_event_handler (Current, $on_check)
			default_path_check_box.add_checked_changed (checked_changed_delegate)

				-- Eiffel names check box
			create eiffel_names_check_box.make_winforms_check_box
			eiffel_names_check_box.set_text (dictionary.Eiffel_names_check_box_text.to_cil)
			eiffel_names_check_box.set_font (a_font)
			a_point.set_X (dictionary.Margin)
			a_point.set_Y (4 * dictionary.Margin + 9 * dictionary.Label_height)
			eiffel_names_check_box.set_location (a_point)
			a_size.set_height (dictionary.Label_height)
			a_size.set_width (dictionary.Window_width - 2 * dictionary.Margin)
			eiffel_names_check_box.set_size (a_size)
			eiffel_names_check_box.set_checked (True)
			eiffel_names_check_box.set_auto_check (True)
			main_win.get_controls.add (eiffel_names_check_box)
			
				-- OK button
			create ok_button.make_winforms_button
			a_point.set_X ((dictionary.Window_width // 2) - (dictionary.Margin //2) - dictionary.Button_width) 
			a_point.set_Y (4 * dictionary.Margin + 10 * dictionary.Label_height)
			ok_button.set_location (a_point)
			ok_button.set_text (dictionary.Ok_button_label.to_cil)
			ok_button.set_height (dictionary.Button_height)
			ok_button.set_width (dictionary.Button_width)
			create on_ok_event_handler_delegate.make_event_handler (Current, $on_ok_event_handler)
			ok_button.add_Click (on_ok_event_handler_delegate)

				-- Cancel button
			create cancel_button.make_winforms_button
			a_point.set_X ((dictionary.Window_width // 2) + (dictionary.Margin // 2))
			a_point.set_Y (4 * dictionary.Margin + 10 * dictionary.Label_height)
			cancel_button.set_location (a_point)
			cancel_button.set_height (dictionary.Button_height)
			cancel_button.set_width (dictionary.Button_width)
			cancel_button.set_text (dictionary.Cancel_button_label.to_cil)
			create on_cancel_event_handler_delegate.make_event_handler (Current, $on_cancel_event_handler)
			cancel_button.add_Click (on_cancel_event_handler_delegate)
			
				-- Addition of controls
			main_win.get_controls.add (ok_button)
			main_win.get_controls.add (cancel_button)
		rescue
			retried := True
			retry
		end
		
feature -- Event handling

	on_ok_event_handler (sender: SYSTEM_OBJECT; arguments: EVENT_ARGS) is
		indexing
			description: "Process `ok_button' activation."
			external_name: "OnOkEventHandler"
		local
			message_box: MESSAGE_BOX
			import_with_dependancies_delegate: EVENT_HANDLER
		do
			create import_with_dependancies_delegate.make_event_handler (Current, $import)
			create message_box.make (dictionary.Assembly_and_dependancies_importation_message, import_with_dependancies_delegate)
		end
		
feature {NONE} -- Implementation
	
	import (sender: SYSTEM_OBJECT; arguments: EVENT_ARGS) is
		indexing
			description: "Import assembly with dependencies."
			external_name: "Import"
		require
			non_void_sender: sender /= Void
		local
			conversion_support: CONVERSION_SUPPORT
			assembly_name: ASSEMBLY_NAME
			assembly: ASSEMBLY
			emitter: EIFFEL_CLASS_GENERATOR
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
					conversion_support := create {CONVERSION_SUPPORT}
					assembly_name := conversion_support.assembly_name_from_descriptor (assembly_descriptor)
					assembly := assembly.load (assembly_name)
					main_win.close
					create emitter.make_eiffel_class_generator
					if destination_path_text_box.get_text /= Void and then destination_path_text_box.get_text.get_length > 0 then
						emitter.import_assembly_with_dependancies (assembly, destination_path_text_box.get_text, eiffel_names_check_box.get_checked)
						message_box.main_win.close
					else
						message_box.main_win.close
						returned_value := windows_message_box.show_string_string_message_box_buttons_message_box_icon (dictionary.No_path.to_cil, dictionary.Error_caption.to_cil, message_box_buttons.Ok, message_box_icon.Error)
					end
				else
					message_box.main_win.close
					returned_value := windows_message_box.show_string_string_message_box_buttons_message_box_icon (dictionary.Importation_error.to_cil, dictionary.Error_caption.to_cil, message_box_buttons.Ok, message_box_icon.Error)
				end
			end
		rescue
			retried := True
			retry
		end
	
end -- class IMPORT_DIALOG
