indexing
	description: "Objects that manipulate objects of type EV_TEXTABLE"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_EV_TEXTABLE
	
	-- The following properties from EV_TEXTABLE are manipulated by `Current'.
	-- Text - Performed on the real object and the display_object child.

inherit
	GB_EV_ANY
		undefine
			attribute_editor,
			set_up_user_events
		end
		
	EV_FRAME_CONSTANTS
			export
			{NONE} all
		undefine
			default_create
		end
		
	EV_ANY_HANDLER
		undefine
			default_create
		end

	GB_EV_TEXTABLE_EDITOR_CONSTRUCTOR
		undefine
			default_create
		end
	
	CDATA_HANDLER
		export
			{NONE} all
		undefine
			default_create
		end
		
	DEFAULT_OBJECT_STATE_CHECKER
		export
			{NONE} all
		undefine
			default_create
		end

feature {GB_XML_STORE} -- Output

	generate_xml (element: XM_ELEMENT) is
			-- Generate an XML representation of `Current' in `element'.
		local
			textable: EV_TEXTABLE
		do
			textable ?= default_object_by_type (class_name (first))
			if not textable.text.is_equal (objects.first.text) or uses_constant (Text_string) then
				add_string_element (element, Text_string, enclose_in_cdata (objects.first.text))
			end
		end
		
	modify_from_xml (element: XM_ELEMENT) is
			-- Update all items in `objects' based on information held in `element'.
		local
			element_info: ELEMENT_INFORMATION
		do
			full_information := get_unique_full_info (element)
			element_info := full_information @ (text_string)
				-- We must prune the CDATA tag. We will only have this while generating internally
				-- while resetting an object. When we are using the XML document, this is stripped
				-- automatically so we do not encounter it.
			if element_info /= Void and then element_info.data.count /= 0 then
				for_all_objects (agent {EV_TEXTABLE}.set_text (strip_cdata (retrieve_and_set_string_value (text_string))))
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
			element_info := full_information @ (text_string)
			if element_info /= Void and then element_info.data.count /= 0 then
				Result.extend (info.name + ".set_text (" + retrieve_string_setting (text_string) + ")")
			end
		end

end -- class GB_EV_TEXTABLE