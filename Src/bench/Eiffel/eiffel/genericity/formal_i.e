class FORMAL_I

inherit
	TYPE_I
		redefine
			is_formal, same_as, has_formal, instantiation_in,
			complete_instantiation_in, generated_id, is_explicit
		end

feature

	position: INTEGER
			-- Position of the formal in declarations

	set_position (i: INTEGER) is
			-- Assign `i' to `position'.
		do
			position := i
		end

	is_formal: BOOLEAN is True
			-- Is the type a formal type ?

	is_explicit: BOOLEAN is False

	has_formal: BOOLEAN is True
			-- Has the type formal in its structure ?

	same_as (other: like Current): BOOLEAN is
			-- Is `other' equal to Current ?
		local
			other_formal: FORMAL_I
		do
			other_formal ?= other
			Result := 	other_formal /= Void
						and then
						other_formal.position = position
		end

	instantiation_in (other: GEN_TYPE_I): TYPE_I is
			-- Instantiation of Current in context of `other'
		require else
			good_context: position <= other.meta_generic.count
		do
			Result := other.meta_generic.item (position)
		end

	complete_instantiation_in (other: GEN_TYPE_I): TYPE_I is

		require else
			good_context: position <= other.true_generics.count;
		local
			btype : BASIC_I
		do
			-- Keep formal generic parameters iff the
			-- actual is not a basic type.

			btype ?= other.true_generics.item (position)

			if btype /= Void then
				Result := btype
			else
				Result := Current
			end
		end

	c_type: TYPE_C is
		do
		ensure then
			False
		end; -- c_type

	append_signature (st: STRUCTURED_TEXT) is
		do
			st.add_string ("Formal #")
			st.add_int (position)
		end

	dump (file: FILE) is
			-- Debug purpose
		do
			file.putstring ("Formal #")
			file.putint (position)
		end

	description: INTEGER_DESC is
		do
		ensure then
			False
		end

	generate_cecil_value (f: INDENT_FILE) is
		do
		ensure then
			False
		end

	hash_code: INTEGER is
			-- Hash code for current type
		do
			Result := Other_code + position
		end

	sk_value: INTEGER is
		do
		ensure then
			False
		end

	cecil_value: INTEGER is
		do
		ensure then
			False
		end

	type_a: FORMAL_A is
		do
			!!Result
			Result.set_position (position)
		end

feature -- Generic conformance

	generated_id (final_mode : BOOLEAN) : INTEGER is

		do
			Result := -16 - position
		end

end
