indexing
	description: "Objects that manipulate objects of type EV_VIEWPORT"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_EV_VIEWPORT
	
	-- The following properties from EV_VIEWPORT are manipulated by `Current'.
	-- X_offset - Performed on the real object and the display_object.
	-- Y_offset - Performed on the real object and the display_object.
	-- Set_item_height and Set_item_width are both manipulated on both objects.

inherit
	
	GB_EV_ANY
		undefine
			attribute_editor
		redefine
			modify_from_xml_after_build,
			ev_type
		end
		
	GB_EV_VIEWPORT_EDITOR_CONSTRUCTOR

	GB_SHARED_DEFERRED_BUILDER
		undefine
			default_create
		end
		
feature {GB_XML_STORE} -- Output
	
	generate_xml (element: XM_ELEMENT) is
			-- Generate an XML representation of `Current' in `element'.
		do
			add_integer_element (element, x_offset_string, objects.first.x_offset)
			add_integer_element (element, y_offset_string, objects.first.y_offset)
				-- If we have no child, then we store -1, so we no not to perform any setting when
				-- loading.
			if objects.first.full then
				add_integer_element (element, item_width_string, objects.first.item.width)
				add_integer_element (element, item_height_string, objects.first.item.height)
			else
				add_integer_element (element, item_width_string, -1)
				add_integer_element (element, item_height_string, -1)
			end
		end
		
	modify_from_xml (element: XM_ELEMENT) is
			-- Update all items in `objects' based on information held in `element'.
		do
				-- We set up some deferred building now.
			deferred_builder.defer_building (Current, element)
		end
		
	modify_from_xml_after_build (element: XM_ELEMENT) is
			-- Build from XML any information that was
			-- deferred during the load/build cycle.
		local
			element_info: ELEMENT_INFORMATION
		do
			full_information := get_unique_full_info (element)
			element_info := full_information @ (Item_width_string)
			if element_info /= Void then
				if element_info.data.to_integer >= 0 then
					set_item_width (retrieve_and_set_integer_value (Item_width_string))	
				end
			end
			element_info := full_information @ (Item_height_string)
			if element_info /= Void then
				if element_info.data.to_integer >= 0 then
					set_item_height (retrieve_and_set_integer_value (Item_height_string))	
				end
			end
			if full_information @ (X_offset_string) /= Void then
				set_x_offset (retrieve_and_set_integer_value (X_offset_string))
			end
			if full_information @ (Y_offset_string) /= Void then
				set_y_offset (retrieve_and_set_integer_value (Y_offset_string))
			end			
		end
		
feature {GB_CODE_GENERATOR} -- Output

	generate_code (element: XM_ELEMENT; info: GB_GENERATED_INFO): ARRAYED_LIST [STRING] is
			-- `Result' is string representation of
			-- settings held in `Current' which is
			-- in a compilable format.
		local
			element_info: ELEMENT_INFORMATION
		do
			create Result.make (2)
			full_information := get_unique_full_info (element)
						
			element_info := full_information @ item_width_string
			if element_info /= Void and then element_info.data.to_integer >= 0 then
				Result.extend (info.name + ".set_item_width (" + retrieve_integer_setting (item_width_string) + ")")
			end
			
			element_info := full_information @ item_height_string
			if element_info /= Void and then element_info.data.to_integer >= 0 then
				Result.extend (info.name + ".set_item_height (" + retrieve_integer_setting (item_height_string) + ")")
			end
			
			element_info := full_information @ X_offset_string
			if element_info /= Void and then element_info.data.to_integer /= 0 then
				Result.extend (info.name + ".set_x_offset (" + retrieve_integer_setting (X_offset_string) + ")")
			end
			
			element_info := full_information @ Y_offset_string
			if element_info /= Void and then element_info.data.to_integer /= 0 then
				Result.extend (info.name + ".set_y_offset (" + retrieve_integer_setting (Y_offset_string) + ")")
			end
		end

end -- class GB_EV_WINDOW