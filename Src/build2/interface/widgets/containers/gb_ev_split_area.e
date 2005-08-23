indexing
	description: "Objects that manipulate objects of type EV_BOX"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_EV_SPLIT_AREA

	-- The following properties from EV_SPLIT_AREA are manipulated by `Current'.
	-- Is_item_expanded - Perform on both objects.

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
		
	GB_EV_SPLIT_AREA_EDITOR_CONSTRUCTOR
		
	GB_SHARED_DEFERRED_BUILDER
		undefine
			default_create
		end

feature {GB_XML_STORE} -- Output

	generate_xml (element: XM_ELEMENT) is
			-- Generate an XML representation of `Current' in `element'.
		local
			value: INTEGER
		do
			if objects.first.full then
				if objects.first.is_item_expanded (objects.first.first) then
					value := 1
				elseif objects.first.is_item_expanded (objects.first.second) then
					value := 2
				else
					value := 0
				end
				add_element_containing_integer (element, is_item_expanded_string, value)
			end
		end
		
	modify_from_xml (element: XM_ELEMENT) is
			-- Update all items in `objects' based on information held in `element'.
		do
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
			children: ARRAYED_LIST [GB_GENERATED_INFO]
		do
			create Result.make (1)
			full_information := get_unique_full_info (element)
			element_info := full_information @ (is_item_expanded_string)
			if element_info /= Void then
				children := info.children
				if element_info.data.is_equal ("0") then
					Result.extend (info.name +".enable_item_expand (" + children.i_th (1).ev_any_access_name + ")")
					Result.extend (info.name +".enable_item_expand (" + children.i_th (2).ev_any_access_name + ")")
				elseif element_info.data.is_equal ("1") then
					Result.extend (info.name +".enable_item_expand (" + children.i_th (1).ev_any_access_name + ")")
					Result.extend (info.name +".disable_item_expand (" + children.i_th (2).ev_any_access_name + ")")
				elseif element_info.data.is_equal ("2") then
					Result.extend (info.name +".disable_item_expand (" + children.i_th (1).ev_any_access_name + ")")
					Result.extend (info.name +".enable_item_expand (" + children.i_th (2).ev_any_access_name + ")")
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
		do
			full_information := get_unique_full_info (element)
			element_info := full_information @ (Is_item_expanded_string)
			
			if element_info /= Void then
				second ?= object.real_display_object
				if element_info.data.is_equal ("0") then
					first.disable_item_expand (first.first)
					first.disable_item_expand (first.second)
					second.disable_item_expand (second.first)
					second.disable_item_expand (second.second)
				elseif element_info.data.is_equal ("1") then
					first.disable_item_expand (first.second)
					first.enable_item_expand (first.first)
					second.disable_item_expand (second.second)
					second.enable_item_expand (second.first)
				elseif element_info.data.is_equal ("2") then
					first.disable_item_expand (first.first)
					first.enable_item_expand (first.second)
					second.disable_item_expand (second.first)
					second.enable_item_expand (second.second)
				else
					check
						invalid_data: False
					end
				end
			end
		end

end -- class GB_EV_SPLIT_AREA
