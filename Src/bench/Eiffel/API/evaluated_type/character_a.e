-- Actual type for character type

class CHARACTER_A

inherit

	BASIC_A
		rename
			internal_conform_to as old_conform_to
		redefine
			is_character, dump, type_i, associated_class, same_as
		end;
	BASIC_A
		redefine
			is_character, dump, type_i, associated_class, same_as,
			internal_conform_to
		select
			internal_conform_to
		end

feature

	internal_conform_to (other: TYPE_A; in_generics: BOOLEAN): BOOLEAN is
			-- Does `other' conform to Current ?
		do
			if in_generics then
				Result := other.is_character;
			else
				Result := old_conform_to (other, False);
			end;
		end;

	is_character: BOOLEAN is
			-- Is the current type a character type ?
		do
			Result := True;
		end;

	dump: STRING is "CHARACTER";
			-- Dumped trace

	type_i: CHAR_I is
			-- C type
		once
			Result := Char_c_type;
		end;

	associated_class: CLASS_C is
			-- Class CHARACTER
		require else
			System.character_class.compiled;
		once
			Result := System.character_class.compiled_class;
		end;

	same_as (other: TYPE_A): BOOLEAN is
			-- Is the current type the same as `other' ?
		do
			Result := other.is_character;
		end;

end
