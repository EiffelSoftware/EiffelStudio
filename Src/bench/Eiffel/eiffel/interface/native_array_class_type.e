indexing
	description: "Class type for NATIVE_ARRAY class.";
	date: "$Date$";
	revision: "$Revision$"


class NATIVE_ARRAY_CLASS_TYPE 

inherit
	CLASS_TYPE

	SHARED_C_LEVEL

	SHARED_IL_CODE_GENERATOR

	IL_CONST
	
	PREDEFINED_NAMES
	
creation
	make

feature -- Access

	first_generic: TYPE_I is
			-- First generic parameter type
		require
			has_generics: type.meta_generic /= Void;
			good_generic_count: type.meta_generic.count = 1;
		do
			Result := type.meta_generic.item (1);
		end

	il_type_name: STRING is
			-- Associated name to current generic derivation.
			-- E.g. SPECIAL [INTEGER] gives `INTEGER []'.
		require
			has_generics: type.true_generics /= Void
			good_generic_count: type.true_generics.count = 1
			in_il_generation: System.il_generation
		do
			Result := il_element_type_name
			Result.append ("[]")
		end

	il_element_type_name: STRING is
			-- Associated name of element types.
			-- E.g. SPECIAL [INTEGER] gives `INTEGER'.
		require
			has_generics: type.true_generics /= Void
			good_generic_count: type.true_generics.count = 1
			in_il_generation: System.il_generation
		local
			gen_param: TYPE_I
			cl_type: CL_TYPE_I
			ref: REFERENCE_I
		do
			gen_param := first_generic
			ref ?= gen_param
			if ref /= Void and then not gen_param.is_true_expanded then
					-- Create 15 characters to accomodate 2 extra ones `[]'.
				create Result.make (15)
				Result := "System.Object"
			else
				cl_type ?= type.true_generics.item (1)
				check
					cl_type_not_void: cl_type /= Void
				end
				create Result.make (cl_type.il_type_name.count + 2)
				Result.append (cl_type.il_type_name)
			end
		end

feature -- IL code generation

	generate_il (name_id: INTEGER) is
			-- Generate call to `name_id' from SPECIAL.
		require
			valid_name_id: name_id > 0
			has_generics: type.true_generics /= Void
			good_generic_count: type.true_generics.count = 1
		local
			gen_param: TYPE_I
			cl_type: CL_TYPE_I
			ref: REFERENCE_I
			is_expanded: BOOLEAN
			type_c: TYPE_C
			type_kind: INTEGER
			generic_type_id: INTEGER
		do
			gen_param := first_generic
			is_expanded := gen_param.is_true_expanded
			type_c := gen_param.c_type

			if not is_expanded then
				inspect
					type_c.level
				when C_char then
					if type_c.is_boolean then
						type_kind := il_i1
					else
						type_kind := il_i2
					end
				when C_wide_char, C_int32 then
					type_kind := il_i4
				when C_int8 then
					type_kind := il_i1
				when C_int16 then
					type_kind := il_i2
				when C_int64 then
					type_kind := il_i8
				when C_float then
					type_kind := il_r4
				when C_double then
					type_kind := il_r8
				when C_pointer then
					type_kind := il_i
				else
					type_kind := il_ref
				end;

				ref ?= gen_param

				inspect
					name_id

				when item_name_id, infix_at_name_id then
					il_generator.generate_array_access (type_kind)

				when put_name_id then
 					il_generator.generate_array_write (type_kind)

				when make_name_id then
					if ref /= Void and then not is_expanded then
						generic_type_id := System.system_object_class.compiled_class.
							types.first.static_type_id
					else
						cl_type ?= type.true_generics.item (1)
						check
							cl_type_not_void: cl_type /= Void
						end
						generic_type_id := cl_type.associated_class_type.static_type_id
					end
					il_generator.generate_array_creation (generic_type_id)
					
				when count_name_id then
 					il_generator.generate_array_count

				when lower_name_id then
 					il_generator.generate_array_lower

	 			when upper_name_id then
	 				il_generator.generate_array_upper

				when all_default_name_id then

				when clear_all_name_id then

				when index_of_name_id then

				when resized_area_name_id then

				when same_items_name_id then

				else
--					check
--						False
--					end
				end
			end
		end
		
invariant
	il_generation: System.il_generation

end -- end of NATIVE_ARRAY_CLASS_TYPE
