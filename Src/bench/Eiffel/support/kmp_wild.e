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
		rename
			make as kmp_make
		redefine
			found_at,
			set_pattern,
			search_for_pattern
		end

creation
	make, make_empty

feature {NONE} -- Initialization

	make (new_pattern, new_text: STRING) is
			-- Create a matcher to search pattern
			-- `new_pattern' in text `new_text'.
		require
			new_pattern_non_void: new_pattern /= Void;
			not_new_pattern_empty: not new_pattern.empty;
			new_text_non_void: new_text /= Void;
			not_new_text_empty: not new_text.empty
		do
			character_representation := '?';
			string_representation := '*'
			kmp_make (new_pattern, new_text);
		ensure
			pattern_is_new_pattern: pattern = new_pattern;
			text_is_new_text: text = new_text
		end;

feature -- Status setting

	set_pattern (new_pattern: STRING) is
			-- Set the `pattern' to `new_pattern'.
		do
			pattern := new_pattern;
			init_list
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

feature -- Search

	search_for_pattern: BOOLEAN is
			-- Search in the text to find the very next
			-- occurrence of `pattern'.
		local
			ls: LIST [STRING];
			lsi: STRING;
			fa, lp, i, tc, pc, tcmpc: INTEGER;
			sr, cr: STRING;
			real_end: BOOLEAN
			kmp_matcher: KMP_MATCHER
			str_without_wild: STRING
		do
			found := false;
			!! sr.make (0);
			sr.extend (string_representation);
			!! cr.make (0);
			cr.extend (character_representation);
			i := index;
			tc := text.count;
			pc := pattern.count;
			tcmpc := tc - pc;
			if tcmpc = -1 and then pattern.item (pc) = string_representation then
				found := text.is_equal (pattern.substring (1, tc))
			end;

			!! kmp_matcher.make (pattern,text)

			str_without_wild := clone (pattern)
			str_without_wild.prune_all (string_representation)
	
			if str_without_wild.count > text.count then
				found := False
			else
				from
					ls := string_list;
					ls.start;
					found := true;
					fa := -1
					real_end := False
				until
					real_end
				loop
					lsi := ls.item;
					if lsi.is_equal (sr) then
						ls.forth
					elseif lsi.is_equal (cr) then
						if fa = -1 then
							fa := i + 1
						end;
						i := i + 1;
						index := i
						ls.forth;
					else
						kmp_matcher.set_pattern (lsi);
						index := i;
						found := kmp_matcher.search_for_pattern
						i := index;
						if fa = -1 then
							fa := i - lsi.count + 1
						end;
						ls.forth
					end
					real_end := ls.after or else not found
				end
			end

			if found then
				found_at := fa
				Result := found
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
				!! sr.make (0);
				sr.extend (string_representation);
				!! cr.make (0);
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

feature {NONE} -- Attributes

	string_list: LINKED_LIST [STRING]
			-- List of strings
			--| Parts not containing `string_representation' and
			--| `character_representation' are held as items.

invariant

	different_character_and_string_representation: string_representation /= character_representation

end -- class KMP_WILD
