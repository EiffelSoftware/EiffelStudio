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

feature -- Processing

	process_nodes (nodes: ITERABLE [XML_NODE])
			-- Process list of nodes `nodes'.
		do
			across
				nodes as c
			loop
				c.process (Current)
			end
		end

	process_element (e: XML_ELEMENT)
			-- Process element `e'.
		local
			s: STRING
		do
			create s.make_empty
			if attached e.ns_prefix as nsp and then not nsp.is_empty then
				s.append_string (nsp + ":")
			end
			s.append_string (e.name)
			if attached e.namespace as ns and then not ns.uri.is_empty then
				s.append_string (" (" + ns.uri + ")")
			end
			print (offset (e.level) + "element: " + s + "%N")
			process_nodes (e)
		end

	process_character_data (c: XML_CHARACTER_DATA)
			-- Process character data `c'.
		do
			if not is_blank_content (c.content) then
				print (offset (c.level) + "content: " + single_line (c.content) + "%N")
			end
		end

	process_processing_instruction (a_pi: XML_PROCESSING_INSTRUCTION)
			-- Process processing instruction `a_pi'.
		do
		end

	process_document (doc: XML_DOCUMENT)
			-- Process document `doc'.
		do
--			doc.process_children (Current)
			process_nodes (doc)
		end

	process_comment (com: XML_COMMENT)
			-- Process comment `com'.
		do
			print (offset (com.level) + "comment: " + single_line (com.data) + "%N")
		end

	process_attributes (e: XML_ELEMENT)
			-- Process attributes of element `e'.
		do
			process_nodes (e)
		end

	process_attribute (att: XML_ATTRIBUTE)
			-- Process attribute `att'.
		local
			s: STRING
		do
			create s.make_empty
			if attached att.ns_prefix as nsp and then not nsp.is_empty then
				s.append_string (nsp + ":")
			end
			s.append_string (att.name)
			if attached att.namespace as ns and then not ns.uri.is_empty then
				s.append_string (" (" + ns.uri + ")")
			end
			print (offset (att.level) + "+ attribute: " + s + "=%"" + att.value + "%"%N")
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

	single_line (s: STRING): STRING
		do
			create Result.make_from_string (s)
			Result.replace_substring_all ("%R%N", "%%N")
			Result.replace_substring_all ("%N", "%%N")
		end

	offset (n: INTEGER): STRING
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
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
