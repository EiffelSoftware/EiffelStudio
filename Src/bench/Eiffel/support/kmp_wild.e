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
			search_for_pattern as kmp_search,
			set_pattern as kmp_set_pattern,
			make as kmp_make
		redefine
			found_at
		end

	KMP_MATCHER
		rename
			search_for_pattern as kmp_search,
			make as kmp_make
		redefine
			found_at,
			set_pattern
		select
			set_pattern
		end

creation
	make, make_empty

feature -- Initialization

	make (new_pattern, new_text: STRING) is
			-- Create a matcher to search pattern
			-- `new_pattern' in text `new_text'.
		require
			new_pattern_non_void: new_pattern /= Void;
			not_new_pattern_empty: not new_pattern.empty;
			new_text_non_void: new_text /= Void;
			not_new_text_empty: not new_text.empty
		do
			kmp_make (new_pattern, new_text);
			char_rep := Void;
			str_rep := Void
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
			new_str_rep_non_void: new_str_rep /= Void
		do
			str_rep := new_str_rep
		ensure
			string_representation_is_new_str_rep: string_representation = new_str_rep
		end;

	set_character_representation (new_char_rep: CHARACTER) is
			-- Set `character_representation' to
			-- `new_char_rep'.
		require
			new_char_rep_non_void: new_char_rep /= Void
		do
			char_rep := new_char_rep
		ensure
			character_representation_is_new_char_rep: character_representation = new_char_rep
		end;

feature -- Status report

	found_at: INTEGER
		-- Index in `text' where `pattern' was found.
		
	character_representation: CHARACTER is
			-- The character that represents any single
			-- character in `text'. Default: '?'
		do
			if char_rep = Void then
				Result := '?'
			else
				Result := char_rep
			end
		end;

	string_representation: CHARACTER is
			-- The character that represents any string
			-- in `text'. Default: '*'
		do
			if str_rep = Void then
				Result := '*'
			else
				Result := str_rep
			end;
		end;

feature -- Search

	search_for_pattern is
			-- Search in the text to find the very next
			-- occurrence of `pattern'.
		local
			ls: LIST [STRING];
			lsi: STRING;
			fa, lp, i, tc, pc, tcmpc: INTEGER;
			sr, cr: STRING;
			ta: SPECIAL [CHARACTER]
		do
			from
				found := false;
				!! sr.make (0);
				sr.extend (str_rep);
				!! cr.make (0);
				cr.extend (char_rep);
				i := index;
				tc := text.count;
				pc := pattern.count;
				tcmpc := tc - pc;
				ta := text.area
			until
				found or else i >= tcmpc
			loop
				from
					ls := string_list;
					ls.start;
					found := true;
					fa := -1
				until
					not found or else ls.after
				loop
					lsi := ls.item;
					if lsi.is_equal (sr) then
						ls.forth
					elseif lsi.is_equal (cr) then
						lp := i;
						if fa = -1 then
							fa := i + 1
						end;
						i := i + 1;
						ls.forth;
						check_word (ta, lsi.area, i, lsi.count);
						i := index;
						if not found then
							i := lp
						end;
						ls.forth
					else
						kmp_set_pattern (lsi);
						index := i;
						kmp_search;
						i := index;
						if fa = -1 then
							fa := i - lsi.count + 1
						end;
						ls.forth
					end
				end
			end;
			if found then
				found_at := fa
			end
		end;

feature {NONE} -- Implementation

	init_list is
			-- Initializes the list for the wild carded
			-- pattern.
		local
			str: STRING;
			i, pc: INTEGER;
			pa: SPECIAL [CHARACTER];
			sl: LINKED_LIST [STRING];
			sr, cr: STRING
		do
			from
				!! string_list.make;
				!! str.make (0);
				!! sr.make (0);
				sr.extend (str_rep);
				!! cr.make (0);
				cr.extend (char_rep);
				pa := pattern.area;
				i := 0;
				pc := pattern.count;
				sl := string_list
			until
				i = pc
			loop
				if pa.item (i).is_equal (str_rep) then
					sl.extend (str);
					sl.extend (sr);
					!! str.make (0);
					i := i + 1
				elseif pa.item (i).is_equal (char_rep) then
					sl.extend (str);
					sl.extend (cr);
					!! str.make (0);
					i := i + 1
				else
					str.extend (pa.item (i));
					i := i + 1
				end
			end;
			if str.count > 0 then
				sl.extend (str)
			end
		end;
	
	check_word (t, p: SPECIAL [CHARACTER]; i, pc: INTEGER) is
			-- Checks whether `p' with length `pc'
			-- is in `t' starting at `i'.
		local
			j, n: INTEGER
		do
			from
				n := i;
				j := 0
			until
				j = pc or else t.item (n) /= p.item (j)
			loop
				j := j + 1;
				n := n + 1
			end
			index := n;
			if j = pc then
				found := true
			else
				found := false
			end
		end;

feature {NONE} -- Attributes

	string_list: LINKED_LIST [STRING]

	char_rep: CHARACTER
			-- The character that represents any single
			-- character in `text'.

	str_rep: CHARACTER
			-- The character that represents any string
			-- in `text'.

end -- class KMP_WILD

--|----------------------------------------------------------------
--| EiffelBase: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1986, 1990, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------
