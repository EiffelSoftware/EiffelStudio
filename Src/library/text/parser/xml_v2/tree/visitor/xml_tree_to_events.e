note
	description: "[
		Emit events from a tree
		]"
	date: "$Date$"
	revision: "$Revision$"

class XML_TREE_TO_EVENTS

inherit
	XML_NODE_VISITOR

	XML_EXPORTER

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
			a_document.process_children (Current)
			events.on_finish
		end

	process_element (an_element: XML_ELEMENT)
			-- Process element.
		do
			process_start_tag_finish

			events.on_start_tag (an_element.namespace.internal_uri, an_element.namespace.internal_ns_prefix, an_element.internal_name)
			in_attributes := True

			an_element.process_children (Current)

			process_start_tag_finish
			events.on_end_tag (an_element.namespace.internal_uri, an_element.namespace.internal_ns_prefix, an_element.internal_name)
		end

	process_attributes (e: XML_ELEMENT)
			-- Process attributes of element `e'.
		do
		end

	process_attribute (an_attribute: XML_ATTRIBUTE)
		do
			check in_attributes: in_attributes end
			events.on_attribute (an_attribute.namespace.internal_uri, an_attribute.namespace.internal_ns_prefix,
					an_attribute.internal_name, an_attribute.internal_value)
		end

	process_character_data (a_data: XML_CHARACTER_DATA)
			-- Process character data .
		do
			process_start_tag_finish
			events.on_content (a_data.internal_content)
		end

	process_processing_instruction (a_pi: XML_PROCESSING_INSTRUCTION)
			-- Process processing instruction `a_pi'.
		do
			process_start_tag_finish
			events.on_processing_instruction (a_pi.internal_target, a_pi.internal_data)
		end

	process_comment (a_comment: XML_COMMENT)
		do
			process_start_tag_finish
			events.on_comment (a_comment.internal_data)
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
	copyright: "Copyright (c) 1984-2012, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
