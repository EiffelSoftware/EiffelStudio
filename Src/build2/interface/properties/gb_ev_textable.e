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
			attribute_editor
		end
		
	EV_FRAME_CONSTANTS
		undefine
			default_create
		end
		
	EV_ANY_HANDLER
		undefine
			default_create
		end
		
	GB_GENERAL_UTILITIES
		undefine
			default_create
		end
		
	GB_EV_TEXTABLE_EDITOR_CONSTRUCTOR

feature {GB_XML_STORE} -- Output

	generate_xml (element: XML_ELEMENT) is
			-- Generate an XML representation of `Current' in `element'.
		local
			textable: EV_TEXTABLE
		do
			textable ?= new_instance_of (dynamic_type_from_string (class_name (first)))
			textable.default_create
			if not objects.first.text.is_empty then
				add_element_containing_string (element, text_string, cdata_opening + objects.first.text + cdata_closing)	
			end
		end
		
	modify_from_xml (element: XML_ELEMENT) is
			-- Update all items in `objects' based on information held in `element'.
		local
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			element_info: ELEMENT_INFORMATION
			text: STRING
		do
			full_information := get_unique_full_info (element)
			element_info := full_information @ (text_string)
				-- We must prune the CDATA tag. We will only have this while generating internally
				-- while resetting an object. When we are using the XML document, this is stripped
				-- automatically so we do not encounter it.
			if element_info /= Void and then element_info.data.count /= 0 then
				text := element_info.data
				if text.substring_index (cdata_opening, 1) = 1 then
					text := text.substring (cdata_opening.count + 1, text.count - cdata_closing.count)
				end
				for_all_objects (agent {EV_TEXTABLE}.set_text (text))
			end
		end
		
feature {GB_CODE_GENERATOR} -- Output

	generate_code (element: XML_ELEMENT; info: GB_GENERATED_INFO): STRING is
			-- `Result' is string representation of
			-- settings held in `Current' which is
			-- in a compilable format.
		local
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			element_info: ELEMENT_INFORMATION
			escaped_text: STRING
			stripped_text: STRING
		do
			Result := ""
			full_information := get_unique_full_info (element)
			element_info := full_information @ (text_string)
			if element_info /= Void and then element_info.data.count /= 0 then
				stripped_text := element_info.data
				check
					has_tags: stripped_text.substring_index (cdata_opening, 1) = 1 and
						stripped_text.substring_index (cdata_closing, 1) = stripped_text.count - cdata_closing.count + 1
				end
				stripped_text := stripped_text.substring (cdata_opening.count + 1, stripped_text.count - cdata_closing.count)
				escaped_text := escape_special_characters (stripped_text)
				Result := info.name + ".set_text (%"" + escaped_text + "%")"
			end
			Result := strip_leading_indent (Result)
		end
		
	cdata_opening: STRING is "<![CDATA["
	
	cdata_closing: STRING is "]]>"

end -- class GB_EV_TEXTABLE