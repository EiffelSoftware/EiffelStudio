indexing
	description: "Type class."
	date: "$Date$"
	revision: "$Revision$"

class CL_TYPE_I

inherit
	TYPE_I
		redefine
			is_reference,
			is_expanded,
			is_separate,
			is_valid,
			is_explicit,
			is_external,
			same_as,
			c_type,
			conforms_to_array,
			generated_id,
			generate_cid,
			make_gen_type_byte_code,
			generate_cid_array,
			generate_cid_init,
			generate_gen_type_il,
			generate_expanded_creation,
			generate_expanded_initialization,
			instantiation_in,
			generic_derivation,
			is_generated_as_single_type
		end

	SHARED_IL_CASING
		export
			{NONE} all
		end

	SHARED_GENERATION
		export
			{NONE} all
		end

	SHARED_DECLARATIONS
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
			if is_basic then
					-- We know for sure that it is expanded then.
				is_expanded := True
			end
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

	generic_derivation: CL_TYPE_I is
			-- Precise generic derivation of current type.
			-- That is to say given a type, it gives the associated TYPE_I
			-- which can be used to search its associated CLASS_TYPE.
		do
			Result := Current
		end
		
	type_a: CL_TYPE_A is
		do
			create Result.make (class_id)
			Result.set_is_expanded (is_expanded)
			Result.set_is_separate (is_separate)
		end

	name: STRING is
			-- String that should be displayed in debugger to represent `Current'.
		do
			Result := base_name
		end
		
	instantiation_in (other: CLASS_TYPE): CL_TYPE_I is
			-- Instantation of Current in `other'
		do
			Result := Current
		end
		
	il_type_name (a_prefix: STRING): STRING is
			-- Class name of current type.
		local
			l_class_c: like base_class
			l_is_precompiled: BOOLEAN
			l_cl_type: like associated_class_type
			l_index: INTEGER
			l_name: STRING
		do
			l_class_c := base_class
			if is_external then
				Result := l_class_c.external_class_name.twin
			else
				l_is_precompiled := l_class_c.is_precompiled
				if l_is_precompiled then
					l_cl_type := associated_class_type
					l_is_precompiled := l_cl_type.is_precompiled
					if l_is_precompiled then
						Result := associated_class_type.il_type_name (a_prefix)
					end
				end
				if not l_is_precompiled then
					if l_class_c.external_class_name.is_equal (l_class_c.name) then
						Result := internal_il_type_name (l_class_c.name.twin, a_prefix)
					elseif a_prefix /= Void then
						l_name := l_class_c.external_class_name
						l_index := l_name.last_index_of ('.', l_name.count)
						create Result.make (l_name.count + a_prefix.count + 1)
						if l_index > 0 then
							Result.append (l_name.substring (1, l_index))
							Result.append (a_prefix)
							Result.append (l_name.substring (l_index, l_name.count))
						else
							Result.append (l_name)
							Result.append_character ('.')
							Result.append (a_prefix)
						end
					else
						Result := l_class_c.external_class_name.twin
					end
				end
			end
		end

	description: ATTR_DESC is
			-- Type description for skeletons
		local
			exp: EXPANDED_DESC
			ref: REFERENCE_DESC
		do
			if is_expanded then
				create exp
				exp.set_cl_type_i (Current)
				exp.set_type_i (Current)
				Result := exp
			else
				Result := c_type.description
				ref ?= Result
				if ref /= Void then
					ref.set_type_i (Current)
				end
			end
		end

	c_type: TYPE_C is
			-- Associated C type
		do
			Result := Reference_c_type
		end

	associated_class_type: CLASS_TYPE is
			-- Associated class type
		require
			has: has_associated_class_type
		do
			Result := base_class.types.search_item (Current)
		end

	type_id: INTEGER is
			-- Type id of the correponding class type
		do
			Result := associated_class_type.type_id
		end

	sk_value: INTEGER is
			-- Generate SK value associated to the current type.
		do
			if is_expanded then
				Result := Sk_exp | (type_id - 1)
			else
				Result := Sk_ref | (type_id - 1)
			end
		end

	hash_code: INTEGER is
			-- Hash code for current type
		do
			Result := Other_code + class_id
		end

feature -- Status

	element_type: INTEGER_8 is
			-- Void element type
		do
			if is_expanded then
				Result := feature {MD_SIGNATURE_CONSTANTS}.Element_type_valuetype				
			else
				if class_id = System.system_string_class.compiled_class.class_id then
					Result := feature {MD_SIGNATURE_CONSTANTS}.Element_type_string
				elseif class_id = System.system_object_id or class_id = system.any_id then
						-- For ANY or SYSTEM_OBJECT, we always generate a System.Object
						-- signature since we can now assign SYSTEM_OBJECTs into ANYs.
					Result := feature {MD_SIGNATURE_CONSTANTS}.Element_type_object
				else
					Result := feature {MD_SIGNATURE_CONSTANTS}.Element_type_class
				end
			end
		end

	tuple_code: INTEGER_8 is
			-- Tuple code for class type
		do
			Result := feature {SHARED_GEN_CONF_LEVEL}.reference_tuple_code
		end
		
	is_expanded: BOOLEAN
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
			Result := is_expanded and then base_class.is_enum
		end

	is_external: BOOLEAN is
			-- Is current type based on an external class?
		local
			l_base_class: like base_class
		do
				-- All Eiffel basic types are externals, and only basic types used
				-- as reference are not external.
			l_base_class := base_class
			Result := is_basic or (not l_base_class.is_basic and l_base_class.is_external)
		end
		
	is_generated_as_single_type: BOOLEAN is
			-- Is associated type generated as a single type or as an interface type and 
			-- an implementation type.
		do
				-- External classes have only one type.
			Result := is_external
			if not Result then
					-- Classes that inherits from external classes
					-- have only one generated type.
				Result := base_class.is_single
			end
		end

	is_valid: BOOLEAN is
			-- Is the base class still in the system and matches its specification?
		local
			l_base_class: like base_class
		do
			l_base_class := base_class
			Result := l_base_class /= Void and then (l_base_class.generics = Void)
		end

	is_reference: BOOLEAN is
			-- Is the type a reference type ?
		do
			Result := not is_expanded
		end; 

	is_explicit: BOOLEAN is
			-- Is Current type fixed at compile time?
		do
			if cr_info /= Void then
				Result := cr_info.is_explicit
			else
				Result := True
			end
		end

	has_associated_class_type: BOOLEAN is
			-- Has `Current' an associated class type?
		do
			Result := base_class.types.has_type (Current)
		end

	same_as (other: TYPE_I): BOOLEAN is
			-- Is `other' equal to Current ?
		local
			other_cl_type: CL_TYPE_I
		do
			other_cl_type ?= other
			Result := other_cl_type /= Void -- FIXME
					and then other_cl_type.class_id = class_id
					and then other_cl_type.is_expanded = is_expanded
					and then other_cl_type.is_separate = is_separate
					and then other_cl_type.meta_generic = Void
					and then other_cl_type.true_generics = Void
		end

feature -- Setting

	set_is_expanded (b: BOOLEAN) is
			-- Assign `b' to `is_expanded'.
		do
			is_expanded := b
		ensure
			is_expanded_set: is_expanded = b
		end

	set_is_separate (b: BOOLEAN) is
			-- Assign `b' to `is_separate'.
		do
			is_separate := b
		ensure
			is_separate_set: is_separate = b
		end

	set_cr_info (cinfo : CREATE_INFO) is
			-- Set `cr_info' to `cinfo'.
		require
			create_info_not_void: cinfo /= Void
			not_expanded: not is_expanded
		do
			cr_info := cinfo
		ensure
			cr_info_set : cr_info = cinfo
		end

feature -- C generation

	generate_expanded_creation (buffer: GENERATION_BUFFER; target_name: STRING) is
			-- Generate creation of expanded object associated to Current.
		do
			associated_class_type.generate_expanded_creation (buffer, target_name)
		end

	generate_expanded_initialization (buffer: GENERATION_BUFFER; target_name: STRING) is
			-- Generate creation of expanded object associated to Current.
		do
			associated_class_type.generate_expanded_initialization (buffer, target_name, target_name, True)
		end

	generate_cecil_value (buffer: GENERATION_BUFFER) is
			-- Generate cecil value
		do
			if not is_expanded then
				buffer.put_string ("SK_REF + (uint32) ")
			else
				buffer.put_string ("SK_EXP + (uint32) ")
			end
			buffer.put_type_id (associated_class_type.type_id)
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
				Result := associated_class_type.static_type_id - 1
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
			else
				buffer.put_integer (generated_id (final_mode))
				buffer.put_character (',')
			end
		end

	make_gen_type_byte_code (ba : BYTE_ARRAY; use_info : BOOLEAN) is
		do
			if
				use_info and then (cr_info /= Void)
				and then not is_expanded
			then
				-- It's an anchored type 
				cr_info.make_gen_type_byte_code (ba)
			else
				ba.append_short_integer (generated_id (False))
			end
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
			else
				buffer.put_integer (generated_id (final_mode))
				buffer.put_character (',')

					-- Increment counter
				dummy := idx_cnt.next
			end
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
			else
				dummy := idx_cnt.next
			end
		end

feature -- Generic conformance for IL

	generate_gen_type_il (il_generator: IL_CODE_GENERATOR; use_info : BOOLEAN) is
			-- `use_info' is true iff we generate code for a 
			-- creation instruction.
		do
			if use_info and then cr_info /= Void then
					-- It's an anchored type, we call feature
					-- that will tell us the real type of the 
					-- anchor in the context of Current.
				cr_info.generate_il_type
			else
				il_generator.generate_class_type_instance (Current)
			end	
		end

feature {NONE} -- Implementation

	base_name: STRING is
			-- String that should be displayed in debugger to represent `Current'.
		local
			l_base_class: like base_class
		do
			create Result.make (32)
			l_base_class := base_class
			if is_expanded and not l_base_class.is_expanded then
				Result.append ("expanded ")
			elseif is_separate then
				Result.append ("separate ")
			end
			Result.append (l_base_class.name)
		end

	frozen internal_il_type_name (a_base_name, a_prefix: STRING): STRING is
			-- Full type name of `a_base_name' using `a_prefix' in IL code generation
			-- with namespace specification
		require
			a_base_name_not_void: a_base_name /= Void
		local
			l_name: STRING
			l_base_class: like base_class
		do
			l_base_class := base_class
				-- Result needs to be in lower case because that's
				-- what our casing conversion routines require to perform
				-- a good job.
			if
				(is_expanded and l_base_class.is_expanded) or
				(not is_expanded and not l_base_class.is_expanded)
			then
				Result := a_base_name.as_lower
			else
				if is_expanded then
					create Result.make (6 + a_base_name.count)
					Result.append ("VALUE_")
				else
					create Result.make (10 + a_base_name.count)
					Result.append ("REFERENCE_")
				end
				Result.append (a_base_name)
				Result.to_lower
			end
			l_name := l_base_class.lace_class.actual_namespace
			if a_prefix /= Void then
				if l_name.is_empty then
					l_name := a_prefix + "."
				else
					l_name := il_casing.namespace_casing (System.dotnet_naming_convention,
						l_name) + "." + a_prefix + "."
				end
			else
				if not l_name.is_empty then					
					l_name := il_casing.namespace_casing (System.dotnet_naming_convention,
						l_name) + "."
				end
			end
			Result := l_name + il_casing.pascal_casing (System.dotnet_naming_convention,
				Result, feature {IL_CASING_CONVERSION}.upper_case)
		ensure
			internal_il_type_name_not_void: Result /= Void
			internal_il_type_name_not_empty: not Result.is_empty
		end

invariant
	class_id_positive: class_id > 0

end
