class TEST

create
	make

feature

	is_character_printable_32 (a_char: CHARACTER_32): BOOLEAN
			-- Is `a_char' printable?
		do
			Result := not a_char.is_character_8 or else a_char.to_character_8.is_printable
		end

	is_character_printable_8 (a_char: CHARACTER_32): BOOLEAN
			-- Is `a_char' printable?
		do
			Result := not a_char.is_character_8 or else a_char.to_character_8.is_printable
		end

	 make
		do
			io.put_boolean (is_character_printable_8 ('a'))
			io.put_boolean (is_character_printable_32 ({CHARACTER_32} 'a'))
			io.put_new_line
		end

end
