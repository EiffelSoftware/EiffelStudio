indexing
	description: "Enable user to import a .NET assembly."
	external_name: "AssemblyManager.ImportDialog"

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

feature -- Constants

	Title: STRING is "Import a .NET assembly"
			-- Window title
		indexing
			external_name: "Title"
		end
	
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
				Result := 280
			else
				Result := 230
			end
		end
		
	Window_width: INTEGER is 700
			-- Window width
		indexing
			external_name: "WindowWidth"
		end
		
	Assembly_label_text: STRING is "Selected assembly: "
			-- Text of assembly label
		indexing
			external_name: "AssemblyLabelText"
		end
	
	Left_margin: INTEGER is 10
			-- Left margin
		indexing
			external_name: "LeftMargin"
		end
	
	Top_margin: INTEGER is 10
			-- Top margin
		indexing
			external_name: "TopMargin"
		end
	
	Name_string: STRING is "Name: " 
			-- Assembly name label
		indexing
			external_name: "NameString"
		end

	Version_string: STRING is "Version: " 
			-- Assembly version label
		indexing
			external_name: "VersionString"
		end

	Culture_string: STRING is "Culture: " 
			-- Assembly culture label
		indexing
			external_name: "CultureString"
		end

	Public_key_string: STRING is "Public Key: " 
			-- Assembly public key label
		indexing
			external_name: "PublicKeyString"
		end
	
	Comma_separator: STRING is ", "
			-- Comma separator
		indexing
			external_name: "CommaSeparator"
		end
		
	Assembly_descriptor_text: STRING is 
			-- Text representing `assembly_descriptor'.
		indexing
			external_name: "AssemblyDescriptorText"
		require
			non_void_assembly_descriptor: assembly_descriptor /= Void
			non_void_assembly_name: assembly_descriptor.name /= Void
			not_empty_assembly_name: assembly_descriptor.name.Length > 0
		once
			Result := Name_string
			Result := Result.concat_string_string (Result, assembly_descriptor.name)
			if assembly_descriptor.version /= Void then
				if assembly_descriptor.version.Length > 0 then
					Result := Result.concat_string_string_string_string (Result, Comma_separator, Version_string, assembly_descriptor.version)
				end
			end
			if assembly_descriptor.culture /= Void then
				if assembly_descriptor.culture.Length > 0 then
					Result := Result.concat_string_string_string_string (Result, Comma_separator, Culture_string, assembly_descriptor.culture)
				end
			end
			if assembly_descriptor.publickey /= Void then
				if assembly_descriptor.publickey.Length > 0 then
					Result := Result.concat_string_string_string_string (Result, Comma_separator, Public_key_string, assembly_descriptor.publickey)
				end
			end			
		end
	
	Label_height: INTEGER is 20
			-- Label height
		indexing
			external_name: "LabelHeight"
		end
	
	Font_family_name: STRING is "Verdana"
			-- Name of label font family
		indexing
			external_name: "FontFamilyName"
		end
	
	Label_font_size: REAL is 10.0
			-- Label font size
		indexing
			external_name: "LabelFontSize"
		end
	
	Bold_style: INTEGER is 0
			-- Bold style
		indexing
			external_name: "BoldStyle"
		end
	
	Destination_path_label_text: STRING is "Destination path: " 
			-- Text of destination path label
		indexing
			external_name: "DestinationPathLabelText"
		end

	Browse_button_label: STRING is "Browse..."
			-- Browse button label
		indexing
			external_name: "BrowseButtonLabel"
		end
		
	Explanation_label_text: STRING is "Path to directory where Eiffel classes will be generated." 
			-- Explanation of destination path
		indexing
			external_name: "ExplanationLabelText"
		end	
	
	Dependancies_check_box_text: STRING is "Import assembly dependancies"
			-- Dependancies check box text
		indexing
			external_name: "DependanciesCheckBoxText"
		end
		
	Button_height: INTEGER is 30
			-- Button height
		indexing
			external_name: "ButtonHeight"
		end
	
	Button_width: INTEGER is 80
			-- Button height
		indexing
			external_name: "ButtonWidth"
		end
	
	Ok_button_label: STRING is "OK"
			-- OK button label
		indexing
			external_name: "OkButtonLabel"
		end

	Cancel_button_label: STRING is "Cancel"
			-- Cancel button label
		indexing
			external_name: "CancelButtonLabel"
		end
		
	System_event_handler_type: STRING is "System.EventHandler"
			-- `System.EventHandler' type
		indexing
			external_name: "SystemEventHandlerType"
		end
	
	Empty_string: STRING is ""
			-- Empty string
		indexing
			external_name: "EmptyString"
		end
		
	Neutral_culture: STRING is "neutral"
			-- Neutral culture
		indexing
			external_name: "NeutralCulture"
		end
	
	Destination_path_selection_title: STRING is "Select a destination path"
			-- Title of browse dialog used to select the destination path
		indexing
			external_name: "DestinationPathSelectionTitle"
		end
	
	Warning_text: STRING is "Are you sure you want to import the .NET assembly without its dependancies?"
			-- Warning in case user does not ask for importation of assembly dependancies
		indexing
			external_name: "WarningText"
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
			type: SYSTEM_TYPE
			on_browse_event_handler_delegate: SYSTEM_EVENTHANDLER
			on_ok_event_handler_delegate: SYSTEM_EVENTHANDLER
			on_cancel_event_handler_delegate: SYSTEM_EVENTHANDLER
		do
			set_Enabled (True)
			set_text (Title)
			set_borderstyle (Border_style)
			a_size.set_Width (Window_width)
			a_size.set_Height (Window_height)
			set_size (a_size)		

				-- `Selected assembly: '
			create assembly_label.make_label
			assembly_label.set_text (Assembly_label_text)
			a_point.set_X (Left_margin)
			a_point.set_Y (Top_margin)
			assembly_label.set_location (a_point)
			a_size.set_Height (Label_height)
			assembly_label.set_size (a_size)
			create label_font.make_font_10 (Font_family_name, Label_font_size,  Bold_style) 
			assembly_label.set_font (label_font)
			
			create assembly_descriptor_label.make_label
			assembly_descriptor_label.set_text (Assembly_descriptor_text)
			a_point.set_X (Left_margin)
			a_point.set_Y (Top_margin + Label_height)
			assembly_descriptor_label.set_location (a_point)			
			a_size.set_Width (Window_width - 2 * Left_margin)
			assembly_descriptor_label.set_size (a_size)
			assembly_descriptor_label.set_autosize (True)
			
				-- `Destination_path: '
			create destination_path_label.make_label
			destination_path_label.set_text (Destination_path_label_text)
			a_point.set_X (Left_margin)
			a_point.set_Y (3 * Top_margin + 2 * Label_height)
			destination_path_label.set_location (a_point)
			a_size.set_Height (Label_height)
			destination_path_label.set_size (a_size)
			destination_path_label.set_font (label_font)				

				-- Destination path text box
			create destination_path_text_box.make_textbox
			a_point.set_X (Left_margin)
			a_point.set_Y (4 * Top_margin + 3 * Label_height)
			destination_path_text_box.set_location (a_point)
			a_size.set_Width (Window_width - Button_width - 3 * Left_margin)
			a_size.set_Height (Label_height)
			destination_path_text_box.set_size (a_size)

				-- Browse button
			create browse_button.make_button
			a_point.set_X (Window_width - Left_margin - Button_width) 
			a_point.set_Y (3 * Top_margin + 3 * Label_height + Top_margin // 2)
			browse_button.set_location (a_point)
			--a_size.set_Width (Button_width)
			--a_size.set_Height (Button_height)
			--browse_button.set_size (a_size)
			browse_button.set_text (Browse_button_label)
			type := type_factory.GetType_String (System_event_handler_type)
			on_browse_event_handler_delegate ?= delegate_factory.CreateDelegate_Type_Object (type, Current, "OnBrowseEventHandler")
			browse_button.add_Click (on_browse_event_handler_delegate)
			
				-- Explanation for destination path
			create explanation_label.make_label
			explanation_label.set_text (Explanation_label_text)
			a_point.set_X (Left_margin)
			a_point.set_Y (5 * Top_margin + 4 * Label_height)
			explanation_label.set_location (a_point)
			explanation_label.set_autosize (True)

				-- Dependancies check box (checked by default)
			if dependancies.count > 0 then
				create dependancies_check_box.make_checkbox
				dependancies_check_box.set_text (Dependancies_check_box_text)
				a_point.set_X (Left_margin)
				a_point.set_Y (7 * Top_margin + 5 * Label_height)
				dependancies_check_box.set_location (a_point)
				a_size.set_height (Label_height)
				a_size.set_width (Window_width - 2 * Left_margin)
				dependancies_check_box.set_size (a_size)
				dependancies_check_box.set_checked (True)
				dependancies_check_box.set_autocheck (True)
				controls.add (dependancies_check_box)
			end
			
				-- OK button
			create ok_button.make_button
			a_point.set_X ((Window_width // 2) - (Left_margin //2) - Button_width) 
			if dependancies.count > 0 then
				a_point.set_Y (9 * Top_margin + 6 * Label_height)
			else
				a_point.set_Y (6 * Top_margin + 5 * Label_height)
			end
			ok_button.set_location (a_point)
			ok_button.set_text (Ok_button_label)
			type := type_factory.GetType_String (System_event_handler_type)
			on_ok_event_handler_delegate ?= delegate_factory.CreateDelegate_Type_Object (type, Current, "OnOkEventHandler")
			ok_button.add_Click (on_ok_event_handler_delegate)

				-- Cancel button
			create cancel_button.make_button
			a_point.set_X ((Window_width // 2) + (Left_margin //2))
			if dependancies.count > 0 then
				a_point.set_Y (9 * Top_margin + 6 * Label_height)
			else
				a_point.set_Y (6 * Top_margin + 5 * Label_height)
			end
			cancel_button.set_location (a_point)
			cancel_button.set_text (Cancel_button_label)
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
			warning_dialog: WARNING_DIALOG
			assembly_name: SYSTEM_REFLECTION_ASSEMBLYNAME
			assembly: SYSTEM_REFLECTION_ASSEMBLY
		do
				-- Check for importation of assembly dependancies
			if dependancies.count > 0 then
				if not dependancies_check_box.Checked then
					create warning_dialog.make (assembly_descriptor, dependancies, Warning_text)
				end
			else
				assembly_name := assembly_name_from_info
				assembly := assembly.load (assembly_name)
				console.writeline_string ("ok: importation of assembly and dependancies")
				--import (assembly)
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
		local
			--select_folder_dialog: SYSTEM_WINDOWS_FORMS_DESIGN_FOLDERNAMEEDITOR
		do
			console.writeline_string ("browse")
			--create select_folder_dialog.make_foldernameeditor
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

	assembly_name_from_info: SYSTEM_REFLECTION_ASSEMBLYNAME is
			-- Assembly name corresponding to `assembly_descriptor'.
		require
			non_void_descriptor: assembly_descriptor /= Void
		local
			version: SYSTEM_VERSION
			culture: SYSTEM_GLOBALIZATION_CULTUREINFO
			encoding: SYSTEM_TEXT_ASCIIENCODING
			public_key: ARRAY [INTEGER_8]
		do
			create Result.make
			Result.set_Name (assembly_descriptor.Name)
			create version.make_3 (assembly_descriptor.Version)
			Result.set_Version (version)
			if not assembly_descriptor.Culture.Equals_String (Neutral_culture) then
				create culture.make (assembly_descriptor.Culture)
			else
				create culture.make (Empty_string)
			end
			Result.set_CultureInfo (culture)
			create encoding.make_asciiencoding 
			public_key := encoding.GetBytes (assembly_descriptor.PublicKey)
			Result.SetPublicKeyToken (public_key)
		ensure
			non_void_assembly_name: Result /= Void
		end
		
end -- class IMPORT_DIALOG