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

	LOCALIZED_PRINTER

	XML_SHARED_UTILITIES

feature -- Processing

	process_nodes (nodes: ITERABLE [XML_NODE])
			-- Process list of nodes `nodes'.
		do
			⟳ n: nodes ¦ n.process (Current) ⟲
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
			print (offset (e.level) + "element: ")
			localized_print (s)
			print ("%N")
			process_nodes (e)
		end

	process_character_data (c: XML_CHARACTER_DATA)
			-- Process character data `c'.
		do
			if not is_blank_content (c.content) then
				print (offset (c.level))
				print ("content: ")
				localized_print (single_line (c.content))
				print ("%N")
			end
		end

	process_xml_declaration (a_decl: XML_DECLARATION)
			-- Process xml declaration `a_decl'
		do
			print ("<?xml version=%"")
			localized_print (a_decl.version)
			print ("%"")
			if attached a_decl.encoding as enc then
				print (" encoding=%"")
				localized_print (enc)
				print ("%"")
			end
			if a_decl.standalone then
				print (" standalone=%"yes%"")
			end
			print ("?>%N")
		end

	process_processing_instruction (a_pi: XML_PROCESSING_INSTRUCTION)
			-- Process processing instruction `a_pi'.
		do
			print ("<?")
			localized_print (a_pi.target)
			print (" ")
			localized_print (a_pi.data)
			print ("?>%N")
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
			print (offset (com.level) + "comment: ")
			localized_print (single_line (com.data))
			print ("%N")
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
			print (offset (att.level) + "+ attribute: ")
			localized_print (s)
			print ("=%"")
			print (xml_utilities.escaped_xml (att.value))
			print ("%"%N")
		end

feature {NONE} -- Formatter

	is_blank_content (s: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `s' containing only space?
		require
			s_attached: s /= Void
		local
			i, n: INTEGER
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

	single_line (s: READABLE_STRING_GENERAL): STRING_32
		do
			create Result.make_from_string_general (s)
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
	copyright: "Copyright (c) 1984-2021, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
