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
		undefine
			attribute_editor
		redefine
			modify_from_xml_after_build
		end
		
	GB_XML_UTILITIES
		undefine
			default_create
		end
		
	GB_EV_BOX_EDITOR_CONSTRUCTOR
		
	GB_SHARED_DEFERRED_BUILDER
		undefine
			default_create
		end

feature {GB_XML_STORE} -- Output

	generate_xml (element: XM_ELEMENT) is
			-- Generate an XML representation of `Current' in `element'.
		local
			temp_string: STRING
		do
				-- Boxes are not homogeneous by default.
			if objects.first.is_homogeneous = True then
				add_element_containing_boolean (element, Is_homogeneous_string, objects.first.is_homogeneous)
			end
				-- Padding is 0 by default.
			if objects.first.padding_width > 0 or uses_constant (Padding_string) then
				add_integer_element (element, Padding_string, objects.first.padding_width)	
			end
				-- Border is 0 by default.
			if objects.first.border_width > 0 or uses_constant (Border_string) then
				add_integer_element (element, Border_string, objects.first.border_width)
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
		
	modify_from_xml (element: XM_ELEMENT) is
			-- Update all items in `objects' based on information held in `element'.
		local
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

			if attribute_set (Padding_string) then
				for_all_objects (agent {EV_BOX}.set_padding_width (retrieve_and_set_integer_value (Padding_string)))
			end
			
			if attribute_set (Border_string) /= Void then
				for_all_objects (agent {EV_BOX}.set_border_width (retrieve_and_set_integer_value (Border_string)))
			end
		
		
				-- We set up some deferred building now.
			deferred_builder.defer_building (Current, element)
		end
		
feature {GB_CODE_GENERATOR} -- Output

	generate_code (element: XM_ELEMENT; info: GB_GENERATED_INFO): ARRAYED_LIST [STRING] is
			-- `Result' is string representation of
			-- settings held in `Current' which is
			-- in a compilable format.
		local
			element_info: ELEMENT_INFORMATION
			children_names: ARRAYED_LIST [STRING]
		do
			create Result.make (4)
			full_information := get_unique_full_info (element)
			element_info := full_information @ (Is_homogeneous_string)
			if element_info /= Void then
				if element_info.data.is_equal (True_string) then
					Result.extend (info.name + ".enable_homogeneous")
				else
					Result.extend (info.name + ".disable_homogeneous")
				end
			end
			
			if attribute_set (Padding_string) then
				Result.extend (info.name + ".set_padding_width (" + retrieve_integer_setting (padding_string) + ")")
			end
			
			if attribute_set (Border_string) then
				Result.extend (info.name + ".set_border_width (" + retrieve_integer_setting (border_string) + ")")
			end

			element_info := full_information @ (Is_item_expanded_string)
				-- We have to check that there is an `is_item_expanded' string.
			if element_info /= Void then
				children_names := info.child_names
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
						Result.extend (info.name + ".disable_item_expand (" + children_names.item + ")")
					end
					children_names.forth
				end
			end
		end
		
feature {GB_DEFERRED_BUILDER} -- Status setting

	modify_from_xml_after_build (element: XM_ELEMENT) is
			-- Build from XML any information that was
			-- deferred during the load/build cycle.
		local
			element_info: ELEMENT_INFORMATION
			second: like ev_type
			temp_string: STRING
			box_parent1, box_parent2: EV_BOX
			children: ARRAYED_LIST [GB_OBJECT]
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
				children := object.children
				check
					children_consistent: children.count = first.count
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
						
							-- Now flag the child object as non expanded.
						children.i_th (first.index).disable_expanded_in_box
					end
					first.forth
					second.forth
				end
			end
		end
		
feature {NONE} -- Implementation

	update_object_expansion (is_expanded: BOOLEAN; index: INTEGER) is
			-- Modify expanded state of `index' child of `object', based on
			-- `is_expanded'.
		local
			child_object: GB_OBJECT
		do
			child_object := object.children.i_th (index)
			if is_expanded then
				child_object.enable_expanded_in_box
			else
				child_object.disable_expanded_in_box
			end
		end

end -- class GB_EV_BOX
