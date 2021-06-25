note
	description: "Iterator pattern for XML node objects."
	date: "$Date$"
	revision: "$Revision$"

class
	XML_NODE_ITERATOR

inherit
	XML_NODE_VISITOR

feature {NONE} -- Processing

	process_nodes (a_nodes: ITERABLE [XML_NODE])
			-- Process list of nodes `a_nodes'.
		do
			⟳ n: a_nodes ¦ n.process (Current) ⟲
		end

	process_attribute_nodes (a_nodes: ITERABLE [XML_NODE])
			-- Process list of attribute nodes `nodes'.
		do
			across
				a_nodes as c
			loop
				if attached {XML_ATTRIBUTE} c as att then
					att.process (Current)
				end
			end
		end

	process_non_attribute_nodes (a_nodes: ITERABLE [XML_NODE])
			-- Process list of non attribute nodes `nodes'.
		do
			across
				a_nodes as c
			loop
				if not attached {XML_ATTRIBUTE} c then
					c.process (Current)
				end
			end
		end

feature -- Processing

	process_element (e: XML_ELEMENT)
			-- Process element `e'.
		do
			process_nodes (e)
		end

	process_character_data (c: XML_CHARACTER_DATA)
			-- Process character data `c'.
		do
		end

	process_xml_declaration (a_decl: XML_DECLARATION)
			-- Process xml declaration `a_decl'
		do
		end

	process_processing_instruction (a_pi: XML_PROCESSING_INSTRUCTION)
			-- Process processing instruction `a_pi'.
		do
		end

	process_document (doc: XML_DOCUMENT)
			-- Process document `doc'.
		do
			process_nodes (doc)
		end

	process_comment (com: XML_COMMENT)
			-- Process comment `com'.
		do
		end

	process_attributes (e: XML_ELEMENT)
			-- Process attributes of element `e'.
		do
			process_nodes (e)
		end

	process_attribute (att: XML_ATTRIBUTE)
			-- Process attribute `att'.
		do
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
