class CHAR_I

inherit
	BASIC_I
		rename
			make as base_make
		redefine
			dump,
			is_char,
			same_as,
			description, sk_value, generate_cecil_value, hash_code,
			generated_id, typecode
		end

create
	make

feature -- Initialization

	make (w: BOOLEAN) is
			-- Create instance of CHAR_I. If `w' a normal character.
			-- Otherwise a wide character.
		do
			is_wide := w
		ensure
			is_wide_set: is_wide = w
		end

feature -- Property

	is_wide: BOOLEAN
			-- Is current character a wide one?

	is_char: BOOLEAN is True
			-- Is the type a char type ?

feature -- Access

	level: INTEGER is
			-- Internal code for generation
		do
			if is_wide then
				Result := C_wide_char
			else
				Result := C_char
			end
		end

	typecode: INTEGER is
			-- Typecode for TUPLE element.
		do
			Result := feature {SHARED_TYPECODE}.character_code
		end

	same_as (other: TYPE_I): BOOLEAN is
			-- Is `other' equal to `Current' ?
		local
			char: like Current
		do
			if other.is_char then
				char ?= other
				Result := is_wide = char.is_wide
			end
		end

	description: CHAR_DESC is
			-- Type description for skeleton
		do
			create Result.make (is_wide)
		end

	dump (buffer: GENERATION_BUFFER) is
			-- Debug purpose
		do
			if is_wide then
				buffer.putstring ("EIF_WIDE_CHARACTER")
			else
				buffer.putstring ("EIF_CHARACTER")
			end
		end

	generate_cecil_value (buffer: GENERATION_BUFFER) is
			-- Generate cecil type value
		do
			if is_wide then
				buffer.putstring ("SK_WCHAR")
			else
				buffer.putstring ("SK_CHAR")
			end
		end

	c_string: STRING is
			-- String generated for the type.
		do
			if is_wide then
				Result := Wide_char_string
			else
				Result := Character_string
			end
		end

	c_string_id: INTEGER is
			-- String ID generated for the type.
		do
			if is_wide then
				Result := Wide_char_string_id
			else
				Result := Character_string_id
			end
		end

	union_tag: STRING is
		do
			if is_wide then
				Result := Union_wide_char_tag
			else
				Result := Union_character_tag
			end
		end

	hash_code: INTEGER is
			-- Hash code for current type
		do
			if is_wide then
				Result := Wide_char_code
			else
				Result := Character_code
			end
		end

	associated_reference: CLASS_TYPE is
			-- Reference class associated with simple type
		do
			if is_wide then
				Result := system.wide_char_ref_class.compiled_class.types.first
			else
				Result := system.character_ref_class.compiled_class.types.first
			end
		end

	sk_value: INTEGER is
			-- Generate SK value associated to the current type.
		do
			if is_wide then
				Result := Sk_wchar
			else
				Result := Sk_char
			end
		end

	generate_sk_value (buffer: GENERATION_BUFFER) is
			-- Generate SK value associated to current C type in `buffer'.
		do
			if is_wide then
				buffer.putstring ("SK_WCHAR")
			else
				buffer.putstring ("SK_CHAR")
			end
		end
	
	type_a: CHARACTER_A is
		do
			create Result.make (is_wide)
		end

	separate_get_macro: STRING is
			-- String generated to access the argument to a separate call
		do
			if is_wide then
				Result := "CURGWC"
			else
				Result := "CURGC"
			end
		end

	separate_send_macro: STRING is
			-- String generated to return the result of a separate call
		do
			if is_wide then
				Result := "CURSQRWC"
			else
				Result := "CURSQRC"
			end
		end

	generate_union (buffer: GENERATION_BUFFER) is
			-- Generate discriminant of C structure "item" associated
			-- to the current C type in `buffer'.
		do
			if is_wide then
				buffer.putstring ("it_wchar")
			else
				buffer.putstring ("it_char")
			end
		end

feature -- Generic conformance

	generated_id (final_mode : BOOLEAN) : INTEGER is

		do
			if is_wide then
				Result := Wide_char_type
			else
				Result := Character_type
			end
		end
feature

	make_basic_creation_byte_code (ba : BYTE_ARRAY) is

		do
			if is_wide then
				ba.append (Bc_wchar)
			else
				ba.append (Bc_char)
			end
			ba.append ('%U')
		end

feature {NONE} -- Constants

	Character_string: STRING is "EIF_CHARACTER"
	Wide_char_string: STRING is "EIF_WIDE_CHAR"

	Character_string_id: INTEGER is
		once
			Result := Names_heap.eif_char_name_id
		end

	Wide_char_string_id: INTEGER is
		once
			Result := Names_heap.eif_wide_char_name_id
		end
	
	Union_character_tag: STRING is "carg"
	Union_wide_char_tag: STRING is "wcarg"

end
