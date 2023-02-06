note
	description: "Summary description for {DEFAULT_CMS_TEMPLATE}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	DEFAULT_CMS_TEMPLATE

inherit
	CMS_TEMPLATE

feature {NONE} -- Implementation		

	apply_template_engine (s: STRING_8)
		local
			p,n: INTEGER
			k: STRING
			sv: detachable STRING
		do
			from
				n := s.count
				p := 1
			until
				p = 0
			loop
				p := s.index_of ('$', p)
				if p > 0 then
					k := next_identifier (s, p + 1)
					s.remove_substring (p, p + k.count)
					sv := Void
					if attached variables.item (k) as l_value then

						if attached {STRING_8} l_value as s8 then
							sv := s8
						elseif attached {STRING_32} l_value as s32 then
							sv := theme.html_encoded (s32)
						else
							sv := l_value.out
						end
						s.insert_string (sv, p)
						p := p + sv.count
					else
						debug
							s.insert_string ("$" + k, p)
						end
					end
				end
			end
		end

	next_identifier (s: STRING; a_index: INTEGER): STRING
		local
			i: INTEGER
		do
			from
				i := a_index
			until
				not (s[i].is_alpha_numeric or s[i] = '_' or s[i] = '.')
			loop
				i := i + 1
			end
			Result := s.substring (a_index, i - 1)
		end

note
	copyright: "2011-2023, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
