indexing
	description: "Actual type for character type."
	date: "$Date$"
	revision: "$Revision $"

class CHARACTER_A

inherit
	BASIC_A
		rename
			make as cl_make
		redefine
			is_character, type_i, associated_class, same_as,
			internal_conform_to
		end

create
	make

feature -- Initialization

	make (w: BOOLEAN) is
			-- Create instance of CHARACTER_A. If `w' a normal character.
			-- Otherwise a wide character.
		do
			is_wide := w
		ensure
			is_wide_set: is_wide = w
		end

feature -- Property

	is_character: BOOLEAN is True
			-- Is the current type a character type ?

	is_wide: BOOLEAN
			-- Is current character a wide one?

feature -- Access

	same_as (other: TYPE_A): BOOLEAN is
			-- Is the current type the same as `other' ?
		local
			char: like Current
		do
			Result := other.is_character
			if Result then
				char ?= other
				Result := is_wide = char.is_wide
			end
		end

	associated_class: CLASS_C is
			-- Class CHARACTER
		do
			if is_wide then
				Result := System.wide_char_class.compiled_class
			else
				Result := System.character_class.compiled_class
			end
		end

feature {COMPILER_EXPORTER}

	internal_conform_to (other: TYPE_A; in_generics: BOOLEAN): BOOLEAN is
			-- Does `other' conform to Current ?
		local
			char: like Current
		do
			if in_generics then
				Result := same_as (other)
			else
				Result := {BASIC_A} Precursor (other, False)
				if not Result and then other.is_character then
					char ?= other
					Result := is_wide or else not char.is_wide
				end
			end
		end

	type_i: CHAR_I is
			-- C type
		do
			if is_wide then
				Result := Wide_char_c_type
			else
				Result := Char_c_type
			end
		end

end -- class CHARACTER_A
