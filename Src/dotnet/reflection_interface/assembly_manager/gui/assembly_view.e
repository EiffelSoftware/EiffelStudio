indexing
	description: "List the types of currently selected assembly."
	external_name: "ISE.AssemblyManager.AssemblyView"

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
			create dictionary
			assembly_descriptor := an_assembly_descriptor
			type_list := a_type_list
			create types.make
			create children_table.make
			initialize_gui
			return_value := showdialog
		ensure
			assembly_descriptor_set: assembly_descriptor = an_assembly_descriptor
			type_list_set: type_list = a_type_list
			non_void_types: types /= Void
		end

feature -- Access
	
	dictionary: ASSEMBLY_VIEW_DICTIONARY
			-- Dictionary
		indexing
			external_name: "Dictionary"
		end
		
	assembly_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR
			-- Assembly descriptor
		indexing
			external_name: "AssemblyDescriptor"
		end

	assembly_modifications: ASSEMBLY_MODIFICATIONS is
			-- Assembly modifications descriptor
		indexing
			external_name: "AssemblyModifications"
		once
			create Result.make_from_info (assembly_descriptor)
		ensure
			assembly_modifications_created: Result /= Void
			assembly_descriptor_set: Result.assembly_descriptor = assembly_descriptor
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

	Window_height: INTEGER is 600
			-- Window height
		indexing
			external_name: "WindowHeight"
		end
	
	View: INTEGER is 3
			-- View property for list view
		indexing
			external_name: "View"
		end
	
	Alignment: INTEGER is 5
			-- Alignment in list view
		indexing
			external_name: "Alignment"
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
--			i: INTEGER
--			added: INTEGER	
--			a_type: ISE_REFLECTION_EIFFELCLASS
--			an_item: STRING
--			list_view_item: SYSTEM_WINDOWS_FORMS_LISTVIEWITEM
			type: SYSTEM_TYPE
--			on_item_event_handler_delegate: SYSTEM_EVENTHANDLER
			on_close_event_handler_delegate: SYSTEM_EVENTHANDLER
		do
			set_Enabled (True)
			set_text (dictionary.Title)
		--	set_borderstyle (dictionary.Border_style)
		--	a_size.set_Width (dictionary.Window_width)
		--	a_size.set_Height (dictionary.Window_height)
			set_borderstyle (Border_style)
			a_size.set_Width (Window_width)
			a_size.set_Height (Window_height)
			set_minimumsize (a_size)	

				-- `Selected assembly: '
			create assembly_label.make_label
			assembly_label.set_text (assembly_descriptor.name)
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
			assembly_descriptor_label.set_text (dictionary.Assembly_description (assembly_descriptor))
			--a_point.set_X (dictionary.Margin)
			--a_point.set_Y (dictionary.Margin + dictionary.Label_height)
			a_point.set_X (Margin)
			a_point.set_Y (Margin + Label_height)
			assembly_descriptor_label.set_location (a_point)			
			--a_size.set_Width (Window_width - 2 * Left_margin)
			--assembly_descriptor_label.set_size (a_size)
			assembly_descriptor_label.set_autosize (True)
			assembly_descriptor_label.set_font (label_font)

				-- `Types: '
			create types_label.make_label
			types_label.set_text (dictionary.Types_label_text)
			--a_point.set_X (dictionary.Margin)
			--a_point.set_Y (dictionary.Margin * 3 + 2 * Label_height)
			a_point.set_X (Margin)
			a_point.set_Y (Margin * 3 + 2 * Label_height)
			types_label.set_location (a_point)
			--a_size.set_Height (dictionary.Label_height)
			a_size.set_Height (Label_height)
			types_label.set_size (a_size)
			types_label.set_font (label_font)
			
				-- Type list
			build_list_view 
			
				-- Close button
			create close_button.make_button
			--a_point.set_X ((dictionary.Window_width // 2) - (dictionary.Button_width //2))
			--a_point.set_Y (dictionary.Window_height - 4 * dictionary.Margin - dictionary.Button_height)
			a_point.set_X ((Window_width // 2) - (Button_width //2))
			a_point.set_Y (Window_height - 4 * Margin - Button_height)
			close_button.set_location (a_point)
			close_button.set_text (dictionary.Close_button_label)
			type := type_factory.GetType_String (dictionary.System_event_handler_type)
			on_close_event_handler_delegate ?= delegate_factory.CreateDelegate_Type_Object (type, Current, "OnCloseEventHandler")
			close_button.add_Click (on_close_event_handler_delegate)

			controls.add (assembly_label)
			controls.add (assembly_descriptor_label)
			controls.add (types_label)
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
			children: SYSTEM_COLLECTIONS_ARRAYLIST
			type_view: TYPE_VIEW
		do
			selected_item := type_list_view.focuseditem
			eiffel_class ?= types.item (selected_item)
			if eiffel_class /= Void then
				if not children_table.contains (eiffel_class) then
					children := children_factory.recursive_children (eiffel_class)
					children_table.add (eiffel_class, children)
				else
					children ?= children_table.item (eiffel_class)
				end
				create type_view.make (assembly_descriptor, eiffel_class, children, Current)
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

feature {TYPE_VIEW} -- Status Setting

	set_assembly_types (a_list: like type_list) is
			-- Set `type_list' with `a_list'.
		indexing
			external_name: "SetAssemblyTypes"
		require
			non_void_type_list: a_list /= Void
		do
			type_list := a_list
			controls.remove (type_list_view)
			build_list_view
			refresh
		ensure
			type_list_set: type_list = a_list
		end

	set_children (an_eiffel_class: ISE_REFLECTION_EIFFELCLASS; children_list: SYSTEM_COLLECTIONS_ARRAYLIST) is
			-- Replace children of `an_eiffel_class' by `children_list' in `children_table'.
		indexing
			external_name: "SetChildren"
		require
			non_void_eiffel_class: an_eiffel_class /= Void
			non_void_children_list: children_list /= Void	
		do
			if children_table.contains (an_eiffel_class) then
				children_table.remove (an_eiffel_class)
				children_table.add (an_eiffel_class, children_list)
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
	
	types: SYSTEM_COLLECTIONS_HASHTABLE
			-- Key: Instance of `SYSTEM_WINDOWS_FORMS_LISTVIEWITEM'
			-- Value: Instance of `ISE_REFLECTION_EIFFELCLASS'
		indexing
			external_name: "Types"
		end
	
	children_factory: CHILDREN_FACTORY is
			-- Children factory
		indexing
			external_name: "ChildrenFactory"
		require
			non_void_type_list: type_list /= Void
		once
			create Result.make (type_list)
		ensure
			children_factory_created: Result /= Void
		end
	
	children_table: SYSTEM_COLLECTIONS_HASHTABLE
			-- Key: instance of `ISE_REFLECTION_EIFFELCLASS'
			-- Value: List of children (instance of `SYSTEM_COLLECTIONS_ARRAYLIST [ISE_REFLECTION_EIFFELCLASS]')
		indexing
			external_name: "ChildrenTable"
		end
	
	build_list_view is
			-- Build list view from `type_list'.
		indexing
			external_name: "BuildListView"
		local
			a_size: SYSTEM_DRAWING_SIZE
			a_point: SYSTEM_DRAWING_POINT
			i: INTEGER
			a_type: ISE_REFLECTION_EIFFELCLASS
			an_item: STRING
			list_view_item: SYSTEM_WINDOWS_FORMS_LISTVIEWITEM
			type: SYSTEM_TYPE
			on_item_event_handler_delegate: SYSTEM_EVENTHANDLER		
		do
			create type_list_view.make_listview
			--type_list_view.set_borderstyle (dictionary.List_view_border_style)
			type_list_view.set_borderstyle (List_view_border_style)
			type_list_view.set_checkboxes (False)
			type_list_view.set_fullrowselect (True)
			type_list_view.set_gridlines (True)
			type_list_view.set_multiselect (False)
			type_list_view.set_sorting (0)
			--type_list_view.set_view (dictionary.View)
			type_list_view.set_view (View)
			type_list_view.set_activation (0)
			--type_list_view.set_alignment (dictionary.Alignment)
			type_list_view.set_alignment (Alignment)
			type_list_view.set_scrollable (True)
			type_list_view.set_tabindex (0)
			
			--a_point.set_X (dictionary.Margin)
			--a_point.set_Y (5 * dictionary.Margin + 3 * dictionary.Label_height)
			a_point.set_X (Margin)
			a_point.set_Y (5 * Margin + 3 * Label_height)
			type_list_view.set_location (a_point)
			
			--a_size.set_width (dictionary.Window_width - 2 * dictionary.Margin)
			--a_size.set_height (dictionary.Window_height - 11 * dictionary.Margin - 3 * dictionary.Label_height - dictionary.Button_height)
			a_size.set_width (Window_width - 2 * Margin)
			a_size.set_height (Window_height - 11 * Margin - 3 * Label_height - Button_height)
			type_list_view.set_size (a_size)				
			from
			until
				i = type_list.count
			loop
				a_type ?= type_list.item (i)
				if a_type /= Void then
					an_item := a_type.eiffelname
					if a_type.fullexternalname /= Void and then a_type.fullexternalname.length > 0 then
						an_item := an_item.concat_string_string_string_string (an_item, dictionary.Space, dictionary.Opening_bracket, a_type.fullexternalname)
						an_item := an_item.concat_string_string (an_item, dictionary.Closing_bracket)
					end
					create list_view_item.make_1 (an_item)
					list_view_item := type_list_view.items.add_listviewitem (list_view_item)
					types.add (list_view_item, a_type)
				end
				i := i + 1
			end
			type := type_factory.GetType_String (dictionary.System_event_handler_type)
			on_item_event_handler_delegate ?= delegate_factory.CreateDelegate_Type_Object (type, Current, "OnItemEventHandler")
			type_list_view.add_Click (on_item_event_handler_delegate)
			controls.add (type_list_view)
		end
		
end -- class ASSEMBLY_VIEW