note
	description: "Summary description for {WIKI_HELPER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WIKI_HELPER

feature -- Query

	index_of_end_of_line (s: STRING; i: INTEGER): INTEGER
			-- Return the index of the end of line from `i'
		require
			s_attached: s /= Void
		local
			p: INTEGER
		do
			p := s.index_of ('%N', i)
			if p > 0 then
				check p >= i end
				Result := p -1
			else
				Result := s.count
			end
		end

	current_line (s: STRING; i: INTEGER): STRING
			-- Return the line from `i' to end of line
		require
			s_attached: s /= Void
		do
			Result := s.substring (i, index_of_end_of_line (s, i))
		end

	is_blank_string (s: STRING_GENERAL): BOOLEAN
			-- Is blank string?
		require
			s_attached: s /= Void
		local
			i, n: INTEGER
		do
			from
				i := 1
				n := s.count
				Result := True
			until
				i > n or not Result
			loop
				inspect s.code (i).to_character_8
				when ' ', '%T', '%N' then
					--| Still space
				else
					Result := False
				end
				i := i + 1
			end
		end

	is_valid_wiki_name (s: STRING): BOOLEAN
		local
			i,n: INTEGER
		do
			Result := True
			from
				i := 1
				n := s.count
			until
				i > n or not Result
			loop
				Result := is_valid_wiki_name_character (s[i])
			end
		end

	is_valid_wiki_name_character (c: CHARACTER): BOOLEAN
		do
			Result := True
			inspect c
			when 'a'..'z' then
			when 'A'..'Z' then
			when '0'..'9' then
			when '_', ' ' then
			when '[', ']', '|' then
				Result := False
			when ':' then -- [[Image:foo|bar]]
			when '#' then
				Result := True --|Used to indicate section
			else
--				Result := False				
			end
		end

feature -- wiki string

	wiki_string (s: STRING): WIKI_STRING
		require
			s_attached: s /= Void
		do
			create Result.make (s)
		end

	wiki_raw_string (s: STRING): WIKI_RAW_STRING
		require
			s_attached: s /= Void
		do
			create Result.make (s)
		end

feature -- String manipulation

	next_following_character_matched (s: STRING; p: INTEGER; a_string: STRING; a_case_sensitive: BOOLEAN): BOOLEAN
		local
			i,n: INTEGER
		do
			from
				Result := True
				i := 1
				n := p + a_string.count
			until
				not Result or i + p > n
			loop
				if a_case_sensitive then
					Result := s[i + p - 1] = a_string [i]
				else
					Result := s[i + p - 1].as_lower = a_string [i].as_lower
				end
				i := i + 1
			end
		end

	safe_character (s: STRING; p: INTEGER): CHARACTER
		do
			if s.valid_index (p) then
				Result := s.item (p)
			end
		end

	safe_following_character_count (s: STRING; p: INTEGER; a_char_token: CHARACTER): INTEGER
		local
			i, n: INTEGER
			c: CHARACTER
		do
			if s.valid_index (p) then
				from
					n := s.count
					i := p
					c := s.item (i)
				until
					i > n or c /= a_char_token
				loop
					c := s.item (i)
					i := i + 1
				end
				Result := i - p - 1
			end
		end

note
	copyright: "2011-2014, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end
