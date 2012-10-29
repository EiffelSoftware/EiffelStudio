note
	description:
		"[
			Pretty printer, output as XML document

			Note: the original code is from Gobo's XM library (http://www.gobosoft.com/)
		]"
	date: "$Date$"
	revision: "$Revision$"

class XML_PRETTY_PRINT_FILTER

inherit
	XML_CALLBACKS_FILTER
		redefine
			on_xml_declaration,
			on_comment,
			on_processing_instruction,
			on_start_tag,
			on_attribute,
			on_start_tag_finish,
			on_end_tag,
			on_content,
			on_finish,
			default_create,
			make_null
		end

	XML_OUTPUT
		redefine
			default_create
		end

	XML_MARKUP_CONSTANTS
		export
			{NONE} all
		undefine
			default_create
		end

create
	make_null,
	make_with_next

feature {NONE} -- Initialization

	default_create
		do
			Precursor {XML_CALLBACKS_FILTER}
			Precursor {XML_OUTPUT}
		end

	make_null
		do
			make_with_next (create {XML_CALLBACKS_NULL}.make)
		end

	make_with_next (a_callbacks: like next)
		do
			default_create
			set_next (a_callbacks)
		end

feature {NONE} -- Document

	on_finish
			-- Forward finish.
		do
			Precursor
			flush
		end

feature -- Meta

	on_xml_declaration (a_version: READABLE_STRING_32; an_encoding: detachable READABLE_STRING_32; a_standalone: BOOLEAN)
			-- XML declaration.
		do
			output_constant (Pi_start)
			output_constant (xml_prefix)
			output_constant (Space_s)
			output_constant ("version=%"")
			output_constant (a_version)
			output_constant ("%"")
			if an_encoding /= Void then
				output_constant (Space_s)
				output_constant ("encoding=%"")
				output_constant (an_encoding)
				output_constant ("%"")
			end
			if a_standalone then
				output_constant (Space_s)
				output_constant ("standalone=%"yes%"")
			end
			output_constant (Pi_end)
			output_constant ("%N")

			Precursor (a_version, an_encoding, a_standalone)
		end

	on_processing_instruction (a_name: READABLE_STRING_32; a_content: READABLE_STRING_32)
			-- Print processing instruction.
		do
			output_constant (Pi_start)
			output_escaped (a_name)
			output_constant (Space_s)
			output_escaped (a_content)
			output_constant (Pi_end)
			output_constant ("%N")
			Precursor (a_name, a_content)
		end

	on_comment (a_content: READABLE_STRING_32)
			-- Print comment.
		do
			output_constant (Comment_start)
			output_escaped (a_content)
			output_constant (Comment_end)
			Precursor (a_content)
		end

feature -- Tag

	on_start_tag (a_namespace: detachable READABLE_STRING_32; a_prefix: detachable READABLE_STRING_32; a_local_part: READABLE_STRING_32)
			-- Print start of start tag.
		do
			output_constant (Stag_start)
			output_name (a_prefix, a_local_part)
			Precursor (a_namespace, a_prefix, a_local_part)
		end

	on_attribute (a_namespace: detachable READABLE_STRING_32; a_prefix: detachable READABLE_STRING_32; a_local_part: READABLE_STRING_32; a_value: READABLE_STRING_32)
			-- Print attribute.
		do
			output_constant (Space_s)
			output_name (a_prefix, a_local_part)
			output_constant (Eq_s)
			output_constant (Quot_s)
			output_attribute_value (a_value)
			output_constant (Quot_s)
			Precursor (a_namespace, a_prefix, a_local_part, a_value)
		end

	on_start_tag_finish
			-- Print end of start tag.
		do
			output_constant (Stag_end)
			Precursor
		end

	on_end_tag (a_namespace: detachable READABLE_STRING_32; a_prefix: detachable READABLE_STRING_32; a_local_part: READABLE_STRING_32)
			-- Print end tag.
		do
			output_constant (Etag_start)
			output_name (a_prefix, a_local_part)
			output_constant (Etag_end)
			Precursor (a_namespace, a_prefix, a_local_part)
		end

feature -- Content

	on_content (a_content: READABLE_STRING_32)
			-- Text content.
			-- NOT atomic: successive content may be different.
			-- Default: forward event to 'next'.
		do
			output_escaped (a_content)
			Precursor (a_content)
		end

feature {NONE} -- Output

	output_constant (a_string: READABLE_STRING_GENERAL)
			-- Output constant string.
			--| It is know to be without any escapable character.
		require
			a_string_not_void: a_string /= Void
		do
			output (a_string)
		end

	output_attribute_value (a_string: READABLE_STRING_32)
			-- Like output escaped and also escape quote for attribute values.
		require
			a_string_not_void: a_string /= Void
		local
			last_escaped: INTEGER
			i: INTEGER
			cnt: INTEGER
			l_code: NATURAL_32
		do
			from
				last_escaped := 0
				i := 1
				cnt := a_string.count
			invariant
				last_escaped <= i
			until
				i > cnt
			loop
				l_code := a_string.code (i)
				if l_code = Quot_char.natural_32_code then
					if last_escaped < i - 1 then
						output_escaped (a_string.substring (last_escaped + 1, i - 1))
					end
					output_constant (Quot_entity)
					last_escaped := i
				end
				i := i + 1
			end
				-- At exit.
			if last_escaped = 0 then
				output_escaped (a_string)
			elseif last_escaped < i - 1 then
				output_escaped (a_string.substring (last_escaped + 1, i - 1))
			end
		end

	output_escaped (a_string: READABLE_STRING_32)
			-- Escape and output content string.
		require
			a_string_not_void: a_string /= Void
		do
			output_stream.put_string_32_escaped (a_string)
		end

	output_name (a_prefix: detachable READABLE_STRING_32; a_local_part: READABLE_STRING_32)
			-- Output prefix:name.
		require
			a_local_part_not_void: a_local_part /= Void
		do
			if a_prefix /= Void and has_prefix (a_prefix) then
				output (a_prefix)
				output_constant (Prefix_separator)
			end
			output (a_local_part)
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
