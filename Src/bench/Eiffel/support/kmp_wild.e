indexing

	description:	"Pattern match algorithm to match a pattern%
			% containing wild cards.%
			% Done through the Knuth, Morris, Pratt%
			% algorithm.";
	status:		"See notice at end of class";
	date:		"$Date$";
	revision:	"$Revision$"

class KMP_WILD

inherit
	KMP_MATCHER
		redefine
			make,
			make_empty,
			found_at,
			set_pattern,
			search_for_pattern,
			found_pattern_length,
			find_matching_indices,
			lengths
		end

creation
	make, make_empty

feature {NONE} -- Initialization

	make (new_pattern, new_text: STRING) is
			-- Create a matcher to search pattern
			-- `new_pattern' in text `new_text'.
		do
			character_representation := '?';
			string_representation := '*'
			Precursor {KMP_MATCHER} (new_pattern, new_text);
		end

	make_empty is
			-- Create a matcher to search for a pattern
			-- in a text. Initialize it later.
		do
			character_representation := '?'
			string_representation := '*'
			Precursor {KMP_MATCHER}
		end

feature -- Access

	found_pattern_length: INTEGER
			-- length of the found pattern in text


	lengths: ARRAYED_LIST [INTEGER]
			-- lengths of found patterns in text


feature -- Status setting

	set_pattern (new_pattern: STRING) is
			-- Set the `pattern' to `new_pattern'.
		do
			pattern := new_pattern;
		end;

	set_string_representation (new_str_rep: CHARACTER) is
			-- Set `string_representation' to
			-- `new_str_rep'.
		require
			new_str_rep_not_nul_char: new_str_rep /= '%U';
			new_str_rep_different: new_str_rep /= character_representation
		do
			string_representation := new_str_rep
		ensure
			string_representation_is_new_str_rep: string_representation = new_str_rep
		end;

	set_character_representation (new_char_rep: CHARACTER) is
			-- Set `character_representation' to
			-- `new_char_rep'.
		require
			new_char_rep_not_nul_char: new_char_rep /= '%U';
			new_char_rep_different: new_char_rep /= string_representation
		do
			character_representation := new_char_rep
		ensure
			character_representation_is_new_char_rep: character_representation = new_char_rep
		end;

feature -- Status report

	found_at: INTEGER;
		-- Index in `text' where `pattern' was found.

	character_representation: CHARACTER;
			-- The character that represents any single
			-- character in `text'
			--|Default: '?'

	string_representation: CHARACTER
			-- The character that represents any string
			-- in `text'
			--| Default: '*'

	has_wild_cards: BOOLEAN is
			-- Has Current either of `string_representation' or
			-- `character_representation'?
		require
			pattern_set: pattern /= Void
		do
			Result := pattern.has (string_representation) or else
				  pattern.has (character_representation);
		end

feature -- Search

	pattern_matches: BOOLEAN is
			-- does `text' exactly match `pattern' ?
		local
			lsi, for_test: STRING;
			as_star: BOOLEAN
			offset: INTEGER
		do
			if
				search_for_pattern
					and then
				(found_at = 1 or else pattern @ 1 = string_representation)				
			then
				from
					string_list.finish
					offset := text.count
					Result := True
				until
					string_list.before or as_star or not Result
				loop
					lsi := string_list.item
					if lsi.is_equal (string_representation.out) then
						as_star := True
					elseif lsi.is_equal (character_representation.out) then
						offset := offset - 1
					else
						for_test := text.substring (offset - lsi.count + 1, offset)
						Result := for_test.is_equal (lsi)
						offset := offset - lsi.count
					end
					string_list.back	
				end
				if not as_star then
					Result := found_pattern_length = text.count
				end
			end
		end

	search_for_pattern: BOOLEAN is
			-- Search in the text to find the very next
			-- occurrence of `pattern'.
		local
			ls: LIST [STRING];
			lsi: STRING;
			fa, i, tc, pc, tcmpc, i_before_loop: INTEGER;
			sr, cr: STRING;
			kmp_matcher: KMP_MATCHER
			str_without_wild: STRING
			is_star: BOOLEAN
			old_pattern, old_text: STRING
		do
			if is_not_case_sensitive then
				old_text := text
				old_pattern := pattern
				pattern := pattern.out
				pattern.to_lower
				text := text.out
				text.to_lower
			end
			init_list
			!! sr.make (1);
			sr.extend (string_representation);
			!! cr.make (1);
			cr.extend (character_representation);
			tc := text.count;
			pc := pattern.count;
			tcmpc := tc - pc;
			if tcmpc = -1 and then pattern.item (pc) = string_representation then
				Result := text.is_equal (pattern.substring (1, tc))
				if Result then
					fa := 1
				end
			end;

			!! kmp_matcher.make (pattern, text)

			str_without_wild := clone (pattern)
			str_without_wild.prune_all (string_representation)
	
			if str_without_wild.count > text.count then
				Result := False
			else
				from
					i_before_loop := index - 1
				until
					Result or else i_before_loop >= tc
				loop
					i := i_before_loop + 1
					i_before_loop := i
					from
						ls := string_list
						ls.start
						Result := True
						fa := -1
					until
						not Result or ls.after
					loop
						lsi := ls.item;
						if lsi.is_equal (sr) then
							ls.forth
							is_star := True
						elseif lsi.is_equal (cr) then
							if fa = -1 then
								fa := i
							end;
							i := i + 1;
							index := i
							ls.forth;
						else
							if i > tc then
								Result := False
							else
								kmp_matcher.set_pattern (lsi);
								kmp_matcher.start_at (i)
								Result := kmp_matcher.search_for_pattern and then
									(not is_star implies kmp_matcher.found_at = i)
								if Result then
									i := kmp_matcher.found_at + lsi.count
									if fa = - 1 then
										fa := kmp_matcher.found_at
									end
								end
							end
							is_star := False
							ls.forth
						end
						--Result := Result and then (not ls.after or else (is_star or i > tc))
						Result := Result and then ((i <= tc + 1) or else ls.after)
					end
				end
			end

			if Result then
				found_pattern_length := i - fa
				found_at := fa
				index := i
			end
			found := Result
			if is_not_case_sensitive then
				text := old_text
				pattern := old_pattern
			end
		end

	find_matching_indices is
			-- All indices in `text' which matches the
			-- very next occurence of `pattern'.
		local
			ls: LIST [STRING]
			lsi: STRING;
			fa, i, tc, pc, tcmpc: INTEGER;
			sr, cr: STRING;
			found_one: BOOLEAN
			kmp_matcher: KMP_MATCHER
			str_without_wild: STRING
			is_star: BOOLEAN
			offset, next_i: INTEGER
			old_pattern, old_text: STRING
		do
			if is_not_case_sensitive then
				old_text := text
				old_pattern := pattern
				pattern := pattern.out
				pattern.to_lower
				text := text.out
				text.to_lower
			end
			init_list
			create {ARRAYED_LIST [INTEGER]} matching_indices.make (10)
			create {ARRAYED_LIST [INTEGER]} lengths.make (10)
			create sr.make (1);
			sr.extend (string_representation);
			create cr.make (1);
			cr.extend (character_representation);
			tc := text.count;
			pc := pattern.count
			tcmpc := tc - pc
			create kmp_matcher.make (pattern, text)
			str_without_wild := clone (pattern)
			str_without_wild.prune_all (string_representation)
			if str_without_wild.count <= text.count then
				from
					i := index
				until
					i > tc
				loop
					from
						found_one := False
					until
						found_one or else i > tc
					loop
						from
							ls := string_list
							ls.start
							found_one := True
							fa := -1
							offset := 0
						until
							not found_one or ls.after
						loop
							lsi := ls.item;
							if lsi.is_equal (sr) then
								ls.forth
								is_star := True
							elseif lsi.is_equal (cr) then
								if fa = -1 then
									fa := i
								end;
								i := i + 1
								offset := offset + 1
								index := i
								ls.forth;
							else
								if i > tc then
									found_one := False
									next_i := tc + 1
								else
									kmp_matcher.set_pattern (lsi)
									kmp_matcher.start_at (i)
									if kmp_matcher.search_for_pattern then
										found_one := (not is_star implies kmp_matcher.found_at = i)
										if found_one then
											i := kmp_matcher.found_at + lsi.count
											if fa = - 1 then
												fa := kmp_matcher.found_at
											end
											offset := offset + lsi.count
										else
											next_i := kmp_matcher.found_at - offset
											offset := 0
										end
									else
										found_one := False
										next_i := tc + 1
										offset := 0
									end
								end
								is_star := False
								ls.forth
							end
							--found_one := found_one and then (not ls.after or else (is_star or i > tc))
							found_one := found_one and then (i <= tc + 1 or else ls.after) 
						end
						if found_one then
							matching_indices.extend (fa)
							lengths.extend (i- fa)
							i := fa + 1
						else
							next_i := next_i - offset
							i := next_i
						end
					end
				end
			end
			if is_not_case_sensitive then
				text := old_text
				pattern := old_pattern
			end
		end

feature {NONE} -- Implementation

	init_list is
			-- Initializes the list for the wild carded
			-- pattern.
		local
			str: STRING;
			i, pc: INTEGER;
			pa: SPECIAL [CHARACTER];
			sr, cr: STRING
		do
			from
				!! string_list.make;
				!! str.make (0);
				!! sr.make (1);
				sr.extend (string_representation);
				!! cr.make (1);
				cr.extend (character_representation);
				pa := pattern.area;
				pc := pattern.count;
				i := 0;
			until
				i = pc
			loop
				if pa.item (i) = string_representation then
					if str.count > 0 then
						string_list.extend (str);
					end
					string_list.extend (sr);
					!! str.make (0);
				elseif pa.item (i) = character_representation then
					if str.count > 0 then
						string_list.extend (str);
					end
					string_list.extend (cr);
					!! str.make (0);
				else
					str.extend (pa.item (i));
				end
				i := i + 1
			end;
			if str.count > 0 then
				string_list.extend (str)
			end
		end;

	last_string_matches: BOOLEAN is
		local
			i: INTEGER
		do
			if string_list /= Void and then not string_list.is_empty then
				if string_list.last.is_equal (string_representation.out) then
					Result := True
				else
					from
						i := 0
						string_list.finish
					until
						string_list.before or else not string_list.item.is_equal (character_representation.out)
					loop
						i := i + 1
						string_list.back
					end
					if string_list.before or else string_list.item.is_equal (string_representation.out) then
						Result := True
					else
						Result := text.substring (text.count - string_list.item.count - i + 1, text.count - i).is_equal (string_list.item)	
					end
				end
 			end
		end

feature {NONE} -- Attributes

	string_list: LINKED_LIST [STRING]
			-- List of strings
			--| Parts not containing `string_representation' and
			--| `character_representation' are held as items.

invariant

	different_character_and_string_representation: string_representation /= character_representation

end -- class KMP_WILD

