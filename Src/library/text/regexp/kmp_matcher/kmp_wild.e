note
	description: "[
		Pattern match algorithm to match a pattern containing wild cards.
		Done through the Knuth, Morris, Pratt algorithm.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class KMP_WILD

inherit
	KMP_MATCHER
		redefine
			make_empty,
			found_at,
			set_pattern,
			search_for_pattern,
			found_pattern_length,
			find_matching_indices,
			lengths
		end

create
	make, make_empty

feature {NONE} -- Initialization

	make_empty
			-- Create a matcher to search for a pattern
			-- in a text. Initialize it later.
		do
			character_representation := '?';
			string_representation := '*'
			create string_list.make
			Precursor {KMP_MATCHER}
		end

feature -- Access

	found_pattern_length: INTEGER
			-- length of the found pattern in text

	lengths: detachable ARRAYED_LIST [INTEGER]
			-- lengths of found patterns in text

feature -- Status setting

	set_pattern (new_pattern: READABLE_STRING_GENERAL)
			-- Set the `pattern' to `new_pattern'.
		do
			pattern := new_pattern.as_string_32
		end

	set_string_representation (new_str_rep: CHARACTER_32)
			-- Set `string_representation' to
			-- `new_str_rep'.
		require
			new_str_rep_not_nul_char: new_str_rep /= '%U'
			new_str_rep_different: new_str_rep /= character_representation
		do
			string_representation := new_str_rep
		ensure
			string_representation_is_new_str_rep: string_representation = new_str_rep
		end

	set_character_representation (new_char_rep: CHARACTER_32)
			-- Set `character_representation' to
			-- `new_char_rep'.
		require
			new_char_rep_not_nul_char: new_char_rep /= '%U'
			new_char_rep_different: new_char_rep /= string_representation
		do
			character_representation := new_char_rep
		ensure
			character_representation_is_new_char_rep: character_representation = new_char_rep
		end

feature -- Status report

	found_at: INTEGER
		-- Index in `text' where `pattern' was found.

	character_representation: CHARACTER_32
			-- The character that represents any single
			-- character in `text'.
			--| Default: '?'

	string_representation: CHARACTER_32
			-- The character that represents any string
			-- in `text'.
			--| Default: '*'

	has_wild_cards: BOOLEAN
			-- Has Current either of `string_representation' or
			-- `character_representation'?
		require
			pattern_set: pattern /= Void
		do
			Result := pattern.has (string_representation) or else
				  pattern.has (character_representation)
		end

feature -- Search

	pattern_matches: BOOLEAN
			-- Does `text' exactly match `pattern'?
		local
			lsi: STRING_32
			as_star: BOOLEAN
			offset: INTEGER
			ls: like string_list
			txt: like text
			c: CHARACTER_32
		do
			if
				search_for_pattern and then
				(found_at = 1 or else pattern [1] = string_representation)
			then
				txt := text
				ls := string_list
				from
					ls.finish
					offset := txt.count
					Result := True
				until
					ls.before or as_star or not Result
				loop
					lsi := ls.item
					check
							-- Implied by invariant
						lsi_not_empty: not lsi.is_empty
					end
					c := lsi [1]
					if c = string_representation then
						as_star := True
					elseif c = character_representation then
						offset := offset - 1
					else
						Result := imp_same_substring (txt, offset - lsi.count + 1, offset, lsi)
						offset := offset - lsi.count
					end
					ls.back
				end
				if not as_star then
					Result := found_pattern_length = txt.count
				end
			end
		end

	search_for_pattern: BOOLEAN
			-- Search in the text to find the very next
			-- occurrence of `pattern'.
		local
			ls: like string_list
			lsi: STRING_32
			fa, i, tc, pc, tcmpc, i_before_loop: INTEGER
			sr, cr: STRING_32
			kmp_matcher: KMP_MATCHER
			str_without_wild: STRING_32
			is_star: BOOLEAN
			old_pattern: like pattern
			old_text: like text
		do
			old_text := text
			old_pattern := pattern
			if is_not_case_sensitive then
				pattern := pattern.as_lower
				text := text.as_lower
			end
			init_list
			create sr.make (1)
			sr.extend (string_representation)
			create cr.make (1)
			cr.extend (character_representation)
			tc := text.count
			pc := pattern.count
			tcmpc := tc - pc
			if tcmpc = -1 and then pattern.item (pc) = string_representation then
				Result := imp_same_substring (pattern, 1, tc, text)
				if Result then
					fa := 1
				end
			end

			create kmp_matcher.make (pattern, text)

			str_without_wild := pattern.twin
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
								kmp_matcher.set_pattern (lsi)
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

	find_matching_indices
			-- All indices in `text' which matches the
			-- very next occurrence of `pattern'.
		local
			ls: like string_list
			lsi: STRING_32
			fa, i, tc, tcmpc: INTEGER
			sr, cr: STRING_32
			found_one: BOOLEAN
			kmp_matcher: KMP_MATCHER
			str_without_wild: STRING_32
			is_star: BOOLEAN
			offset, next_i: INTEGER
			old_pattern: like pattern
			old_text: like text
			l_indices: like matching_indices
			l_lengths: like lengths
		do
			old_text := text
			old_pattern := pattern
			if is_not_case_sensitive then
				pattern := pattern.as_lower
				text := text.as_lower
			end
			init_list
			create {ARRAYED_LIST [INTEGER]} l_indices.make (10)
			matching_indices := l_indices

			create {ARRAYED_LIST [INTEGER]} l_lengths.make (10)
			lengths := l_lengths
			create sr.make (1)
			sr.extend (string_representation)
			create cr.make (1)
			cr.extend (character_representation)
			tc := text.count
			tcmpc := tc - pattern.count
			create kmp_matcher.make (pattern, text)
			str_without_wild := pattern.twin
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
										found_one := not is_star implies kmp_matcher.found_at = i
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
							found_one := found_one and then (i <= tc + 1 or else ls.after)
						end
						if found_one then
							l_indices.extend (fa)
							l_lengths.extend (i- fa)
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
		ensure then
			created: lengths /= Void
		end

feature {NONE} -- Attributes

	string_list: LINKED_LIST [STRING_32]
			-- List of strings.
			--| Parts not containing `string_representation' and
			--| `character_representation' are held as items

feature {NONE} -- Implementation

	init_list
			-- Initializes the list for the wild carded
			-- pattern.
		local
			ls: like string_list
			str: STRING_32
			i, pc: INTEGER
			pa: SPECIAL [CHARACTER_32]
			sr, cr: STRING_32
			c: CHARACTER_32
		do
			from
				create ls.make
				string_list := ls
				create str.make (0)
				create sr.make (1)
				sr.extend (string_representation)
				create cr.make (1)
				cr.extend (character_representation)
				pa := pattern.area
				pc := pattern.count
				i := 0
			until
				i = pc
			loop
				c := pa.item (i)
				if c = string_representation then
					if str.count > 0 then
						ls.extend (str)
					end
					ls.extend (sr)
					create str.make (0)
				elseif c = character_representation then
					if str.count > 0 then
						ls.extend (str)
					end
					ls.extend (cr)
					create str.make (0)
				else
					str.extend (pa.item (i))
				end
				i := i + 1
			end;
			if str.count > 0 then
				ls.extend (str)
			end
		end

	last_string_matches: BOOLEAN
		local
			i: INTEGER
			ls: like string_list
			lsi: STRING_32
			txt: like text
			txt_count: INTEGER
		do
			ls := string_list
			if not ls.is_empty then
				if ls.last.item (1) = string_representation then
					Result := True
				else
					txt := text
					txt_count := txt.count
					from
						i := 0
						ls.finish
					until
						ls.before or else ls.item [1] /= character_representation
					loop
						i := i + 1
						ls.back
					end
					lsi := ls.item
					if ls.before or else lsi [1] = string_representation then
						Result := True
					else
						Result := imp_same_substring (txt, txt_count - lsi.count - i + 1, txt_count - i, lsi)
					end
				end
 			end
		end

	imp_same_substring (a_text: STRING_32; a_text_start, a_text_end: INTEGER; a_string: STRING_32): BOOLEAN
			-- Optimized code for `a_text.substring (a_text_start, a_text_end).is_equal (a_string)'?
		require
			a_text_not_empty: a_text /= Void
			a_string_attached: a_string /= Void
		local
			i, j, m, n: INTEGER
		do
			m := a_text.count
			n := a_string.count
			if m >= n then
				if
					1 <= a_text_start and
					a_text_start <= a_text_end and
					a_text_end <= m
				then
					from
						i := 1
						j := a_text_start
						Result := a_text_end - a_text_start + 1 = n
					until
						not Result or i > n or j > a_text_end
					loop
						Result := a_text.item (j) = a_string.item (i)
						i := i + 1
						j := j + 1
					end
				else
					Result := a_string.is_empty
				end
			end
		ensure
			result_correct: a_text.substring (a_text_start, a_text_end).is_equal (a_string)
		end

invariant

	attached_string_list: string_list /= Void
	string_list_contains_non_empty_item: string_list.for_all (agent (s: STRING_32): BOOLEAN do Result := s /= Void and then not s.is_empty end)
	different_character_and_string_representation: string_representation /= character_representation

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
