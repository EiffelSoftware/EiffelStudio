indexing
	description: "Objects that provide useful utilities for XML."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_XML_UTILITIES

inherit
	
	ANY
	
	GB_CONSTANTS
		export
			{NONE} all
		end
		
	BASIC_ROUTINES

feature -- Access

	new_child_element (a_parent: XM_COMPOSITE; a_name, a_ns_prefix: STRING): XM_ELEMENT is
			-- `Result' is a new child element with name `a_name' and ns_prexif `a_ns_prefix'.
		require
			parent_not_void: a_parent /= Void
			name_not_void: a_name /= Void
		do
			create Result.make_child (a_parent, a_name, create {XM_NAMESPACE}.make (a_ns_prefix, ""))
		ensure
			Result_not_void: Result /= Void
		end

	add_attribute_to_element (element: XM_ELEMENT; a_name, a_prefix, a_value: STRING) is
			-- Add an atribute with name `a_name', prefix `a_prefix' and value `a_value' to `element'.
		require
			element_not_void: element /= Void
			a_name_not_void: a_name /= Void
			a_prefix_not_void: a_prefix /= Void
			a_value_not_void: a_value /= Void
		local
			attribute: XM_ATTRIBUTE
		do
			create attribute.make (a_name, create {XM_NAMESPACE}.make ("", ""), a_value, element )
			element.force_last (attribute)
		end
	
	add_element_containing_integer (element: XM_ELEMENT; element_name: STRING; value: INTEGER) is
			-- Add an element named `element' containing integer data `value' to `element'.
		require
			element_not_void: element /= Void
			element_name_not_void: element_name /= Void
			element_name_not_empty: element_name.count >= 1
		local
			new_element: XM_ELEMENT
		do
			new_element := new_child_element (element, element_name, "")
			element.force_last (new_element)
			add_string_data (new_element, value.out)
		end

	add_element_containing_string (element: XM_ELEMENT; element_name, value: STRING) is
			-- Add an element named `element' containing string data `value' to `element'.
		require
			element_not_void: element /= Void
			element_name_not_void: element_name /= Void
			element_name_not_empty: element_name.count >= 1
			value_not_void: value /= Void
		local
			new_element: XM_ELEMENT
		do
			new_element := new_child_element (element, element_name, "")
			element.force_last (new_element)
			add_string_data (new_element, value)
		end

	add_element_containing_boolean (element: XM_ELEMENT; element_name: STRING; value: BOOLEAN) is
			-- Add an element named `element' containing boolean data `value' to `element'.
		require
			element_not_void: element /= Void
			element_name_not_void: element_name /= Void
			element_name_not_empty: element_name.count >= 1
		local
			new_element: XM_ELEMENT
		do
			new_element := new_child_element (element, element_name, "")
			element.force_last (new_element)
			add_boolean_data (new_element, value)
		end

	add_boolean_data (element: XM_ELEMENT; content: BOOLEAN) is
			-- Add boolean character data with content `content' to `element'
		require
			element_not_void: element /= Void
		local
			string_data: STRING
		do
			if content then
				string_data := True_string
			else
				string_data := False_string
			end
			add_string_data (element, string_data)
		end

	add_string_data (element: XM_ELEMENT; content: STRING) is
			-- Add string character data with content `content' to `element'
		require
			element_not_void: element /= Void
			content_not_void: content /= Void
		local	
			new_element: XM_CHARACTER_DATA
		do
			create new_element.make (element, content)
			element.force_last (new_element)
		end

	create_widget_instance (element: XM_ELEMENT; widget_name: STRING): XM_ELEMENT is
			-- Create a new instance of a widget `widget_name' in `element'.
		require
			element_not_void: element /= Void
			widget_name_not_void: widget_name /= Void
			widget_name_not_empty: widget_name.count >= 1
		do
			Result := new_child_element (element, Item_string, "")
			add_attribute_to_element (Result, "type", "xsi", widget_name)
		ensure
			Result_not_void: Result /= Void
		end
		
	get_unique_full_info (element: XM_ELEMENT): HASH_TABLE [ELEMENT_INFORMATION, STRING] is
			-- `Result' provides access to all child_elements and XML character
			-- data of `Current' referenced by their unique names.
			-- Ignores `item'.
		local
			current_element: XM_ELEMENT
			current_data_element: XM_CHARACTER_DATA
			char_data: STRING
			info: ELEMENT_INFORMATION
		do
			create Result.make (8)
			from
				element.start
			until
				element.off
			loop
				current_element ?= element.item_for_iteration
				if current_element /= Void then
					if not current_element.name.is_equal (Item_string) and
						not current_element.name.is_equal ("item_text") then
						create info
						info.set_name (current_element.name)
						info.set_element (current_element)
						from
							current_element.start
						until
							current_element.off
						loop
							current_data_element ?= current_element.item_for_iteration
							if current_data_element /= Void then
								char_data := current_data_element.content
								char_data.replace_substring_all ("%T","")
									-- If we are loading a multiple line text, then we must
									-- keep appending a new line character and the new text.
									--| FIXME, I believe that there is no longer a need to perform this
									--| as now we use CDATA tags which support multiple lines of text.
								if data_valid (char_data) then
									if info.data = Void then
										info.set_data (char_data)
									else
										info.set_data (info.data + "%N" + char_data)
									end
								end
							end
							current_element.forth
						end
					Result.extend (info, info.name)
					end
				end
				element.forth
			end
		end
		
	all_child_element_names (element: XM_ELEMENT): ARRAYED_LIST [STRING] is
			-- `Result' is a list of all names of the child elements of `element'
		require
			element_not_void: element /= Void
		local
			current_element: XM_ELEMENT
		do
			create Result.make (0)
			from
				element.start
			until
				element.off
			loop
				current_element ?= element.item_for_iteration
				if current_element /= Void then
					Result.extend (current_element.name)
				end
				element.forth
			end
		end
		
	child_element_by_name (element: XM_ELEMENT; a_name: STRING): XM_ELEMENT is
			-- `Result' is child element of `element' with name equal to `a_name'.
		require
			element_not_void: element /= Void
			name_not_void_or_empty: a_name /= Void and then a_name.count > 0 
		local
			current_element: XM_ELEMENT
			found: BOOLEAN
		do
			from
				element.start
			until
				element.off or found
			loop
				current_element ?= element.item_for_iteration
				if current_element /= Void and then current_element.name.is_equal (a_name) then
					found := True
					Result := current_element
				end
				element.forth
			end
		end
		
	process_xml_string (xml_string: STRING) is
			-- Format `xml_string' so that it includes indents and new lines, so that it
			-- will appear nicely in editors that do not automatically format XML.
			-- Note that this algorithm is far from perfect, but is good enough for the
			-- moment. There is definitely the possibility for improvement. Julian 02/03/03
		local
			depth: INTEGER
			counter: INTEGER
			closing_index: INTEGER
			tag_contents: STRING
		do
			from
				counter := 1
			until
				counter > xml_string.count
			loop
				if xml_string @ counter = ('<')  then
					closing_index := xml_string.index_of ('>', counter  + 1)
					if closing_index - counter > 1 then
						tag_contents := xml_string.substring (counter + 1, closing_index - 1)
						if tag_contents.has ('/') then
							if not ((tag_contents @ tag_contents.count) = '/') then
								if depth > 0 then
									depth := depth - 1
								end
								xml_string.insert_character ('%N', closing_index + 1)
								add_tabs (xml_string, closing_index + 2, depth)
							else
								xml_string.insert_character ('%N', closing_index + 1)
								add_tabs (xml_string, closing_index + 2, depth)
							end
						else
							if not tag_contents.substring (1, 8).is_equal ("![CDATA[") then
								-- We must ignore the CDATA tags, as they are not another entry, but contained within
								-- a tag.
								if (not tag_contents.is_equal (Internal_properties_string)) then
									depth := depth + 1
								else
									xml_string.insert_character ('%N', closing_index + 1)
									add_tabs (xml_string, closing_index + 2, depth)
								end
							end
						end
					end
				end
				counter := counter + 1
			end
		end
		
	add_tabs (a_string: STRING; index, count: INTEGER) is
			-- Add `count' tab characters to `a_string' at index `index'.
		local
			counter: INTEGER
			temp_string: STRING
		do
			create temp_string.make (0)
			from
				counter := 1
			until
				counter > count
			loop
				temp_string.append ("%T")
				counter := counter + 1
			end
			a_string.insert_string (temp_string, index)
		ensure
			new_count_correct: a_string.count = old a_string.count + count
		end

feature {NONE} -- Implementation

	data_valid (current_data: STRING):BOOLEAN is
			-- Is `current_data' not empty and valid?
		require
			data_not_void: current_data /= Void
		do
			if current_data.count > 0 then
				Result := True
			end
		end

end -- class XML_UTILITIES
