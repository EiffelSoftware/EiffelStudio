note

	description:
		"General mechanisms for building lexical analyzers"
	legal: "See notice at end of class.";

	status: "See notice at end of class.";
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

	make
			-- Set up the analyzer.
		do
			pdfa_make (0, 0)
			last_character_code := Last_ascii;
			create tool_list.make;
			create tool_names.make
		ensure
			last_character_set: last_character_code = Last_ascii
		end;

	make_extended (char_code: INTEGER)
			-- Set up the analyzer with `char_code' as 'last_character_code'.
		require
			valid_char_code: char_code > 0
		do
			pdfa_make (0, 0)
			last_character_code := char_code
			create tool_list.make;
			create tool_names.make
		ensure
			last_character_set: last_character_code = char_code
		end;

	initialize
			-- Set up attributes of `analyzer'.
		local
			l_analyzer: like analyzer
			l_dfa: like dfa
			l_categories: like categories_table
			l_keywords: like keyword_h_table
		do
			initialized := True;
			l_analyzer := analyzer
			if l_analyzer = Void then
				create l_analyzer.make
				analyzer := l_analyzer
			end;
			l_dfa := dfa
			l_categories := categories_table
			l_keywords := keyword_h_table
			check
				l_dfa_attached: l_dfa /= Void
				l_categories_attached: l_categories /= Void
				l_keywords_attached: l_keywords /= Void
			end
			l_analyzer.initialize_attributes (l_dfa, l_categories, l_keywords, keywords_case_sensitive)
		ensure
			analyzer_attached: analyzer /= Void
			initialized
		end;

feature -- Access

	last_character_code: INTEGER;
			-- Last character code recognized by the language

	tool_list: detachable LINKED_LIST [PDFA];
			-- Regular expressions used as auxiliary tools

	tool_names: detachable LINKED_LIST [STRING];
			-- Names of regular expressions in tool list

	case_sensitive: BOOLEAN;
			-- Will future tools be case-sensitive?

	keywords_case_sensitive: BOOLEAN;
			-- Will future tools be case-sensitive for keywords?

	categories_table: detachable ARRAY [INTEGER];
			-- Table of category numbers for each input

	keyword_h_table: detachable HASH_TABLE [INTEGER, STRING];
			-- Keyword table

	error_list: ERROR_LIST
			-- List of error messages
		once
			create Result.make
		ensure
			result_attached: Result /= Void
		end;

	analyzer: detachable LEXICAL;
			-- The lexical analyzer built so far

	last_created_tool: INTEGER;
			-- Identification number of the last
			-- regular expression put in tool_list

	selected_tools: detachable LINKED_LIST [INTEGER];
			-- Regular expressions included in the main one

	token_type_list: detachable LINKED_LIST [INTEGER];
			-- Token types of the selected tools.
			-- Indexed by tool numbers.

	lexical_frozen: BOOLEAN;
			-- Has the lexical grammar been finalized?
			-- | (in other words: has the DFA been built?)

feature -- Status setting	

	ignore_case
			-- Make letter case not significant in future tools.
			-- This is the default.
		do
			case_sensitive := False
		ensure
			not case_sensitive
		end;

	distinguish_case
			-- Make letter case significant in future tools.
			-- Default is ignore case.
		do
			case_sensitive := True
		ensure
			case_sensitive
		end;

	keywords_ignore_case
			-- Make letter case not significant for keywords
			-- in future tools.
			-- This is the default.
		require
			no_tool_built: not attached tool_list as l_tools or else l_tools.is_empty
		do
			keywords_case_sensitive := False
		ensure
			not keywords_case_sensitive
		end;

	keywords_distinguish_case
			-- Make letter case not significant for keywords
			-- in future tools.
			-- Default is ignore case.
		require
			no_tool_built: not attached tool_list as l_tools or else l_tools.is_empty
		do
			keywords_case_sensitive := True
		ensure
			keywords_case_sensitive
		end;

feature -- Element change

	interval (b, e: CHARACTER)
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
			l_tools: like tool_list
			l_tool_names: like tool_names
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

			l_tools := tool_list
			l_tool_names := tool_names
			check
				l_tools_attached: l_tools /= Void
				l_tool_names_attached: l_tool_names /= Void
			end
			last_created_tool := last_created_tool + 1;
			l_tools.finish;
			l_tools.put_right (fa);
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
			l_tool_names.finish;
			l_tool_names.put_right (c_name)
		end;

	any_character
			-- Create regular expression $. matching all characters.
		require
			not_frozen: not lexical_frozen
		local
			i: INTEGER;
			new_tool: PDFA
			l_tools: like tool_list
			l_tool_names: like tool_names
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

			l_tools := tool_list
			l_tool_names := tool_names
			check
				l_tools_attached: l_tools /= Void
				l_tool_names_attached: l_tool_names /= Void
			end
			l_tools.finish;
			l_tools.put_right (new_tool);
			l_tool_names.finish;
			l_tool_names.put_right ("$.")
		end;

	any_printable
			-- Create regular expression $P matching all
			-- printable characters.
		require
			not_frozen: not lexical_frozen
		local
			i: INTEGER;
			new_tool: PDFA
			l_tools: like tool_list
			l_tool_names: like tool_names
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

			l_tools := tool_list
			l_tool_names := tool_names
			check
				l_tools_attached: l_tools /= Void
				l_tool_names_attached: l_tool_names /= Void
			end
			l_tools.finish;
			l_tools.put_right (new_tool);
			l_tool_names.finish;
			l_tool_names.put_right ("$P")
		end;

	difference (r: INTEGER; c: CHARACTER)
			-- Create regular expression representing
			-- the difference `r' - `c'.
			-- `r' must be a simple category, such as `a'..`z',
			-- or a union of simple categories,
			-- such as `a'..`z' | `0'..`9'.
		require
			not_frozen: not lexical_frozen;
			r_exists: r >= 1 and r <= last_created_tool;
			r_simple_category: attached tool_list as rl_tools and then rl_tools.i_th (r).nb_states = 2
		local
			new: PDFA;
			cc: INTEGER;
			c_name: STRING
			l_tools: like tool_list
			l_tool_names: like tool_names
		do
			l_tools := tool_list
			check l_tools_attached: l_tools /= Void end
			l_tools.go_i_th (r);
			create new.make (l_tools.item.nb_states, last_character_code);
			new.include (l_tools.item, 0);
			cc := c.code;
			new.delete_transition (1, cc, 2);
			if not case_sensitive then
				new.remove_case_sensitiveness
			end;
			last_created_tool := last_created_tool + 1;
			l_tools.finish;
			l_tools.put_right (new);
			create c_name.make (0);
			l_tool_names := tool_names
			check l_tool_names_attached: l_tool_names /= Void end
			l_tool_names.go_i_th (r);
			c_name.append (l_tool_names.item);
			c_name.extend ('-');
			c_name.extend ('%'');
			c_name.extend (c);
			c_name.extend ('%'');
			l_tool_names.finish;
			l_tool_names.put_right (c_name)
		end;

	append (p, s: INTEGER)
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
			l_tools: like tool_list
			l_tool_names: like tool_names
		do
			l_tools := tool_list
			l_tool_names := tool_names
			check
				l_tools_attached: l_tools /= Void
				l_tool_names_attached: l_tool_names /= Void
			end

			l_tools.go_i_th (p);
			p_length := l_tools.item.nb_states;
			l_tools.go_i_th (s);
			s_length := l_tools.item.nb_states;
			length := p_length + s_length;
			create new.make (length, last_character_code);
			new.include (l_tools.item, p_length);
			l_tools.go_i_th (p);
			new.include (l_tools.item, 0);
			new.set_e_transition (p_length, p_length + 1);
			if not case_sensitive then
				new.remove_case_sensitiveness
			end;
			last_created_tool := last_created_tool + 1;
			l_tools.finish;
			l_tools.put_right (new);
			create c_name.make (0);
			l_tool_names.go_i_th (p);
			c_name.append (l_tool_names.item);
			c_name.extend (' ');
			l_tool_names.go_i_th (s);
			c_name.append (l_tool_names.item);
			l_tool_names.finish;
			l_tool_names.put_right (c_name)
		end;

	append_optional (p, s: INTEGER)
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
			l_tools: like tool_list
			l_tool_names: like tool_names
		do
			l_tools := tool_list
			l_tool_names := tool_names
			check
				l_tools_attached: l_tools /= Void
				l_tool_names_attached: l_tool_names /= Void
			end

			l_tools.go_i_th (p);
			p_length := l_tools.item.nb_states;
			l_tools.go_i_th (s);
			s_length := l_tools.item.nb_states;
			length := p_length + s_length;
			create new.make (length, last_character_code);
			new.include (l_tools.item, p_length);
			l_tools.go_i_th (p);
			new.include (l_tools.item, 0);
			new.set_e_transition (p_length, p_length + 1);
			new.set_e_transition (p_length, length);
			if not case_sensitive then
				new.remove_case_sensitiveness
			end;
			last_created_tool := last_created_tool + 1;
			l_tools.finish;
			l_tools.put_right (new);
			create c_name.make (0);
			l_tool_names.go_i_th (p);
			c_name.append (l_tool_names.item);
			c_name.extend (' ');
			c_name.extend ('[');
			l_tool_names.go_i_th (s);
			c_name.append (l_tool_names.item);
			c_name.extend (']');
			l_tool_names.finish;
			l_tool_names.put_right (c_name)
		end;

	prepend_optional (p, s: INTEGER)
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
			l_tools: like tool_list
			l_tool_names: like tool_names
		do
			l_tools := tool_list
			l_tool_names := tool_names
			check
				l_tools_attached: l_tools /= Void
				l_tool_names_attached: l_tool_names /= Void
			end

			l_tools.go_i_th (p);
			p_length := l_tools.item.nb_states;
			l_tools.go_i_th (s);
			s_length := l_tools.item.nb_states;
			length := p_length + s_length;
			create new.make (length, last_character_code);
			new.include (l_tools.item, p_length);
			l_tools.go_i_th (p);
			new.include (l_tools.item, 0);
			new.set_e_transition (1, p_length + 1);
			new.set_e_transition (p_length, p_length + 1);
			if not case_sensitive then
				new.remove_case_sensitiveness
			end;
			last_created_tool := last_created_tool + 1;
			l_tools.finish;
			l_tools.put_right (new);
			create c_name.make (0);
			c_name.extend ('[');
			l_tool_names.go_i_th (p);
			c_name.append (l_tool_names.item);
			c_name.extend (']');
			c_name.extend (' ');
			l_tool_names.go_i_th (s);
			c_name.append (l_tool_names.item);
			l_tool_names.finish;
			l_tool_names.put_right (c_name)
		end;

	case_insensitive (c: INTEGER)
			-- Create regular expression ~(`c'):
			-- like `c', but case-insensitive.
		require
			not_frozen: not lexical_frozen;
			z_possible: last_character_code >= Lower_z;
			c_in_tool: c >= 1 and c <= last_created_tool
		local
			new: PDFA;
			c_name: STRING;
			l_tools: like tool_list
			l_tool_names: like tool_names
		do
			l_tools := tool_list
			l_tool_names := tool_names
			check
				l_tools_attached: l_tools /= Void
				l_tool_names_attached: l_tool_names /= Void
			end

			l_tools.go_i_th (c);
			create new.make (l_tools.item.nb_states, last_character_code);
			new.include (l_tools.item, 0);
			new.remove_case_sensitiveness;
			last_created_tool := last_created_tool + 1;
			l_tools.finish;
			l_tools.put_right (new);
			l_tool_names.go_i_th (c);
			create c_name.make (0);
			c_name.extend ('~');
			c_name.extend ('(');
			c_name.append (l_tool_names.item);
			c_name.extend (')');
			l_tool_names.finish;
			l_tool_names.put_right (c_name)
		end;

	optional (c: INTEGER)
			-- Create regular expression [`c']:
			-- optional `c'.
		require
			not_frozen: not lexical_frozen;
			c_in_tool: c >= 1 and c <= last_created_tool
		local
			new: PDFA;
			c_name: STRING;
			length: INTEGER
			l_tools: like tool_list
			l_tool_names: like tool_names
		do
			l_tools := tool_list
			l_tool_names := tool_names
			check
				l_tools_attached: l_tools /= Void
				l_tool_names_attached: l_tool_names /= Void
			end

			l_tools.go_i_th (c);
			length := l_tools.item.nb_states;
			create new.make (length, last_character_code);
			new.include (l_tools.item, 0);
			new.set_e_transition (1, length);
			if not case_sensitive then
				new.remove_case_sensitiveness
			end;
			last_created_tool := last_created_tool + 1;
			l_tools.finish;
			l_tools.put_right (new);
			l_tool_names.go_i_th (c);
			create c_name.make (0);
			c_name.extend ('[');
			c_name.append (l_tool_names.item);
			c_name.extend (']');
			l_tool_names.finish;
			l_tool_names.put_right (c_name)
		end;

	iteration1 (c: INTEGER)
			-- Create regular expression +(`c'): one or more
			-- consecutive occurrences of `c'.
		require
			not_frozen: not lexical_frozen;
			c_in_tool: c >= 1 and c <= last_created_tool
		local
			new: PDFA;
			c_name: STRING;
			length: INTEGER
			l_tools: like tool_list
			l_tool_names: like tool_names
		do
			l_tools := tool_list
			l_tool_names := tool_names
			check
				l_tools_attached: l_tools /= Void
				l_tool_names_attached: l_tool_names /= Void
			end

			l_tools.go_i_th (c);
			length := l_tools.item.nb_states;
			create new.make (length, last_character_code);
			new.include (l_tools.item, 0);
			new.set_e_transition (length, 1);
			if not case_sensitive then
				new.remove_case_sensitiveness
			end;
			last_created_tool := last_created_tool + 1;
			l_tools.finish;
			l_tools.put_right (new);
			l_tool_names.go_i_th (c);
			create c_name.make (0);
			c_name.precede ('+');
			c_name.extend ('(');
			c_name.append (l_tool_names.item);
			c_name.extend (')');
			l_tool_names.finish;
			l_tool_names.put_right (c_name)
		end;

	iteration (c: INTEGER)
			-- Create regular expression *(`c'): zero or more
			-- consecutive occurrences of `c'.
		require
			not_frozen: not lexical_frozen;
			c_in_tool: c >= 1 and c <= last_created_tool
		local
			new: PDFA;
			c_name: STRING;
			length: INTEGER
			l_tools: like tool_list
			l_tool_names: like tool_names
		do
			l_tools := tool_list
			l_tool_names := tool_names
			check
				l_tools_attached: l_tools /= Void
				l_tool_names_attached: l_tool_names /= Void
			end

			l_tools.go_i_th (c);
			length := l_tools.item.nb_states;
			create new.make (length, last_character_code);
			new.include (l_tools.item, 0);
			new.set_e_transition (length, 1);
			new.set_e_transition (1, length);
			if not case_sensitive then
				new.remove_case_sensitiveness
			end;
			last_created_tool := last_created_tool + 1;
			l_tools.finish;
			l_tools.put_right (new);
			l_tool_names.go_i_th (c);
			create c_name.make (0);
			c_name.precede ('*');
			c_name.extend ('(');
			c_name.append (l_tool_names.item);
			c_name.extend (')');
			l_tool_names.finish;
			l_tool_names.put_right (c_name)
		end;

	iteration_n (n, c: INTEGER)
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
			l_tools: like tool_list
			l_tool_names: like tool_names
		do
			l_tools := tool_list
			l_tool_names := tool_names
			check
				l_tools_attached: l_tools /= Void
				l_tool_names_attached: l_tool_names /= Void
			end

			l_tools.go_i_th (c);
			new := l_tools.item;
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
			l_tools.finish;
			l_tools.put_right (a_prefix);
			l_tool_names.go_i_th (c);
			create c_name.make (0);
			c_name.append_integer (n);
			c_name.extend ('(');
			c_name.append (l_tool_names.item);
			c_name.extend (')');
			l_tool_names.finish;
			l_tool_names.put_right (c_name)
		end;

	union2 (a, b: INTEGER)
			-- Create regular expression `a' | `b': union of
			-- `a' and `b' (matches an occurrence of `a' or `b')).
		require
			not_frozen: not lexical_frozen;
			a_in_tool: a >= 1 and a <= last_created_tool;
			b_in_tool: b >= 1 and b <= last_created_tool
		local
			new: PDFA;
			length, a_length, b_length: INTEGER;
			a_transitions, b_transitions: detachable LINKED_LIST [INTEGER];
			c_name: STRING
			l_tools: like tool_list
			l_tool_names: like tool_names
		do
			l_tools := tool_list
			l_tool_names := tool_names
			check
				l_tools_attached: l_tools /= Void
				l_tool_names_attached: l_tool_names /= Void
			end

			l_tools.go_i_th (a);
			a_length := l_tools.item.nb_states;
			a_transitions := l_tools.item.item (a_length);
			l_tools.go_i_th (b);
			b_length := l_tools.item.nb_states;
			b_transitions := l_tools.item.item (b_length);
			length := a_length + b_length + 2;
			if length = 6 and then
					(a_transitions = Void and b_transitions = Void) then
					-- If `a' and `b' are categories,
					-- `a' | `b' must also be one.
					-- not 'a'|+('b') ==> test of transition number.
				debug ("lex_output")
					io.put_string ("Union2, length = 6");
					io.new_line;
				end;
				create new.make (2, last_character_code);
				new.include (l_tools.item, 0);
				l_tools.go_i_th (a);
				new.include (l_tools.item, 0)
			else
				debug
					io.put_string ("Union2, length /= 6");
					io.new_line;
				end;
				create new.make (length, last_character_code);
				new.include (l_tools.item, a_length + 1);
				l_tools.go_i_th (a);
				new.include (l_tools.item, 1);
				new.set_e_transition (1, 2);
				new.set_e_transition (1, a_length + 2);
				new.set_e_transition (a_length + 1, length);
				new.set_e_transition (length - 1, length)
			end;
			if not case_sensitive then
				new.remove_case_sensitiveness
			end;
			last_created_tool := last_created_tool + 1;
			l_tools.finish;
			l_tools.put_right (new);
			create c_name.make (0);
			l_tool_names.go_i_th (a);
			c_name.append (l_tool_names.item);
			c_name.extend ('|');
			l_tool_names.go_i_th (b);
			c_name.append (l_tool_names.item);
			l_tool_names.finish;
			l_tool_names.put_right (c_name)
		end;

	union (a, b: INTEGER)
			-- Create regular expression for the multiple union
			-- `a' | `a'+1 | .. | `b': matches any occurrence of
			-- `a', or `a'+1, .., or `b'.
		require
			not_frozen: not lexical_frozen;
			a_not_too_small: a >= 1;
			b_not_too_large: b <= last_created_tool;
			a_smaller_than_b: a <= b
		local
			new, cat: detachable PDFA;
			tool_p, length, index: INTEGER;
			c_name: STRING;
			cat_set, non_cat_set: FIXED_INTEGER_SET
			l_tools: like tool_list
			l_tool_names: like tool_names
		do
			l_tools := tool_list
			l_tool_names := tool_names
			check
				l_tools_attached: l_tools /= Void
				l_tool_names_attached: l_tool_names /= Void
			end

			create cat_set.make (b);
			create non_cat_set.make (b);
			length := 2;
			from
				l_tools.go_i_th (a)
			until
				l_tools.index = b + 1
			loop
				if l_tools.item.nb_states > 2 then
					non_cat_set.put (l_tools.index);
					length := length + l_tools.item.nb_states
				else
					cat_set.put (l_tools.index)
				end;
				l_tools.forth
			end;
			if not cat_set.is_empty then
				create cat.make (2, last_character_code);
				from
					tool_p := cat_set.smallest
				until
					tool_p > b
				loop
					l_tools.go_i_th (tool_p);
					cat.include (l_tools.item, 0);
					tool_p := cat_set.next (tool_p)
				end
			end;

			check cat_attached: cat /= Void end
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
					l_tools.go_i_th (tool_p);
					new.include (l_tools.item, index - 1);
					new.set_e_transition (1, index);
					index := index + l_tools.item.nb_states;
					new.set_e_transition (index - 1, length);
					tool_p := non_cat_set.next (tool_p)
				end
			end;
			if not case_sensitive then
				new.remove_case_sensitiveness
			end;
			last_created_tool := last_created_tool + 1;
			l_tools.finish;
			l_tools.put_right (new);
			create c_name.make (0);
			from
				l_tool_names.go_i_th (a);
			until
				l_tool_names.index = b
			loop
				c_name.append (l_tool_names.item);
				c_name.extend ('|');
				l_tool_names.forth
			end;
			c_name.append (l_tool_names.item);
			l_tool_names.finish;
			l_tool_names.put_right (c_name)
		end;

	set_word (word: STRING)
			-- Create regular expression for `word':
			-- synonym for concatenation (`w' `o' `r' `d').
		require
			word_not_empty: word.count >= 1
		local
			new_tool: PDFA;
			length, code, i: INTEGER;
			tool_name: STRING
			l_tools: like tool_list
			l_tool_names: like tool_names
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

			l_tools := tool_list
			l_tool_names := tool_names
			check
				l_tools_attached: l_tools/= Void
				l_tool_names_attached: l_tool_names /= Void
			end
			last_created_tool := last_created_tool + 1;
			l_tools.finish;
			l_tools.put_right (new_tool);
			tool_name := word.twin
			tool_name.precede ('"');
			tool_name.extend ('"');
			l_tool_names.finish;
			l_tool_names.put_right (tool_name)
		end;

	up_to (word: STRING)
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
			l_tools: like tool_list
			l_tool_names: like tool_names
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

			l_tools := tool_list
			l_tool_names := tool_names
			check
				l_tools_attached: l_tools/= Void
				l_tool_names_attached: l_tool_names /= Void
			end
			l_tools.finish;
			l_tools.put_right (new_tool);
			create r_name.make (4);
			r_name.extend ('-');
			r_name.extend ('>');
			r_name.extend ('"');
			r_name.append (word);
			r_name.extend ('"');
			l_tool_names.finish;
			l_tool_names.put_right (r_name)
		end;

	put_keyword (s: STRING; exp: INTEGER)
			-- Declare `s' as a keyword described by
			-- the regular expression of code `exp'.
			--| Do not check if `s' is recognized by `exp'.
			--| This is done when the dfa is built.
		require
			not_frozen: not lexical_frozen;
			exp_selected: attached token_type_list as rl_token_types and then rl_token_types.has(exp)
		local
			u, l: STRING;
			index: INTEGER
			l_selected_tools: like selected_tools
			l_token_types: like token_type_list
			l_tools: like tool_list
		do
			l_selected_tools := selected_tools
			l_token_types := token_type_list
			l_tools := tool_list
			check
				l_selected_tools_attached: l_selected_tools /= Void
				l_token_types_attached: l_token_types /= Void
				l_tools_attached: l_tools /= Void
			end
			index := l_token_types.index_of (exp, 1);
			l_tools.go_i_th (l_selected_tools.i_th (index));
			l_tools.item.add_keyword (s.twin);
			last_declared_keyword := last_declared_keyword + 1;
			if not keywords_case_sensitive then
				l := s.as_lower
				l_tools.item.add_keyword (l);
				u := s.as_upper
				l_tools.item.add_keyword (u);
				last_declared_keyword := last_declared_keyword + 2
			end
		end;

	select_tool (i: INTEGER)
			-- Select the `i'_th tool for inclusion in the main
			-- regular expression.
		require
			not_frozen: not lexical_frozen;
			i_exist: i > 0 and i <= last_created_tool
		local
			l_selected_tools: like selected_tools
			l_token_types: like token_type_list
			l_tools: like tool_list
		do
			l_selected_tools := selected_tools
			l_token_types := token_type_list
			if l_selected_tools = Void then
				create l_selected_tools.make;
				selected_tools := l_selected_tools
				create l_token_types.make
				token_type_list := l_token_types
			end;
			check l_token_types_attached: l_token_types /= Void end
			l_selected_tools.finish;
			l_selected_tools.put_right (i);
			l_selected_tools.finish;
			l_token_types.finish;
			l_token_types.put_right (i);
			l_token_types.finish;

			l_tools := tool_list
			check l_tools_attached: l_tools /= Void end
			l_tools.go_i_th (i);
			nb_states := nb_states + l_tools.item.nb_states
		ensure
			selected_tools_attached: selected_tools /= Void
			token_types_attached: token_type_list /= Void
			i_selected: attached selected_tools as el_selected_tools and then el_selected_tools.has (i)
		end;

	associate (t, n: INTEGER)
			-- Associate the `t'-th tool with token type `n'.
			-- If this routine is not used, the default value is `t'.
		require
			t_selected: attached selected_tools as rl_selected_tools and then rl_selected_tools.has (t);
			n_not_zero: n /= 0;
			n_not_minus_one: n /= -1
				-- 0 is reserved for the non-final states.
				-- -1 is reserved for the end of text.
		local
			l_selected_tools: like selected_tools
			l_token_types: like token_type_list
		do
			l_selected_tools := selected_tools
			l_token_types := token_type_list
			check
				l_selected_tools_attached: l_selected_tools /= Void
				l_token_types_attached: l_token_types /= Void
			end
			l_selected_tools.finish;
			if l_selected_tools.item = t then
				l_token_types.finish;
				l_token_types.put (n)
			else
				from
					l_selected_tools.start;
					l_token_types.start
				until
					l_selected_tools.item = t
				loop
					l_selected_tools.forth;
					l_token_types.forth
				end;
				l_token_types.put (n)
			end
		end;

	recognize (s: STRING): INTEGER
			-- Token_type of `s'; 0 if not recognized
		local
			i: INTEGER;
			l: LINKED_LIST [INTEGER];
			l_dfa: like dfa
			l_categories: like categories_table
		do
			l_dfa := dfa
			l_categories := categories_table
			check
				l_dfa_attached: l_dfa /= Void
				l_categories_attached: l_categories /= Void
			end
			create l.make;
			from
				i := 1
			until
				i = s.count + 1
			loop
				l.put_right (l_categories.item (s.item (i).code));
				l.forth;
				i := i + 1
			end;
			Result := l_dfa.recognize (l)
		end;

feature -- Removal

	remove
			-- Remove the last regular expression
			-- from the tool list.
		require
			not_frozen: not lexical_frozen;
			at_least_one_regular: last_created_tool >= 1
		local
			l_tools: like tool_list
			l_tool_names: like tool_names
		do
			l_tools := tool_list
			l_tool_names := tool_names
			check
				l_tools_attached: l_tools /= Void
				l_tool_names_attached: l_tool_names /= Void
			end

			last_created_tool := last_created_tool - 1;
			l_tools.finish;
			l_tool_names.finish;
			l_tools.remove;
			l_tool_names.remove
		end;

feature -- Input

	retrieve_analyzer (file_name: STRING)
			-- Retrieve `analyzer' from file named `file_name'.
		local
			retrieved_file: RAW_FILE
		do
			create retrieved_file.make_open_read (file_name);
			if attached {like analyzer} retrieved_file.retrieved as l_analyzer then
				analyzer := l_analyzer
			else
				analyzer := Void
			end
			retrieved_file.close
		end;

feature -- Output

	store_analyzer (file_name: STRING)
			-- Store `analyzer' in file named `file_name'.
		require
			initialized: initialized
		local
			l_analyzer: like analyzer
			store_file: RAW_FILE
		do
			l_analyzer := analyzer
			if l_analyzer = Void then
				create l_analyzer.make
				analyzer := l_analyzer
			end;
			create store_file.make_open_write (file_name);
			store_file.basic_store (l_analyzer);
			store_file.close
		ensure
			analyzer_attached: analyzer /= Void
		end;

feature -- Implementation

	initialized: BOOLEAN;
			-- Is analyzer initialized?

feature {NONE} -- Implementation

	last_declared_keyword: INTEGER;
			-- Identification number of the last keyword declared

	readable_form (c: CHARACTER): STRING
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

	freeze_lexical
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

	creation_with_all_inputs
			-- Create main PDFA, including all the selected tools.
			-- Very important: for each tool this routine assumes
			-- that the initial state in the first one, and the
			-- final state is the last one.
		require
			not_frozen: not lexical_frozen
		local
			shift: INTEGER;
			fa: PDFA
			l_selected_tools: like selected_tools
			l_token_types: like token_type_list
			l_tool_names: like tool_names
			l_tools: like tool_list
		do
			nb_states := nb_states + 1;
			pdfa_make (nb_states, last_character_code);
			l_selected_tools := selected_tools
			l_token_types := token_type_list
			l_tools := tool_list
			check
				l_selected_tools_attached: l_selected_tools /= Void
				l_token_types_attached: l_token_types /= Void
				l_tools_attached: l_tools /= Void
			end
			from
				l_selected_tools.start;
				l_token_types.start;
				shift := 1
			until
				l_selected_tools.after or l_selected_tools.is_empty
			loop
				set_e_transition (1, shift + 1);
				fa := l_tools.i_th (l_selected_tools.item);
				include (fa, shift);
				shift := shift + fa.nb_states;
				set_final (shift, l_token_types.item);
				debug ("lex_output")
					io.put_string (" Tool selected: ");
					io.put_integer (l_selected_tools.item);
					io.put_string (" Description: ");
					l_tool_names := tool_names
					check l_tool_names_attached: l_tool_names /= Void end
					io.put_string (l_tool_names.i_th (l_selected_tools.item));
					io.put_string (" Token type associated: ");
					io.put_integer (l_token_types.item);
					io.new_line
				end;
				l_selected_tools.forth;
				l_token_types.forth
			end
		end;

	build_categories_table
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
			set, old_set: detachable FIXED_INTEGER_SET
			l_categories: like categories_table
		do
			create set_tree.make_filled (nb_states, 0);
			create l_categories.make (-1, last_character_code);
			categories_table := l_categories
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
						l_categories.put (set_position, in_put)
					else
						search_in_tree (set);
						old_set := set;
						l_categories.put (set_position, in_put)
					end
				end
			end;
			greatest_input := new_number;
			new_number := 0;
			set_tree := Void
		ensure
			categories_table_attached: categories_table /= Void
		end;

	creation_with_categories
			-- Re-Create main PDFA, using categories_table,
			-- and bringing together the inputs of the same category.
			-- This routine do not deal with the epsilon transitions,
			-- which are left unchanged.
		require
			categories_table: categories_table /= Void
		local
			new_input_array: ARRAY [detachable FIXED_INTEGER_SET];
			category, in_put: INTEGER
			l_categories: like categories_table
		do
			l_categories := categories_table
			check l_categories_attached: l_categories /= Void end
			create new_input_array.make (0, greatest_input);
			from
				in_put := -1
			until
				in_put = last_character_code
			loop
				in_put := in_put + 1;
				category := l_categories.item (in_put);
				if new_input_array.item (category) = Void and then attached input_array.item (in_put) as l_input_array_item then
					new_input_array.put (l_input_array_item, category)
				end
			end;
			input_array := new_input_array
		end;

	copy_keywords
			-- Copy the keywords in the hash table.
		local
			k_list: LINKED_LIST [STRING];
			k: STRING;
			tool_number, token_type: INTEGER
			l_selected_tools: like selected_tools
			l_token_types: like token_type_list
			l_keywords: like keyword_h_table
			l_tools: like tool_list
		do
			if last_declared_keyword > 0 then
				create l_keywords.make (last_declared_keyword)
				keyword_h_table := l_keywords
			end;
			l_selected_tools := selected_tools
			l_token_types := token_type_list
			l_tools := tool_list
			check
				l_selected_tools_attached: l_selected_tools /= Void
				l_token_types_attached: l_token_types /= Void
				l_tools_attached: l_tools /= Void
			end
			from
				l_selected_tools.start;
				l_token_types.start
			until
				l_selected_tools.after or l_selected_tools.is_empty
			loop
				tool_number := l_selected_tools.item;
				token_type := l_token_types.item;
				k_list := l_tools.i_th (tool_number).keywords_list;
				from
					k_list.start
				until
					k_list.after or k_list.is_empty
				loop
					k := k_list.item;
					check l_keywords_attached: l_keywords /= Void end
					l_keywords.put (token_type, k);
					if not recognized (k, token_type) then
						error_keyword (tool_number, k)
					end;
					k_list.forth
				end;
				l_selected_tools.forth;
				l_token_types.forth
			end
		end;

	recognized (kwd: STRING; token_type: INTEGER): BOOLEAN
			-- Is `kwd' recognized by the regular
			-- expression number `token_type'?
		require
			dfa_attached: dfa /= Void
			kwd_attached: kwd /= Void
		local
			i: INTEGER;
			l: LINKED_LIST [INTEGER];
			l_tokens: detachable ARRAY [INTEGER]
			l_dfa: like dfa
			l_categories: like categories_table
		do
			l_categories := categories_table
			l_dfa := dfa
			check
				l_categories_attached: l_categories /= Void
				l_dfa_attached: l_dfa /= Void
			end

			create l.make;
			from
				i := 1
			until
				i = kwd.count + 1
			loop
				l.put_right (l_categories.item (kwd.item (i).code));
				l.forth;
				i := i + 1
			end;

			l_tokens := l_dfa.possible_tokens (l);
			check l_tokens_attached: l_tokens /= Void end
			from
				i := l_tokens.lower
			until
				Result or i > l_tokens.upper
			loop
				Result := (l_tokens.item (i) = token_type);
				i := i + 1
			end
		end;

	dfa_set_final (s, new_final: INTEGER)
			-- Set the attribute `final' of state `s' to `new_final'.
		local
			old_final: INTEGER;
			l_dfa: like dfa
			l_state_of_dfa: detachable STATE_OF_DFA
		do
			l_dfa := dfa
			check l_dfa_attached: l_dfa /= Void end
			l_state_of_dfa := l_dfa.item (s)
			check l_state_of_dfa /= Void end
			old_final := l_state_of_dfa.final;
			if old_final = 0 then
				l_state_of_dfa.set_final (new_final)
			elseif old_final /= new_final then
				error_common_part (old_final, new_final);
				l_state_of_dfa.set_final (new_final)
			end
		end;

	error_common_part (first, second: INTEGER)
			-- Create an error message when a regular expression can
			-- be recognized by the first and the second token type.
			-- Example "aa" is recognized by +(a..z) and 2(a).
			-- The first will yield the priority to the second.
		require
			first_and_second_is_a_token_type: attached token_type_list as rl_token_types and then
				rl_token_types.has (first) and then
				rl_token_types.has (second)
		local
			message: STRING
			l_selected_tools: like selected_tools
			l_token_types: like token_type_list
			l_tool_names: like tool_names
		do
			l_selected_tools := selected_tools
			l_token_types := token_type_list
			l_tool_names := tool_names
			check
				l_selected_tools_attached: l_selected_tools /= Void
				l_token_types_attached: l_token_types /= Void
				l_tool_names_attached: l_tool_names /= Void
			end

			create message.make (0);
			message.append ("Warning: some tokens can be recognized by ");
			l_token_types.start;
			l_token_types.search (first);
			l_selected_tools.go_i_th (l_token_types.index);
			l_tool_names.go_i_th (l_selected_tools.item);
			message.append (l_tool_names.item);
			message.append (" and by ");
			l_token_types.start;
			l_token_types.search (second);
			l_selected_tools.go_i_th (l_token_types.index);
			l_tool_names.go_i_th (l_selected_tools.item);
			message.append (l_tool_names.item);
			message.append (".%N	The second one has priority.");
			error_list.add_message (message)
		end;

	error_keyword (t: INTEGER; k: STRING)
			-- Create an error message when a keyword k is not
			-- recognized by the corresponding tool.
		local
			message: STRING
			l_tools_names: like tool_names
			l_name: detachable STRING
		do
			create message.make (0);
			message.append ("Warning: ");
			message.append (k);
			message.append (" is not recognized by ");
			l_tools_names := tool_names
			check l_tools_names_attached: l_tools_names /= Void end
			l_name := l_tools_names.i_th (t)
			check l_name_attached: l_name /= Void end
			message.append (l_name);
			message.extend ('.');
			error_list.add_message (message)
		end;

invariant
	analyzer_attached: initialized implies analyzer /= Void
	last_created: not attached tool_list as il_tool_list or else last_created_tool = il_tool_list.count

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class LEX_BUILDER


