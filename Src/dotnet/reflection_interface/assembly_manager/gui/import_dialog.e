indexing
	description: "Enable user to import a .NET assembly."
	external_name: "ISE.AssemblyManager.ImportDialog"

class
	IMPORT_DIALOG

inherit
	SYSTEM_WINDOWS_FORMS_FORM

create
	make

feature {NONE} -- Initialization

	make (an_assembly_descriptor: like assembly_descriptor; assembly_dependancies: like dependancies) is
			-- Set `assembly_descriptor' with `an_assembly_descriptor'.
			-- Set `assembly_dependancies' with `dependancies'.
		indexing
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
			create dictionary
			assembly_descriptor := an_assembly_descriptor
			dependancies := assembly_dependancies
			initialize_gui
			return_value := showdialog
		ensure
			assembly_descriptor_set: assembly_descriptor = an_assembly_descriptor
			dependancies_set: dependancies = assembly_dependancies
		end
		
feature -- Access
	
	dictionary: IMPORT_DIALOG_DICTIONARY
			-- Dictionary
		indexing
			external_name: "Dictionary"
		end
		
	assembly_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR
			-- Assembly descriptor
		indexing
			external_name: "AssemblyDescriptor"
		end

	dependancies: ARRAY [SYSTEM_REFLECTION_ASSEMBLYNAME]
			-- Assembly dependancies
		indexing
			external_name: "Dependancies"
		end

	assembly_label: SYSTEM_WINDOWS_FORMS_LABEL
			-- Assembly label
		indexing
			external_name: "AssemblyLabel"
		end

	assembly_descriptor_label: SYSTEM_WINDOWS_FORMS_LABEL
			-- Assembly descriptor label
		indexing
			external_name: "AssemblyDescriptorLabel"
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
		
	dependancies_check_box: SYSTEM_WINDOWS_FORMS_CHECKBOX
			-- Dependancies check box
		indexing
			external_name: "DependanciesCheckBox"
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

	Window_height: INTEGER is 
			-- Window width
		indexing
			external_name: "WindowHeight"
		do
			if dependancies.count > 0 then
				Result := 330
			else
				Result := 280
			end
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
			type: SYSTEM_TYPE
			on_browse_event_handler_delegate: SYSTEM_EVENTHANDLER
			on_ok_event_handler_delegate: SYSTEM_EVENTHANDLER
			on_cancel_event_handler_delegate: SYSTEM_EVENTHANDLER
		do
			set_Enabled (True)
			set_text (dictionary.Title)
			set_borderstyle (dictionary.Border_style)
			a_size.set_Width (dictionary.Window_width)
			a_size.set_Height (Window_height)
			set_size (a_size)		

				-- `Selected assembly: '
			create assembly_label.make_label
			assembly_label.set_text (dictionary.Assembly_label_text)
			a_point.set_X (dictionary.Margin)
			a_point.set_Y (dictionary.Margin)
			assembly_label.set_location (a_point)
			a_size.set_Height (dictionary.Label_height)
			assembly_label.set_size (a_size)
			create label_font.make_font_10 (dictionary.Font_family_name, dictionary.Label_font_size, dictionary.Bold_style) 
			assembly_label.set_font (label_font)
			
			create assembly_descriptor_label.make_label
			create a_font.make_font_10 (dictionary.Font_family_name, dictionary.Font_size, dictionary.Regular_style) 
			assembly_descriptor_label.set_font (a_font)			
			assembly_descriptor_label.set_text (dictionary.Assembly_descriptor_text (assembly_descriptor))
			a_point.set_X (dictionary.Margin)
			a_point.set_Y (dictionary.Margin + dictionary.Label_height)
			assembly_descriptor_label.set_location (a_point)			
			assembly_descriptor_label.set_autosize (True)
			
				-- `Destination_path: '
			create destination_path_label.make_label
			destination_path_label.set_text (dictionary.Destination_path_label_text)
			a_point.set_X (dictionary.Margin)
			a_point.set_Y (3 * dictionary.Margin + 2 * dictionary.Label_height)
			destination_path_label.set_location (a_point)
			a_size.set_Height (dictionary.Label_height)
			destination_path_label.set_size (a_size)
			destination_path_label.set_font (label_font)				

				-- Destination path text box
			create destination_path_text_box.make_textbox
			a_point.set_X (dictionary.Margin)
			a_point.set_Y (4 * dictionary.Margin + 3 * dictionary.Label_height)
			destination_path_text_box.set_location (a_point)
			a_size.set_Width (dictionary.Window_width - dictionary.Button_width - 3 * dictionary.Margin)
			a_size.set_Height (dictionary.Label_height)
			destination_path_text_box.set_size (a_size)

				-- Browse button
			create browse_button.make_button
			a_point.set_X (dictionary.Window_width - dictionary.Margin - dictionary.Button_width) 
			a_point.set_Y (3 * dictionary.Margin + 3 * dictionary.Label_height + dictionary.Margin // 2)
			browse_button.set_location (a_point)
			browse_button.set_text (dictionary.Browse_button_label)
			type := type_factory.GetType_String (dictionary.System_event_handler_type)
			on_browse_event_handler_delegate ?= delegate_factory.CreateDelegate_Type_Object (type, Current, "OnBrowseEventHandler")
			browse_button.add_Click (on_browse_event_handler_delegate)
			
				-- Explanation for destination path
			create explanation_label.make_label
			explanation_label.set_text (dictionary.Explanation_label_text)
			explanation_label.set_font (a_font)
			a_point.set_X (dictionary.Margin)
			a_point.set_Y (5 * dictionary.Margin + 4 * dictionary.Label_height)
			explanation_label.set_location (a_point)
			explanation_label.set_autosize (True)

				-- Dependancies check box (checked by default)
			if dependancies.count > 0 then
				create dependancies_check_box.make_checkbox
				dependancies_check_box.set_text (dictionary.Dependancies_check_box_text)
				dependancies_check_box.set_font (a_font)
				a_point.set_X (dictionary.Margin)
				a_point.set_Y (7 * dictionary.Margin + 5 * dictionary.Label_height)
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
				a_point.set_Y (9 * dictionary.Margin + 6 * dictionary.Label_height)
			else
				a_point.set_Y (6 * dictionary.Margin + 5 * dictionary.Label_height)
			end
			ok_button.set_location (a_point)
			ok_button.set_text (dictionary.Ok_button_label)
			type := type_factory.GetType_String (dictionary.System_event_handler_type)
			on_ok_event_handler_delegate ?= delegate_factory.CreateDelegate_Type_Object (type, Current, "OnOkEventHandler")
			ok_button.add_Click (on_ok_event_handler_delegate)

				-- Cancel button
			create cancel_button.make_button
			a_point.set_X ((dictionary.Window_width // 2) + (dictionary.Margin //2))
			if dependancies.count > 0 then
				a_point.set_Y (9 * dictionary.Margin + 6 * dictionary.Label_height)
			else
				a_point.set_Y (6 * dictionary.Margin + 5 * dictionary.Label_height)
			end
			cancel_button.set_location (a_point)
			cancel_button.set_text (dictionary.Cancel_button_label)
			on_cancel_event_handler_delegate ?= delegate_factory.CreateDelegate_Type_Object (type, Current, "OnCancelEventHandler")
			cancel_button.add_Click (on_cancel_event_handler_delegate)
			
				-- Addition of controls
			controls.add (assembly_label)
			controls.add (assembly_descriptor_label)
			controls.add (destination_path_label)
			controls.add (destination_path_text_box)
			controls.add (browse_button)
			controls.add (explanation_label)
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
		local
			on_confirmation_event_handler_delegate: SYSTEM_EVENTHANDLER
			warning_dialog: WARNING_DIALOG
		do
			if dependancies.count > 0 then
				if not dependancies_check_box.Checked then
					create on_confirmation_event_handler_delegate.make_eventhandler (Current, $import_assembly_without_dependancies)
					create warning_dialog.make (assembly_descriptor, dependancies, dictionary.Warning_text, on_confirmation_event_handler_delegate)
				else
					import_assembly_and_dependancies
					close
				end
			else
				import_assembly_and_dependancies
				close
			end
		end

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
			if last_folder /= Void then
				destination_path_text_box.set_text (last_folder)
			end
		end
		
feature {NONE} -- Implementation

	type_factory: SYSTEM_TYPE
			-- Statics needed to create a type
		indexing
			external_name: "TypeFactory"
		end
		
	delegate_factory: SYSTEM_DELEGATE
			-- Statics needed to create a delegate
		indexing
			external_name: "DelegateFactory"
		end

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
		do
			create browser.make
			browser.ask_for_folder
			last_folder := browser.last_folder
		end
	
	import_assembly_and_dependancies is
			-- Import the assembly corresponding to `assembly_descriptor' and its dependancies.
		indexing
			external_name: "ImportAssemblyAndDependancies"
		require
			non_void_assembly_descriptor: assembly_descriptor /= Void
		local
			conversion_support: ISE_REFLECTION_CONVERSIONSUPPORT
			assembly_name: SYSTEM_REFLECTION_ASSEMBLYNAME
			assembly: SYSTEM_REFLECTION_ASSEMBLY
			emitter: NEWEIFFELCLASSGENERATOR
			returned_value: INTEGER
			message_box: SYSTEM_WINDOWS_FORMS_MESSAGEBOX
		do
			create conversion_support.make_conversionsupport
			assembly_name := conversion_support.assemblynamefromdescriptor (assembly_descriptor)
			assembly := assembly.load (assembly_name)
			returned_value := message_box.show (dictionary.Assembly_and_dependancies_importation_message)
			create emitter.make_neweiffelclassgenerator
			if destination_path_text_box.text /= Void then
				ok_button.set_enabled (False)
				cancel_button.set_enabled (False)
				emitter.importassemblywithdependancies (assembly, destination_path_text_box.text)
			else
				returned_value := message_box.show (dictionary.No_path)
			end
			refresh
		end

	import_assembly_without_dependancies is
			-- Import the assembly corresponding to `assembly_descriptor' without its dependancies.
		indexing
			external_name: "ImportAssemblyWithoutDependancies"
		require	
			non_void_assembly_descriptor: assembly_descriptor /= Void
		local
			assembly_name: SYSTEM_REFLECTION_ASSEMBLYNAME
			assembly: SYSTEM_REFLECTION_ASSEMBLY
			conversion_support: ISE_REFLECTION_CONVERSIONSUPPORT
			emitter: NEWEIFFELCLASSGENERATOR
			returned_value: INTEGER
			message_box: SYSTEM_WINDOWS_FORMS_MESSAGEBOX		
		do
			create conversion_support.make_conversionsupport
			assembly_name := conversion_support.assemblynamefromdescriptor (assembly_descriptor)
			assembly := assembly.load (assembly_name)
			returned_value := message_box.show (dictionary.Assembly_importation_message)
			create emitter.make_neweiffelclassgenerator
			if destination_path_text_box.text /= Void then
				ok_button.set_enabled (False)
				cancel_button.set_enabled (False)
				emitter.importassemblywithoutdependancies (assembly, destination_path_text_box.text)
			else
				returned_value := message_box.show (dictionary.No_path)
			end
			refresh			
		end
		
end -- class IMPORT_DIALOG