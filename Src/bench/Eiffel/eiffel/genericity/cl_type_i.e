indexing
	description: "Type class."
	date: "$Date$"
	revision: "$Revision$"

class CL_TYPE_I

inherit
	TYPE_I
		redefine
			is_reference,
			is_true_expanded,
			is_separate,
			is_valid,
			is_explicit,
			is_external,
			same_as,
			c_type,
			instantiation_in,
			complete_instantiation_in,
			conforms_to_array,
			generated_id,
			generate_cid,
			make_gen_type_byte_code,
			generate_cid_array,
			generate_cid_init,
			generate_gen_type_il
		end
	
	DEBUG_OUTPUT
		export
			{NONE} all
		end

create
	make
	
feature {NONE} -- Initialization

	make (id: INTEGER) is
			-- Create new instance of `Current' with `class_id'
			-- assigned with `id'.
		require
			valid_id: id > 0
		do
			class_id := id
		ensure
			class_id_set: class_id = id
		end
		
feature -- Access

	class_id: INTEGER
			-- Base class id of the type class

	meta_generic: META_GENERIC is
			-- Meta generic array describing the type class
		do
			-- No meta generic in non-generic type
		end

	cr_info : CREATE_INFO
			-- Additional information for the creation
			-- of generic types with anchored parameters

	true_generics : ARRAY [TYPE_I] is
			-- Array of generics: no mapping reference -> REFERENCE_I
		do
			-- Non generic types don't have them
		end

	base_class: CLASS_C is
			-- Base class associated to the class type
		do
			Result := System.class_of_id (class_id)
		end

	type_a: CL_TYPE_A is
		do
			create Result.make (class_id)
			Result.set_is_true_expanded (is_true_expanded)
			Result.set_is_separate (is_separate)
		end

	il_type_name: STRING is
			-- Class name of current type.
		local
			l_class_c: like base_class
		do
			l_class_c := base_class
			if l_class_c.is_external then
				Result := clone (base_class.external_class_name)
			else
				Result := clone (base_class.name)
			end
		end

	instantiation_in (other: GEN_TYPE_I): CL_TYPE_I is
			-- Instantiation of Current in context of `other'
		require else
			True
		do
			Result := Current
		end

	complete_instantiation_in (other: GEN_TYPE_I): CL_TYPE_I is
			-- Instantiation of Current in context of `other'
		require else
			True
		do
			Result := Current
		end

	description: ATTR_DESC is
			-- Type description for skeletons
		local
			exp: EXPANDED_DESC
			ref: REFERENCE_DESC
		do
			if is_true_expanded then
				!! exp
				is_true_expanded := False
				exp.set_class_type (base_class.types.conservative_search_item (Current))
				is_true_expanded := True
				exp.set_type_i (Current)
				Result := exp
			elseif is_separate then
				-- FIXME
				Result := c_type.description
			else
				Result := c_type.description
			end

			ref ?= Result
			if ref /= Void then
				ref.set_class_type_i (Current)
			end
		end

	c_type: TYPE_C is
			-- Associated C type
		do
			Result := Reference_c_type
		end

	typecode: INTEGER is
			-- Typecode for TUPLE element.
		do
			Result := feature {SHARED_TYPECODE}.reference_code
		end
		
	associated_class_type: CLASS_TYPE is
			-- Associated class type
		require
		--	has: has_associated_class_type
		do
			if is_true_expanded then
				is_true_expanded := False
				Result := base_class.types.conservative_search_item (Current)
				is_true_expanded := True
			elseif is_separate then
				is_separate := False
				Result := base_class.types.conservative_search_item (Current)
				is_separate := True
			else
				Result := base_class.types.conservative_search_item (Current)
			end
		end

	type_id: INTEGER is
			-- Type id of the correponding class type
		do
			Result := associated_class_type.type_id
		end

	expanded_type_id: INTEGER is
			-- Type id of the corresponding expanded class type
		do
			is_true_expanded := False
			Result := base_class.types.conservative_search_item (Current).type_id
			is_true_expanded := True
		end

	sk_value: INTEGER is
			-- Generate SK value associated to the current type.
		do
				-- FIXME????: separate
			if not is_true_expanded then
				Result := Sk_ref + (type_id - 1)
			else
				is_true_expanded := False
				Result := Sk_exp + (type_id - 1)
				is_true_expanded := True
			end
		end

	cecil_value: INTEGER is
		do
				-- FIXME????: separate
			if not is_true_expanded then
				Result := Sk_dtype
			else
				Result := Sk_exp + class_id
			end
		end

	hash_code: INTEGER is
			-- Hash code for current type
		do
			Result := Other_code + class_id
		end

feature -- Status

	is_true_expanded: BOOLEAN
			-- Is the type expanded?

	is_separate: BOOLEAN
			-- Is the type separate?

	is_enum: BOOLEAN is
			-- Is current type an IL enum type?
			-- Useful to find out if some call optimization can be done
			-- in FEATURE_B.
		require
			il_generation: System.il_generation
		do
			Result := is_true_expanded and then base_class.is_enum
		end

	is_external: BOOLEAN is
			-- Is current type an IL enum type?
			-- Useful to find out if some call optimization can be done
			-- in FEATURE_B.
		do
			Result := base_class.is_external
		end

	is_valid: BOOLEAN is
			-- Is the base class still in the system ?
		do
			Result := base_class /= Void
		end

	is_reference: BOOLEAN is
			-- Is the type a reference type ?
		do
			Result := not is_true_expanded
		end; 

	is_explicit: BOOLEAN is

		do
			Result := (cr_info = Void) or else is_expanded
		end

	has_associated_class_type: BOOLEAN is
			-- Has `Current' an associated class type?
		do
			if is_true_expanded then
				is_true_expanded := False
				Result := base_class.types.has_type (Current)
				is_true_expanded := True
			elseif is_separate then
				is_separate := False
				Result := base_class.types.has_type (Current)
				is_separate := True
			else
				Result := base_class.types.has_type (Current)
			end
		end

	same_as (other: TYPE_I): BOOLEAN is
			-- Is `other' equal to Current ?
		local
			other_cl_type: CL_TYPE_I
		do
			other_cl_type ?= other
			Result := other_cl_type /= Void -- FIXME
					and then other_cl_type.class_id = class_id
					and then other_cl_type.is_true_expanded = is_true_expanded
					and then other_cl_type.is_separate = is_separate
					and then other_cl_type.meta_generic = Void
					and then other_cl_type.true_generics = Void
		end

feature -- Setting

	set_is_true_expanded (b: BOOLEAN) is
			-- Assign `b' to `is_true_expanded'.
		do
			is_true_expanded := b
		end

	set_is_separate (b: BOOLEAN) is
			-- Assign `b' to `is_separate'.
		do
			is_separate := b
		end

	set_cr_info (cinfo : CREATE_INFO) is
			-- Set `cr_info' to `cinfo'.
		require
			create_info_not_void: cinfo /= Void
		do
			cr_info := cinfo
		ensure
			cr_info_set : cr_info = cinfo
		end

feature -- Formatting

	append_signature (st: STRUCTURED_TEXT) is
		do
			if is_true_expanded then
				st.add_string ("expanded ")
			elseif is_separate then
				st.add_string ("separate ")
			end
			base_class.append_signature (st)
		end

	dump (buffer: GENERATION_BUFFER) is
		do
			buffer.putstring (debug_output)
		end

feature -- C generation

	generate_cecil_value (buffer: GENERATION_BUFFER) is
			-- Generate cecil value
		do
				-- FIXME????: separate
			if not is_true_expanded then
				buffer.putstring ("SK_DTYPE")
			else
				buffer.putstring ("SK_EXP + (uint32) ")
				buffer.putint (class_id)
			end
		end

feature -- Array optimization

	conforms_to_array: BOOLEAN is
		do
			Result := base_class.conform_to (array_class_c)
		end

feature {NONE} -- Array optimization

	array_class_c: CLASS_C is
		once
			Result := System.array_class.compiled_class
		end

feature -- Generic conformance

	generated_id (final_mode : BOOLEAN) : INTEGER is

		do
			if final_mode then
				Result := type_id - 1
			else
				Result := associated_class_type.static_type_id-1
			end

			if is_true_expanded then
				Result := Expanded_level - Result
			end
		end

	generate_cid (buffer : GENERATION_BUFFER; final_mode, use_info : BOOLEAN) is

		do
			if
				use_info and then (cr_info /= Void)
				and then not is_expanded
			then
				-- It's an anchored type 
				cr_info.generate_cid (buffer, final_mode)
			end
			buffer.putint (generated_id (final_mode))
			buffer.putstring (", ")
		end

	make_gen_type_byte_code (ba : BYTE_ARRAY; use_info : BOOLEAN) is
		do
			if
				use_info and then (cr_info /= Void)
				and then not is_expanded
			then
				-- It's an anchored type 
				cr_info.make_gen_type_byte_code (ba)
			end
			ba.append_short_integer (generated_id (False))
		end

	generate_cid_array (buffer : GENERATION_BUFFER; 
						final_mode, use_info : BOOLEAN; idx_cnt : COUNTER) is
		local
			dummy : INTEGER
		do
			if
				use_info and then (cr_info /= Void)
				and then not is_expanded
			then
				-- It's an anchored type 
				cr_info.generate_cid_array (buffer, final_mode, idx_cnt)
			end
			buffer.putint (generated_id (final_mode))
			buffer.putstring (", ")

			-- Increment counter
			dummy := idx_cnt.next
		end

	generate_cid_init (buffer : GENERATION_BUFFER; 
					   final_mode, use_info : BOOLEAN; idx_cnt : COUNTER) is
		local
			dummy : INTEGER
		do
			if
				use_info and then (cr_info /= Void)
				and then not is_expanded
			then
				-- It's an anchored type 
				cr_info.generate_cid_init (buffer, final_mode, idx_cnt)
			end

			dummy := idx_cnt.next
		end

feature -- Generic conformance for IL

	generate_gen_type_il (il_generator: IL_CODE_GENERATOR; use_info : BOOLEAN) is
			-- `use_info' is true iff we generate code for a 
			-- creation instruction.
		do
			if use_info and then cr_info /= Void then
					-- It's an ancored type 
			end	
			il_generator.generate_class_type_instance (Current)
		end

feature -- Output

	debug_output: STRING is
			-- String that should be displayed in debugger to represent `Current'.
		do
			create Result.make (32)
			if is_true_expanded then
				Result.append ("expanded ")
			elseif is_separate then
				Result.append ("separate ")
			end
			Result.append (base_class.name_in_upper)
		end
	
end
