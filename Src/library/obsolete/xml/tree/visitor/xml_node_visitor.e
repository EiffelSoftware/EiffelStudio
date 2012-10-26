note
	description: "[
			Visitor pattern for XML node objects. Inherit and 
			redefine to make use of this pattern
		]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XML_NODE_VISITOR

feature -- Processing

	process_element (e: XML_ELEMENT)
			-- Process element `e'.
		require
			e_not_void: e /= Void
		deferred
		end

	process_character_data (c: XML_CHARACTER_DATA)
			-- Process character data `c'.
		require
			c_not_void: c /= Void
		deferred
		end

	process_processing_instruction (a_pi: XML_PROCESSING_INSTRUCTION)
			-- Process processing instruction `a_pi'.
		require
			a_pi_not_void: a_pi /= Void
		deferred
		end

	process_document (doc: XML_DOCUMENT)
			-- Process document `doc'.
		require
			doc_not_void: doc /= Void
		deferred
		end

	process_comment (com: XML_COMMENT)
			-- Process comment `com'.
		require
			com_not_void: com /= Void
		deferred
		end

	process_attributes (e: XML_ELEMENT)
			-- Process attributes of element `e'.
		require
			e_not_void: e /= Void
		deferred
		end

	process_attribute (att: XML_ATTRIBUTE)
			-- Process attribute `att'.
		require
			att_not_void: att /= Void
		deferred
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
