note
	description: "[
			Iterator pattern for XML node objects. 
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	XML_NODE_ITERATOR

inherit
	XML_NODE_VISITOR

feature -- Processing

	process_nodes (nodes: LIST [XML_NODE])
			-- Process list of nodes `nodes'.
		do
			from
				nodes.start
			until
				nodes.after
			loop
				nodes.item.process (Current)
				nodes.forth
			end
		end

	process_element (e: XML_ELEMENT)
			-- Process element `e'.
		local
			s: STRING
		do
			process_nodes (e.nodes)
		end

	process_character_data (c: XML_CHARACTER_DATA)
			-- Process character data `c'.
		do
		end

	process_processing_instruction (a_pi: XML_PROCESSING_INSTRUCTION)
			-- Process processing instruction `a_pi'.
		do
		end

	process_document (doc: XML_DOCUMENT)
			-- Process document `doc'.
		do
			process_nodes (doc.nodes)
		end

	process_comment (com: XML_COMMENT)
			-- Process comment `com'.
		do
		end

	process_attributes (e: XML_ELEMENT)
			-- Process attributes of element `e'.
		do
			process_nodes (e.nodes)
		end

	process_attribute (att: XML_ATTRIBUTE)
			-- Process attribute `att'.
		do
		end

note
	copyright: "Copyright (c) 1984-2010, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
