indexing
	description: "Dialog showing dependancies of a .NET assembly"
	external_name: "AssemblyManager.DependancyViewer"

class
	DEPENDANCY_VIEWER
	
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

	dependancies_label: SYSTEM_WINDOWS_FORMS_LABEL
			-- Dependancies label
		indexing
			external_name: "DependanciesLabel"
		end
	
	close_button: SYSTEM_WINDOWS_FORMS_BUTTON
			-- Close button
		indexing
			external_name: "CloseButton"
		end

	Window_height: INTEGER is 
			-- Window height
		indexing
			external_name: "WindowHeight"
		do
			if dependancies.count = 0 then
				Result := 200
			else
				Result := Label_height * (dependancies.count + 4) + (dependancies.count + 8) * Top_margin + Button_height
			end
		end
		
feature -- Constants

	Title: STRING is "Dependancy viewer"
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
	
	Dependancies_label_text: STRING is "Dependancies: " 
			-- Text of dependancies label
		indexing
			external_name: "DependanciesLabelText"
		end
	
	No_dependancies_text: STRING is "The selected assembly has no dependancy."
			-- Text whenever selected assembly has no dependancy	
		indexing
			external_name: "NoDependanciesText"
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
	
	Close_button_label: STRING is "Close"
			-- Close button label
		indexing
			external_name: "CloseButtonLabel"
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
			on_close_event_handler_delegate: SYSTEM_EVENTHANDLER
		do
			set_Enabled (True)
			set_text (Title)
			set_borderstyle (Border_style)
			a_size.set_Width (Window_width)
			a_size.set_Height (Window_height)
			set_size (a_size)	
			--set_autoscroll (True)

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
			
				-- `Dependancies: '
			if dependancies.count > 0 then
				create dependancies_label.make_label
				dependancies_label.set_text (Dependancies_label_text)
				a_point.set_X (Left_margin)
				a_point.set_Y (3 * Top_margin + 2 * Label_height)
				dependancies_label.set_location (a_point)
				a_size.set_Height (Label_height)
				dependancies_label.set_size (a_size)
				dependancies_label.set_font (label_font)
				from
				until
					i = dependancies.count
				loop
					a_dependancy := dependancies.item (i)
					create dependancy_label.make_label
					dependancy_label.set_text (a_dependancy.fullname)
					a_point.set_X (Left_margin)
					a_point.set_Y ( (4 + i) * Top_margin + (3 + i) * Label_height)
					dependancy_label.set_location (a_point)			
					a_size.set_Width (Window_width - 2 * Left_margin)
					dependancy_label.set_size (a_size)
					dependancy_label.set_autosize (True)					
					controls.add (dependancy_label)
					i := i + 1
				end 
			else
				create dependancies_label.make_label
				dependancies_label.set_text (No_dependancies_text)
				a_point.set_X (Left_margin)
				a_point.set_Y (3 * Top_margin + 2 * Label_height)
				dependancies_label.set_location (a_point)
				a_size.set_Height (Label_height)
				dependancies_label.set_size (a_size)
				dependancies_label.set_font (label_font)				
			end
				
				-- Close button
			create close_button.make_button
			a_point.set_X ((Window_width // 2) - (Button_width //2))
			a_point.set_Y (Window_height - 4 * Top_margin - Button_height)
			close_button.set_location (a_point)
			--a_size.set_Width (Button_width)
			--a_size.set_Height (Button_height)
			--close_button.set_size (a_size)
			close_button.set_text (Close_button_label)
			type := type_factory.GetType_String (System_event_handler_type)
			on_close_event_handler_delegate ?= delegate_factory.CreateDelegate_Type_Object (type, Current, "OnCloseEventHandler")
			close_button.add_Click (on_close_event_handler_delegate)
			
				-- Addition of controls
			controls.add (assembly_label)
			controls.add (assembly_descriptor_label)
			controls.add (dependancies_label)
			controls.add (close_button)
		end

feature -- Event handling

	on_close_event_handler (sender: ANY; arguments: SYSTEM_EVENTARGS) is
			-- Process `close_button' activation.
		indexing
			external_name: "OnCloseEventHandler"
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
			
end -- class DEPENDANCY_VIEWER
