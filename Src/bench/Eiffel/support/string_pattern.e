class STRING_PATTERN

inherit
	STRING

creation
	make

feature -- Status setting

	set_string_representation (new_str_rep: CHARACTER) is
			-- Set `string_representation' to
			-- `new_str_rep'.
		require
			new_str_rep_non_void: new_str_rep /= Void
		do
			str_rep := new_str_rep;
		ensure
			string_representation_is_new_str_rep: string_representation = new_str_rep
		end;

	set_character_representation (new_char_rep: CHARACTER) is
			-- Set `character_representation' to
			-- `new_char_rep'.
		require
			new_char_rep_non_void: new_char_rep /= Void
		do
			char_rep := new_char_rep;
		ensure
			character_representation_is_new_char_rep: character_representation = new_char_rep
		end;
	
feature -- Status report

	character_representation: CHARACTER is
			-- The character that represents any single
			-- character in `text'. Default: '?'
		do
			if char_rep = Void then
				Result := '?';
			else
				Result := char_rep;
			end;
		end;

	string_representation: CHARACTER is
			-- The character that represents any string
			-- in `text'. Default: '*'
		do
			if str_rep = Void then
				Result := '*';
			else
				Result := str_rep;
			end;
		end;

	has_wild_cards: BOOLEAN is
			-- Has the Current either of `string_representation' or
			-- `character_representation'.
		do
			Result := has (string_representation) or else
				  has (character_representation);
		end;
feature -- Comparison

        str_is_equal (other: STRING): BOOLEAN is
                        -- Is string made of same character sequence as `other'
                        -- (possibly with a different capacity)?
                local
                        o_area: like area;
                        i: INTEGER
                do
                        if count = other.count then
                                o_area := other.area;
                                i := str_cmp ($area, $o_area, count, other.count
);
                                Result := (i = 0);
                        end;
                end;

	matches (other: STRING): BOOLEAN is
			-- Matches `other' the Current pattern ?
		require
			has_wild_cards: has_wild_cards;
			other_non_void: other /= Void;
		local
			automaton_area, input_area: SPECIAL [CHARACTER]
			automaton_index, automaton_count: INTEGER
			input_index, input_count: INTEGER
			next_automaton, automaton_char, input_char, s_r, c_r: CHARACTER
			str_rep_str: STRING
 		do
			s_r := str_rep;
			c_r := char_rep;
			!! str_rep_str.make (0);
			str_rep_str.extend (s_r);
			if count > other.count then
				Result := false
			elseif str_is_equal(str_rep_str) then
				Result := true
			else

				from
					automaton_area := area
					input_area := other.area
					automaton_count := count
					input_count := other.count
					Result := true;
				until
					automaton_index >= automaton_count or else
					input_index >= input_count or else
					not Result
				loop
					automaton_char := automaton_area.item(automaton_index)
					input_char := input_area.item(input_index)
					if automaton_index + 1 < automaton_count then
						next_automaton := automaton_area.item(automaton_index + 1)
					else
						input_index := input_count
						automaton_index := automaton_count
					end
	
					if automaton_char.is_equal (s_r)  then
						if next_automaton = Void then
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
						automaton_index := automaton_index + 1
						input_index := input_index + 1
					else
						if automaton_char /= input_char then
							Result := false
						else
							automaton_index := automaton_index + 1
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

feature {NONE} -- Attributes

	char_rep: CHARACTER;
			-- Character that represents any single character.

	str_rep: CHARACTER;
			-- Character that represents any number of characters.

end -- class STRING_PATTERN
