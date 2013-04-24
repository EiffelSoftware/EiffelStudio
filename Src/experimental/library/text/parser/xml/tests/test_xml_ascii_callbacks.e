note
	description: "Summary description for {TEST_STRING_8_XML_CALLBACKS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_XML_ASCII_CALLBACKS

inherit
	XML_ASCII_CALLBACKS

create
	make,
	make_null

feature {NONE} -- Initialization

	make (cb: like callbacks)
			-- Don't forward anything
		do
			set_callbacks (cb)
		end

	make_null
		do
			set_callbacks (create {XML_ASCII_CALLBACKS_NULL}.make)
		end

feature -- Access

	callbacks: XML_ASCII_CALLBACKS
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

	on_xml_declaration (a_version: STRING_8; an_encoding: detachable STRING_8; a_standalone: BOOLEAN)
			-- XML declaration.
		do
			callbacks.on_xml_declaration (a_version, an_encoding, a_standalone)
		end

feature {NONE} -- Errors

	on_error (a_message: STRING_8)
			-- Event producer detected an error.
		do
			callbacks.on_error (a_message)
		end

feature {NONE} -- Meta

	on_processing_instruction (a_name, a_content: STRING_8)
			-- Forward PI.
		do
			callbacks.on_processing_instruction (a_name, a_content)
		end

	on_comment (a_content: STRING_8)
			-- Forward comment.
		do
			callbacks.on_comment (a_content)
		end

feature {NONE} -- Tag

	on_start_tag (a_namespace: detachable STRING_8; a_prefix: detachable STRING_8; a_local_part: STRING_8)
			-- Start of start tag.
		do
			callbacks.on_start_tag (a_namespace, a_prefix, a_local_part)
		end

	on_attribute (a_namespace: detachable STRING_8; a_prefix: detachable STRING_8; a_local_part: STRING_8; a_value: STRING_8)
			-- Process attribute.
		do
			callbacks.on_attribute (a_namespace, a_prefix, a_local_part, a_value)
		end

	on_start_tag_finish
			-- End of start tag.
		do
			callbacks.on_start_tag_finish
		end

	on_end_tag (a_namespace: detachable STRING_8; a_prefix: detachable STRING_8; a_local_part: STRING_8)
			-- End tag.
		do
			callbacks.on_end_tag (a_namespace, a_prefix, a_local_part)
		end

feature {NONE} -- Content

	on_content (a_content: STRING_8)
			-- Forward content.
		do
			callbacks.on_content (a_content)
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
