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
			on_finish
		end

	XML_OUTPUT

	XML_MARKUP_CONSTANTS
		export {NONE} all end

create
	make_null,
	set_next

feature {NONE} -- Document

	on_finish
			-- Forward finish.
		do
			Precursor
			if attached output_stream as s then
				s.flush
			end
		end

feature -- Meta

	on_processing_instruction (a_name: STRING; a_content: STRING)
			-- Print processing instruction.
		do
			output_constant (Pi_start)
			output (a_name)
			output_constant (Space_s)
			output (a_content)
			output_constant (Pi_end)
			Precursor (a_name, a_content)
		end

	on_comment (a_content: STRING)
			-- Print comment.
		do
			output_constant (Comment_start)
			output (a_content)
			output_constant (Comment_end)
			Precursor (a_content)
		end

feature -- Tag

	on_start_tag (a_namespace: detachable STRING; a_prefix: detachable STRING; a_local_part: STRING)
			-- Print start of start tag.
		do
			output_constant (Stag_start)
			output_name (a_prefix, a_local_part)
			Precursor (a_namespace, a_prefix, a_local_part)
		end

	on_attribute (a_namespace: detachable STRING; a_prefix: detachable STRING; a_local_part: STRING; a_value: STRING)
			-- Print attribute.
		do
			output_constant (Space_s)
			output_name (a_prefix, a_local_part)
			output_constant (Eq_s)
			output_constant (Quot_s)
			output_quote_escaped (a_value)
			output_constant (Quot_s)
			Precursor (a_namespace, a_prefix, a_local_part, a_value)
		end

	on_start_tag_finish
			-- Print end of start tag.
		do
			output_constant (Stag_end)
			Precursor
		end

	on_end_tag (a_namespace: detachable STRING; a_prefix: detachable STRING; a_local_part: STRING)
			-- Print end tag.
		do
			output_constant (Etag_start)
			output_name (a_prefix, a_local_part)
			output_constant (Etag_end)
			Precursor (a_namespace, a_prefix, a_local_part)
		end

feature -- Content

	on_content (a_content: STRING)
			-- Text content.
			-- NOT atomic: successive content may be different.
			-- Default: forward event to 'next'.
		do
			output_escaped (a_content)
			Precursor (a_content)
		end

feature {NONE} -- Escaped

	is_escaped (a_char: INTEGER): BOOLEAN
			-- Is this an escapable character?
		do
			Result := a_char = Lt_char.code
				or a_char = Gt_char.code
				or a_char = Amp_char.code
				or a_char >= 128
		end

	escaped_char (a_char: INTEGER): STRING
			-- Escape char.
		require
			is_escaped: is_escaped (a_char)
		do
			if a_char = Lt_char.code then
				Result := Lt_entity
			elseif a_char = Gt_char.code then
				Result := Gt_entity
			elseif a_char = Amp_char.code then
				Result := Amp_entity
			else
				create Result.make_from_string ("&#")
				Result.append_integer (a_char)
				Result.append_character (';')
			end
		end

feature {NONE} -- Output

	output_constant (a_string: STRING)
			-- Output constant string.
		require
			a_string_not_void: a_string /= Void
		do
			output (a_string)
		end

	output_quote_escaped (a_string: STRING)
			-- Like output escaped with quote also escaped for
			-- attribute values.
		require
			a_string_not_void: a_string /= Void
		local
			last_escaped: INTEGER
			i: INTEGER
			cnt: INTEGER
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
				if a_string.item_code (i) = Quot_char.code then
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

	output_escaped (a_string: STRING)
			-- Escape and output content string.
		require
			a_string_not_void: a_string /= Void
		local
			last_escaped: INTEGER
			i: INTEGER
			cnt: INTEGER
			a_char: INTEGER
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
				a_char := a_string.item_code (i)
				if is_escaped (a_char) then
					if last_escaped < i - 1 then
						output (a_string.substring (last_escaped + 1, i - 1))
					end
					output_constant (escaped_char (a_char))
					last_escaped := i
				end
				i := i + 1
			end
				-- At exit.
			if last_escaped = 0 then
				output (a_string)
			elseif last_escaped < i - 1 then
				output (a_string.substring (last_escaped + 1, i - 1))
			end
		end

	output_name (a_prefix: detachable STRING; a_local_part: STRING)
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
	copyright: "Copyright (c) 1984-2010, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
