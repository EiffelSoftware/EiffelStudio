indexing
	description: "Dialog showing dependancies of a .NET assembly"
	external_name: "AssemblyManager.RemoveDialog"

class
	REMOVE_DIALOG
	
inherit
	SYSTEM_WINDOWS_FORMS_FORM

create
	make

feature {NONE} -- Initialization

	make (an_assembly_descriptor: like assembly_descriptor; assembly_dependancies: like dependancies) is
			-- Set `assembly_descriptor' with `an_assembly_descriptor'.
			-- Set `dependancies' with `assembly_dependancies'.
		indexing
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

	question_label: SYSTEM_WINDOWS_FORMS_LABEL
			-- Question label
		indexing
			external_name: "QuestionLabel"
		end

	dependancies_check_box: SYSTEM_WINDOWS_FORMS_CHECKBOX
			-- Check box to remove dependancies 
		indexing
			external_name: "DependanciesCheckBox"
		end
				
	yes_button: SYSTEM_WINDOWS_FORMS_BUTTON
			-- Yes button
		indexing
			external_name: "YesButton"
		end

	no_button: SYSTEM_WINDOWS_FORMS_BUTTON
			-- No button
		indexing
			external_name: "NoButton"
		end
		
	Window_height: INTEGER is 
			-- Window height
		indexing
			external_name: "WindowHeight"
		do
			if dependancies.count > 0 then
				Result := 220
			else
				Result := 180
			end
		end
		
feature -- Constants

	Title: STRING is "Remove a .NET assembly"
			-- Window title
		indexing
			external_name: "Title"
		end
	
	Border_style: INTEGER is 3
			-- Window border style: a fixed, single line border
		indexing
			external_name: "BorderStyle"
		end
	
	Window_width: INTEGER is 700
			-- Window width
		indexing
			external_name: "WindowWidth"
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

	Assembly_label_text: STRING is "Selected assembly: "
			-- Text of assembly label
		indexing
			external_name: "AssemblyLabelText"
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
		ensure
			non_void_assembly_descriptor_text: Result /= Void
			not_empty_assembly_descriptor_label_text: Result.length > 0
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

	Question_label_text: STRING is "Are you sure you want to remove the selected .NET assembly?"
			-- Question to the user
		indexing
			external_name: "QuestionLabelText"
		end

	Warning_text: STRING is "Are you sure you want to remove the assembly and its dependancies?"
			-- Warning in case user asks for removal of assembly dependancies
		indexing
			external_name: "WarningText"
		end
		
	Dependancies_check_box_text: STRING is "Remove dependancies."
			-- Check box for dependancies removal
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
	
	Yes_button_label: STRING is "Yes"
			-- Yes button label
		indexing
			external_name: "YesButtonLabel"
		end

	No_button_label: STRING is "No"
			-- No button label
		indexing
			external_name: "NoButtonLabel"
		end
		
	System_event_handler_type: STRING is "System.EventHandler"
			-- `System.EventHandler' type
		indexing
			external_name: "SystemEventHandlerType"
		end
	
	Neutral_culture: STRING is "neutral"
			-- Neutral culture
		indexing
			external_name: "NeutralCulture"
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
			i: INTEGER
			a_dependancy: SYSTEM_REFLECTION_ASSEMBLYNAME
			dependancy_label: SYSTEM_WINDOWS_FORMS_LABEL	
			type: SYSTEM_TYPE
			on_yes_event_handler_delegate: SYSTEM_EVENTHANDLER
			on_no_event_handler_delegate: SYSTEM_EVENTHANDLER
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

				-- Question to the user
			create question_label.make_label
			question_label.set_text (Question_label_text)
			a_point.set_X (Left_margin)
			a_point.set_Y (5 * Top_margin +  Label_height)
			question_label.set_location (a_point)
			question_label.set_autosize (True)	
			question_label.set_font (label_font)
			
				-- `Dependancies: '
			if dependancies.count > 0 then
					-- Dependancies check box (not checked by default)		
				create dependancies_check_box.make_checkbox
				dependancies_check_box.set_text (Dependancies_check_box_text)
				a_point.set_X (Left_margin)
				a_point.set_Y (7 * Top_margin + 2 * Label_height)
				dependancies_check_box.set_location (a_point)
				a_size.set_height (Label_height)
				dependancies_check_box.set_size (a_size)
				dependancies_check_box.set_checked (False)
				dependancies_check_box.set_autocheck (True)
				controls.add (dependancies_check_box)
			end
			
				-- Yes button
			create yes_button.make_button
			a_point.set_X ((Window_width // 2) - Button_width - (Top_margin //2))
			a_point.set_Y (Window_height - 4 * Top_margin - Button_height)
			yes_button.set_location (a_point)
			--a_size.set_Width (Button_width)
			--a_size.set_Height (Button_height)
			--yes_button.set_size (a_size)
			yes_button.set_text (Yes_button_label)
			type := type_factory.GetType_String (System_event_handler_type)
			on_yes_event_handler_delegate ?= delegate_factory.CreateDelegate_Type_Object (type, Current, "OnYesEventHandler")
			yes_button.add_Click (on_yes_event_handler_delegate)

				-- No button
			create no_button.make_button
			a_point.set_X ((Window_width // 2) + (Top_margin //2))
			a_point.set_Y (Window_height - 4 * Top_margin - Button_height)
			no_button.set_location (a_point)
			--a_size.set_Width (Button_width)
			--a_size.set_Height (Button_height)
			--no_button.set_size (a_size)
			no_button.set_text (No_button_label)
			type := type_factory.GetType_String (System_event_handler_type)
			on_no_event_handler_delegate ?= delegate_factory.CreateDelegate_Type_Object (type, Current, "OnNoEventHandler")
			no_button.add_Click (on_no_event_handler_delegate)
			
				-- Addition of controls
			controls.add (assembly_label)
			controls.add (assembly_descriptor_label)
			controls.add (question_label)
			controls.add (yes_button)
			controls.add (no_button)
		end

feature -- Event handling

	on_yes_event_handler (sender: ANY; arguments: SYSTEM_EVENTARGS) is
			-- Process `yes_button' activation.
		indexing
			external_name: "OnYesEventHandler"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		local
			warning_dialog: WARNING_DIALOG
		do
			if dependancies.count > 0 then
				if dependancies_check_box.Checked then
					create warning_dialog.make (assembly_descriptor, dependancies, Warning_text)
				else
					console.writeline_string ("yes clicked: will remove selected assembly without any dependancies")
				end
			else
				console.writeline_string ("yes clicked: will remove selected assembly")
			end
		end

	on_no_event_handler (sender: ANY; arguments: SYSTEM_EVENTARGS) is
			-- Process `no_button' activation.
		indexing
			external_name: "OnNoEventHandler"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		do
			close
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
			
end -- class REMOVE_DIALOG
