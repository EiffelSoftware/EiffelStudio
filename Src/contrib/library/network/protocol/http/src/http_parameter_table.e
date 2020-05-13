note
	description: "[
			Table representing parameters of the form  q=1.0;note="blabla";foo=bar
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	HTTP_PARAMETER_TABLE

inherit
	STRING_TABLE [READABLE_STRING_8]
		redefine
			empty_duplicate
		end

create
	make,
	make_from_string,
	make_from_substring

feature {NONE} -- Initialization

	make_from_string (s: READABLE_STRING_8)
			-- Build table of parameters for `s'
		do
			make_from_substring (s, 1, s.count)
		end

	make_from_substring (s: READABLE_STRING_8; a_start_index: INTEGER; a_end_index: INTEGER)
			-- Build table of parameters for `s.substring (a_start_index, a_end_index)'
		local
			cl: CELL [INTEGER]
			i: INTEGER
		do
			make (1)
			from
				i := a_start_index
				create cl.put (i)
			until
				i >= a_end_index
			loop
				force_substring (s, i, cl)
				i := cl.item
			end
		end

feature -- Status report

	has_error: BOOLEAN
			-- Current has error?
			--| Mainly in relation with `make_from_string' and `force_substring'

feature {NONE} -- Implementation

	force_substring (s: READABLE_STRING_8; start_index: INTEGER; out_end_index: CELL [INTEGER])
			-- Add parameter from string   "  attribute=value  "
			-- and put in `out_end_index' the index after found parameter.
		local
			n: INTEGER
			pn: READABLE_STRING_8
			pv: STRING_8
			i: INTEGER
			p, q: INTEGER
			err: BOOLEAN
		do
			n := s.count
				-- Skip spaces
			from
				i := start_index
			until
				i > n or not s[i].is_space
			loop
				i := i + 1
			end
			if s[i] = ';' then
					-- empty parameter
				out_end_index.replace (i + 1)
			elseif i < n then
				p := s.index_of ('=', i)
				if p > 0 then
					pn := s.substring (i, p - 1)
					if p >= n then
						pv := ""
						out_end_index.replace (n + 1)
					else
						if s[p+1] = '%"' then
							q := s.index_of ('%"', p + 2)
							if q > 0 then
								pv := s.substring (p + 2, q - 1).to_string_8
								from
									i := q + 1
								until
									i > n or not s[i].is_space
								loop
									i := i + 1
								end
								if s[i] = ';' then
									i := i + 1
								end
								out_end_index.replace (i)
							else
								err := True
								pv := ""
								-- missing closing double quote.								
							end
						else
							q := s.index_of (';', p + 1)
							if q = 0 then
								q := n + 1
							end
							pv := s.substring (p + 1, q - 1).to_string_8
							out_end_index.replace (q + 1)
						end
						pv.right_adjust
						if not err then
							force (pv, pn)
						end
					end
				else
					-- expecting: attribute "=" value
					err := True
				end
			end
			if err then
				out_end_index.replace (n + 1)
			end
			has_error := has_error or err
		ensure
			entry_processed: out_end_index.item > start_index
		end

feature {NONE} -- Duplication

	empty_duplicate (n: INTEGER): like Current
			-- Create an empty copy of Current that can accommodate `n' items
		do
			Result := Precursor (n)
		end

note
	copyright: "2011-2020, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
