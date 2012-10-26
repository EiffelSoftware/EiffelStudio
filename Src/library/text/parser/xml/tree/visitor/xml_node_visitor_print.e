note
	description: "[
			Visitor pattern for XML node objects. Inherit and 
			redefine to make use of this pattern

			Main purpose=debugging
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	XML_NODE_VISITOR_PRINT

inherit
	XML_NODE_VISITOR

	XML_SHARED_UTILITIES

feature -- Processing

	process_nodes (nodes: ITERABLE [XML_NODE])
			-- Process list of nodes `nodes'.
		do
			across
				nodes as c
			loop
				c.item.process (Current)
			end
		end

	process_element (e: XML_ELEMENT)
			-- Process element `e'.
		local
			s: STRING_32
		do
			create s.make_empty
			if attached e.ns_prefix as nsp and then not nsp.is_empty then
				s.append_string (nsp)
				s.append_character (':')
			end
			s.append_string (e.name)
			if attached e.namespace as ns and then not ns.uri.is_empty then
				s.append_character (' ')
				s.append_character ('(')
				s.append_string (ns.uri)
				s.append_character (')')
			end
			-- FIXME: use localized console			
			print (offset (e.level) + "element: " + s.to_string_8 + "%N")
			process_nodes (e)
		end

	process_character_data (c: XML_CHARACTER_DATA)
			-- Process character data `c'.
		do
			if not is_blank_content (c.content) then
				-- FIXME: use localized console
				print (offset (c.level) + "content: " + single_line (c.content).as_string_8 + "%N")
			end
		end

	process_xml_declaration (a_decl: XML_DECLARATION)
			-- Process xml declaration `a_decl'
		do
			print ("<?xml version=%"" + a_decl.version + "%"")
			if attached a_decl.encoding as enc then
				print (" encoding=%"" + enc + "%"")
			end
			if a_decl.standalone then
				print (" standalone=%"yes%"")
			end
			print ("?>%N")
		end

	process_processing_instruction (a_pi: XML_PROCESSING_INSTRUCTION)
			-- Process processing instruction `a_pi'.
		do
			-- FIXME: use localized console
			print ("<?" + a_pi.target.as_string_8 + " " + a_pi.data.as_string_8 + "?>%N")
		end

	process_document (doc: XML_DOCUMENT)
			-- Process document `doc'.
		do
			process_nodes (doc)
		end

	process_comment (com: XML_COMMENT)
			-- Process comment `com'.
		do
			-- FIXME: use localized console
			print (offset (com.level) + "comment: " + single_line (com.data).as_string_8 + "%N")
		end

	process_attributes (e: XML_ELEMENT)
			-- Process attributes of element `e'.
		do
			process_nodes (e)
		end

	process_attribute (att: XML_ATTRIBUTE)
			-- Process attribute `att'.
		local
			s: STRING_32
		do
			create s.make_empty
			if attached att.ns_prefix as nsp and then not nsp.is_empty then
				s.append_string (nsp)
				s.append_character (':')
			end
			s.append_string_general (xml_utilities.escaped_xml (att.name))
			if attached att.namespace as ns and then not ns.uri.is_empty then
				s.append_character (' ')
				s.append_character ('(')
				s.append_string (ns.uri)
				s.append_character (')')
			end
			-- FIXME: use localized console
			print (offset (att.level) + "+ attribute: " + s.to_string_8 + "=%"" + xml_utilities.escaped_xml (att.value) + "%"%N")
		end

feature {NONE} -- Formatter

	is_blank_content (s: STRING): BOOLEAN
			-- Is `s' containing only space?
		require
			s_attached: s /= Void
		local
			i,n: INTEGER
		do
			Result := True

			if not s.is_empty then
				Result := True
				from
					i := 1
					n := s.count
				until
					not Result or i > n
				loop
					Result := s.item (i).is_space
					i := i + 1
				end
			end
		end

	single_line (s: STRING_32): STRING_32
		do
			create Result.make_from_string (s)
			Result.replace_substring_all ({STRING_32} "%R%N", {STRING_32} "%%N")
			Result.replace_substring_all ({STRING_32} "%N", {STRING_32} "%%N")
		end

	offset (n: INTEGER): STRING_8
		local
			lev: STRING
		do
			create Result.make_filled (' ', n)
			lev := n.out
			from
			until
				lev.count = 5
			loop
				lev.append_character (' ')
			end
			Result.prepend (lev)
		end

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
