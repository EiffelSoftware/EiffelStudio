indexing
	description: "Representation of a compiled formal parameter."
	date: "$Date$"
	revision: "$Revision$"
	
class FORMAL_I

inherit
	TYPE_I
		redefine
			is_formal, same_as, has_true_formal, has_formal, instantiation_in,
			complete_instantiation_in,
			generated_id, is_explicit, generate_gen_type_il,
			generate_cid, generate_cid_array, generate_cid_init,
			make_gen_type_byte_code, is_reference, is_expanded
		end

	SHARED_BYTE_CONTEXT
		export
			{NONE} all
		end

create
	make
	
feature {NONE} -- Initialization

	make (is_ref: like is_reference; is_exp: like is_expanded; i: like position) is
			-- Assign `i' to `position'.
		require
			valid_position: i > 0
		do
			is_reference := is_ref
			is_expanded := is_exp
			position := i
		ensure
			is_reference_set: is_reference = is_ref
			is_expanded_set: is_expanded = is_exp
			position_set: position = i
		end

feature -- Status report

	element_type: INTEGER_8 is
			-- Formal element type.
		do
				-- Before we said that we should not be called, but now there is one case
				-- where we are called, it is when we try to create a NATIVE_ARRAY [G] where
				-- G is a formal generic parameter. In this case we actually considered that
				-- we have for the type system a NATIVE_ARRAY [SYSTEM_OBJECT].
			Result := {MD_SIGNATURE_CONSTANTS}.element_type_object
		end

	tuple_code: INTEGER_8 is
			-- Formal tuple code. Should not be called.
		do
			check
				False
			end
		end

feature -- Access

	position: INTEGER
			-- Position of the formal in declarations

	is_reference: BOOLEAN
			-- Is current constrained to be always a reference?

	is_expanded: BOOLEAN
			-- Is current constrained to be always an expanded?

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

	instantiation_in (other: CLASS_TYPE): TYPE_I is
			-- Instantiation of Current in context of `other'
		do
			Result := other.type.meta_generic.item (position)
		end

	complete_instantiation_in (other: CLASS_TYPE): TYPE_I is
			-- Instantiation of Current in context of `other'.
		do
			Result := other.type.true_generics.item (position)
		end

	name: STRING is
			-- Name of current type.
		do
			create Result.make (9)
			Result.append ("Formal #")
			Result.append_integer (position)
		end

	il_type_name (a_prefix: STRING): STRING is
			-- Name of current class type.
		do
			Result := name
		end

	type_a: FORMAL_A is
			-- Associated FORMAL_A object.
		do
			create Result.make (is_reference, is_expanded, position)
		end

feature -- Comparison
 
	same_as (other: TYPE_I): BOOLEAN is
			-- Is `other' equal to Current ?
		local
			other_formal: FORMAL_I
		do
			other_formal ?= other
			Result := other_formal /= Void and then other_formal.position = position and then
				is_reference = other.is_reference and then is_expanded = other.is_expanded
		end

feature -- Generic conformance

	generated_id (final_mode: BOOLEAN): INTEGER is
			-- Id of a generic formal parameter.
		do
			Result := Formal_type
		end

	generate_cid (buffer: GENERATION_BUFFER; final_mode, use_info: BOOLEAN) is
		do
			buffer.put_integer (Formal_type)
			buffer.put_character (',')
			buffer.put_integer (position)
			buffer.put_character (',')
		end

	make_gen_type_byte_code (ba: BYTE_ARRAY; use_info: BOOLEAN) is
		do
			ba.append_short_integer (formal_type)
			ba.append_short_integer (position)
		end

	generate_cid_array (buffer: GENERATION_BUFFER; final_mode, use_info: BOOLEAN; idx_cnt: COUNTER) is
		local
			dummy: INTEGER
		do
			buffer.put_integer (Formal_type)
			buffer.put_character (',')
			buffer.put_integer (position)
			buffer.put_character (',')
			dummy := idx_cnt.next
			dummy := idx_cnt.next
		end

	generate_cid_init (buffer: GENERATION_BUFFER; final_mode, use_info: BOOLEAN; idx_cnt: COUNTER) is
		local
			dummy : INTEGER
		do
				-- Increment counter
			dummy := idx_cnt.next
			dummy := idx_cnt.next
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
			il_generator.generate_feature_access (l_decl_type, l_formal.origin_feature_id, 0, True, True)
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
		end

	description: ATTR_DESC is
		do
		ensure then
			False
		end

	sk_value: INTEGER is
		do
		ensure then
			False
		end

end -- class FORMAL_I
