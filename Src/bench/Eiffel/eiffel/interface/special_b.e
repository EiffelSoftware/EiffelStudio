--- Compiled class SPECIAL

class SPECIAL_B

inherit
	CLASS_C
		redefine
			check_validity, new_type, is_special
		end

	SPECIAL_CONST

creation
	make
	
feature

	check_validity is
			-- Check validity of class SPECIAL
		local
			special_error: SPECIAL_ERROR
			feat_table: FEATURE_TABLE
			item_feature, put_feature: FEATURE_I
		do
				-- First, check if class has one formal generic parameter
			if generics = Void or else generics.count /= 1 then
				!!special_error.make (Case_11, Current)
				Error_handler.insert_error (special_error)
			end

				-- Second, check if class has a feature item (INTEGER): Generic #1
			feat_table := feature_table
			item_feature := feat_table.item ("item")
			if item_feature = Void
				or else not equal (item_feature.written_in, id)
				or else not item_feature.same_signature (Item_signature)
			then
				!!special_error.make (Case_12, Current)
				Error_handler.insert_error (special_error)
			end
			
				-- Third, check if class has a feature put (Generic #1, INTEGER)
			put_feature := feat_table.item ("put")
			if put_feature = Void
				or else not equal (put_feature.written_in, id)
				or else not put_feature.same_signature (Put_signature)
			then
				!!special_error.make (Case_13, Current)
				Error_handler.insert_error (special_error)
			end
		end

	Item_signature: DYN_FUNC_I is
			-- Required signature for feature `item' of class SPECIAL
		local
			args: FEAT_ARG
			f: FORMAL_A
		once
			!!args.make (1)
			args.put_i_th (Integer_type, 1)
			!!Result
			Result.set_arguments (args)
			!!f
			f.set_position (1)
			Result.set_type (f)
			Result.set_feature_name ("item")
		end

	Put_signature: DYN_PROC_I is
			-- Required signature for feature `put' of class SPECIAL
		local
			args: FEAT_ARG
			f: FORMAL_A
		once
			!!f
			f.set_position (1)
			!!args.make (2)
			args.put_i_th (f, 1)
			args.put_i_th (Integer_type, 2)
			!!Result
			Result.set_arguments (args)
			Result.set_feature_name ("put")
		end
		
	new_type (data: CL_TYPE_I): SPECIAL_CLASS_TYPE is
			-- New class type for class SPECIAL
		do
			!! Result.make (data)
		end

	is_special: BOOLEAN is True
			-- Is the class special ?
	
	generate_dynamic_types (plug_file: INDENT_FILE) is
			-- Generate dynamic types of type classes available in the system
		local
			class_type: CLASS_TYPE
			gen_type: GEN_TYPE_I
			gen_param: TYPE_I
			dtype, char_dtype, long_dtype,
			float_dtype, double_dtype,
			pointer_dtype, boolean_dtype: INTEGER
		do
			from
				char_dtype := -1
				long_dtype := -1
				float_dtype := -1
				double_dtype := -1
				boolean_dtype := -1
				pointer_dtype := -1
				types.start
			until
				types.after
			loop
				class_type := types.item
				dtype := class_type.type_id - 1
				gen_type ?= class_type.type
				gen_param := gen_type.meta_generic.item (1)
				if gen_param.is_char then
					char_dtype := dtype
				elseif gen_param.is_long then
					long_dtype := dtype
				elseif gen_param.is_float then
					float_dtype := dtype
				elseif gen_param.is_double then
					double_dtype := dtype
				elseif gen_param.is_boolean then
					boolean_dtype := dtype
				elseif gen_param.is_feature_pointer then
					pointer_dtype := dtype
				end
				types.forth
			end
			Plug_file.putstring ("%N%Tegc_sp_char = ")
			Plug_file.putint (char_dtype)
			Plug_file.putstring (";%N%Tegc_sp_bool = ")
			Plug_file.putint (boolean_dtype)
			Plug_file.putstring (";%N%Tegc_sp_int = ")
			Plug_file.putint (long_dtype)
			Plug_file.putstring (";%N%Tegc_sp_real = ")
			Plug_file.putint (float_dtype)
			Plug_file.putstring (";%N%Tegc_sp_double = ")
			Plug_file.putint (double_dtype)
			Plug_file.putstring (";%N%Tegc_sp_pointer = ")
			Plug_file.putint (pointer_dtype)
			Plug_file.putstring (";%N")
		end

end
