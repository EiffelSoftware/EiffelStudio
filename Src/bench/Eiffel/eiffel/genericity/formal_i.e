indexing
	description: "Representation of a compiled formal parameter."
	date: "$Date$"
	revision: "$Revision$"
	
class FORMAL_I

inherit
	TYPE_I
		redefine
			is_formal, same_as, has_true_formal, has_formal, instantiation_in,
			complete_instantiation_in, creation_instantiation_in,
			generated_id, is_explicit, generate_gen_type_il
		end

	SHARED_BYTE_CONTEXT
		export
			{NONE} all
		end

feature -- Access

	position: INTEGER
			-- Position of the formal in declarations

	hash_code: INTEGER is
			-- Hash code for current type
		do
			Result := Other_code + position
		end

feature -- Status report

	is_formal: BOOLEAN is True
			-- Is the type a formal type ?

	is_explicit: BOOLEAN is False

	has_true_formal, has_formal: BOOLEAN is True
			-- Has the type formal in its structure ?

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

	il_type_name: STRING is
			-- Name of current class type.
		do
			Result := internal_name
		end

	type_a: FORMAL_A is
			-- Associated FORMAL_A object.
		do
			create Result
			Result.set_position (position)
		end

feature -- Setting

	set_position (i: INTEGER) is
			-- Assign `i' to `position'.
		require
			valid_position: i > 0
		do
			position := i
		ensure
			position_set: position = i
		end

feature -- Comparison
 
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

feature -- Formatting

	append_signature (st: STRUCTURED_TEXT) is
		do
			st.add_string (internal_name)
		end

	dump (buffer: GENERATION_BUFFER) is
			-- Debug purpose
		do
			buffer.putstring (internal_name)
		end

feature -- Generic conformance

	generated_id (final_mode : BOOLEAN): INTEGER is
			-- Id of a generic formal parameter.
		do
			Result := Formal_type - position
		end

feature -- Generic conformance for IL

	generate_gen_type_il (il_generator: IL_CODE_GENERATOR; use_info: BOOLEAN) is
			-- `use_info' is true iff we generate code for a
			-- creation instruction.
		local
			l_gen_type: GEN_TYPE_I
			l_decl_type: CL_TYPE_I
			l_formal: TYPE_FEATURE_I
		do
			l_gen_type ?= context.current_type
			
				-- We must be in a generic class otherwise having a formal creation
				-- does not make sense.
			check
				l_gen_type_not_void: l_gen_type /= Void
			end
			
				-- Generate call to feature, defined in every descendant of
				-- generic class represented by `l_gen_type', that will
				-- create the corresponding runtime type associated with formal
				-- in descendant class.
			l_formal := l_gen_type.base_class.formal_at_position (position)
			il_generator.generate_current
			l_decl_type := il_generator.implemented_type (l_formal.origin_class_id,
				context.current_type)
			il_generator.generate_feature_access (l_decl_type, l_formal.origin_feature_id, True)
		end

feature {NONE} -- Code generation

	generate_cecil_value (buffer: GENERATION_BUFFER) is
		do
		ensure then
			False
		end

feature {NONE} -- Not applicable

	c_type: TYPE_C is
			-- Associated C type.
		do
				-- FIXME: we should not call it, but in case we have decided that it
				-- will always return a reference type
			Result := Reference_c_type
		ensure then
			False
		end

	description: INTEGER_DESC is
		do
		ensure then
			False
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

feature {NONE} -- Implementation

	internal_name: STRING is
			-- Name of current type.
		do
			create Result.make (9)
			Result.append ("Formal #")
			Result.append_integer (position)
		ensure
			result_not_void: Result /= Void
		end

end -- class FORMAL_I
