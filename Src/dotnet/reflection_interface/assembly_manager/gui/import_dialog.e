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
			non_void_assembly_name: an_assembly_descriptor.get_name /= Void
			not_empty_assembly_name: an_assembly_descriptor.get_name.get_length > 0
			non_void_dependancies: assembly_dependancies /= Void
		local
			return_value: SYSTEM_WINDOWS_FORMS_DIALOGRESULT
		do
			make_form
			assembly_descriptor := an_assembly_descriptor
			dependancies := assembly_dependancies
			initialize_gui
			return_value := show_dialog
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

	dependancies: ARRAY [SYSTEM_REFLECTION_ASSEMBLYNAME]
		indexing
			description: "Assembly dependancies"
			external_name: "Dependancies"
		end
	
	dependancies_check_box: SYSTEM_WINDOWS_FORMS_CHECKBOX
		indexing
			description: "Dependancies check box"
			external_name: "DependanciesCheckBox"
		end
	
	non_imported_dependancies: ARRAY [SYSTEM_REFLECTION_ASSEMBLYNAME]
		indexing
			description: "Non imported dependancies; Result of `dependancies_imported'"
			external_name: "NonImportedDependancies"
		end

	eiffel_names_check_box: SYSTEM_WINDOWS_FORMS_CHECKBOX
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
			an_assembly_name: SYSTEM_REFLECTION_ASSEMBLYNAME
			support: ISE_REFLECTION_CONVERSIONSUPPORT
			reflection_interface: ISE_REFLECTION_REFLECTIONINTERFACE
			a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR
			retried: BOOLEAN
		do
			if not retried then
				create support.make_conversionsupport
				create reflection_interface.make_reflectioninterface
				reflection_interface.make_reflection_interface
				from
					Result := True
					create non_imported_dependancies.make (dependancies.count)
				until
					i = dependancies.count 
				loop
					an_assembly_name := dependancies.item (i)
					if an_assembly_name /= Void then 
						a_descriptor := support.assembly_descriptor_from_name (an_assembly_name)
						if a_descriptor /= Void then
							reflection_interface.search (a_descriptor)
							if not reflection_interface.get_found then
								non_imported_dependancies.put (i, an_assembly_name)
							end
							Result := Result and reflection_interface.get_found
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
			a_size: SYSTEM_DRAWING_SIZE
			a_point: SYSTEM_DRAWING_POINT
			label_font: SYSTEM_DRAWING_FONT
			a_font: SYSTEM_DRAWING_FONT
			on_ok_event_handler_delegate: SYSTEM_EVENTHANDLER
			on_cancel_event_handler_delegate: SYSTEM_EVENTHANDLER
			retried: BOOLEAN
			returned_value: SYSTEM_WINDOWS_FORMS_DIALOGRESULT
			message_box_buttons: SYSTEM_WINDOWS_FORMS_MESSAGEBOXBUTTONS
			message_box_icon: SYSTEM_WINDOWS_FORMS_MESSAGEBOXICON 
			windows_message_box: SYSTEM_WINDOWS_FORMS_MESSAGEBOX
			checked_changed_delegate: SYSTEM_EVENTHANDLER
		do	
			initialize
			set_text (dictionary.Title)
			a_size.set_Height (dictionary.Window_height)
			a_size.set_Width (dictionary.Window_width)
			set_size (a_size)
			if not retried then
				set_icon (dictionary.Import_icon)
			else
				returned_value := windows_message_box.show_string_string_message_box_buttons_message_box_icon (dictionary.Pixmap_not_found_error, dictionary.Error_caption, message_box_buttons.Ok, message_box_icon.Error)
			end						
			destination_path_text_box.set_text (dictionary.Default_generation_path)

			create other_explanation_label.make_label
			a_point.set_X (dictionary.Margin)
			a_point.set_Y (4 * dictionary.Margin + 7 * dictionary.Label_height)
			other_explanation_label.set_location (a_point)
			other_explanation_label.set_auto_size (True)
			other_explanation_label.set_text (dictionary.Explanation_text)
			get_controls.extend (other_explanation_label)

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
			default_path_check_box.set_auto_check (True)
			get_controls.extend (default_path_check_box)
			create checked_changed_delegate.make_eventhandler (Current, $on_check)
			default_path_check_box.add_checked_changed (checked_changed_delegate)

				-- Eiffel names check box
			create eiffel_names_check_box.make_checkbox
			eiffel_names_check_box.set_text (dictionary.Eiffel_names_check_box_text)
			eiffel_names_check_box.set_font (a_font)
			a_point.set_X (dictionary.Margin)
			a_point.set_Y (4 * dictionary.Margin + 9 * dictionary.Label_height)
			eiffel_names_check_box.set_location (a_point)
			a_size.set_height (dictionary.Label_height)
			a_size.set_width (dictionary.Window_width - 2 * dictionary.Margin)
			eiffel_names_check_box.set_size (a_size)
			eiffel_names_check_box.set_checked (True)
			eiffel_names_check_box.set_auto_check (True)
			get_controls.extend (eiffel_names_check_box)
			
				-- OK button
			create ok_button.make_button
			a_point.set_X ((dictionary.Window_width // 2) - (dictionary.Margin //2) - dictionary.Button_width) 
			a_point.set_Y (4 * dictionary.Margin + 10 * dictionary.Label_height)
			ok_button.set_location (a_point)
			ok_button.set_text (dictionary.Ok_button_label)
			ok_button.set_height (dictionary.Button_height)
			ok_button.set_width (dictionary.Button_width)
			create on_ok_event_handler_delegate.make_eventhandler (Current, $on_ok_event_handler)
			ok_button.add_Click (on_ok_event_handler_delegate)

				-- Cancel button
			create cancel_button.make_button
			a_point.set_X ((dictionary.Window_width // 2) + (dictionary.Margin // 2))
			a_point.set_Y (4 * dictionary.Margin + 10 * dictionary.Label_height)
			cancel_button.set_location (a_point)
			cancel_button.set_height (dictionary.Button_height)
			cancel_button.set_width (dictionary.Button_width)
			cancel_button.set_text (dictionary.Cancel_button_label)
			create on_cancel_event_handler_delegate.make_eventhandler (Current, $on_cancel_event_handler)
			cancel_button.add_Click (on_cancel_event_handler_delegate)
			
				-- Addition of controls
			get_controls.extend (ok_button)
			get_controls.extend (cancel_button)
		rescue
			retried := True
			retry
		end
		
feature -- Event handling

	on_ok_event_handler (sender: ANY; arguments: SYSTEM_EVENTARGS) is
		indexing
			description: "Process `ok_button' activation."
			external_name: "OnOkEventHandler"
		local
			message_box: MESSAGE_BOX
			import_with_dependancies_delegate: SYSTEM_EVENTHANDLER
		do
			create import_with_dependancies_delegate.make_eventhandler (Current, $import)
			create message_box.make (dictionary.Assembly_and_dependancies_importation_message, import_with_dependancies_delegate)
		end
		
feature {NONE} -- Implementation
	
	import (sender: ANY; arguments: SYSTEM_EVENTARGS) is
		indexing
			description: "Import assembly with dependencies."
			external_name: "Import"
		require
			non_void_sender: sender /= Void
		local
			conversion_support: ISE_REFLECTION_CONVERSIONSUPPORT
			assembly_name: SYSTEM_REFLECTION_ASSEMBLYNAME
			assembly: SYSTEM_REFLECTION_ASSEMBLY
			emitter: NEWEIFFELCLASSGENERATOR
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
					create conversion_support.make_conversionsupport
					assembly_name := conversion_support.assembly_name_from_descriptor (assembly_descriptor)
					assembly := assembly.load (assembly_name)
					close
					create emitter.make_neweiffelclassgenerator
					if destination_path_text_box.get_text /= Void and then destination_path_text_box.get_text.get_length > 0 then
						emitter.import_assembly_with_dependancies (assembly, destination_path_text_box.get_text, eiffel_names_check_box.get_checked)
						message_box.close
					else
						message_box.close
						returned_value := windows_message_box.show_string_string_message_box_buttons_message_box_icon (dictionary.No_path, dictionary.Error_caption, message_box_buttons.Ok, message_box_icon.Error)
					end
				else
					message_box.close
					returned_value := windows_message_box.show_string_string_message_box_buttons_message_box_icon (dictionary.Importation_error, dictionary.Error_caption, message_box_buttons.Ok, message_box_icon.Error)
				end
			end
		rescue
			retried := True
			retry
		end
	
end -- class IMPORT_DIALOG
