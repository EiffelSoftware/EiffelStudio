class FORMAL_I

inherit
	TYPE_I
		redefine
			is_formal, same_as, has_true_formal, has_formal, instantiation_in,
			complete_instantiation_in, creation_instantiation_in,
			generated_id, is_explicit
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

	has_true_formal, has_formal: BOOLEAN is True
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
		do
			Result := other.meta_generic.item (position)
		end

	creation_instantiation_in, complete_instantiation_in (other: GEN_TYPE_I): TYPE_I is
			-- Instantiation of Current in context of `other'.
		do
				-- Keep formal generic parameters iff the
				-- actual is not a basic type.
			Result := other.true_generics.item (position)

			if not Result.is_basic then
				Result := Current
			end
		end

	c_type: TYPE_C is
		do
				-- FIXME: we should not call it, but in case we have decided that it
				-- will always return a reference type
			Result := Reference_c_type
		ensure then
			False
		end; -- c_type

	append_signature (st: STRUCTURED_TEXT) is
		do
			st.add_string ("Formal #")
			st.add_int (position)
		end

	dump (buffer: GENERATION_BUFFER) is
			-- Debug purpose
		do
			buffer.putstring ("Formal #")
			buffer.putint (position)
		end

	il_type_name: STRING is
			-- Name of current class type.
		do
			Result := "Formal #" + position.out
		end

	description: INTEGER_DESC is
		do
		ensure then
			False
		end

	generate_cecil_value (buffer: GENERATION_BUFFER) is
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
			Result := Formal_type - position
		end

end
