indexing
	description: "Objects that manipulate objects of type EV_TEXT_ALIGNABLE"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_EV_TEXT_ALIGNABLE
	
	-- The following properties from EV_TEXT_ALIGNABLE are manipulated by `Current'.
	-- Text_alignment - Performed on the real object and the display_object child

inherit
	GB_EV_ANY
		undefine
			attribute_editor
		end
		
	GB_EV_TEXT_ALIGNABLE_EDITOR_CONSTRUCTOR
		
	EV_FRAME_CONSTANTS
		undefine
			default_create
		end
		
feature {GB_XML_STORE} -- Output

	generate_xml (element: XML_ELEMENT) is
			-- Generate an XML representation of `Current' in `element'.
		local
			alignment: INTEGER
			alignment_text: STRING
			textable: EV_TEXT_ALIGNABLE
			default_alignment: INTEGER
		do
			textable ?= new_instance_of (dynamic_type_from_string (class_name (first)))
			textable.default_create
			default_alignment := textable.text_alignment
			alignment := first.text_alignment
			if not alignment.is_equal (default_alignment) then

			inspect alignment
			when feature {EV_TEXT_ALIGNMENT_CONSTANTS}.Ev_text_alignment_left then
				alignment_text := Ev_textable_left_string
			when feature {EV_TEXT_ALIGNMENT_CONSTANTS}.Ev_text_alignment_center then
				alignment_text := Ev_textable_center_string
			when feature {EV_TEXT_ALIGNMENT_CONSTANTS}.Ev_text_alignment_right then
				alignment_text := Ev_textable_right_string
			else
				check
					error: False					
				end
			end
			add_element_containing_string (element, text_alignment_string, alignment_text)
			end
		end
		
	modify_from_xml (element: XML_ELEMENT) is
			-- Update all items in `objects' based on information held in `element'.
		local
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			element_info: ELEMENT_INFORMATION
		do
			full_information := get_unique_full_info (element)
			element_info := full_information @ (text_alignment_string)
			if element_info /= Void then
				if element_info.data.is_equal (Ev_textable_left_string) then
					for_all_objects (agent {EV_TEXT_ALIGNABLE}.align_text_left)
				elseif element_info.data.is_equal (Ev_textable_center_string) then
					for_all_objects (agent {EV_TEXT_ALIGNABLE}.align_text_center)
				elseif element_info.data.is_equal (Ev_textable_right_string) then
					for_all_objects (agent {EV_TEXT_ALIGNABLE}.align_text_right)
				end
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
		do
			Result := ""
			full_information := get_unique_full_info (element)
			element_info := full_information @ (text_alignment_string)
			if element_info /= Void then
				if element_info.data.is_equal (Ev_textable_left_string) then
					Result := Result + indent + info.name + ".align_text_left"
				elseif element_info.data.is_equal (Ev_textable_center_string) then
					Result := Result + indent + info.name + ".align_text_center"
				elseif element_info.data.is_equal (Ev_textable_right_string) then
					Result := Result + indent + info.name + ".align_text_right"
				end
			end
			Result := strip_leading_indent (Result)
		end

end -- class GB_EV_TEXT_ALIGNABLE
