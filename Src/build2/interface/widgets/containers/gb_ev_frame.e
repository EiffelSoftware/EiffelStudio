indexing
	description: "Objects that manipulate objects of type EV_FRAME"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_EV_FRAME

inherit
	GB_EV_ANY
		undefine
			attribute_editor
		redefine
			ev_type
		end
		
	GB_EV_FRAME_EDITOR_CONSTRUCTOR
	
	DEFAULT_OBJECT_STATE_CHECKER
		undefine
			default_create
		end

feature {GB_XML_STORE} -- Output

	generate_xml (element: XM_ELEMENT) is
			-- Generate an XML representation of `Current' in `element'.
		local
			frame: EV_FRAME
		do
			frame ?= default_object_by_type (class_name (first))
			if frame.style /= objects.first.style then
				add_element_containing_integer (element, Style_string, objects.first.style)
			end
		end
		
	modify_from_xml (element: XM_ELEMENT) is
			-- Update all items in `objects' based on information held in `element'.
		local
			element_info: ELEMENT_INFORMATION
		do
			full_information := get_unique_full_info (element)
			element_info := full_information @ (Style_string)
			if element_info /= Void then
				check
					data_is_an_integer: element_info.data.is_integer
				end
				for_all_objects (agent {EV_FRAME}.set_style (element_info.data.to_integer))
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
			create Result.make (1)
			full_information := get_unique_full_info (element)
			element_info := full_information @ (Style_string)
			if element_info /= Void then
				Result.extend (info.name + ".set_style (" + element_info.data + ")")
			end
		end

end -- class GB_EV_FRAME
