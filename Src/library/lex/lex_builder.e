indexing

	description:
		"General mechanisms for building lexical analyzers";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class LEX_BUILDER inherit

	PDFA
		rename
			make as pdfa_make,
			item as pdfa_item,
			put as pdfa_put,
			wipe_out as pdfa_wipe_out,
			move as pdfa_move
		redefine
			dfa_set_final
		end

create

	make, make_extended

feature  -- Initialization

	make is
			-- Set up the analyzer.
		do
			last_character_code := Last_ascii;
			create tool_list.make;
			create tool_names.make
		ensure
			last_character_set: last_character_code = Last_ascii
		end;

	make_extended (char_code: INTEGER) is
			-- Set up the analyzer with `char_code' as 'last_character_code'.
		require
			valid_char_code: char_code > 0
		do
			last_character_code := char_code
			create tool_list.make;
			create tool_names.make
		ensure
			last_character_set: last_character_code = char_code
		end;

	initialize is
			-- Set up attributes of `analyzer'.
		do
			initialized := True;
			if analyzer = Void then
				create analyzer.make
			end;
			analyzer.initialize_attributes (dfa, categories_table,
					keyword_h_table, keywords_case_sensitive)
		ensure
			initialized
		end;

feature -- Access

	last_character_code: INTEGER;
			-- Last character code recognized by the language

	tool_list: LINKED_LIST [PDFA];
			-- Regular expressions used as auxiliary tools

	tool_names: LINKED_LIST [STRING];
			-- Names of regular expressions in tool list

	case_sensitive: BOOLEAN;
			-- Will future tools be case-sensitive?

	keywords_case_sensitive: BOOLEAN;
			-- Will future tools be case-sensitive for keywords?

	categories_table: ARRAY [INTEGER];
			-- Table of category numbers for each input

	keyword_h_table: HASH_TABLE [INTEGER, STRING];
			-- Keyword table

	error_list: ERROR_LIST is
			-- List of error messages
		once
			create Result.make
		end;

	analyzer: LEXICAL;
			-- The lexical analyzer built so far

	last_created_tool: INTEGER;
			-- Identification number of the last
			-- regular expression put in tool_list

	selected_tools: LINKED_LIST [INTEGER];
			-- Regular expressions included in the main one

	token_type_list: LINKED_LIST [INTEGER];
			-- Token types of the selected tools.
			-- Indexed by tool numbers.

	lexical_frozen: BOOLEAN;
			-- Has the lexical grammar been finalized?
			-- | (in other words: has the DFA been built?)

feature -- Status setting	

	ignore_case is
			-- Make letter case not significant in future tools.
			-- This is the default.
		do
			case_sensitive := False
		ensure
			not case_sensitive
		end;

	distinguish_case is
			-- Make letter case significant in future tools.
			-- Default is ignore case.
		do
			case_sensitive := True
		ensure
			case_sensitive
		end;

	keywords_ignore_case is
			-- Make letter case not significant for keywords
			-- in future tools.
			-- This is the default.
		require
			no_tools_built: tool_list = Void or else tool_list.is_empty
		do
			keywords_case_sensitive := False
		ensure
			not keywords_case_sensitive
		end;

	keywords_distinguish_case is
			-- Make letter case not significant for keywords
			-- in future tools.
			-- Default is ignore case.
		require
			no_tool_built: tool_list.is_empty
		do
			keywords_case_sensitive := True
		ensure
			keywords_case_sensitive
		end;

feature -- Element change

	interval (b, e: CHARACTER) is
			-- Create regular expression `b'..`e', or `b' if `b' = `e'.
		require
			not_built: not lexical_frozen;
			e_code_small_enough:  e.code <= last_character_code;
			b_code_large_enough: b.code >= 0;
			b_before_e: b.code <= e.code
		local
			i, ee, bb: INTEGER;
			fa: PDFA;
			c_name: STRING;
		do
			create fa.make (2, last_character_code);
			bb := b.code;
			ee := e.code;
			from
				i := bb
			until
				i = ee + 1
			loop
				fa.set_transition (1, i, 2);
				i := i + 1
			end;
			if bb <= Lower_z and ee >= Upper_a and then
					(bb <= Upper_z or ee >= Lower_a) then
				fa.set_letters
			end;
			if not case_sensitive then
				fa.remove_case_sensitiveness
			end;
			last_created_tool := last_created_tool + 1;
			tool_list.finish;
			tool_list.put_right (fa);
			if bb /= ee then
				create c_name.make (8);
				c_name.extend ('%'');
				c_name.append (readable_form (b));
				c_name.extend ('%'');
				c_name.append ("..");
				c_name.extend ('%'');
				c_name.append (readable_form (e));
				c_name.extend ('%'')
			else
				create c_name.make (3);
				c_name.extend ('%'');
				c_name.append (readable_form (b));
				c_name.extend ('%'')
			end;
			tool_names.finish;
			tool_names.put_right (c_name)
		end;

	any_character is
			-- Create regular expression $. matching all characters.
		require
			not_frozen: not lexical_frozen
		local
			i: INTEGER;
			new_tool: PDFA
		do
			create new_tool.make (2, last_character_code);
			from
				i := -1
			until
				i = last_character_code
			loop
				i := i + 1;
				new_tool.set_transition (1, i, 2)
			end;
			new_tool.set_letters;
			if not case_sensitive then
				new_tool.remove_case_sensitiveness
			end;
			last_created_tool := last_created_tool + 1;
			tool_list.finish;
			tool_list.put_right (new_tool);
			tool_names.finish;
			tool_names.put_right ("$.")
		end;

	any_printable is
			-- Create regular expression $P matching all
			-- printable characters.
		require
			not_frozen: not lexical_frozen
		local
			i: INTEGER;
			new_tool: PDFA
		do
			create new_tool.make (2, last_character_code);
			from
				i := First_printable - 1
			until
				i = Last_printable
			loop
				i := i + 1;
				new_tool.set_transition (1, i, 2)
			end;
			new_tool.set_letters;
			if not case_sensitive then
				new_tool.remove_case_sensitiveness
			end;
			last_created_tool := last_created_tool + 1;
			tool_list.finish;
			tool_list.put_right (new_tool);
			tool_names.finish;
			tool_names.put_right ("$P")
		end;

	difference (r: INTEGER; c: CHARACTER) is
			-- Create regular expression representing
			-- the difference `r' - `c'.
			-- `r' must be a simple category, such as `a'..`z',
			-- or a union of simple categories,
			-- such as `a'..`z' | `0'..`9'.
		require
			not_frozen: not lexical_frozen;
			r_exists: r >= 1 and r <= last_created_tool;
			r_simple_category: tool_list.i_th (r).nb_states = 2
		local
			new: PDFA;
			cc: INTEGER;
			c_name: STRING
		do
			tool_list.go_i_th (r);
			create new.make (tool_list.item.nb_states, last_character_code);
			new.include (tool_list.item, 0);
			cc := c.code;
			new.delete_transition (1, cc, 2);
			if not case_sensitive then
				new.remove_case_sensitiveness
			end;
			last_created_tool := last_created_tool + 1;
			tool_list.finish;
			tool_list.put_right (new);
			create c_name.make (0);
			tool_names.go_i_th (r);
			c_name.append (tool_names.item);
			c_name.extend ('-');
			c_name.extend ('%'');
			c_name.extend (c);
			c_name.extend ('%'');
			tool_names.finish;
			tool_names.put_right (c_name)
		end;

	append (p, s: INTEGER) is
			-- Create regular expression `p'`s':
			-- `s' appended to `p'.
		require
			not_frozen: not lexical_frozen;
			p_in_tool: p >= 1 and p <= last_created_tool;
			s_in_tool: s >= 1 and s <= last_created_tool
		local
			new: PDFA;
			c_name: STRING;
			p_length, s_length, length: INTEGER
		do
			tool_list.go_i_th (p);
			p_length := tool_list.item.nb_states;
			tool_list.go_i_th (s);
			s_length := tool_list.item.nb_states;
			length := p_length + s_length;
			create new.make (length, last_character_code);
			new.include (tool_list.item, p_length);
			tool_list.go_i_th (p);
			new.include (tool_list.item, 0);
			new.set_e_transition (p_length, p_length + 1);
			if not case_sensitive then
				new.remove_case_sensitiveness
			end;
			last_created_tool := last_created_tool + 1;
			tool_list.finish;
			tool_list.put_right (new);
			create c_name.make (0);
			tool_names.go_i_th (p);
			c_name.append (tool_names.item);
			c_name.extend (' ');
			tool_names.go_i_th (s);
			c_name.append (tool_names.item);
			tool_names.finish;
			tool_names.put_right (c_name)
		end;

	append_optional (p, s: INTEGER) is
			-- Create regular expression `p'[`s']:
			-- `s' optionally appended to `p'.
		require
			not_frozen: not lexical_frozen;
			p_in_tool: p >= 1 and p <= last_created_tool;
			s_in_tool: s >= 1 and s <= last_created_tool
		local
			new: PDFA;
			c_name: STRING;
			p_length, s_length, length: INTEGER
		do
			tool_list.go_i_th (p);
			p_length := tool_list.item.nb_states;
			tool_list.go_i_th (s);
			s_length := tool_list.item.nb_states;
			length := p_length + s_length;
			create new.make (length, last_character_code);
			new.include (tool_list.item, p_length);
			tool_list.go_i_th (p);
			new.include (tool_list.item, 0);
			new.set_e_transition (p_length, p_length + 1);
			new.set_e_transition (p_length, length);
			if not case_sensitive then
				new.remove_case_sensitiveness
			end;
			last_created_tool := last_created_tool + 1;
			tool_list.finish;
			tool_list.put_right (new);
			create c_name.make (0);
			tool_names.go_i_th (p);
			c_name.append (tool_names.item);
			c_name.extend (' ');
			c_name.extend ('[');
			tool_names.go_i_th (s);
			c_name.append (tool_names.item);
			c_name.extend (']');
			tool_names.finish;
			tool_names.put_right (c_name)
		end;

	prepend_optional (p, s: INTEGER) is
			-- Create regular expression [`p']`s':
			-- `s' appended to optional `p'.
		require
			not_frozen: not lexical_frozen;
			p_in_tool: p >= 1 and p <= last_created_tool;
			s_in_tool: s >= 1 and s <= last_created_tool
		local
			new: PDFA;
			c_name: STRING;
			p_length, s_length, length: INTEGER
		do
			tool_list.go_i_th (p);
			p_length := tool_list.item.nb_states;
			tool_list.go_i_th (s);
			s_length := tool_list.item.nb_states;
			length := p_length + s_length;
			create new.make (length, last_character_code);
			new.include (tool_list.item, p_length);
			tool_list.go_i_th (p);
			new.include (tool_list.item, 0);
			new.set_e_transition (1, p_length + 1);
			new.set_e_transition (p_length, p_length + 1);
			if not case_sensitive then
				new.remove_case_sensitiveness
			end;
			last_created_tool := last_created_tool + 1;
			tool_list.finish;
			tool_list.put_right (new);
			create c_name.make (0);
			c_name.extend ('[');
			tool_names.go_i_th (p);
			c_name.append (tool_names.item);
			c_name.extend (']');
			c_name.extend (' ');
			tool_names.go_i_th (s);
			c_name.append (tool_names.item);
			tool_names.finish;
			tool_names.put_right (c_name)
		end;

	case_insensitive (c: INTEGER) is
			-- Create regular expression ~(`c'):
			-- like `c', but case-insensitive.
		require
			not_frozen: not lexical_frozen;
			z_possible: last_character_code >= Lower_z;
			c_in_tool: c >= 1 and c <= last_created_tool
		local
			new: PDFA;
			c_name: STRING;
		do
			tool_list.go_i_th (c);
			create new.make (tool_list.item.nb_states, last_character_code);
			new.include (tool_list.item, 0);
			new.remove_case_sensitiveness;
			last_created_tool := last_created_tool + 1;
			tool_list.finish;
			tool_list.put_right (new);
			tool_names.go_i_th (c);
			create c_name.make (0);
			c_name.extend ('~');
			c_name.extend ('(');
			c_name.append (tool_names.item);
			c_name.extend (')');
			tool_names.finish;
			tool_names.put_right (c_name)
		end;

	optional (c: INTEGER) is
			-- Create regular expression [`c']:
			-- optional `c'.
		require
			not_frozen: not lexical_frozen;
			c_in_tool: c >= 1 and c <= last_created_tool
		local
			new: PDFA;
			c_name: STRING;
			length: INTEGER
		do
			tool_list.go_i_th (c);
			length := tool_list.item.nb_states;
			create new.make (length, last_character_code);
			new.include (tool_list.item, 0);
			new.set_e_transition (1, length);
			if not case_sensitive then
				new.remove_case_sensitiveness
			end;
			last_created_tool := last_created_tool + 1;
			tool_list.finish;
			tool_list.put_right (new);
			tool_names.go_i_th (c);
			create c_name.make (0);
			c_name.extend ('[');
			c_name.append (tool_names.item);
			c_name.extend (']');
			tool_names.finish;
			tool_names.put_right (c_name)
		end;

	iteration1 (c: INTEGER) is
			-- Create regular expression +(`c'): one or more
			-- consecutive occurrences of `c'.
		require
			not_frozen: not lexical_frozen;
			c_in_tool: c >= 1 and c <= last_created_tool
		local
			new: PDFA;
			c_name: STRING;
			length: INTEGER
		do
			tool_list.go_i_th (c);
			length := tool_list.item.nb_states;
			create new.make (length, last_character_code);
			new.include (tool_list.item, 0);
			new.set_e_transition (length, 1);
			if not case_sensitive then
				new.remove_case_sensitiveness
			end;
			last_created_tool := last_created_tool + 1;
			tool_list.finish;
			tool_list.put_right (new);
			tool_names.go_i_th (c);
			create c_name.make (0);
			c_name.precede ('+');
			c_name.extend ('(');
			c_name.append (tool_names.item);
			c_name.extend (')');
			tool_names.finish;
			tool_names.put_right (c_name)
		end;

	iteration (c: INTEGER) is
			-- Create regular expression *(`c'): zero or more
			-- consecutive occurrences of `c'.
		require
			not_frozen: not lexical_frozen;
			c_in_tool: c >= 1 and c <= last_created_tool
		local
			new: PDFA;
			c_name: STRING;
			length: INTEGER
		do
			tool_list.go_i_th (c);
			length := tool_list.item.nb_states;
			create new.make (length, last_character_code);
			new.include (tool_list.item, 0);
			new.set_e_transition (length, 1);
			new.set_e_transition (1, length);
			if not case_sensitive then
				new.remove_case_sensitiveness
			end;
			last_created_tool := last_created_tool + 1;
			tool_list.finish;
			tool_list.put_right (new);
			tool_names.go_i_th (c);
			create c_name.make (0);
			c_name.precede ('*');
			c_name.extend ('(');
			c_name.append (tool_names.item);
			c_name.extend (')');
			tool_names.finish;
			tool_names.put_right (c_name)
		end;

	iteration_n (n, c: INTEGER) is
			-- Create regular expression `n'(`c'):
			-- exactly `n' consecutive occurrences of `c'.
		require
			not_frozen: not lexical_frozen;
			n_large_enough: n > 0;
			c_in_tool: c >= 1 and c <= last_created_tool
		local
			a_prefix, new: PDFA;
			c_name: STRING;
			index, o_length, p_length: INTEGER
		do
			tool_list.go_i_th (c);
			new := tool_list.item;
			o_length := new.nb_states;
			create a_prefix.make (o_length * n, last_character_code);
			a_prefix.include (new, 0);
			from
				index := 1
			until
				index = n
			loop
				p_length := index * o_length;
				index := index + 1;
				a_prefix.include (new, p_length);
				a_prefix.set_e_transition (p_length, p_length + 1)
			end;
			if not case_sensitive then
				a_prefix.remove_case_sensitiveness
			end;
			last_created_tool := last_created_tool + 1;
			tool_list.finish;
			tool_list.put_right (a_prefix);
			tool_names.go_i_th (c);
			create c_name.make (0);
			c_name.append_integer (n);
			c_name.extend ('(');
			c_name.append (tool_names.item);
			c_name.extend (')');
			tool_names.finish;
			tool_names.put_right (c_name)
		end;

	union2 (a, b: INTEGER) is
			-- Create regular expression `a' | `b': union of
			-- `a' and `b' (matches an occurrence of `a' or `b')).
		require
			not_frozen: not lexical_frozen;
			a_in_tool: a >= 1 and a <= last_created_tool;
			b_in_tool: b >= 1 and b <= last_created_tool
		local
			new: PDFA;
			length, a_length, b_length: INTEGER;
			a_transitions, b_transitions: LINKED_LIST [INTEGER];
			c_name: STRING
		do
			tool_list.go_i_th (a);
			a_length := tool_list.item.nb_states;
			a_transitions := tool_list.item.item (a_length);
			tool_list.go_i_th (b);
			b_length := tool_list.item.nb_states;
			b_transitions := tool_list.item.item (b_length);
			length := a_length + b_length + 2;
			if length = 6 and then
					(a_transitions = Void and b_transitions = Void) then
					-- If `a' and `b' are categories,
					-- `a' | `b' must also be one.
					-- not 'a'|+('b') ==> test of transition number.
				debug
					io.put_string ("Union2, length = 6");
					io.new_line;
				end;
				create new.make (2, last_character_code);
				new.include (tool_list.item, 0);
				tool_list.go_i_th (a);
				new.include (tool_list.item, 0)
			else
				debug
					io.put_string ("Union2, length /= 6");
					io.new_line;
				end;
				create new.make (length, last_character_code);
				new.include (tool_list.item, a_length + 1);
				tool_list.go_i_th (a);
				new.include (tool_list.item, 1);
				new.set_e_transition (1, 2);
				new.set_e_transition (1, a_length + 2);
				new.set_e_transition (a_length + 1, length);
				new.set_e_transition (length - 1, length)
			end;
			if not case_sensitive then
				new.remove_case_sensitiveness
			end;
			last_created_tool := last_created_tool + 1;
			tool_list.finish;
			tool_list.put_right (new);
			create c_name.make (0);
			tool_names.go_i_th (a);
			c_name.append (tool_names.item);
			c_name.extend ('|');
			tool_names.go_i_th (b);
			c_name.append (tool_names.item);
			tool_names.finish;
			tool_names.put_right (c_name)
		end;

	union (a, b: INTEGER) is
			-- Create regular expression for the multiple union
			-- `a' | `a'+1 | .. | `b': matches any occurrence of
			-- `a', or `a'+1, .., or `b'.
		require
			not_frozen: not lexical_frozen;
			a_not_too_small: a >= 1;
			b_not_too_large: b <= last_created_tool;
			a_smaller_than_b: a <= b
		local
			new, cat: PDFA;
			tool_p, length, index: INTEGER;
			c_name: STRING;
			cat_set, non_cat_set: FIXED_INTEGER_SET
		do
			create cat_set.make (b);
			create non_cat_set.make (b);
			length := 2;
			from
				tool_list.go_i_th (a)
			until
				tool_list.index = b + 1
			loop
				if tool_list.item.nb_states > 2 then
					non_cat_set.put (tool_list.index);
					length := length + tool_list.item.nb_states
				else
					cat_set.put (tool_list.index)
				end;
				tool_list.forth
			end;
			if not cat_set.is_empty then
				create cat.make (2, last_character_code);
				from
					tool_p := cat_set.smallest
				until
					tool_p > b
				loop
					tool_list.go_i_th (tool_p);
					cat.include (tool_list.item, 0);
					tool_p := cat_set.next (tool_p)
				end
			end;
			if length = 2 then
				new := cat
			else
				if cat_set.is_empty then
					create new.make (length, last_character_code);
					index := 2
				else
					length := length + 2;
					create new.make (length, last_character_code);
					new.include (cat, 1);
					new.set_e_transition (1, 2);
					new.set_e_transition (3, length);
					index := 4
				end;
				from
					tool_p := non_cat_set.smallest
				until
					tool_p > b
				loop
					tool_list.go_i_th (tool_p);
					new.include (tool_list.item, index - 1);
					new.set_e_transition (1, index);
					index := index + tool_list.item.nb_states;
					new.set_e_transition (index - 1, length);
					tool_p := non_cat_set.next (tool_p)
				end
			end;
			if not case_sensitive then
				new.remove_case_sensitiveness
			end;
			last_created_tool := last_created_tool + 1;
			tool_list.finish;
			tool_list.put_right (new);
			create c_name.make (0);
			from
				tool_names.go_i_th (a);
			until
				tool_names.index = b
			loop
				c_name.append (tool_names.item);
				c_name.extend ('|');
				tool_names.forth
			end;
			c_name.append (tool_names.item);
			tool_names.finish;
			tool_names.put_right (c_name)
		end;

	set_word (word: STRING) is
			-- Create regular expression for `word':
			-- synonym for concatenation (`w' `o' `r' `d').
		require
			word_not_empty: word.count >= 1
		local
			new_tool: PDFA;
			length, code, i: INTEGER;
			tool_name: STRING
		do
			length := word.count;
			create new_tool.make (length + 1, last_character_code);
			from
			until
				i = length
			loop
				i := i + 1;
				code := word.item_code (i);
				new_tool.set_transition (i, code, i + 1);
				if (code <= Lower_z and code >= Lower_a) or else
						(code <= Upper_z and code >= Upper_a) then
					new_tool.set_letters
				end
			end;
			if not case_sensitive then
				new_tool.remove_case_sensitiveness
			end;
			last_created_tool := last_created_tool + 1;
			tool_list.finish;
			tool_list.put_right (new_tool);
			tool_name := clone (word);
			tool_name.precede ('"');
			tool_name.extend ('"');
			tool_names.finish;
			tool_names.put_right (tool_name)
		end;

	up_to (word: STRING) is
			-- Create regular expression ->"`word'", which is a
			-- set of any number of any characters ended by "`word'".
			-- Example: "/* C comment */" matches (->"*/").
			-- The difference between (+$. '*' '/') and
			-- (->"*/") is that "*/..*/..*/" matches
			-- the first but not the second.
			-- The difference between
			-- ((($.-'*') | ('*'($.-'/'))) +('*' '/') )
			-- and "(->"*/")" is that "..**/" matches
			-- the second but not the first.
		require
			word_not_empty: word.count > 0;
			not_frozen: not lexical_frozen
		local
			i, j, length: INTEGER;
			new_tool: PDFA;
			r_name: STRING
		do
			length := word.count;
			create new_tool.make ((6 * length) + 1, last_character_code);
			from
			until
				i = length
			loop
				new_tool.set_e_transition ((6 * i) + 1, (6 * i) + 2);
				new_tool.set_e_transition ((6 * i) + 1, (6 * i) + 4);
				new_tool.set_e_transition ((6 * i) + 1, (6 * i) + 6);
				new_tool.set_e_transition ((6 * i) + 3, 1);
				new_tool.set_e_transition ((6 * i) + 5, 7);
				from
					j := -1
				until
					j = last_character_code
				loop
					j := j + 1;
					new_tool.set_transition ((6 * i) + 2, j, (6 * i) + 3)
				end;
				new_tool.delete_transition ((6 * i) + 2,
					word.item_code (i + 1), (6 * i) + 3);
				new_tool.delete_transition ((6 * i) + 2,
					word.item_code (1), (6 * i) + 3);
				new_tool.set_transition ((6 * i) + 6,
					word.item_code (i + 1), (6 * i) + 7);
				new_tool.set_transition ((6 * i) + 4,
					word.item_code (1), (6 * i) + 5);
				i := i + 1
			end;
			new_tool.set_letters;
			if not case_sensitive then
				new_tool.remove_case_sensitiveness
			end;
			last_created_tool := last_created_tool + 1;
			tool_list.finish;
			tool_list.put_right (new_tool);
			create r_name.make (4);
			r_name.extend ('-');
			r_name.extend ('>');
			r_name.extend ('"');
			r_name.append (word);
			r_name.extend ('"');
			tool_names.finish;
			tool_names.put_right (r_name)
		end;

	put_keyword (s: STRING; exp: INTEGER) is
			-- Declare `s' as a keyword described by
			-- the regular expression of code `exp'.
			--| Do not check if `s' is recognized by `exp'.
			--| This is done when the dfa is built.
		require
			not_frozen: not lexical_frozen;
			exp_selected: token_type_list /= Void and then token_type_list.has(exp)
		local
			u, l: STRING;
			index: INTEGER
		do
			index := token_type_list.index_of (exp, 1);
			tool_list.go_i_th (selected_tools.i_th (index));
			tool_list.item.add_keyword (s);
			last_declared_keyword := last_declared_keyword + 1;
			if not keywords_case_sensitive then
				l := clone (s);
				l.to_lower;
				tool_list.item.add_keyword (l);
				u := clone (s);
				u.to_upper;
				tool_list.item.add_keyword (u);
				last_declared_keyword := last_declared_keyword + 2
			end
		end;

	select_tool (i: INTEGER) is
			-- Select the `i'_th tool for inclusion in the main
			-- regular expression.
		require
			not_frozen: not lexical_frozen;
			i_exist: i > 0 and i <= last_created_tool
		do
			if selected_tools = Void then
				create selected_tools.make;
				create token_type_list.make
			end;
			selected_tools.finish;
			selected_tools.put_right (i);
			selected_tools.finish;
			token_type_list.finish;
			token_type_list.put_right (i);
			token_type_list.finish;
			tool_list.go_i_th (i);
			nb_states := nb_states + tool_list.item.nb_states
		ensure
			i_selected: selected_tools.has (i)
		end;

	associate (t, n: INTEGER) is
			-- Associate the `t'-th tool with token type `n'.
			-- If this routine is not used, the default value is `t'.
		require
			t_selected: selected_tools.has (t);
			n_not_zero: n /= 0;
			n_not_minus_one: n /= -1
				-- 0 is reserved for the non-final states.
				-- -1 is reserved for the end of text.
		do
			selected_tools.finish;
			if selected_tools.item = t then
				token_type_list.finish;
				token_type_list.put (n)
			else
				from
					selected_tools.start;
					token_type_list.start
				until
					selected_tools.item = t
				loop
					selected_tools.forth;
					token_type_list.forth
				end;
				token_type_list.put (n)
			end
		end;

	recognize (s: STRING): INTEGER is
			-- Token_type of `s'; 0 if not recognized
		local
			i: INTEGER;
			l: LINKED_LIST [INTEGER];
		do
			create l.make;
			from
				i := 1
			until
				i = s.count + 1
			loop
				l.put_right (categories_table.item (s.item (i).code));
				l.forth;
				i := i + 1
			end;
			Result := dfa.recognize (l)
		end;

feature -- Removal

	remove is
			-- Remove the last regular expression
			-- from the tool list.
		require
			not_frozen: not lexical_frozen;
			at_least_one_regular: last_created_tool >= 1
		do
			last_created_tool := last_created_tool - 1;
			tool_list.finish;
			tool_names.finish;
			tool_list.remove;
			tool_names.remove
		end;

feature -- Input

	retrieve_analyzer (file_name: STRING) is
			-- Retrieve `analyzer' from file named `file_name'.
		local
			retrieved_file: RAW_FILE
		do
			create retrieved_file.make_open_read (file_name);
			analyzer ?= retrieved_file.retrieved;
			retrieved_file.close
		end;

feature -- Output

	store_analyzer (file_name: STRING) is
			-- Store `analyzer' in file named `file_name'.
		require
			initialized: initialized
		local
			store_file: RAW_FILE
		do
			if analyzer = Void then
				create analyzer.make
			end;
			create store_file.make_open_write (file_name);
			store_file.basic_store (analyzer);
			store_file.close
		end;

feature -- Implementation

	initialized: BOOLEAN;
			-- Is analyzer initialized?

feature {NONE} -- Implementation

	last_declared_keyword: INTEGER;
			-- Identification number of the last keyword declared

	readable_form (c: CHARACTER): STRING is
			-- "\n" if c = '\n' ...
		do
			if c = '%N' then
				Result := "%%N"
			elseif c = '%T' then
				Result := "%%T"
			elseif c = '%F' then
				Result := "%%F"
			elseif c = '%R' then
				Result := "%%R"
			else
				create Result.make (1);
				Result.extend (c)
			end
		end;

	freeze_lexical is
			-- Build the main PDFA, and then the DFA which is
			-- used to recognize a language.
		require
			not_frozen: not lexical_frozen;
			tools_selected: selected_tools /= Void
		do
			creation_with_all_inputs;
			build_categories_table;
			creation_with_categories;
			set_start (1);
			construct_dfa;
			copy_keywords;
			lexical_frozen := True
		ensure
			not_frozen: dfa /= Void;
			not_frozen: lexical_frozen
		end;

	creation_with_all_inputs is
			-- Create main PDFA, including all the selected tools.
			-- Very important: for each tool this routine assumes
			-- that the initial state in the first one, and the
			-- final state is the last one.
		require
			not_frozen: not lexical_frozen
		local
			shift: INTEGER;
			fa: PDFA
		do
			nb_states := nb_states + 1;
			pdfa_make (nb_states, last_character_code);
			from
				selected_tools.start;
				token_type_list.start;
				shift := 1
			until
				selected_tools.after or selected_tools.is_empty
			loop
				set_e_transition (1, shift + 1);
				tool_list.go_i_th (selected_tools.item);
				fa := tool_list.item;
				include (fa, shift);
				shift := shift + fa.nb_states;
				set_final (shift, token_type_list.item);
				debug
					io.put_string (" Tool selected: ");
					io.put_integer (selected_tools.item);
					io.put_string (" Description: ");
					tool_names.go_i_th (selected_tools.item);
					io.put_string (tool_names.item);
					io.put_string (" Token type associated: ");
					io.put_integer (token_type_list.item);
					io.new_line
				end;
				selected_tools.forth;
				token_type_list.forth
			end
		end;

	build_categories_table is
			-- Build categories_table.
			-- The purpose of this table is to bring together
			-- all the inputs with the same "behavior" in the
			-- main PDFA, in order to reduce the size of the DFA.
			-- A set of inputs is named "category", and
			-- the categories_table provides, for each input, the
			-- number of the category it belongs to.
			-- The 0th category includes all the unused inputs,
			-- and the input -1, which means end of file.
			-- This routine uses "search_in_tree" of NDFA, which
			-- purpose is to sort a set of FIX_INT_SET.
		local
			in_put: INTEGER;
			set, old_set: FIXED_INTEGER_SET
		do
			create set_tree.make (nb_states, 0);
			create categories_table.make (-1, last_character_code);
			create old_set.make (nb_states);
			from
				in_put := - 1
			until
				in_put = last_character_code
			loop
				in_put := in_put + 1;
				set := input_array.item (in_put);
				if set /= Void then
					if set.is_equal (old_set) then
						categories_table.put (set_position, in_put)
					else
						search_in_tree (set);
						old_set := set;
						categories_table.put (set_position, in_put)
					end
				end
			end;
			greatest_input := new_number;
			new_number := 0;
			set_tree := Void
		end;

	creation_with_categories is
			-- Re-Create main PDFA, using categories_table,
			-- and bringing together the inputs of the same category.
			-- This routine do not deal with the epsilon transitions,
			-- which are left unchanged.
		require
			categories_table: categories_table /= Void
		local
			new_input_array: ARRAY [FIXED_INTEGER_SET];
			category, in_put: INTEGER
		do
			create new_input_array.make (0, greatest_input);
			from
				in_put := -1
			until
				in_put = last_character_code
			loop
				in_put := in_put + 1;
				category := categories_table.item (in_put);
				if new_input_array.item (category) = Void then
					new_input_array.put (input_array.item (in_put), category)
				end
			end;
			input_array := new_input_array
		end;

	copy_keywords is
			-- Copy the keywords in the hash table.
		local
			k_list: LINKED_LIST [STRING];
			k: STRING;
			tool_number, token_type: INTEGER
		do
			if last_declared_keyword > 0 then
				create keyword_h_table.make (last_declared_keyword)
			end;
			from
				selected_tools.start;
				token_type_list.start
			until
				selected_tools.after or selected_tools.is_empty
			loop
				tool_number := selected_tools.item;
				token_type := token_type_list.item;
				tool_list.go_i_th (tool_number);
				k_list := tool_list.item.keywords_list;
				from
					k_list.start
				until
					k_list.after or k_list.is_empty
				loop
					k := k_list.item;
					keyword_h_table.put (token_type, k);
					if not recognized (k, token_type) then
						error_keyword (tool_number, k)
					end;
					k_list.forth
				end;
				selected_tools.forth;
				token_type_list.forth
			end
		end;

	recognized (kwd: STRING; token_type: INTEGER): BOOLEAN is
			-- Is `kwd' recognized by the regular
			-- expression number `token_type'?
		require
			kwd /= Void
		local
			i: INTEGER;
			l: LINKED_LIST [INTEGER];
			possible_tokens: ARRAY [INTEGER]
		do
			create l.make;
			from
				i := 1
			until
				i = kwd.count + 1
			loop
				l.put_right (categories_table.item (kwd.item (i).code));
				l.forth;
				i := i + 1
			end;
			possible_tokens := dfa.possible_tokens (l);
			from
				i := possible_tokens.lower
			until
				Result or i > possible_tokens.upper
			loop
				Result := (possible_tokens.item (i) = token_type);
				i := i + 1
			end
		end;

	dfa_set_final (s, new_final: INTEGER) is
			-- Set the attribute `final' of state `s' to `new_final'.
		local
			old_final: INTEGER;
		do
			old_final := dfa.item (s).final;
			if old_final = 0 then
				dfa.item (s).set_final (new_final)
			elseif old_final /= new_final then
				error_common_part (old_final, new_final);
				dfa.item (s).set_final (new_final)
			end
		end;

	error_common_part (first, second: INTEGER) is
			-- Create an error message when a regular expression can
			-- be recognized by the first and the second token type.
			-- Example "aa" is recognized by +(a..z) and 2(a).
			-- The first tool yield the priority to the second.
		require
			first_is_a_token_type: token_type_list.has (first);
			second_is_a_token_type: token_type_list.has (second)
		local
			message: STRING
		do
			create message.make (0);
			message.append ("Warning: some tokens can be recognized by ");
			token_type_list.start;
			token_type_list.search (first);
			selected_tools.go_i_th (token_type_list.index);
			tool_names.go_i_th (selected_tools.item);
			message.append (tool_names.item);
			message.append (" and by ");
			token_type_list.start;
			token_type_list.search (second);
			selected_tools.go_i_th (token_type_list.index);
			tool_names.go_i_th (selected_tools.item);
			message.append (tool_names.item);
			message.append (".%N	The second one has priority.");
			error_list.add_message (message)
		end;

	error_keyword (t: INTEGER; k: STRING) is
			-- Create an error message when a keyword k is not
			-- recognized by the corresponding tool.
		local
			message: STRING
		do
			create message.make (0);
			message.append ("Warning: ");
			message.append (k);
			message.append (" is not recognized by ");
			tool_names.go_i_th (t);
			message.append (tool_names.item);
			message.extend ('.');
			error_list.add_message (message)
		end;

invariant

	last_created: tool_list = Void or else last_created_tool = tool_list.count

end -- class LEX_BUILDER
 

--|----------------------------------------------------------------
--| EiffelLex: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

