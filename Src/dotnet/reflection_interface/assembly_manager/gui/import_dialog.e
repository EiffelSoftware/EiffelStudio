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
	
	console: SYSTEM_CONSOLE
	
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

	message_text_box: SYSTEM_WINDOWS_FORMS_TEXTBOX
			-- Message text box
		indexing
			external_name: "MessageTextBox"
		end
		
feature -- Constants

	Border_style: INTEGER is 3
			-- Window border style: a fixed, single line border
		indexing
			external_name: "BorderStyle"
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
		
	Window_width: INTEGER is 800
			-- Window width
		indexing
			external_name: "WindowWidth"
		end
	
	Margin: INTEGER is 10
			-- Margin
		indexing
			external_name: "Margin"
		end
	
	Label_height: INTEGER is 20
			-- Label height
		indexing
			external_name: "LabelHeight"
		end
	
	Label_font_size: REAL is 10.0
			-- Label font size
		indexing
			external_name: "LabelFontSize"
		end

	Font_size: REAL is 8.0
			-- Font size
		indexing
			external_name: "FontSize"
		end
		
	Bold_style: INTEGER is 1
			-- Bold style
		indexing
			external_name: "BoldStyle"
		end

	Regular_style: INTEGER is 0
			-- Regular style
		indexing
			external_name: "RegularStyle"
		end
		
	Button_height: INTEGER is 23
			-- Button height
		indexing
			external_name: "ButtonHeight"
		end
	
	Button_width: INTEGER is 75
			-- Button height
		indexing
			external_name: "ButtonWidth"
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
			--set_borderstyle (dictionary.Border_style)
			--a_size.set_Width (dictionary.Window_width)
			set_borderstyle (Border_style)
			a_size.set_Width (Window_width)
			a_size.set_Height (Window_height)
			set_size (a_size)		

				-- `Selected assembly: '
			create assembly_label.make_label
			assembly_label.set_text (dictionary.Assembly_label_text)
			--a_point.set_X (dictionary.Margin)
			--a_point.set_Y (dictionary.Margin)
			a_point.set_X (Margin)
			a_point.set_Y (Margin)
			assembly_label.set_location (a_point)
			--a_size.set_Height (dictionary.Label_height)
			a_size.set_Height (Label_height)
			assembly_label.set_size (a_size)
			--create label_font.make_font_10 (dictionary.Font_family_name, dictionary.Label_font_size, dictionary.Bold_style) 
			create label_font.make_font_10 (dictionary.Font_family_name, Label_font_size,  Bold_style) 
			assembly_label.set_font (label_font)
			
			create assembly_descriptor_label.make_label
			--create a_font.make_font_10 (dictionary.Font_family_name, dictionary.Font_size, dictionary.Regular_style) 
			create a_font.make_font_10 (dictionary.Font_family_name, Font_size,  Regular_style) 
			assembly_descriptor_label.set_font (a_font)			
			assembly_descriptor_label.set_text (dictionary.Assembly_descriptor_text (assembly_descriptor))
			--a_point.set_X (dictionary.Margin)
			--a_point.set_Y (dictionary.Margin + dictionary.Label_height)
			a_point.set_X (Margin)
			a_point.set_Y (Margin + Label_height)
			assembly_descriptor_label.set_location (a_point)			
			--a_size.set_Width (Window_width - 2 * Left_margin)
			--assembly_descriptor_label.set_size (a_size)
			assembly_descriptor_label.set_autosize (True)
			
				-- `Destination_path: '
			create destination_path_label.make_label
			destination_path_label.set_text (dictionary.Destination_path_label_text)
			--a_point.set_X (dictionary.Margin)
			--a_point.set_Y (3 * dictionary.Margin + 2 * dictionary.Label_height)
			a_point.set_X (Margin)
			a_point.set_Y (3 * Margin + 2 * Label_height)
			destination_path_label.set_location (a_point)
			--a_size.set_Height (dictionary.Label_height)
			a_size.set_Height (Label_height)
			destination_path_label.set_size (a_size)
			destination_path_label.set_font (label_font)				

				-- Destination path text box
			create destination_path_text_box.make_textbox
			--a_point.set_X (dictionary.Margin)
			--a_point.set_Y (4 * dictionary.Margin + 3 * dictionary.Label_height)
			a_point.set_X (Margin)
			a_point.set_Y (4 * Margin + 3 * Label_height)
			destination_path_text_box.set_location (a_point)
			--a_size.set_Width (dictionary.Window_width - dictionary.Button_width - 3 * dictionary.Margin)
			--a_size.set_Height (dictionary.Label_height)
			a_size.set_Width (Window_width - Button_width - 3 * Margin)
			a_size.set_Height (Label_height)
			destination_path_text_box.set_size (a_size)

				-- Browse button
			create browse_button.make_button
			--a_point.set_X (dictionary.Window_width - dictionary.Margin - dictionary.Button_width) 
			--a_point.set_Y (3 * dictionary.Margin + 3 * dictionary.Label_height + dictionary.Margin // 2)
			a_point.set_X (Window_width - Margin - Button_width) 
			a_point.set_Y (3 * Margin + 3 * Label_height + Margin // 2)
			browse_button.set_location (a_point)
			browse_button.set_text (dictionary.Browse_button_label)
			type := type_factory.GetType_String (dictionary.System_event_handler_type)
			on_browse_event_handler_delegate ?= delegate_factory.CreateDelegate_Type_Object (type, Current, "OnBrowseEventHandler")
			browse_button.add_Click (on_browse_event_handler_delegate)
			
				-- Explanation for destination path
			create explanation_label.make_label
			explanation_label.set_text (dictionary.Explanation_label_text)
			explanation_label.set_font (a_font)
			--a_point.set_X (dictionary.Margin)
			--a_point.set_Y (5 * dictionary.Margin + 4 * dictionary.Label_height)
			a_point.set_X (Margin)
			a_point.set_Y (5 * Margin + 4 * Label_height)
			explanation_label.set_location (a_point)
			explanation_label.set_autosize (True)

				-- Dependancies check box (checked by default)
			if dependancies.count > 0 then
				create dependancies_check_box.make_checkbox
				dependancies_check_box.set_text (dictionary.Dependancies_check_box_text)
				dependancies_check_box.set_font (a_font)
				--a_point.set_X (dictionary.Margin)
				--a_point.set_Y (7 * dictionary.Margin + 5 * dictionary.Label_height)
				a_point.set_X (Margin)
				a_point.set_Y (7 * Margin + 5 * Label_height)
				dependancies_check_box.set_location (a_point)
				--a_size.set_height (dictionary.Label_height)
				--a_size.set_width (dictionary.Window_width - 2 * dictionary.Margin)
				a_size.set_height (Label_height)
				a_size.set_width (Window_width - 2 * Margin)
				dependancies_check_box.set_size (a_size)
				dependancies_check_box.set_checked (True)
				dependancies_check_box.set_autocheck (True)
				controls.add (dependancies_check_box)
			end
			
				-- OK button
			create ok_button.make_button
			--a_point.set_X ((dictionary.Window_width // 2) - (dictionary.Margin //2) - dictionary.Button_width) 
			a_point.set_X ((Window_width // 2) - (Margin //2) - Button_width) 
			if dependancies.count > 0 then
				--a_point.set_Y (9 * dictionary.Margin + 6 * dictionary.Label_height)
				a_point.set_Y (9 * Margin + 6 * Label_height)
			else
				--a_point.set_Y (6 * dictionary.Margin + 5 * dictionary.Label_height)
				a_point.set_Y (6 * Margin + 5 * Label_height)
			end
			ok_button.set_location (a_point)
			ok_button.set_text (dictionary.Ok_button_label)
			type := type_factory.GetType_String (dictionary.System_event_handler_type)
			on_ok_event_handler_delegate ?= delegate_factory.CreateDelegate_Type_Object (type, Current, "OnOkEventHandler")
			ok_button.add_Click (on_ok_event_handler_delegate)

				-- Cancel button
			create cancel_button.make_button
			--a_point.set_X ((dictionary.Window_width // 2) + (dictionary.Margin //2))
			a_point.set_X ((Window_width // 2) + (Margin //2))
			if dependancies.count > 0 then
				--a_point.set_Y (9 * dictionary.Margin + 6 * dictionary.Label_height)
				a_point.set_Y (9 * Margin + 6 * Label_height)
			else
				--a_point.set_Y (6 * dictionary.Margin + 5 * dictionary.Label_height)
				a_point.set_Y (6 * Margin + 5 * Label_height)
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
			type: SYSTEM_TYPE
			on_confirmation_event_handler_delegate: SYSTEM_EVENTHANDLER
			warning_dialog: WARNING_DIALOG
		do
			if dependancies.count > 0 then
				if not dependancies_check_box.Checked then
					type := type_factory.GetType_String (dictionary.System_event_handler_type)
					on_confirmation_event_handler_delegate ?= delegate_factory.CreateDelegate_Type_Object (type, Current, "ImportAssemblyWithoutDependancies")
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
				console.writeline_string (last_folder)
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
		
	assembly_name_from_info: SYSTEM_REFLECTION_ASSEMBLYNAME is
			-- Assembly name corresponding to `assembly_descriptor'.
		require
			non_void_descriptor: assembly_descriptor /= Void
		local
			version: SYSTEM_VERSION
			culture: SYSTEM_GLOBALIZATION_CULTUREINFO
			encoding: SYSTEM_TEXT_ASCIIENCODING
			public_key: ARRAY [INTEGER_8]
			retried: BOOLEAN
		do
			create Result.make
			Result.set_Name (assembly_descriptor.Name)
			create version.make_3 (assembly_descriptor.Version)
			Result.set_Version (version)
			if not assembly_descriptor.Culture.equals_string (dictionary.Neutral_culture) then
				create culture.make (assembly_descriptor.Culture)
			else
				create culture.make (dictionary.Empty_string)
			end
			Result.set_CultureInfo (culture)
			create encoding.make_asciiencoding 
			if not retried then
				public_key := encoding.GetBytes (assembly_descriptor.PublicKey)
				Result.SetPublicKeyToken (public_key)
			end
		ensure
			non_void_assembly_name: Result /= Void
		rescue
			retried := True
			retry
		end
	
	import_assembly_and_dependancies is
			-- Import the assembly corresponding to `assembly_descriptor' and its dependancies.
		indexing
			external_name: "ImportAssemblyAndDependancies"
		require
			non_void_assembly_descriptor: assembly_descriptor /= Void
		local
			assembly_name: SYSTEM_REFLECTION_ASSEMBLYNAME
			assembly: SYSTEM_REFLECTION_ASSEMBLY
			--emitter: ISE_REFLECTION_EIFFELCODEGENERATOR
		do
			assembly_name := assembly_name_from_info
			assembly := assembly.load (assembly_name)
			console.writeline_string (dictionary.Assembly_and_dependancies_importation_message)
			display_message (dictionary.Assembly_and_dependancies_importation_message)
			--create emitter.make
			--emitter.importassemblyfromgac (assembly)
			controls.remove (message_text_box)
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
			--emitter: ISE_REFLECTION_EIFFELCODEGENERATOR		
		do
			assembly_name := assembly_name_from_info
			assembly := assembly.load (assembly_name)
			console.writeline_string (dictionary.Assembly_importation_message)
			display_message (dictionary.Assembly_importation_message)
			--create emitter.make
			--emitter.importassemblywithoutdependancies (assembly)
			controls.remove (message_text_box)
			refresh			
		end
		
	display_message (a_message: STRING) is
			-- Display `a_message' in a text box at the bottom of the window.
		indexing
			external_name: "DisplayMessage"
		require
			non_void_message: a_message /= Void
			not_empty_message: a_message.length > 0
		local
			a_size: SYSTEM_DRAWING_SIZE
			a_point: SYSTEM_DRAWING_POINT
		do
			create message_text_box.make_textbox
			message_text_box.set_forecolor (dictionary.Red_color)
			message_text_box.set_text (a_message)
			--a_size.set_width (dictionary.Window_width - 2 * dictionary.Margin)
			a_size.set_width (Window_width - 2 * Margin)
			message_text_box.set_size (a_size)
			a_point.set_x (Margin)
			if dependancies.count > 0 then
				--a_point.set_Y (9 * dictionary.Margin + 6 * dictionary.Label_height)
				a_point.set_Y (9 * Margin + 6 * Label_height)
			else
				--a_point.set_Y (6 * dictionary.Margin + 5 * dictionary.Label_height)
				a_point.set_Y (6 * Margin + 5 * Label_height)
			end	
			message_text_box.set_location (a_point)
			controls.add (message_text_box)
		end
		
end -- class IMPORT_DIALOG