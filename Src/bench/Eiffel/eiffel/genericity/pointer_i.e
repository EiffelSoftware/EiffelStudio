class POINTER_I

inherit
	BASIC_I
		redefine
			dump,
			is_feature_pointer,
			same_as,
			description, sk_value, hash_code, generate_cecil_value,
			generated_id
		end

feature

	level: INTEGER is
			-- Internal code for generation
		do
			Result := C_pointer
		end

	is_feature_pointer: BOOLEAN is True
			-- Is the type a feature pointer type ?

	dump (buffer: GENERATION_BUFFER) is
			-- Debug purpose
		do
			buffer.putstring ("EIF_POINTER")
		end

	same_as (other: TYPE_I): BOOLEAN is
			-- Is `other' the equal to Current ?
		do
			Result := other.is_feature_pointer
		end

	description: POINTER_DESC is
			-- Type description for skeleton
		do
			!!Result
		end

	generate_cecil_value (f: GENERATION_BUFFER) is
			-- Generate Cecil type value.
		do
			f.putstring ("SK_POINTER")
		end

	c_string: STRING is "EIF_POINTER"
			-- String generated for the type.

	c_string_id: INTEGER is
			-- String ID generated for Current
		once
			Result := Names_heap.eif_pointer_name_id
		end
		
	union_tag: STRING is "parg"

	separate_get_macro: STRING is "CURGP"
			-- String generated to access the argument to a separate call

	separate_send_macro: STRING is "CURSQRP"
			-- String generated to return the result of a separate call

	hash_code: INTEGER is
			-- Hash code for current type
		once
			Result := Pointer_code
		end

	associated_reference: CLASS_TYPE is
			-- Reference class associated with simple type
		do
			Result := system.pointer_ref_class.compiled_class.types.first
		end

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
	
	type_a: POINTER_A is
		do
			!!Result
		end

feature -- Generic conformance

	generated_id (final_mode : BOOLEAN) : INTEGER is

		do
			Result := Pointer_type
		end
feature

	make_basic_creation_byte_code (ba : BYTE_ARRAY) is

		do
			ba.append (Bc_null_pointer)
		end 

end
