note
	description: "[
			Descendant of callbacks interface forwarding to a client interface
	
			Note: the original code is from Gobo's XM library (http://www.gobosoft.com/)
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	XML_FORWARD_CALLBACKS

inherit
	XML_CALLBACKS_SOURCE

create
	make_null

feature {NONE} -- Initialization

	make_null
			-- Don't forward anything
		do
			set_callbacks (create {XML_CALLBACKS_NULL}.make)
		end

feature -- Access

	callbacks: XML_CALLBACKS
			-- Callbacks event interface to which events are forwarded;

feature -- Setting

	set_callbacks (a_callbacks: like callbacks)
			-- Set `callbacks' to `a_callbacks'.
		do
			callbacks := a_callbacks
		ensure then
			callbacks_set: callbacks = a_callbacks
		end

feature {NONE} -- Document

	on_start
			-- Forward start.
		do
			callbacks.on_start
		end

	on_finish
			-- Forward finish.
		do
			callbacks.on_finish
		end

	on_xml_declaration (a_version: STRING; an_encoding: detachable STRING; a_standalone: BOOLEAN)
			-- XML declaration.
		do
			callbacks.on_xml_declaration (a_version, an_encoding, a_standalone)
		end

feature {NONE} -- Errors

	on_error (a_message: STRING)
			-- Event producer detected an error.
		do
			callbacks.on_error (a_message)
		end

feature {NONE} -- Meta

	on_processing_instruction (a_name, a_content: STRING)
			-- Forward PI.
		do
			callbacks.on_processing_instruction (a_name, a_content)
		end

	on_comment (a_content: STRING)
			-- Forward comment.
		do
			callbacks.on_comment (a_content)
		end

feature {NONE} -- Tag

	on_start_tag (a_namespace: detachable STRING; a_prefix: detachable STRING; a_local_part: STRING)
			-- Start of start tag.
		do
			callbacks.on_start_tag (a_namespace, a_prefix, a_local_part)
		end

	on_attribute (a_namespace: detachable STRING; a_prefix: detachable STRING; a_local_part: STRING; a_value: STRING)
			-- Process attribute.
		do
			callbacks.on_attribute (a_namespace, a_prefix, a_local_part, a_value)
		end

	on_start_tag_finish
			-- End of start tag.
		do
			callbacks.on_start_tag_finish
		end

	on_end_tag (a_namespace: detachable STRING; a_prefix: detachable STRING; a_local_part: STRING)
			-- End tag.
		do
			callbacks.on_end_tag (a_namespace, a_prefix, a_local_part)
		end

feature {NONE} -- Content

	on_content (a_content: STRING)
			-- Forward content.
		do
			callbacks.on_content (a_content)
		end

note
	copyright: "Copyright (c) 1984-2011, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
