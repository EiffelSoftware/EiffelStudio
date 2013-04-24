note

	description: "[
			Callback interface for core content XML events
			
			Note: the original code is from Gobo's XM library (http://www.gobosoft.com/)
			]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XML_ASCII_CALLBACKS

feature -- Document

	on_start
			-- Called when parsing starts.
		deferred
		end

	on_finish
			-- Called when parsing finished.
		deferred
		end

	on_xml_declaration (a_version: READABLE_STRING_8; an_encoding: detachable READABLE_STRING_8; a_standalone: BOOLEAN)
			-- XML declaration.
		require
			a_version_not_void: a_version /= Void
			a_version_not_empty: a_version.count > 0
		deferred
		end

feature -- Errors

	on_error (a_message: READABLE_STRING_8)
			-- Event producer detected an error.
		require
			not_void: a_message /= Void
		deferred
		end

feature -- Meta

	on_processing_instruction (a_name: READABLE_STRING_8; a_content: READABLE_STRING_8)
			-- Processing instruction.
			-- Warning: strings may be polymorphic, see XM_STRING_MODE.
			--| See http://en.wikipedia.org/wiki/Processing_instruction
		require
			name_not_void: a_name /= Void
			content_not_void: a_content /= Void
		deferred
		end

	on_comment (a_content: READABLE_STRING_8)
			-- Processing a comment.
			-- Atomic: single comment produces single event
		require
			a_content_not_void: a_content /= Void
		deferred
		end

feature -- Tag

	on_start_tag (a_namespace: detachable READABLE_STRING_8; a_prefix: detachable READABLE_STRING_8; a_local_part: READABLE_STRING_8)
			-- Start of start tag.
		require
			unresolved_namespace_is_void: has_resolved_namespaces implies a_namespace /= Void
			local_part: is_local_part (a_local_part)
		deferred
		end

	on_attribute (a_namespace: detachable READABLE_STRING_8; a_prefix: detachable READABLE_STRING_8; a_local_part: READABLE_STRING_8; a_value: READABLE_STRING_8)
			-- Start of attribute.
		require
			unresolved_namespace_is_void: has_resolved_namespaces implies a_namespace /= Void
			local_part: is_local_part (a_local_part)
			a_value_not_void: a_value /= Void
		deferred
		end

	on_start_tag_finish
			-- End of start tag.
		deferred
		end

	on_end_tag (a_namespace: detachable READABLE_STRING_8; a_prefix: detachable READABLE_STRING_8; a_local_part: READABLE_STRING_8)
			-- End tag.
		require
			unresolved_namespace_is_void: has_resolved_namespaces implies a_namespace /= Void
			local_part: is_local_part (a_local_part)
		deferred
		end

feature -- Content

	on_content (a_content: READABLE_STRING_8)
			-- Text content.
			-- NOT atomic: two on_content events may follow each other
			-- without a markup event in between.
			--| this should not occur, but I leave this comment just in case
		require
			not_void: a_content /= Void
			not_empty: a_content.count >= 0
		deferred
		end

feature -- Support

	has_prefix (a: detachable READABLE_STRING_8): BOOLEAN
			-- Is prefix in use?
		do
			Result := a /= Void and then a.count > 0
		end

	has_namespace (a: detachable READABLE_STRING_8): BOOLEAN
			-- Is namespace resolved?
		do
			Result := a /= Void
		end

	is_local_part (a: detachable READABLE_STRING_8): BOOLEAN
			-- Is this a valid local part string?
		do
			Result := a /= Void and then a.count > 0
		ensure
			definition: Result = (a /= Void and then a.count > 0)
		end

feature -- Access

	associated_parser: detachable XML_PARSER
			-- Associated parser
			-- mainly used to report error back to the parser
			-- to handle position

feature -- Element change

	set_associated_parser (p: like associated_parser)
			-- Set `p' to `associated_parser'
		do
			associated_parser := p
		end

feature -- Assertion

	has_resolved_namespaces: BOOLEAN
			-- Does this callback event consumer expect resolved
			-- namespaces?
			-- If True, it must be located downstream of a filter
			-- or source producing resolved namespaces such
			-- as XML_NAMESPACE_RESOLVER.
		do
		end

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
