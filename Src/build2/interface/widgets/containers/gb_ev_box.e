indexing
	description: "Objects that manipulate objects of type EV_BOX"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_EV_BOX

	-- The following properties from EV_BOX are manipulated by `Current'.
	-- Is_homgeneous - Performed on the real object and the display_object child.
	-- Padding width - Performed on the real object and the display_object child
	-- Border_width - Performed on the real object and the display_object child
	-- Is_item_expanded - Performed on the real object and the display_object child

inherit
	
	GB_EV_ANY
		redefine
			attribute_editor,
			ev_type,
			modify_from_xml_after_build
		end
		
	GB_XML_UTILITIES
		undefine
			default_create
		end
		
	INTERNAL
		undefine
			default_create
		end
		
	GB_SHARED_DEFERRED_BUILDER
		undefine
			default_create
		end

feature -- Access


	ev_type: EV_BOX
		-- Vision2 type represented by `Current'.
		
	type: STRING is "EV_BOX"
		-- String representation of object_type modifyable by `Current'.
		
	attribute_editor: GB_OBJECT_EDITOR_ITEM is
			-- A vision2 component to enable modification
			-- of items held in `objects'.
		local
			label: EV_LABEL
			second: like ev_type
			check_button: EV_CHECK_BUTTON
		do
			create check_buttons.make (0)
			Result := Precursor {GB_EV_ANY}
				-- We need the child of the display objects here,
				-- not the actual object itself.
			second := objects @ (2).item
			
			create is_homogeneous_check.make_with_text ("Is_homogeneous?")
			Result.extend (is_homogeneous_check)
			is_homogeneous_check.select_actions.extend (agent update_homogeneous)
			is_homogeneous_check.select_actions.extend (agent update_editors)
			
			create padding_entry.make (Current, Result, "Padding", agent set_padding (?), agent valid_input (?))
			create border_entry.make (Current, Result, "Border", agent set_border (?), agent valid_input (?))

				-- We only add the is_expandable label if there are children
			if not first.is_empty then
				create label.make_with_text ("Is_item_expanded?")
				Result.extend (label)			
			end		
			from
				first.start
				second.start
			until
				first.off or second.off
			loop
				create check_button.make_with_text (class_name (first.item))
				check_button.set_pebble_function (agent retrieve_pebble (parent_editor.object.layout_item, first.index))
				check_buttons.force (check_button)
				check_button.select_actions.extend (agent update_widget_expanded (check_button, first.item))
				check_button.select_actions.extend (agent update_widget_expanded (check_button, second.item))
				check_button.select_actions.extend (agent update_editors)
				Result.extend (check_button)
				first.forth
				second.forth
			end
			
			update_attribute_editor

			disable_all_items (Result)
			align_labels_left (Result)
		end
		
	retrieve_pebble (a_layout_item: GB_LAYOUT_CONSTRUCTOR_ITEM; child_index: INTEGER): ANY is
			-- Retrieve pebble for transport.
			-- A convenient was of setting up the drop
			-- actions for GB_OBJECT.
		local
			environment: EV_ENVIRONMENT
			object: GB_OBJECT
			layout_item: GB_LAYOUT_CONSTRUCTOR_ITEM
			shared_tools: GB_SHARED_TOOLS
		do
			layout_item ?= a_layout_item.i_th (child_index)
			check
				layout_item_not_void: layout_item /= Void
			end
			object := layout_item.object
			
			--| FIXME This is currently identical to version in 
			--| GB_OBJECT
			create environment
				-- If the ctrl key is pressed, then we must
				-- start a new object editor for `Current', instead
				-- of beginning the pick and drop.
			if environment.application.ctrl_pressed then
				new_object_editor (object)
			else
				create shared_tools
				shared_tools.type_selector.update_drop_actions_for_all_children (object)
				Result := object
			end
		end
		
	update_attribute_editor is
			-- Update status of `attribute_editor' to reflect information
			-- from `objects.first'.
		do
			check
				counts_match: first.count = check_buttons.count
			end
			is_homogeneous_check.select_actions.block

			if first.is_homogeneous then
				is_homogeneous_check.enable_select
			else
				is_homogeneous_check.disable_select
			end
			border_entry.set_text (first.border_width.out)
			padding_entry.set_text (first.padding_width.out)
			
			from
				check_buttons.start
			until
				check_buttons.off
			loop
				check_buttons.item.select_actions.block
				if first.is_item_expanded (first @ check_buttons.index) then
					check_buttons.item.enable_select
				else
					check_buttons.item.disable_select
				end
				check_buttons.item.select_actions.resume
				check_buttons.forth
			end			
			is_homogeneous_check.select_actions.resume
		end
		
		
	update_widget_expanded (check_button: EV_CHECK_BUTTON; w: EV_WIDGET) is
			-- Change the expanded status of `w'.
		local
			box_parent: EV_BOX
		do
			box_parent ?= w.parent
			check
				parent_is_box: box_parent /= Void
			end
			if check_button.is_selected then
				box_parent.enable_item_expand (w)
			else
				box_parent.disable_item_expand (w)
			end
			system_status.enable_project_modified
			command_handler.update
		end
		
		
feature {GB_XML_STORE} -- Output

	
	generate_xml (element: XML_ELEMENT) is
			-- Generate an XML representation of `Current' in `element'.
		local
			temp_string: STRING
		do
				-- Boxes are not homogeneous by default.
			if objects.first.is_homogeneous = True then
				add_element_containing_boolean (element, Is_homogeneous_string, objects.first.is_homogeneous)
			end
				-- Padding is 0 by default.
			if objects.first.padding_width > 0 then
				add_element_containing_integer (element, Padding_string, objects.first.padding_width)	
			end
				-- Border is 0 by default.
			if objects.first.border_width > 0 then
				add_element_containing_integer (element, Border_string, objects.first.border_width)
			end
			
				-- If there are one or more children in the box, then we always
				-- store the string of details. This could be changed to be made smarter
				-- at some point, so we only store if one ore more are not expanded.
				-- Initialize `temp_string' as empty.
			temp_string := ""
			from
				first.start
			until
				first.off
			loop
						-- For each child that is expandable add "1" else add "0".
					if first.is_item_expanded (first.item) then
						temp_string := temp_string + "1"
					else
						temp_string := temp_string + "0"
					end
				first.forth
			end
			if not temp_string.is_empty then
				add_element_containing_string (element, Is_item_expanded_string, temp_string)
			end
		end
		
	modify_from_xml (element: XML_ELEMENT) is
			-- Update all items in `objects' based on information held in `element'.
		local
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			element_info: ELEMENT_INFORMATION
		do
			full_information := get_unique_full_info (element)
			
			element_info := full_information @ (Is_homogeneous_string)
			if element_info /= Void then
				if element_info.data.is_equal (True_string) then
					for_all_objects (agent {EV_BOX}.enable_homogeneous)
				else
					for_all_objects (agent {EV_BOX}.disable_homogeneous)
				end
			end

			element_info := full_information @ (Padding_string)
			if element_info /= Void then
				for_all_objects (agent {EV_BOX}.set_padding_width (element_info.data.to_integer))
			end
			
			element_info := full_information @ (Border_string)
			if element_info /= Void then
				for_all_objects (agent {EV_BOX}.set_border_width (element_info.data.to_integer))
			end
		
		
				-- We set up some deferred building now.
			deferred_builder.defer_building (Current, element)
		end
		
feature {GB_CODE_GENERATOR} -- Output

	generate_code (element: XML_ELEMENT; a_name: STRING; children_names: ARRAYED_LIST [STRING]): STRING is
			-- `Result' is string representation of
			-- settings held in `Current' which is
			-- in a compilable format.
		local
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			element_info: ELEMENT_INFORMATION
		do
			Result := ""
			full_information := get_unique_full_info (element)
			element_info := full_information @ (Is_homogeneous_string)
			if element_info /= Void then
				if element_info.data.is_equal (True_string) then
					Result := a_name + ".enable_homgeneous"
				else
					Result := a_name + ".disable_homogeneous"
				end
			end
			
			
			element_info := full_information @ (Padding_string)
			if element_info /= Void then
				Result := Result + indent + a_name + ".set_padding_width (" + element_info.data + ")"
			end
			
			element_info := full_information @ (Border_string)
			if element_info /= Void then
				Result := Result + indent + a_name + ".set_border_width (" + element_info.data + ")"
			end
			
				-- This is always saved, so there is no check.
			element_info := full_information @ (Is_item_expanded_string)
			check
				consistent: children_names.count = element_info.data.count
			end
			from
				children_names.start
			until
				children_names.off
			loop
					-- We only generate code for all the children that are disabled as they
					-- are expanded by default.
				if element_info.data @ children_names.index /= '1' then
					Result := Result + indent + a_name + ".disable_item_expand (" + children_names.item + ")"
				end
				children_names.forth
			end
	
			Result := strip_leading_indent (Result)
		end
		
feature {GB_DEFERRED_BUILDER} -- Status setting

	modify_from_xml_after_build (element: XML_ELEMENT) is
			-- Build from XML any information that was
			-- deferred during the load/build cycle.
		local
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			element_info: ELEMENT_INFORMATION
			second: like ev_type
			temp_string: STRING
			box_parent1, box_parent2: EV_BOX
		do
			full_information := get_unique_full_info (element)
			element_info := full_information @ (Is_item_expanded_string)
				-- We only stored the expanded information if there were
				-- children.
			if element_info /= Void then			
				temp_string := element_info.data
				second ?= (objects @ 2)
				box_parent1 ?= first
				box_parent2 ?= second
				check
					string_matches: temp_string.count = first.count
				end
				from
					first.start
					second.start
				until
					first.off
				loop
					if temp_string @ first.index = '1' then
						box_parent1.enable_item_expand (first.item)
						box_parent2.enable_item_expand (second.item)
					else
						box_parent1.disable_item_expand (first.item)
						box_parent2.disable_item_expand (second.item)
					end
					first.forth
					second.forth
				end
			end
		end
		

feature {NONE} -- Implementation

	update_homogeneous is
			-- Update homogeneous state of items in `objects' depending on
			-- state of `is_homogeneous_check'.
		do
			if is_homogeneous_check.is_selected then
				for_all_objects (agent {EV_BOX}.enable_homogeneous)
			else
				for_all_objects (agent {EV_BOX}.disable_homogeneous)
			end
		end

	set_padding (value: INTEGER) is
			-- Update property `padding' on all items in `objects'.
		require
			first_not_void: first /= Void
		do
			for_all_objects (agent {EV_BOX}.set_padding_width (value))
		end
		
	valid_input (value: INTEGER): BOOLEAN is
			-- Is `value' a valid padding?
		do
			Result := value >= 0
		end
		
	set_border (value: INTEGER) is
			-- Update property `border' on all items in `objects'.
		require
			first_not_void: first /= Void
		do
			for_all_objects (agent {EV_BOX}.set_border_width (value))
		end
		
	is_homogeneous_check: EV_CHECK_BUTTON

	border_entry, padding_entry: GB_INTEGER_INPUT_FIELD
	
	Is_homogeneous_string: STRING is "Is_homogeneous"
	Padding_string: STRING is "Padding"
	Border_string: STRING is "Border"
	Is_item_expanded_string: STRING is "Is_item_expanded"
	
	check_buttons: ARRAYED_LIST [EV_CHECK_BUTTON]
		-- All check buttons created to handle `disable_item_expand'.
	

end -- class GB_EV_BOX
