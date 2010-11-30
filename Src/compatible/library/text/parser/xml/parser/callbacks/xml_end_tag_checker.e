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
			set_next
		end


create
	make_null,
	set_next

feature {NONE} -- Initialization

	set_next (a_next: like next)
			-- Set `next' to `a_next'.
		do
			create {ARRAYED_STACK [STRING]} prefixes.make (5)
			create {ARRAYED_STACK [STRING]} local_parts.make (10)
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

	on_start_tag (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING)
			-- Start of start tag.
		do
			prefixes.force (a_prefix)
			local_parts.force (a_local_part)
			Precursor (a_namespace, a_prefix, a_local_part)
		end

	on_end_tag (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING)
			-- End tag.
		local
			l_prefixes: like prefixes
		do
			l_prefixes := prefixes
			if l_prefixes.count >= 0 then
				if
					not (l_prefixes.item = a_prefix
						or else (
									(a_prefix /= Void and attached l_prefixes.item as l_prefix_item) and then
									a_prefix.same_string_general (l_prefix_item)
								)
						)
					or not a_local_part.same_string_general (local_parts.item)
				then
					report_end_tag_mismatch_error (l_prefixes.item, local_parts.item)
				end
				l_prefixes.remove
				local_parts.remove
			else
				report_extra_end_tag_error (l_prefixes.item, local_parts.item)
			end
			Precursor (a_namespace, a_prefix, a_local_part)
		end

feature {NONE} -- Mean version of STACK [PREFIX+NAME]

	prefixes: STACK [STRING]
	local_parts: STACK [STRING]

feature {NONE} -- Errors

	report_error (a_error_msg: STRING; a_prefix: detachable STRING; a_local: STRING)
			-- Report `a_error_msg' error with details	
		local
			s: STRING
		do
			create s.make_from_string (a_local)
			if a_prefix /= Void then
				s.prepend_character (':')
				s.prepend (a_prefix)
			end
			s := a_error_msg + ": %"" + s + "%""
			if attached associated_parser as p then
				p.report_error_from_callback (s)
			else
				on_error (s)
			end
		end

	report_end_tag_mismatch_error (a_prefix: detachable STRING; a_local: STRING)
			-- Report `End_tag_mismatch_error' error with details
		do
			report_error (End_tag_mismatch_error, a_prefix, a_local)
		end

	report_extra_end_tag_error (a_prefix: detachable STRING; a_local: STRING)
			-- Report `End_tag_mismatch_error' error with details
		do
			report_error (Extra_end_tag_error, a_prefix, a_local)
		end

	End_tag_mismatch_error: STRING = "End tag does not match start tag"
	Extra_end_tag_error: STRING = "End tag without start tag"
			-- Error messages

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
