indexing
	description: "Actual type for character type."
	date: "$Date$"
	revision: "$Revision $"

class CHARACTER_A

inherit
	BASIC_A
		redefine
			is_character, type_i, associated_class, same_as,
			internal_conform_to, associated_eclass
		end

feature -- Property

	is_character: BOOLEAN is True
			-- Is the current type a character type ?

feature -- Access

	same_as (other: TYPE_A): BOOLEAN is
			-- Is the current type the same as `other' ?
		do
			Result := other.is_character
		end

	associated_eclass: CLASS_C is
			-- Associated eiffel class
		once
			Result := System.character_class.compiled_class
		end

feature {COMPILER_EXPORTER}

	internal_conform_to (other: TYPE_A; in_generics: BOOLEAN): BOOLEAN is
			-- Does `other' conform to Current ?
		do
			if in_generics then
				Result := other.is_character
			else
				Result := {BASIC_A} precursor (other, False)
			end
		end

	type_i: CHAR_I is
			-- C type
		once
			Result := Char_c_type
		end

	associated_class: CLASS_C is
			-- Class CHARACTER
		require else
			System.character_class.compiled
		once
			Result := System.character_class.compiled_class
		end

end -- class CHARACTER_A
