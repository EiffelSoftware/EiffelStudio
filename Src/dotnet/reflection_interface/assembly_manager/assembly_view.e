indexing
	description: "List the types of currently selected assembly."
	external_name: "AssemblyManager.AssemblyView"

class
	ASSEMBLY_VIEW

inherit
	SYSTEM_WINDOWS_FORMS_FORM

create
	make

feature {NONE} -- Initialization

	make (an_assembly_descriptor: like assembly_descriptor; a_type_list: like type_list) is
			-- Set `assembly_descriptor' with `an_assembly_descriptor'.
			-- Set `type_list' with `a_type_list'.
		indexing
			external_name: "Make"
		require
			non_void_type_list: a_type_list /= Void
			non_void_assembly_descriptor: an_assembly_descriptor /= Void
			non_void_assembly_name: an_assembly_descriptor.name /= Void
			not_empty_assembly_name: an_assembly_descriptor.name.Length > 0
		local
			return_value: INTEGER
		do
			make_form
			assembly_descriptor := an_assembly_descriptor
			type_list := a_type_list
			create types.make
			initialize_gui
			return_value := showdialog
		ensure
			assembly_descriptor_set: assembly_descriptor = an_assembly_descriptor
			type_list_set: type_list = a_type_list
			non_void_types: types /= Void
		end

feature -- Access
	
	assembly_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR
			-- Assembly descriptor
		indexing
			external_name: "AssemblyDescriptor"
		end

	assembly_descriptor_label: SYSTEM_WINDOWS_FORMS_LABEL
			-- Assembly descriptor label
		indexing
			external_name: "AssemblyDescriptorLabel"
		end
		
	type_list: SYSTEM_COLLECTIONS_ARRAYLIST
			-- Assembly types
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [ISE_REFLECTION_EIFFELCLASS]
		indexing
			external_name: "TypeList"
		end

	assembly_label: SYSTEM_WINDOWS_FORMS_LABEL
			-- Assembly label
		indexing
			external_name: "AssemblyLabel"
		end
	
	types_label: SYSTEM_WINDOWS_FORMS_LABEL
			-- Types label
		indexing
			external_name: "TypesLabel"
		end

	type_list_view: SYSTEM_WINDOWS_FORMS_LISTVIEW
			-- List view of assembly types
		indexing
			external_name: "TypeListView"
		end

	close_button: SYSTEM_WINDOWS_FORMS_BUTTON
			-- Close button
		indexing
			external_name: "CloseButton"
		end
		
feature -- Constants

	Title: STRING is "Assembly view"
			-- Window title
		indexing
			external_name: "Title"
		end
	
	Border_style: INTEGER is 3
			-- Window border style: a fixed, single line border
		indexing
			external_name: "BorderStyle"
		end
	
	List_view_border_style: INTEGER is 1
			-- List view border style
		indexing
			external_name: "ListViewBorderStyle"
		end
		
	Window_width: INTEGER is 800
			-- Window width
		indexing
			external_name: "WindowWidth"
		end

	Window_height: INTEGER is 
			-- Window height
		indexing
			external_name: "WindowHeight"
		once
			if ((type_list.count + 3) * Label_height + 11 * Top_margin + Button_height) < 600 then
				Result := (type_list.count + 3) * Label_height + 11 * Top_margin + Button_height
			else
				Result := 600
			end
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
	
	Opening_bracket: STRING is "("
			-- Opening round bracket
		indexing
			external_name: "OpeningBracket"
		end

	Closing_bracket: STRING is ")"
			-- Closing round bracket
		indexing
			external_name: "ClosingBracket"
		end

	Label_height: INTEGER is 20
			-- Label height
		indexing
			external_name: "LabelHeight"
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
			Result := Opening_bracket
			if assembly_descriptor.version /= Void then
				if assembly_descriptor.version.Length > 0 then
					Result := Result.concat_string_string_string (Result, Version_string, assembly_descriptor.version)
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
			Result := Result.concat_string_string (Result, Closing_bracket)
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

	Types_label_text: STRING is "Types: "
			-- Types label text
		indexing
			external_name: "TypesLabelText"
		end

	System_event_handler_type: STRING is "System.EventHandler"
			-- `System.EventHandler' type
		indexing
			external_name: "SystemEventHandlerType"
		end
	
	Space: STRING is " "
			-- Space 
		indexing
			external_name: "Space"
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
			added: INTEGER	
			a_type: ISE_REFLECTION_EIFFELCLASS
			an_item: STRING
			list_view_item: SYSTEM_WINDOWS_FORMS_LISTVIEWITEM
			type: SYSTEM_TYPE
			on_item_event_handler_delegate: SYSTEM_EVENTHANDLER
			on_close_event_handler_delegate: SYSTEM_EVENTHANDLER
		do
			set_Enabled (True)
			set_text (Title)
			set_borderstyle (Border_style)
			a_size.set_Width (Window_width)
			a_size.set_Height (Window_height)
			set_size (a_size)	

				-- `Selected assembly: '
			create assembly_label.make_label
			assembly_label.set_text (assembly_descriptor.name)
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
			assembly_descriptor_label.set_font (label_font)

				-- `Types: '
			create types_label.make_label
			types_label.set_text (Types_label_text)
			a_point.set_X (Left_margin)
			a_point.set_Y (Top_margin * 3 + 2 * Label_height)
			types_label.set_location (a_point)
			a_size.set_Height (Label_height)
			types_label.set_size (a_size)
			types_label.set_font (label_font)
			
				-- Type list
			create type_list_view.make_listview
			type_list_view.set_borderstyle (List_view_border_style)
			type_list_view.set_checkboxes (False)
			type_list_view.set_fullrowselect (True)
			type_list_view.set_gridlines (True)
			type_list_view.set_multiselect (True)
			type_list_view.set_sorting (0)
			type_list_view.set_view (3)
			type_list_view.set_activation (0)
			type_list_view.set_alignment (5)
			type_list_view.set_scrollable (True)
			type_list_view.set_tabindex (0)
			
			a_point.set_X (Left_margin)
			a_point.set_Y (5 * Top_margin + 3 * Label_height)
			type_list_view.set_location (a_point)
			
			a_size.set_width (Window_width - 2 * Left_margin)
			a_size.set_height (Window_height - 11 * Top_margin - 3 * Label_height - Button_height)
			type_list_view.set_size (a_size)
				
			from
			until
				i = type_list.count
			loop
				a_type ?= type_list.item (i)
				if a_type /= Void then
					an_item := a_type.eiffelname
					if a_type.dotnetsimplename /= Void then
						if a_type.dotnetsimplename.length > 0 then
							an_item := an_item.concat_string_string_string_string (an_item, Space, Opening_bracket, a_type.dotnetfullname)
							an_item := an_item.concat_string_string (an_item, Closing_bracket)
						end
					end
					create list_view_item.make_1 (an_item)
					list_view_item := type_list_view.items.add (list_view_item)
					types.add (list_view_item, a_type)
				end
				i := i + 1
			end

			type := type_factory.GetType_String (System_event_handler_type)
			on_item_event_handler_delegate ?= delegate_factory.CreateDelegate_Type_Object (type, Current, "OnItemEventHandler")
			type_list_view.add_Click (on_item_event_handler_delegate)
			
				-- Close button
			create close_button.make_button
			a_point.set_X ((Window_width // 2) - (Button_width //2))
			a_point.set_Y (Window_height - 4 * Top_margin - Button_height)
			close_button.set_location (a_point)
			close_button.set_text (Close_button_label)
			on_close_event_handler_delegate ?= delegate_factory.CreateDelegate_Type_Object (type, Current, "OnCloseEventHandler")
			close_button.add_Click (on_close_event_handler_delegate)

			controls.add (assembly_label)
			controls.add (assembly_descriptor_label)
			controls.add (types_label)
			controls.add (type_list_view)
			controls.add (close_button)
		end

feature -- Event handling

	on_item_event_handler (sender: ANY; arguments: SYSTEM_EVENTARGS) is
			-- Process `close_button' activation.
		indexing
			external_name: "OnItemEventHandler"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		local
			selected_item: SYSTEM_WINDOWS_FORMS_LISTVIEWITEM
			eiffel_class: ISE_REFLECTION_EIFFELCLASS
			type_view: TYPE_VIEW
		do
			selected_item := type_list_view.focuseditem
			eiffel_class ?= types.item (selected_item)
			if eiffel_class /= Void then
				create type_view.make (assembly_descriptor, eiffel_class)
			end
		end

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
	
	types: SYSTEM_COLLECTIONS_HASHTABLE
			-- Key: Instance of `SYSTEM_WINDOWS_FORMS_LISTVIEWITEM'
			-- Value: Instance of `ISE_REFLECTION_EIFFELCLASS'
		indexing
			external_name: "Types"
		end
			
end -- class ASSEMBLY_VIEW