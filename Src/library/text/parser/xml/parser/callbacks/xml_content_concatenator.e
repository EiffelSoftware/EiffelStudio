note
	description:
		"[
			Event filter that concatenates successive on_content events

			Note: the original code is from Gobo's XM library (http://www.gobosoft.com/)
		]"
	date: "$Date$"
	revision: "$Revision$"

class XML_CONTENT_CONCATENATOR

inherit
	XML_CALLBACKS_FILTER
		redefine
			on_processing_instruction,
			on_comment,
			on_start_tag,
			on_attribute,
			on_end_tag,
			on_content,
			on_finish
		end

create
	make_null,
	set_next

feature {NONE} -- Content

	last_content: detachable STRING_32
			-- Current content

	flush_content
			-- Generate content event if there is pending content.
		do
			if attached last_content as s and then s.count > 0 then
				next.on_content (s)
			end
			last_content := Void
		end

feature -- Content

	on_content (a_content: READABLE_STRING_32)
			-- Aggregate content events so that two content events
			-- never follow each other.
		local
			s32: STRING_32
		do
			if attached last_content as s then
				s.append (a_content)
			else
				create s32.make (a_content.count)
				s32.append_string_general (a_content)
				last_content := s32
			end
		end

	on_comment (a_comment: READABLE_STRING_32)
			-- Eat comment when in content, otherwise the event would be
			-- out of order.
		do
			flush_content
			Precursor (a_comment)
		end

feature -- Events

	on_processing_instruction (a_name: READABLE_STRING_32; a_content: READABLE_STRING_32)
			-- Flush content and forward.
		do
			flush_content
			Precursor (a_name, a_content)
		end

	on_start_tag (a_namespace: detachable READABLE_STRING_32; a_prefix: detachable READABLE_STRING_32; a_local_part: READABLE_STRING_32)
			-- Flush content and forward.
		do
			flush_content
			Precursor (a_namespace, a_prefix, a_local_part)
		end

	on_attribute (a_namespace: detachable READABLE_STRING_32; a_prefix: detachable READABLE_STRING_32; a_local_part: READABLE_STRING_32; a_value: READABLE_STRING_32)
			-- Flush content and forward.
		do
			flush_content
			Precursor (a_namespace, a_prefix, a_local_part, a_value)
		end

	on_end_tag (a_namespace: detachable READABLE_STRING_32; a_prefix: detachable READABLE_STRING_32; a_local_part: READABLE_STRING_32)
			-- Flush content and forward.
		do
			flush_content
			Precursor (a_namespace, a_prefix, a_local_part)
		end

	on_finish
				-- Flush content and forward.
		do
			flush_content
			Precursor
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
