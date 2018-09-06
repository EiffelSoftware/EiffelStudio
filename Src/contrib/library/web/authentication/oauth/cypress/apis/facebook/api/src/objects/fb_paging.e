note
	description: "Summary description for {FB_PAGING}."
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Paging", "src=https://developers.facebook.com/docs/graph-api/using-graph-api/#paging", "protocol=uri"
class
	FB_PAGING


feature -- Access

	cursor_before: detachable STRING
			-- This is the cursor that points to the start of the page of data that has been returned.

	cursor_after: detachable STRING
			-- This is the cursor that points to the end of the page of data that has been returned.

	next: detachable STRING_8
			-- The Graph API endpoint that will return the next page of data.
			-- If not included, this is the last page of data.
			-- Due to how pagination works with visibility and privacy, it is possible that a page may be empty but contain a 'next' paging link.
			-- Stop paging when the 'next' link no longer appears.

	previous: detachable STRING_8
			-- The Graph API endpoint that will return the previous page of data. If not included, this is the first page of data.

feature -- Element Change

	set_cursor_before (a_before: like cursor_before)
			-- Set `cursor_before' with `a_before'.
		do
			cursor_before := a_before
		ensure
			cursor_before_set: cursor_before = a_before
		end

	set_cursor_after (a_after: like cursor_after)
			-- Set `cursor_after' with `a_after'.
		do
			cursor_after := a_after
		ensure
			cursor_after_set: cursor_after = a_after
		end

	set_next (a_next: like next)
			-- Set `next' with `a_next'.
		do
			next := a_next
		ensure
			next_set: next = a_next
		end

	set_previous (a_prev: like previous)
			-- Set `previous' with `a_prev'.
		do
			previous := a_prev
		ensure
			previous_set: previous = a_prev
		end

feature -- Status Report

	basic_out: STRING
		local
			n: STRING
		do
			create n.make_from_string ("PAGING: ")

			if attached cursor_after as l_after then
				n.append_string ( "%N cursor_after (" + l_after)
				n.append_string (")")
				n.append ("%N")
			end
			if attached cursor_before as l_before then
				n.append_string ( " cursor_before (" + l_before)
				n.append_string (")")
				n.append ("%N")
			end
			if attached next as l_next then
				n.append_string ( " next (" + l_next)
				n.append_string (")")
				n.append ("%N")
			end
			if attached previous as l_previous then
				n.append_string ( " previous (" + l_previous)
				n.append_string (")")
				n.append ("%N")
			end
			Result := n
		end
end
