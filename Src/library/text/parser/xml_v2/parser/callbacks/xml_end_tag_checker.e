note
	description: "[
			XML Event filters that check that end tag name balances

			Note: the original code is from Gobo's XM library (http://www.gobosoft.com/)
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	XML_END_TAG_CHECKER

inherit
	XML_CALLBACKS_FILTER
		redefine
			on_start,
			on_finish,
			on_start_tag,
			on_end_tag,
			on_content,
			set_next
		end


create
	make_null,
	set_next

feature {NONE} -- Initialization

	set_next (a_next: like next)
			-- Set `next' to `a_next'.
		do
			create prefixes.make (5)
			create local_parts.make (10)
			Precursor (a_next)
		end

feature -- Document

	on_start
			-- Initialize.
		do
			prefixes.wipe_out
			local_parts.wipe_out
			Precursor
		end

	on_finish
		do
			if local_parts.count > 0 then
				report_end_tag_mismatch_error (prefixes.item, local_parts.item)
			end
			prefixes.wipe_out
			local_parts.wipe_out
			Precursor
		end

feature -- Tag

	on_start_tag (a_namespace: detachable READABLE_STRING_32; a_prefix: detachable READABLE_STRING_32; a_local_part: READABLE_STRING_32)
			-- Start of start tag.
		do
			prefixes.force (a_prefix)
			local_parts.force (a_local_part)
			Precursor (a_namespace, a_prefix, a_local_part)
		end

	on_end_tag (a_namespace: detachable READABLE_STRING_32; a_prefix: detachable READABLE_STRING_32; a_local_part: READABLE_STRING_32)
			-- End tag.
		local
			l_prefixes: like prefixes
			l_local_parts: like local_parts
		do
			l_prefixes := prefixes
			l_local_parts := local_parts
			check same_count: l_prefixes.count = l_local_parts.count end
			if l_prefixes.count > 0 then
				if
					not (l_prefixes.item = a_prefix
					or else (
							(a_prefix /= Void and attached l_prefixes.item as l_prefix_item) and then
							a_prefix.same_string (l_prefix_item)
							)
					)
					or not a_local_part.same_string (l_local_parts.item)
				then
					report_end_tag_mismatch_error (l_prefixes.item, l_local_parts.item)
				end
				l_prefixes.remove
				local_parts.remove
			else
				report_extra_end_tag_error (a_prefix, a_local_part)
			end
			Precursor (a_namespace, a_prefix, a_local_part)
		end

feature {NONE} -- Content

	on_content (a_content: READABLE_STRING_32)
			-- Forward content.
		do
			if prefixes.is_empty and local_parts.is_empty then
				if not is_blank_string (a_content) then
					report_character_data_not_allowed_outside_element (a_content)
				end
			end
			Precursor (a_content)
		end

	is_blank_string (s: READABLE_STRING_32): BOOLEAN
			-- Is string `s' composed only by space/blank characters?
			-- i.e: ' ', '%T', '%N', '%R'
			-- According to XML specification, space is one of
			-- x20 | #x9 | #xD | #xA
			-- i.e. space, tab, CR, LF.
		local
			i, n: INTEGER
		do
			from
				Result := True
				i := 1
				n := s.count
			until
				i > n or not Result
			loop
				inspect s.code (i)
				when 0x20, -- space
					 0x9,  -- tab
					 0xD,  -- CR
					 0xA   -- LF
				then
					-- is_space
				else
					Result := False
				end
				i := i + 1
			end
		end

feature {NONE} -- Mean version of STACK [PREFIX+NAME]

	prefixes: ARRAYED_STACK [detachable READABLE_STRING_32]
	local_parts: ARRAYED_STACK [READABLE_STRING_32]

feature {NONE} -- Errors

	report_custom_error (a_error_msg: READABLE_STRING_32; a_data: detachable READABLE_STRING_32)
			-- Report custom error message `a_error_msg'
		local
			s: STRING_32
			err: READABLE_STRING_32
		do
			if a_data /= Void then
				create s.make_empty
				s.resize (a_error_msg.count + a_data.count + 4)
				s.append (a_error_msg)
				s.append ({STRING_32} ": %"")
				s.append (a_data)
				s.append ({STRING_32} "%"")
				err := a_error_msg
			else
				err := a_error_msg
			end
			if attached associated_parser as p then
				p.report_error_from_callback (err)
			else
				on_error (err)
			end
		end

	report_error (a_error_msg: READABLE_STRING_32; a_prefix: detachable READABLE_STRING_32; a_local: READABLE_STRING_32)
			-- Report `a_error_msg' error with details	
		local
			s: STRING_32
		do
			create s.make (a_local.count)
			s.append (a_local)
			if a_prefix /= Void then
				s.prepend_character (':')
				s.prepend (a_prefix)
			end
			report_custom_error (a_error_msg, s)
		end

	report_end_tag_mismatch_error (a_prefix: detachable READABLE_STRING_32; a_local: READABLE_STRING_32)
			-- Report `End_tag_mismatch_error' error with details
		do
			report_error (End_tag_mismatch_error, a_prefix, a_local)
		end

	report_extra_end_tag_error (a_prefix: detachable READABLE_STRING_32; a_local: READABLE_STRING_32)
			-- Report `End_tag_mismatch_error' error with details
		do
			report_error (Extra_end_tag_error, a_prefix, a_local)
		end

	report_character_data_not_allowed_outside_element (a_content: READABLE_STRING_32)
			-- Report `Character_data_not_allowed_outside_element_error' error with details
		do
			report_custom_error (Character_data_not_allowed_outside_element_error, a_content)
		end

	End_tag_mismatch_error: STRING_32 = "End tag does not match start tag"
	Extra_end_tag_error: STRING_32 = "End tag without start tag"
	Character_data_not_allowed_outside_element_error: STRING_32 = "Character data is not allowed without wrapping it in a container element"
			-- Error messages

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
