note
	description: "[
			Visitor pattern for XML node objects. Inherit and 
			redefine to make use of this pattern
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	XML_NODE_VISITOR_NULL

inherit
	XML_NODE_VISITOR

feature -- Processing

	process_element (e: XML_ELEMENT)
			-- Process element `e'.
		do
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
		end

	process_comment (com: XML_COMMENT)
			-- Process comment `com'.
		do
		end

	process_attributes (e: XML_ELEMENT)
			-- Process attributes of element `e'.
		do
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
