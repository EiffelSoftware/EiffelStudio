note
	description: "Summary description for {XML_CALLBACKS_FILTER_DOCUMENT}."
	date: "$Date$"
	revision: "$Revision$"

class
	XML_CALLBACKS_FILTER_DOCUMENT

inherit
	XML_CALLBACKS_FILTER
		undefine
			has_resolved_namespaces
		redefine
			initialize,
			set_next,
			on_start,
			on_finish,
			on_xml_declaration,
			on_error,
			on_processing_instruction,
			on_comment,
			on_start_tag,
			on_attribute,
			on_start_tag_finish,
			on_end_tag,
			on_content
		end

	XML_CALLBACKS_DOCUMENT
		rename
			make_null as document_make_null
		redefine
			initialize,
			on_start,
			on_finish,
			on_xml_declaration,
			on_error,
			on_processing_instruction,
			on_comment,
			on_start_tag,
			on_attribute,
			on_start_tag_finish,
			on_end_tag,
			on_content
		end

create
	make_null, set_next

feature {NONE} -- Initialization

	set_next (a_next: like next)
			-- Set `next' to `a_next'.
		do
			document_make_null
			Precursor {XML_CALLBACKS_FILTER} (a_next)
		end

	initialize
			-- Called when parsing starts.
		do
			Precursor {XML_CALLBACKS_DOCUMENT}
			Precursor {XML_CALLBACKS_FILTER}
		end

feature -- Document

	on_start
			-- Called when parsing starts.
		do
			Precursor {XML_CALLBACKS_DOCUMENT}
			Precursor {XML_CALLBACKS_FILTER}
		end

	on_finish
			-- Called when parsing finished.
		do
			Precursor {XML_CALLBACKS_DOCUMENT}
			Precursor {XML_CALLBACKS_FILTER}
		end

	on_xml_declaration (a_version: STRING; an_encoding: detachable STRING; a_standalone: BOOLEAN)
			-- XML declaration.
		do
			Precursor {XML_CALLBACKS_DOCUMENT} (a_version, an_encoding, a_standalone)
			Precursor {XML_CALLBACKS_FILTER} (a_version, an_encoding, a_standalone)
		end

feature -- Errors

	on_error (a_message: STRING)
			-- Event producer detected an error.
		do
			Precursor {XML_CALLBACKS_DOCUMENT} (a_message)
			Precursor {XML_CALLBACKS_FILTER} (a_message)
		end

feature -- Meta

	on_processing_instruction (a_name: STRING; a_content: STRING)
			-- Processing instruction.
		do
			Precursor {XML_CALLBACKS_DOCUMENT} (a_name, a_content)
			Precursor {XML_CALLBACKS_FILTER} (a_name, a_content)
		end

	on_comment (a_content: STRING)
			-- Processing a comment.
			-- Atomic: single comment produces single event
		do
			Precursor {XML_CALLBACKS_DOCUMENT} (a_content)
			Precursor {XML_CALLBACKS_FILTER} (a_content)
		end

feature -- Tag

	on_start_tag (a_namespace: detachable STRING; a_prefix: detachable STRING; a_local_part: STRING)
			-- Start of start tag.
		do
			Precursor {XML_CALLBACKS_DOCUMENT} (a_namespace, a_prefix, a_local_part)
			Precursor {XML_CALLBACKS_FILTER} (a_namespace, a_prefix, a_local_part)
		end

	on_attribute (a_namespace: detachable STRING; a_prefix: detachable STRING; a_local_part: STRING; a_value: STRING)
			-- Start of attribute.
		do
			Precursor {XML_CALLBACKS_DOCUMENT} (a_namespace, a_prefix, a_local_part, a_value)
			Precursor {XML_CALLBACKS_FILTER} (a_namespace, a_prefix, a_local_part, a_value)
		end

	on_start_tag_finish
			-- End of start tag.
		do
			Precursor {XML_CALLBACKS_DOCUMENT}
			Precursor {XML_CALLBACKS_FILTER}
		end

	on_end_tag (a_namespace: detachable STRING; a_prefix: detachable STRING; a_local_part: STRING)
			-- End tag.
		do
			Precursor {XML_CALLBACKS_DOCUMENT} (a_namespace, a_prefix, a_local_part)
			Precursor {XML_CALLBACKS_FILTER} (a_namespace, a_prefix, a_local_part)
		end

feature -- Content

	on_content (a_content: STRING)
			-- Text content.
		do
			Precursor {XML_CALLBACKS_DOCUMENT} (a_content)
			Precursor {XML_CALLBACKS_FILTER} (a_content)
		end

;note
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
