note
	description: "Summary description for {WSF_FORMAT_UTILITY }."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_FORMAT_UTILITY

feature -- Access

	accepted_content_types (req: WSF_REQUEST): detachable ARRAYED_LIST [STRING_8]
		local
			s: STRING_8
			q,rs: READABLE_STRING_8
			p: INTEGER
			lst: LIST [READABLE_STRING_8]
			qs: QUICK_SORTER [READABLE_STRING_8]
		do
--TEST		if attached ("text/html,application/xhtml+xml;q=0.6,application/xml;q=0.2,text/plain;q=0.5,*/*;q=0.8") as l_accept then
			if attached req.http_accept as l_accept then
				lst := l_accept.split (',')
				create Result.make (lst.count)
				from
					lst.start
				until
					lst.after
				loop
					rs := lst.item
					p := rs.substring_index (";q=", 1)
					if p > 0 then
						q := rs.substring (p + 3, rs.count)
						rs := rs.substring (1, p - 1)
					else
						q := "1.0"
					end
					create s.make_from_string (q)
					s.append_character (':')
					s.append (rs)
					Result.force (s)

					lst.forth
				end
				create qs.make (create {COMPARABLE_COMPARATOR [READABLE_STRING_8]})
				qs.reverse_sort (Result)
				from
					Result.start
				until
					Result.after
				loop
					s := Result.item
					p := s.index_of (':', 1)
					if p > 0 then
						s.remove_head (p)
					else
						check should_have_colon: False end
					end
					Result.forth
				end
			end
		end

feature {NONE} -- Implementation

	string_in_array (arr: ARRAY [STRING]; s: STRING): BOOLEAN
			-- Is `s' in array `arr' ?
			--| using `{STRING}.same_string (..)'
		local
			i,n: INTEGER
		do
			from
				i := arr.lower
				n := arr.upper
			until
				i > n or Result
			loop
				Result := s.same_string (arr[i])
				i := i + 1
			end
		end

note
	copyright: "2011-2020, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Colin Adams, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
