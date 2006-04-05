indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class
	MEMBER_XML_PARSER

inherit
	XML_PARSER
		redefine
			make,
			on_start_tag,
			on_content,
			on_end_tag,
			on_default
		end
	TAG_FLAGS

creation
	make

feature -- Initialization

	make is
			-- Initialization.
		do
			Precursor {XML_PARSER}
			create Xml_members.make (10000)
			create current_xml_member.make
			create current_tag.make (10)
		ensure then
			non_void_xml_members: xml_members /= Void
			non_void_current_xml_member: current_xml_member /= Void
			non_void_current_tag: current_tag /= Void
		end
		
		
feature -- Access

	xml_members: HASH_TABLE [XML_MEMBER, STRING]
			-- Hash table of all xml types, classified per name.


feature {NONE} -- Access

	current_xml_member: XML_MEMBER
			-- Representation of a member in xml.
	
	current_tag: ARRAYED_STACK [INTEGER]
			-- XML tag opened.


feature

	on_start_tag (start_tag: XML_START_TAG) is
			-- called whenever the parser findes a start element
		local
			l_name: STRING
			l_number_of_char: INTEGER
		do
			if start_tag.name.is_empty then
				l_name := "boooo"
			end
			if start_tag.name.is_equal (member_str) then
				if start_tag.attributes.count > 0 then
					l_name := start_tag.attributes.first.value
					if current_xml_member.pos_in_file > 0  then
						l_number_of_char := last_byte_index - current_xml_member.pos_in_file
						if l_number_of_char <= 0 then
							l_number_of_char := last_byte_index - current_xml_member.pos_in_file
						else
							current_xml_member.set_number_of_char (l_number_of_char)
							xml_members.put (deep_clone (current_xml_member), clone (current_xml_member.name))
						end
					end
					current_xml_member.set_pos_in_file (last_byte_index)
					l_name.keep_tail (l_name.count - 2)
					current_xml_member.set_name (l_name)
				end
			end
			current_xml_member.set_number_of_char (current_xml_member.number_of_char + start_tag.out.count)
		end

	on_content (content: XML_CONTENT) is
			-- called whenever the parser findes character data
		do
		end

	on_end_tag (end_tag: XML_END_TAG) is
			-- called whenever the parser findes an end element
		local
			l_number_of_char: INTEGER
		do
			if end_tag.name.is_equal (Members_str) then
				if current_xml_member.pos_in_file > 0  then
					l_number_of_char := last_byte_index - current_xml_member.pos_in_file
					current_xml_member.set_number_of_char (l_number_of_char)
					xml_members.put (deep_clone (current_xml_member), clone (current_xml_member.name))
				end
			end
		end

	on_default (data: XML_CHARACTER_ARRAY) is
		-- this feature is called for any character in the XML
		-- document for which there is no applicable handler
		do
		end


invariant
	non_void_xml_members: xml_members /= Void
	non_void_current_xml_member: current_xml_member /= Void
	non_void_current_tag: current_tag /= Void
	
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


end -- class MEMBER_XML_PARSER
