class
	TYPE_XML_PARSER

inherit
	XML_PARSER
		redefine
			on_start_tag,
			on_content,
			on_end_tag,
			on_default
		end
	TAG_FLAGS

creation
	make

feature -- Access

	xml_type: XML_TYPE is
			-- Representation of a type in xml.
		once
			create Result.make
		ensure
			non_void_result: Result /= Void
		end
	
	xml_types: HASH_TABLE [XML_TYPE, STRING] is
			-- Hash table of all xml types, classified per name.
		once
			create Result.make (100)
		ensure
			non_void_result: Result /= Void
		end

	current_tag: ARRAYED_STACK [INTEGER]
			-- Balises XML opened.


feature

	on_start_tag (start_tag: XML_START_TAG) is
			-- called whenever the parser findes a start element
		local
			l_name: STRING
			l_number_of_char: INTEGER
		do
			if start_tag.name.is_equal (member_str) then
				if start_tag.attributes.count > 0 then
					l_name := start_tag.attributes.first.value
					if l_name.item (1).is_equal ('T') then
						if Xml_type.pos_in_file > 0  then
							l_number_of_char := last_byte_index - Xml_type.pos_in_file
							Xml_type.set_number_of_char (l_number_of_char)
							xml_types.put (deep_clone (xml_type), clone (xml_type.name))
						end
						Xml_type.set_pos_in_file (last_byte_index)
						--Xml_type.set_number_of_char (0)
						l_name.keep_tail (l_name.count - 2)
						Xml_type.set_name (l_name)
					end
				end
			end
			Xml_type.set_number_of_char (Xml_type.number_of_char + start_tag.out.count)
		end

	on_content (content: XML_CONTENT) is
			-- called whenever the parser findes character data
		do
--			Xml_type.set_number_of_char (Xml_type.number_of_char + content.out.count)
		end

	on_end_tag (end_tag: XML_END_TAG) is
			-- called whenever the parser findes an end element
		local
			l_number_of_char: INTEGER
		do
			if end_tag.name.is_equal (Members_str) then
				if Xml_type.pos_in_file > 0  then
					l_number_of_char := last_byte_index - Xml_type.pos_in_file
					Xml_type.set_number_of_char (l_number_of_char)
					xml_types.put (deep_clone (xml_type), clone (xml_type.name))
				end
			end
--			Xml_type.set_number_of_char (Xml_type.number_of_char + end_tag.out.count)
		end

	on_default (data: XML_CHARACTER_ARRAY) is
		-- this feature is called for any character in the XML
		-- document for which there is no applicable handler
		do
		end

end -- class TYPE_XML_PARSER
