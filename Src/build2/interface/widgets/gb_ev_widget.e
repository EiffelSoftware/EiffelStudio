indexing
	description: "Objects that manipulate objects of type EV_WIDGET"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_EV_WIDGET
	
	-- The following properties from EV_WIDGET are manipulated by `Current'.
	-- Minimum_width - Performed on the real object only. Not the display object
	-- Minimum_height - Performed on the real object only. Not the display_object

inherit
	GB_EV_ANY
		undefine
			attribute_editor
		redefine
			ev_type
		end


	GB_XML_UTILITIES
		export
			{NONE} all
		undefine
			default_create
		end
		
	GB_EV_WIDGET_EDITOR_CONSTRUCTOR
		undefine
			default_create
		end
	
	GB_SHARED_SYSTEM_STATUS
		export
			{NONE} all
		undefine
			default_create
		end

feature {GB_CODE_GENERATOR} -- Output

	generate_code (element: XM_ELEMENT; info: GB_GENERATED_INFO): STRING is
			-- `Result' is string representation of
			-- settings held in `Current' which is
			-- in a compilable format.
		local
			element_info: ELEMENT_INFORMATION
		do
			Result := ""
			full_information := get_unique_full_info (element)
			element_info := full_information @ (Minimum_width_string)
			if element_info /= Void then
				Result := info.name + ".set_minimum_width (" + element_info.data + ")"
			end
			element_info := full_information @ (Minimum_height_string)
				--| FIXME This is a special case for windows, as they are the root object, and when not generating as
				--| a client, only the first name will be pruned from `Result'. Hence we do not apply a second name if
				--| we are are a root object and not generating as a client of the window. The best solution will be to
				--| change type of `Result' to an ARRAYED_LIST [STRING], one item for each line, without formatting and a name,
				--| and have the code generator add this information. To do at some point.
			if element_info /= Void then
				if not system_status.current_project_settings.client_of_window and info.is_root_object then
					Result := Result + indent + "set_minimum_height (" + element_info.data + ")"
				elseif not info.is_root_object then
					Result := Result + indent + info.name + ".set_minimum_height (" + element_info.data + ")"				
				else
					Result := Result + indent + Client_window_string + ".set_minimum_height (" + element_info.data + ")"				
				end
			end
			Result := strip_leading_indent (Result)
		end

feature {GB_XML_STORE} -- Output
	
	generate_xml (element: XM_ELEMENT) is
			-- Generate an XML representation of `Current' in `element'.
		do
			if objects.first.minimum_width_set_by_user then
				add_element_containing_integer (element, Minimum_width_string, objects.first.minimum_width)	
			end
			if objects.first.minimum_height_set_by_user then
				add_element_containing_integer (element, Minimum_height_string, objects.first.minimum_height)
			end
		end
		
	modify_from_xml (element: XM_ELEMENT) is
			-- Update all items in `objects' based on information held in `element'.
		local
			element_info: ELEMENT_INFORMATION
		do
			full_information := get_unique_full_info (element)
			element_info := full_information @ (Minimum_width_string)
			if element_info /= Void then
				for_first_object (agent {EV_WIDGET}.set_minimum_width (element_info.data.to_integer))
			end
			
			element_info := full_information @ (Minimum_height_string)
			if element_info /= Void then
				for_first_object (agent {EV_WIDGET}.set_minimum_height (element_info.data.to_integer))
			end
		end

end -- class GB_EV_WINDOW