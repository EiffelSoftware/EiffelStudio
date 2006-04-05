indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class TYPE_XML_PARSER
