indexing
	description: "Typed version of POINTER_I"
	date: "$Date$"
	revision: "$Revision$"

class TYPED_POINTER_I

inherit
	BASIC_I
		undefine
			is_equal, generate_cid, il_type_name, generate_cid_array,
			generate_cid_init, is_explicit,
			has_true_formal, is_identical, generate_gen_type_il,
			has_formal, same_as, make_gen_type_byte_code,
			instantiation_in, meta_generic, true_generics, hash_code, base_class,
			debug_output, complete_instantiation_in, generic_derivation
		redefine
			is_feature_pointer, name,
			description, sk_value, generate_cecil_value,
			element_type, reference_type, tuple_code
		end
		
	GEN_TYPE_I
		undefine
			is_basic, is_reference, cecil_value, is_void, c_type, is_valid
		redefine
			is_feature_pointer, type_a, description, sk_value,
			generate_cecil_value, element_type, tuple_code,
			name, reference_type
		end

create
	make_typed

feature {NONE} -- Initialization

	make_typed (id: INTEGER; a_type: TYPE_A) is
			-- Create new instance of TYPED_POINTER.
		require
			a_type_not_void: a_type /= Void
		do
			make (id)
			create meta_generic.make (1)
			create true_generics.make (1, 1)
			meta_generic.put (a_type.meta_type, 1)
			true_generics.put (a_type.type_i, 1)
		ensure
			class_id_set: class_id = id
		end
		
feature -- Access

	reference_type: CL_TYPE_I is
			-- Type to which we metamorphose. Because generation of
			-- metamorphose on generic basic types is not done properly
			-- we do this as a temporary solution.
		once
			create Result.make (Pointer_c_type.class_id)
		end

	element_type: INTEGER_8 is
			-- Pointer element type
		do
			Result := feature {MD_SIGNATURE_CONSTANTS}.Element_type_ptr
		end

	tuple_code: INTEGER_8 is
			-- Tuple code for class type
		do
			Result := feature {SHARED_GEN_CONF_LEVEL}.pointer_tuple_code
		end

feature

	level: INTEGER is
			-- Internal code for generation
		do
			Result := C_pointer
		end

	is_feature_pointer: BOOLEAN is True
			-- Is the type a feature pointer type ?

	name: STRING is
			-- Debug purpose
		do
			create Result.make (32)
			Result.append ("expanded ")
			Result.append (meta_generic.item (1).name)
			Result.append_character ('*')
			Result.append_character (' ')
		end

	description: POINTER_DESC is
			-- Type description for skeleton
		do
			create Result
		end

	generate_cecil_value (f: GENERATION_BUFFER) is
			-- Generate Cecil type value.
		do
			f.putstring ("SK_POINTER")
		end

	c_string: STRING is
			-- String generated for the type.
		local
			l_str: STRING
			l_type: TYPE_C
		do
			l_type ?= meta_generic.item (1)
			check
				l_type_not_void: l_type /= Void
			end
			l_str := l_type.c_string
			create Result.make (l_str.count + 2)
			Result.append (l_str)
			Result.append_character ('*')
			Result.append_character (' ')
		end
		
	union_tag: STRING is "parg"

	sk_value: INTEGER is
			-- Generate SK value associated to the current type.
		do
			Result := Sk_pointer
		end

	generate_union (buffer: GENERATION_BUFFER) is
			-- Generate discriminant of C structure "item" associated
			-- to the current C type in `buffer'.
		do
			buffer.putstring ("it_ptr")
		end

	generate_sk_value (buffer: GENERATION_BUFFER) is
			-- Generate SK value associated to current C type in `buffer'.
		do
			buffer.putstring ("SK_POINTER")
		end
	
	type_a: TYPED_POINTER_A is
		do
			create {TYPED_POINTER_A} Result.make_typed (true_generics.item (1).type_a)
		end
		
feature

	make_default_byte_code (ba: BYTE_ARRAY) is
			-- Generate default value of basic type on stack.
		do
			ba.append (Bc_null_pointer)
		end 

end
