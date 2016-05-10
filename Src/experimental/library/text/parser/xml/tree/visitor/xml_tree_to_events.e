note
	description: "[
		Emit events from a tree
		]"
	date: "$Date$"
	revision: "$Revision$"

class XML_TREE_TO_EVENTS

inherit
	XML_NODE_VISITOR

create
	make

feature {NONE} -- Creation

	make (an_events: like events)
			-- Set events sink.
		require
			an_events_not_void: an_events /= Void
		do
			events := an_events
		ensure
			set: events = an_events
		end

feature -- Status

	events: XML_CALLBACKS

feature -- Node processor

	process_document (a_document: XML_DOCUMENT)
		do
			events.on_start
			if attached a_document.xml_declaration as decl then
				process_xml_declaration (decl)
			end
			a_document.process_children (Current)
			events.on_finish
		end

	process_element (an_element: XML_ELEMENT)
			-- Process element.
		do
			process_start_tag_finish

			events.on_start_tag (an_element.namespace.uri, an_element.namespace.ns_prefix, an_element.name)
			in_attributes := True

			an_element.process_children (Current)

			process_start_tag_finish
			events.on_end_tag (an_element.namespace.uri, an_element.namespace.ns_prefix, an_element.name)
		end

	process_attributes (e: XML_ELEMENT)
			-- Process attributes of element `e'.
		do
		end

	process_attribute (an_attribute: XML_ATTRIBUTE)
		do
			check in_attributes: in_attributes end
			events.on_attribute (an_attribute.namespace.uri, an_attribute.namespace.ns_prefix,
					an_attribute.name, an_attribute.value)
		end

	process_character_data (a_data: XML_CHARACTER_DATA)
			-- Process character data .
		do
			process_start_tag_finish
			events.on_content (a_data.content)
		end

	process_xml_declaration (a_decl: XML_DECLARATION)
			-- Process xml declaration `a_decl'
		do
			process_start_tag_finish
			events.on_xml_declaration (a_decl.version, a_decl.encoding, a_decl.standalone)
		end

	process_processing_instruction (a_pi: XML_PROCESSING_INSTRUCTION)
			-- Process processing instruction `a_pi'.
		do
			process_start_tag_finish
			events.on_processing_instruction (a_pi.target, a_pi.data)
		end

	process_comment (a_comment: XML_COMMENT)
		do
			process_start_tag_finish
			events.on_comment (a_comment.data)
		end

feature {NONE} -- Implementation

	in_attributes: BOOLEAN
			-- Within attribute nodes?

	process_start_tag_finish
			-- End of start tag event.
			-- (Requires that all attribute tags are clustered together
			-- at the start of element's list of children.)
		do
			if in_attributes then
				events.on_start_tag_finish
				in_attributes := False
			end
		end

note
	copyright: "Copyright (c) 1984-2016, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
