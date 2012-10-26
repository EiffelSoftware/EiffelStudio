note
	description: "Summary description for {XML_CALLBACKS}."
	date: "$Date$"
	revision: "$Revision$"

class
	XML_ASCII_CALLBACKS_NULL

inherit
	XML_ASCII_CALLBACKS

create
	make

feature {NONE} -- Initialization

	make
			-- Do nothing.
		do
		end

feature -- Document

	on_start
			-- Called when parsing starts.
		do
		end

	on_finish
			-- Called when parsing finished.
		do
		end

	on_xml_declaration (a_version: READABLE_STRING_8; an_encoding: detachable READABLE_STRING_8; a_standalone: BOOLEAN)
			-- XML declaration.
		do
		end

feature -- Errors

	on_error (a_message: READABLE_STRING_8)
			-- Event producer detected an error.
		do
		end

feature -- Meta

	on_processing_instruction (a_name: READABLE_STRING_8; a_content: READABLE_STRING_8)
			-- Processing instruction.
		do
		end

	on_comment (a_content: READABLE_STRING_8)
			-- Processing a comment.
			-- Atomic: single comment produces single event
		do
		end

feature -- Tag

	on_start_tag (a_namespace: detachable READABLE_STRING_8; a_prefix: detachable READABLE_STRING_8; a_local_part: READABLE_STRING_8)
			-- Start of start tag.
		do
		end

	on_attribute (a_namespace: detachable READABLE_STRING_8; a_prefix: detachable READABLE_STRING_8; a_local_part: READABLE_STRING_8; a_value: READABLE_STRING_8)
			-- Start of attribute.
		do
		end

	on_start_tag_finish
			-- End of start tag.
		do
		end

	on_end_tag (a_namespace: detachable READABLE_STRING_8; a_prefix: detachable READABLE_STRING_8; a_local_part: READABLE_STRING_8)
			-- End tag.
		do
		end

feature -- Content

	on_content (a_content: READABLE_STRING_8)
			-- Text content.
		do
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
