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

	generate_code (element: XML_ELEMENT; info: GB_GENERATED_INFO): STRING is
			-- `Result' is string representation of
			-- settings held in `Current' which is
			-- in a compilable format.
		local
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			element_info: ELEMENT_INFORMATION
			children_names: ARRAYED_LIST [STRING]
		do
			Result := ""
			full_information := get_unique_full_info (element)
			element_info := full_information @ (Is_homogeneous_string)
			if element_info /= Void then
				if element_info.data.is_equal (True_string) then
					Result := info.name + ".enable_homogeneous"
				else
					Result := info.name + ".disable_homogeneous"
				end
			end
			
			
			element_info := full_information @ (Padding_string)
			if element_info /= Void then
				Result := Result + indent + info.name + ".set_padding_width (" + element_info.data + ")"
			end
			
			element_info := full_information @ (Border_string)
			if element_info /= Void then
				Result := Result + indent + info.name + ".set_border_width (" + element_info.data + ")"
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
						Result := Result + indent + info.name + ".disable_item_expand (" + children_names.item + ")"
					end
					children_names.forth
				end
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

end -- class GB_EV_BOX
