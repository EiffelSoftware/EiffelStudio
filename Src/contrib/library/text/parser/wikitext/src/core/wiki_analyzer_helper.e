note
	description: "Summary description for {WIKI_ANALYZER_HELPER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIKI_ANALYZER_HELPER

inherit
	WIKI_HELPER

feature -- Helpers	

	next_closing_link (s: READABLE_STRING_8; a_start: INTEGER): INTEGER
		local
			i,n: INTEGER
			v: INTEGER
		do
			from
				i := a_start
				n := s.count
			until
				Result > a_start or i > n
			loop
				inspect s[i]
				when '[' then
					if safe_character (s, i + 1) = '[' then
						v := v + 1
					end
				when ']' then
					if safe_character (s, i + 1) = ']' then
						if v = 0 then
							Result := i - 1
						else
							v := v - 1
						end
					end
				else
				end
				i := i + 1
			end
		end

	next_closing_template (s: READABLE_STRING_8; a_start: INTEGER): INTEGER
		local
			i,n: INTEGER
			v: INTEGER
		do
			from
				i := a_start
				n := s.count
			until
				Result > a_start or i > n
			loop
				inspect s[i]
				when '{' then
					if safe_character (s, i + 1) = '{' then
						v := v + 1
					end
				when '}' then
					if safe_character (s, i + 1) = '}' then
						if v = 0 then
							Result := i - 1
						else
							v := v - 1
						end
					end
				else
				end
				i := i + 1
			end
		end

	next_closing_table (s: READABLE_STRING_8; a_start: INTEGER): INTEGER
		local
			i,j,k,n: INTEGER
			v: INTEGER
		do
			from
				i := a_start
				n := s.count
			until
				Result > a_start or i > n
			loop
				inspect s[i]
				when '{' then
					if safe_character (s, i + 1) = '|' then
						v := v + 1
					end
				when '|' then
					if safe_character (s, i + 1) = '}' then
						if v = 0 then
							Result := i - 1
						else
							v := v - 1
						end
					end
				when '<' then
					j := next_end_of_tag_character (s, i + 1)
					if j > i and then attached tag_name_from (s.substring (i, j)) as l_tag_name then
						j := next_closing_tag (s, l_tag_name, j + 1)
						if j > i then
							i := j
						end
					end
				when '`' then
					if safe_character (s, i + 1) = '`' and then safe_character (s, i + 2) = '`' then
						j := s.substring_index ("```", i + 2)
						if j > 0 then
							i := j
						else
							i := i + 2
						end
					else
						j := s.index_of ('`', i + 1)
						if j > 0 then
							k := index_of_end_of_line (s, i + 1)
							if k = 0 or else j <= k then
								i := j
							end
						end
					end
				else
				end
				i := i + 1
			end
		end

	next_end_of_tag_character (s: READABLE_STRING_8; a_start: INTEGER): INTEGER
		local
			i,n: INTEGER
			v: INTEGER
		do
			from
				i := a_start
				n := s.count
			until
				Result > a_start or i > n
			loop
				inspect s[i]
				when '<' then
					v := v + 1
				when '>' then
					if v = 0 then
						Result := i
					else
						v := v - 1
					end
				else
				end
				i := i + 1
			end
		end

	next_closing_tag (s: READABLE_STRING_8; a_tag_name: READABLE_STRING_8; a_start: INTEGER): INTEGER
		do
			Result := s.substring_index ("</" + a_tag_name + ">", a_start)
		end

	new_wiki_link (s: READABLE_STRING_8; is_followed_by_new_line: BOOLEAN): WIKI_STRING_ITEM
			-- [[name|title]]
			-- [[Image:name|title]]
			-- [[:image:name|title]]
			-- [[Property:name|value]]
			-- [[file:name|value]]
			-- ..
		require
			s_not_empty: s.count > 0
			starts_with_double_bracket: s.starts_with ("[[")
			ends_with_double_bracket: s.ends_with ("]]")
		local
			n,b: INTEGER
			t: detachable READABLE_STRING_8
			l_inlined: BOOLEAN
			p,pp: INTEGER
		do
			n := s.count
			if n > 2 then
				if s[3] = ':' then
					l_inlined := True
					b := 3
					p := s.index_of (':', b + 1)
					if p > 0 then
						t := s.substring (b, p)
					end
				else
					b := 3
					p := s.index_of (':', 2)
					pp := s.index_of ('|', 2)
					if p > 0 and (pp = 0 or else p < pp) then
						t := s.substring (b, p)
					end
				end
			end
			if t = Void then
				create {WIKI_LINK} Result.make (s)
			elseif t.is_case_insensitive_equal ("image:") then
				if is_followed_by_new_line then
					create {WIKI_IMAGE_LINK} Result.make (s)
				else
					create {WIKI_IMAGE_LINK} Result.make_inlined (s)
				end
			elseif t.is_case_insensitive_equal ("file:") then
				create {WIKI_FILE_LINK} Result.make (s)
			elseif t.is_case_insensitive_equal (":category:") then
				create {WIKI_CATEGORY_LINK} Result.make (s)
			elseif t.is_case_insensitive_equal (":media:") then
				create {WIKI_MEDIA_LINK} Result.make (s)
			elseif t.is_case_insensitive_equal ("category:") then
					-- Not a link ... this categories the article !!!
					-- FIXME
				create {WIKI_PROPERTY} Result.make (s)
			elseif t.is_case_insensitive_equal ("property:") then
					-- Not a link ... this is a property !!!
				create {WIKI_PROPERTY} Result.make (s)
			else
					-- Unknown
				create {WIKI_LINK} Result.make (s)
			end
		end

feature {NONE} -- Implementation

	tag_name_from (s: READABLE_STRING_8): detachable STRING_8
			-- Valid tag name from  inside of <...>
			--| for instance ' abc def="geh"' will return abc
			--| if tagname has invalid character, return empty string.
		require
			starts_and_ends_with_tag_char: s.starts_with_general ("<") and then s.ends_with_general (">")
		local
			i,n: INTEGER
		do
			i := s.index_of (' ', 2)
			n := s.index_of ('%T', 2)
			if i = 0 then
				i := n
			elseif n /= 0 then
				i := i.min (n)
			end
			if i > 0 then
				create Result.make_from_string (s.substring (2, i - 1))
			else
				create Result.make_from_string (s.substring (2, s.count - 1))
			end
			Result.left_adjust
			Result.right_adjust
			if not Result.is_empty and then Result [Result.count] = '/' then
				Result.remove_tail (1)
				Result.right_adjust
			end
			if across Result as ic some not (ic.item.is_alpha_numeric or ic.item = ':' or ic.item = '_' or ic.item = '-') end then
					-- Bad tag name
				Result := Void
			end
		end

note
	copyright: "2011-2019, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end
