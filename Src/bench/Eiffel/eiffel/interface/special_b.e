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
				or else not (item_feature.written_in = class_id)
				or else not item_feature.same_signature (Item_signature)
			then
				!!special_error.make (Case_12, Current)
				Error_handler.insert_error (special_error)
			end
			
				-- Third, check if class has a feature put (Generic #1, INTEGER)
			put_feature := feat_table.item ("put")
			if put_feature = Void
				or else not (put_feature.written_in = class_id)
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
			Result.set_feature_name_id (Names_heap.item_name_id)
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
			Result.set_feature_name_id (Names_heap.put_name_id)
		end
		
	new_type (data: CL_TYPE_I): SPECIAL_CLASS_TYPE is
			-- New class type for class SPECIAL
		do
			!! Result.make (data)
		end

	is_special: BOOLEAN is True
			-- Is the class special ?
	
	generate_dynamic_types (buffer: GENERATION_BUFFER) is
			-- Generate dynamic types of type classes available in the system
		local
			class_type: CLASS_TYPE
			gen_type: GEN_TYPE_I
			gen_param: TYPE_I
			int_i: LONG_I
			char_i: CHAR_I
			dtype, char_dtype, int8_dtype, int16_dtype,
			int32_dtype, int64_dtype, wchar_dtype,
			float_dtype, double_dtype,
			pointer_dtype, boolean_dtype: INTEGER
		do
			from
				char_dtype := -1
				wchar_dtype := -1
				int8_dtype := -1
				int16_dtype := -1
				int32_dtype := -1
				int64_dtype := -1
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
					char_i ?= gen_param
					if char_i.is_wide then
						wchar_dtype := dtype
					else
						char_dtype := dtype
					end
				elseif gen_param.is_long then
					int_i ?= gen_param
					inspect int_i.size
					when 8 then int8_dtype := dtype
					when 16 then int16_dtype := dtype
					when 32 then int32_dtype := dtype
					when 64 then int64_dtype := dtype
					end
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
			buffer.putstring ("%N%Tegc_sp_char = ")
			buffer.putint (char_dtype)
			buffer.putstring (";%N%Tegc_sp_wchar = ")
			buffer.putint (wchar_dtype)
			buffer.putstring (";%N%Tegc_sp_bool = ")
			buffer.putint (boolean_dtype)
			buffer.putstring (";%N%Tegc_sp_int8 = ")
			buffer.putint (int8_dtype)
			buffer.putstring (";%N%Tegc_sp_int16 = ")
			buffer.putint (int16_dtype)
			buffer.putstring (";%N%Tegc_sp_int32 = ")
			buffer.putint (int32_dtype)
			buffer.putstring (";%N%Tegc_sp_int64 = ")
			buffer.putint (int64_dtype)
			buffer.putstring (";%N%Tegc_sp_real = ")
			buffer.putint (float_dtype)
			buffer.putstring (";%N%Tegc_sp_double = ")
			buffer.putint (double_dtype)
			buffer.putstring (";%N%Tegc_sp_pointer = ")
			buffer.putint (pointer_dtype)
			buffer.putstring (";%N")
		end

end
