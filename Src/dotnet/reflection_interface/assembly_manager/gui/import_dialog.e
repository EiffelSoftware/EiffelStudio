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
			description: "[Set `assembly_descriptor' with `an_assembly_descriptor'.%
					%Set `assembly_dependancies' with `dependancies'.]"
			external_name: "Make"
		require
			non_void_assembly_descriptor: an_assembly_descriptor /= Void
			non_void_assembly_name: an_assembly_descriptor.name /= Void
			not_empty_assembly_name: an_assembly_descriptor.name.length > 0
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
				reflection_interface.makereflectioninterface
				from
					Result := True
					create non_imported_dependancies.make (dependancies.count)
				until
					i = dependancies.count 
				loop
					an_assembly_name := dependancies.item (i)
					if an_assembly_name /= Void then 
						a_descriptor := support.assemblydescriptorfromname (an_assembly_name)
						if a_descriptor /= Void then
							reflection_interface.search (a_descriptor)
							if not reflection_interface.found then
								non_imported_dependancies.put (i, an_assembly_name)
							end
							Result := Result and reflection_interface.found
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
		do	
			initialize
			set_text (dictionary.Title)
			a_size.set_Height (dictionary.Window_height)
			a_size.set_Width (dictionary.Window_width)
			set_size (a_size)
			set_icon (dictionary.Import_icon)
			destination_path_text_box.set_text (dictionary.Default_generation_path)
			
				-- Dependancies check box (checked by default)
			if dependancies.count > 0 then
				create dependancies_check_box.make_checkbox
				dependancies_check_box.set_text (dictionary.Dependancies_check_box_text)
				dependancies_check_box.set_font (a_font)
				a_point.set_X (dictionary.Margin)
				a_point.set_Y (4 * dictionary.Margin + 9 * dictionary.Label_height)
				dependancies_check_box.set_location (a_point)
				a_size.set_height (dictionary.Label_height)
				a_size.set_width (dictionary.Window_width - 2 * dictionary.Margin)
				dependancies_check_box.set_size (a_size)
				dependancies_check_box.set_checked (True)
				dependancies_check_box.set_autocheck (True)
				controls.add (dependancies_check_box)
			end
			
				-- OK button
			create ok_button.make_button
			a_point.set_X ((dictionary.Window_width // 2) - (dictionary.Margin //2) - dictionary.Button_width) 
			if dependancies.count > 0 then
				a_point.set_Y (5 * dictionary.Margin + 10 * dictionary.Label_height)
			else
				a_point.set_Y (4 * dictionary.Margin + 9 * dictionary.Label_height)
			end
			ok_button.set_location (a_point)
			ok_button.set_text (dictionary.Ok_button_label)
			ok_button.set_height (dictionary.Button_height)
			ok_button.set_width (dictionary.Button_width)
			create on_ok_event_handler_delegate.make_eventhandler (Current, $on_ok_event_handler)
			ok_button.add_Click (on_ok_event_handler_delegate)

				-- Cancel button
			create cancel_button.make_button
			a_point.set_X ((dictionary.Window_width // 2) + (dictionary.Margin // 2))
			if dependancies.count > 0 then
				a_point.set_Y (5 * dictionary.Margin + 10 * dictionary.Label_height)
			else
				a_point.set_Y (4 * dictionary.Margin + 9 * dictionary.Label_height)
			end
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
		indexing
			description: "Process `ok_button' activation."
			external_name: "OnOkEventHandler"
		local
			on_confirmation_event_handler_delegate: SYSTEM_EVENTHANDLER
			warning_dialog: WARNING_DIALOG
		do
			if dependancies.count > 0 then
				if not dependancies_check_box.Checked then
					if not dependancies_imported then
						create on_confirmation_event_handler_delegate.make_eventhandler (Current, $import_assembly_without_dependancies)
						create warning_dialog.make (assembly_descriptor, non_imported_dependancies, dictionary.Warning_text, dictionary.Caption_text, on_confirmation_event_handler_delegate)
					else
						import_assembly_without_dependancies
					end
				else
					import_assembly_and_dependancies
				end
			else
				import_assembly_without_dependancies
			end
		end
		
feature {NONE} -- Implementation
	
	import_assembly_and_dependancies is
		indexing
			description: "Import the assembly corresponding to `assembly_descriptor' and its dependancies."
			external_name: "ImportAssemblyAndDependancies"
		require
			non_void_assembly_descriptor: assembly_descriptor /= Void
		local
			message_box: MESSAGE_BOX
			import_with_dependancies_delegate: SYSTEM_EVENTHANDLER
		do
			create import_with_dependancies_delegate.make_eventhandler (Current, $import_with_dependancies)
			create message_box.make (dictionary.Assembly_and_dependancies_importation_message, import_with_dependancies_delegate)
		end
	
	import_with_dependancies (sender: ANY; arguments: SYSTEM_EVENTARGS) is
		indexing
			description: "Import assembly with dependancies."
			external_name: "ImportWithDependancies"
		require
			non_void_sender: sender /= Void
		local
			conversion_support: ISE_REFLECTION_CONVERSIONSUPPORT
			assembly_name: SYSTEM_REFLECTION_ASSEMBLYNAME
			assembly: SYSTEM_REFLECTION_ASSEMBLY
			emitter: NEWEIFFELCLASSGENERATOR
			returned_value: INTEGER
			windows_message_box: SYSTEM_WINDOWS_FORMS_MESSAGEBOX
			message_box: MESSAGE_BOX
			retried: BOOLEAN		
		do
			message_box ?= sender
			if message_box /= Void then
				message_box.refresh
				if not retried then
					create conversion_support.make_conversionsupport
					assembly_name := conversion_support.assemblynamefromdescriptor (assembly_descriptor)
					assembly := assembly.load (assembly_name)
					close
					create emitter.make_neweiffelclassgenerator
					if destination_path_text_box.text /= Void and then destination_path_text_box.text.length > 0 then
						emitter.importassemblywithdependancies (assembly, destination_path_text_box.text)
						message_box.close
					else
						message_box.close
						returned_value := windows_message_box.show_string_string_messageboxbuttons_messageboxicon (dictionary.No_path, dictionary.Error_caption, dictionary.Ok_message_box_button, dictionary.Error_icon)
					end
				else
					message_box.close
					returned_value := windows_message_box.show_string_string_messageboxbuttons_messageboxicon (dictionary.Importation_error, dictionary.Error_caption, dictionary.Ok_message_box_button, dictionary.Error_icon)
				end
			end
		rescue
			retried := True
			retry
		end

	import_assembly_without_dependancies is
		indexing
			description: "Import the assembly corresponding to `assembly_descriptor' without its dependancies."
			external_name: "ImportAssemblyWithoutDependancies"
		require	
			non_void_assembly_descriptor: assembly_descriptor /= Void
		local
			import_without_dependancies_delegate: SYSTEM_EVENTHANDLER
			message_box: MESSAGE_BOX
		do
			create import_without_dependancies_delegate.make_eventhandler (Current, $import_without_dependancies)
			create message_box.make (dictionary.Assembly_importation_message, import_without_dependancies_delegate)
		end
		
	import_without_dependancies (sender: ANY; arguments: SYSTEM_EVENTARGS) is
		indexing
			description: "Import the assembly corresponding to `assembly_descriptor' without its dependancies."
			external_name: "ImportWithoutDependancies"
		require	
			non_void_assembly_descriptor: assembly_descriptor /= Void
			non_void_sender: sender /= Void
		local
			assembly_name: SYSTEM_REFLECTION_ASSEMBLYNAME
			assembly: SYSTEM_REFLECTION_ASSEMBLY
			conversion_support: ISE_REFLECTION_CONVERSIONSUPPORT
			emitter: NEWEIFFELCLASSGENERATOR
			returned_value: INTEGER
			windows_message_box: SYSTEM_WINDOWS_FORMS_MESSAGEBOX	
			message_box: MESSAGE_BOX
			retried: BOOLEAN
		do
			message_box ?= sender
			if message_box /= Void then
				message_box.refresh
				if not retried then
					create conversion_support.make_conversionsupport
					assembly_name := conversion_support.assemblynamefromdescriptor (assembly_descriptor)
					assembly := assembly.load (assembly_name)
					close
					create emitter.make_neweiffelclassgenerator
					if destination_path_text_box.text /= Void and then destination_path_text_box.text.length > 0 then
						emitter.importassemblywithoutdependancies (assembly, destination_path_text_box.text)
						message_box.close
					else
						message_box.close
						returned_value := windows_message_box.show_string_string_messageboxbuttons_messageboxicon (dictionary.No_path, dictionary.Error_caption, dictionary.Ok_message_box_button, dictionary.Error_icon)
					end
				else
					message_box.close
					returned_value := windows_message_box.show_string_string_messageboxbuttons_messageboxicon (dictionary.Importation_error, dictionary.Error_caption, dictionary.Ok_message_box_button, dictionary.Error_icon)
				end
			end
		rescue
			retried := True
			retry
		end
	
end -- class IMPORT_DIALOG