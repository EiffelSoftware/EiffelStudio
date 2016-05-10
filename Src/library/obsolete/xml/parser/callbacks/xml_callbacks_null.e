note
	description: "Summary description for {XML_CALLBACKS}."
	date: "$Date$"
	revision: "$Revision$"

class
	XML_CALLBACKS_NULL

inherit
	XML_CALLBACKS

create
	make

feature {NONE} -- Initialization

	make
			-- Do nothing.
		do
		end

	initialize
			-- <Precursor>.
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

	on_xml_declaration (a_version: STRING; an_encoding: detachable STRING; a_standalone: BOOLEAN)
			-- XML declaration.
		do
		end

feature -- Errors

	on_error (a_message: STRING)
			-- Event producer detected an error.
		do
		end

feature -- Meta

	on_processing_instruction (a_name: STRING; a_content: STRING)
			-- Processing instruction.
		do
		end

	on_comment (a_content: STRING)
			-- Processing a comment.
			-- Atomic: single comment produces single event
		do
		end

feature -- Tag

	on_start_tag (a_namespace: detachable STRING; a_prefix: detachable STRING; a_local_part: STRING)
			-- Start of start tag.
		do
		end

	on_attribute (a_namespace: detachable STRING; a_prefix: detachable STRING; a_local_part: STRING; a_value: STRING)
			-- Start of attribute.
		do
		end

	on_start_tag_finish
			-- End of start tag.
		do
		end

	on_end_tag (a_namespace: detachable STRING; a_prefix: detachable STRING; a_local_part: STRING)
			-- End tag.
		do
		end

feature -- Content

	on_content (a_content: STRING)
			-- Text content.
		do
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
