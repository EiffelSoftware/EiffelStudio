class MATCH

creation
	make 

feature

	make (t, p: STRING; must_check: BOOLEAN) is
			-- Set text to t and pattern to p
		require
			text_exist: t /= void;
			pattern_exist: t /= pattern;
		do
			text := t;
			pattern := p;
			position := 0;
			index := 0;
			must_check_borders := must_check;
		ensure
			text = t;
			pattern = p;
			before;
			index_before;
		end;
	
	pattern: STRING;
		-- Pattern to search in text

	text: STRING;
		-- Text where the search is performed	

	must_check_borders: BOOLEAN;
		-- Must check whether character before and after pattern
		-- are compatible with pattern

	position: INTEGER;
		-- position of pattern in text after last find

	start is
			-- next search start at the beginning of text
		do
			position := 0;
		end;

	finish is
			-- next search start from the end of text
		do
			position := text.count + 1;
		end;

	before: BOOLEAN  is
			-- nothing at left of current position in text
		do
			Result := position < 1;
		end;

	after: BOOLEAN  is
			-- nothing at right of current position in text
		do
			Result := position > text.count;
		end;

	go (p: INTEGER) is
			-- next search begin at position p in text
		do
			position := p
		end;

	forth is
		do
			if not after then
				position := position + 1;
			end;
		end;

	back is
		do
			if not before then
				position := position - 1
			end;
		end;

	find_next is
		-- Find first substring in text matching pattern after position
		-- position is set to the index of the first character
		-- of the substring or text.count + 1 if not found

		local
			last_start: INTEGER;
			pos: INTEGER;
		do
			from
				last_start := position;
				index := 1;
			until
				after or index_after and stop_token (position)
			loop
				position := last_start + 1;
				find_next_matching_first;
				last_start := position;
				match_forward;
			end;
			if index_after then
				position := last_start;
			end;
		end;	

	find_previous is
		-- Find last substring in text matching pattern before position
		-- postition is set to the index of the last character of the
		-- substring or 0 if not found

		local
			last_start: INTEGER;
			pos: INTEGER;
		do
			from
				pos := position;
				index := pattern.count;
			until
				before or index_before and stop_token (position + 1)
			loop
				position := last_start - 1;
				find_previous_matching_last;
				last_start := position;
				match_backward;
			end;
			if index_before then
				position := last_start;
			end;
		end;

feature {NONE}
	
	index: INTEGER;
		-- current position in pattern

	index_before: BOOLEAN is
			-- nothing at left of current index in pattern
		do
			Result := index = pattern.count;
		end;

	index_after: BOOLEAN is
			-- nothing at right of current index in pattern
		do
			Result := index = pattern.count + 1;
		end;
	
	find_next_matching_first is
			-- find next character in string matching first character
			-- of pattern. Check that it is preceded by an acceptable
			-- character
		local
			found: BOOLEAN;
		do
			from
				index := 1;
			until
				after or found
			loop				
				if matching_chars then
					found := stop_token (position);
					if not found then
						position := position + 1;
					end
				else
					position := position + 1;
				end;
			end;
		end;

	find_previous_matching_last is
			-- find previous character in string matching last character
			-- of pattern. Check that it is followed by an acceptable
			-- character
		local
			found: BOOLEAN;
		do
			from
				index := 1;
			until
				before or found
			loop
				if matching_chars then
					found := stop_token (position + 1);
					if not found then
						position := position - 1;
					end
				else
					position := position - 1
				end;
			end;
		end;
			
	match_forward is
			-- increment position and index as long as corresponding
			-- character in text and pattern match
		do
			from
			until
				after or index_after 
				or else not matching_chars
			loop
				position := position + 1;
				index := index + 1;
			end;
		ensure
			off_or_no_match: after or index_after 
				or else not matching_chars
		end;

	match_backward is 
			-- decrement position and pattern as long as corresponding
			-- character in text and pattern match
		do
			from
			until
				before or index_before
				or else not matching_chars
			loop
				position := position - 1;
				index := index - 1;
			end;
		end;

	stop_token (i: INTEGER): BOOLEAN is
		local
			c1: CHARACTER; c2: CHARACTER;
			c1_is_special, c2_is_special: BOOLEAN;
		do
			if not must_check_borders or  i = 1 or i > text.count then 
				Result := true
			else
				c1 := text @ i;
				c2 := text @ (i - 1);
				Result := Blanks.has(c1) or Blanks.has(c2);
				if not Result then
					c1_is_special := Specials.has(c1);
					c2_is_special := Specials.has(c2);
					Result := c1_is_special =  not c2_is_special;
							-- (= not) <=> (exlusive or)
							-- one and only one is true
				end
			end
		end;

	matching_chars: BOOLEAN is
			-- Do c1 and c2 match each other
		do
			Result := (text @ position).lower
				= (pattern @ index).lower;
		end;

	Specials: ARRAY [CHARACTER] is 
		once
			Result := << '-', ';', ',', ':', '.', '!', '=',
				'/', '>', '(', ')', '[', ']', '{', '}', '<', '%'', '?', 
				'"', '+', '$', '%%', '*' >> 
		end;
		
	Blanks: ARRAY [CHARACTER] is 
		once
			Result := << ' ', '%T' >>
		end;

invariant
	text_exists: text /= void;
	pattern_exists: pattern /= void;
	position_in_text_or_off: before or after 
			or position >= 1 and position <= text.count;
	index_in_text_or_off: index_before or index_after 
		or index >= 1 and index <= pattern.count

end
