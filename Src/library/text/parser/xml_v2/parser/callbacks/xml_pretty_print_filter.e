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
			on_comment,
			on_processing_instruction,
			on_start_tag,
			on_attribute,
			on_start_tag_finish,
			on_end_tag,
			on_content,
			on_finish,
			default_create,
			set_next
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
	set_next

feature {NONE} -- Initialization

	default_create
		do
			Precursor {XML_CALLBACKS_FILTER}
			Precursor {XML_OUTPUT}
		end

feature -- Settings

	set_next (a_callbacks: like next)
		do
			default_create
			Precursor (a_callbacks)
		end

feature {NONE} -- Document

	on_finish
			-- Forward finish.
		do
			Precursor
			flush
		end

feature -- Meta

	on_processing_instruction (a_name: READABLE_STRING_GENERAL; a_content: READABLE_STRING_GENERAL)
			-- Print processing instruction.
		do
			output_constant (Pi_start)
			output_escaped (a_name)
			output_constant (Space_s)
			output_escaped (a_content)
			output_constant (Pi_end)
			Precursor (a_name, a_content)
		end

	on_comment (a_content: READABLE_STRING_GENERAL)
			-- Print comment.
		do
			output_constant (Comment_start)
			output_escaped (a_content)
			output_constant (Comment_end)
			Precursor (a_content)
		end

feature -- Tag

	on_start_tag (a_namespace: detachable READABLE_STRING_GENERAL; a_prefix: detachable READABLE_STRING_GENERAL; a_local_part: READABLE_STRING_GENERAL)
			-- Print start of start tag.
		do
			output_constant (Stag_start)
			output_name (a_prefix, a_local_part)
			Precursor (a_namespace, a_prefix, a_local_part)
		end

	on_attribute (a_namespace: detachable READABLE_STRING_GENERAL; a_prefix: detachable READABLE_STRING_GENERAL; a_local_part: READABLE_STRING_GENERAL; a_value: READABLE_STRING_GENERAL)
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

	on_end_tag (a_namespace: detachable READABLE_STRING_GENERAL; a_prefix: detachable READABLE_STRING_GENERAL; a_local_part: READABLE_STRING_GENERAL)
			-- Print end tag.
		do
			output_constant (Etag_start)
			output_name (a_prefix, a_local_part)
			output_constant (Etag_end)
			Precursor (a_namespace, a_prefix, a_local_part)
		end

feature -- Content

	on_content (a_content: READABLE_STRING_GENERAL)
			-- Text content.
			-- NOT atomic: successive content may be different.
			-- Default: forward event to 'next'.
		do
			output_escaped (a_content)
			Precursor (a_content)
		end

feature {NONE} -- Escaped

	is_output_escaped (a_code: NATURAL_32): BOOLEAN
			-- Is this an escapable character?
			-- in the context of `output'
			-- which means any content output, except attribute's value
		do
			if a_code >= 128 then
				Result := True
			else
				Result := a_code = Lt_char.natural_32_code or
							a_code = Gt_char.natural_32_code or
							a_code = Amp_char.natural_32_code
			end
		end

	output_escaped_char (a_code: NATURAL_32): STRING_8
			-- Escape char in the context of `output'.
			-- which means any content output, except attribute's value
		require
			is_output_escaped: is_output_escaped (a_code)
		do
			if a_code < 128 then
				if a_code = Lt_char.natural_32_code then
					Result := Lt_entity
				elseif a_code = Gt_char.natural_32_code then
					Result := Gt_entity
				elseif a_code = Amp_char.natural_32_code then
					Result := Amp_entity
				else
					check is_escaped: False end
					create Result.make_empty
					Result.append_code (a_code)
				end
			else
				create Result.make_from_string ("&#")
				Result.append_natural_32 (a_code)
				Result.append_character (';')
			end
		end

feature {NONE} -- Output

	output_constant (a_string: STRING)
			-- Output constant string.
			--| It is know to be without any escapable character.
		require
			a_string_not_void: a_string /= Void
		do
			output (a_string)
		end

	output_attribute_value (a_string: READABLE_STRING_GENERAL)
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

	output_escaped (a_string: READABLE_STRING_GENERAL)
			-- Escape and output content string.
		require
			a_string_not_void: a_string /= Void
		local
			last_escaped: INTEGER
			i: INTEGER
			cnt: INTEGER
			l_code: NATURAL_32
			s: READABLE_STRING_GENERAL
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
				if is_output_escaped (l_code) then
					if last_escaped < i - 1 then
						s := a_string.substring (last_escaped + 1, i - 1)
						--| is_escaped and use of last_escaped implies there should not be any non char_8
						check is_valid_as_string_8: s.is_valid_as_string_8 end
						output (s.to_string_8)
					end
					output_constant (output_escaped_char (l_code))
					last_escaped := i
				end
				i := i + 1
			end
				-- At exit.
			if last_escaped = 0 then
				check is_valid_as_string_8: a_string.is_valid_as_string_8 end
				output (a_string.to_string_8)
			elseif last_escaped < i - 1 then
				s := a_string.substring (last_escaped + 1, i - 1)
				check is_valid_as_string_8: s.is_valid_as_string_8 end
				output (s.to_string_8)
			end
		end

	output_name (a_prefix: detachable READABLE_STRING_GENERAL; a_local_part: READABLE_STRING_GENERAL)
			-- Output prefix:name.
		require
			a_local_part_not_void: a_local_part /= Void
		do
			if a_prefix /= Void and has_prefix (a_prefix) then
				output_escaped (a_prefix)
				output_constant (Prefix_separator)
			end
			output_escaped (a_local_part)
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
