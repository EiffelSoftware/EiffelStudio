class STRING_PATTERN

inherit
	STRING
		rename
			make as str_make
		end;
	STRING
		redefine
			make
		select
			make
		end

creation
	make

feature {NONE} -- Initialization

	make (size: INTEGER) is
			-- Create a new string object.
		do
			str_make (size);
			string_representation := '*';
			character_representation := '?'
		end

feature -- Status setting

	set_string_representation (new_str_rep: CHARACTER) is
			-- Set `string_representation' to
			-- `new_str_rep'.
		require
			new_str_rep_not_nul_char: new_str_rep /= '%U';
			different_string_representation: new_str_rep /= character_representation
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
			different_character_representation: new_char_rep /= string_representation
		do
			character_representation := new_char_rep
		ensure
			character_representation_is_new_char_rep: character_representation = new_char_rep
		end
	
feature -- Status report

	character_representation: CHARACTER
			-- The character that represents any single
			-- character in `text'
			--| Default: '?'

	string_representation: CHARACTER
			-- The character that represents any string
			-- in `text'
			--| Default: '*'

	has_wild_cards: BOOLEAN is
			-- Has Current either of `string_representation' or
			-- `character_representation'?
		do
			Result := has (string_representation) or else
				  has (character_representation);
		end

feature -- Comparison

	str_is_equal (other: STRING): BOOLEAN is
			-- Is string made of same character sequence as `other'
			-- (possibly with a different capacity)?
		local
			o_area: like area;
		do
			if count = other.count then
				o_area := other.area;
				Result := str_strict_cmp ($area, $o_area, count) = 0;
			end;
		end;

	matches (other: STRING): BOOLEAN is
			-- Matches `other' the Current pattern ?
		require
			has_wild_cards: has_wild_cards;
			other_non_void: other /= Void
		local
			automaton_area, input_area: SPECIAL [CHARACTER];
			automaton_index, automaton_count: INTEGER;
			input_index, input_count: INTEGER;
			next_automaton, automaton_char, input_char, s_r, c_r: CHARACTER;
			str_rep_str: STRING
			str_without_wild: STRING
 		do
			s_r := string_representation;
			c_r := character_representation;
			!! str_rep_str.make (0);
			str_rep_str.extend (s_r);
			if str_is_equal(str_rep_str) then
				Result := true
			else
				str_without_wild := clone (Current)
				str_without_wild.prune_all (s_r)
				
				if str_without_wild.count > other.count then
					Result := False
				else
					from
						automaton_area := area;
						input_area := other.area;
						automaton_count := count;
						input_count := other.count;
						Result := true
					until
						automaton_index >= automaton_count or else
						input_index >= input_count or else
						not Result or else
						(automaton_index + 1 = automaton_count and next_automaton = s_r)
					loop
						automaton_char := automaton_area.item(automaton_index);
						input_char := input_area.item(input_index);
						if automaton_index + 1 < automaton_count then
							next_automaton := automaton_area.item(automaton_index + 1)
						else
							if input_index + 1 < input_count then
									-- `other' has more characters then Current.
									-- For example: "*y" (Current) against "array2" (`other').
									-- These words do not match.
								Result := False
							else
								input_index := input_count
							end;
							automaton_index := automaton_count
						end
		
						if automaton_char.is_equal (s_r)  then
							if next_automaton = '%U' then
								input_index := input_index + 1
							else
								if next_automaton /= input_char then
									input_index := input_index + 1
								end
								if input_index < input_count and then 
										input_area.item (input_index) = next_automaton then
									automaton_index := automaton_index + 1
								end
							end
						elseif automaton_char = c_r then
							automaton_index := automaton_index + 1;
							input_index := input_index + 1
						else
							if automaton_char /= input_char then
								Result := false
							else
								automaton_index := automaton_index + 1;
								input_index := input_index + 1
							end
						end
					end
					if input_index >= input_count then
						if automaton_index + 1 = automaton_count then
							if not (automaton_area.item (automaton_index).is_equal (s_r)) and then
								not (automaton_area.item (automaton_index).is_equal (c_r)) then
								Result := false
							end
						elseif automaton_index < automaton_count then
							Result := false
						end
					end
				end
			end
		end

invariant

	different_character_and_string_representation: character_representation /= string_representation

end -- class STRING_PATTERN
