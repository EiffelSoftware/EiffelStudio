indexing
	description: "Compiled class SPECIAL"
	date: "$Date$"
	revision: "$Revision$"

class SPECIAL_B

inherit
	CLASS_C
		redefine
			check_validity, new_type, is_special
		end

	SPECIAL_CONST

create
	make
	
feature -- Validity

	check_validity is
			-- Check validity of class SPECIAL
		local
			special_error: SPECIAL_ERROR
			feat_table: FEATURE_TABLE
			item_feature, put_feature, make_feature: FEATURE_I
			done: BOOLEAN
		do
				-- Check if class has one formal generic parameter
			if generics = Void or else generics.count /= 1 or else not is_frozen then
				create special_error.make (special_case_1, Current)
				Error_handler.insert_error (special_error)
			end

			feat_table := feature_table

				-- Check if class has a feature make (INTEGER)
			make_feature := feat_table.item_id (names_heap.make_name_id)
			if
				make_feature = Void
				or else not (make_feature.written_in = class_id)
				or else not make_feature.same_signature (make_signature)
			then
				create special_error.make (special_case_2, Current)
				Error_handler.insert_error (special_error)
			end
			
				-- Check that `make' is indeed a creation procedure
			if creators = Void then
				create special_error.make (special_case_3, Current)
				Error_handler.insert_error (special_error)
			else
				from
					creators.start
				until
					done or else creators.after
				loop
					done := creators.key_for_iteration.
						is_equal (names_heap.item (Names_heap.make_name_id))
					creators.forth
				end
				if not done then
					create special_error.make (special_case_3, Current)
					Error_handler.insert_error (special_error)
				end
			end

				-- Check if class has a feature item (INTEGER): Generic #1
			item_feature := feat_table.item_id (names_heap.item_name_id)
			if item_feature = Void
				or else not (item_feature.written_in = class_id)
				or else not item_feature.same_signature (item_signature)
			then
				create special_error.make (special_case_4, Current)
				Error_handler.insert_error (special_error)
			end
			
				-- Check if class has a feature put (Generic #1, INTEGER)
			put_feature := feat_table.item_id (names_heap.put_name_id)
			if put_feature = Void
				or else not (put_feature.written_in = class_id)
				or else not put_feature.same_signature (put_signature)
			then
				create special_error.make (special_case_5, Current)
				Error_handler.insert_error (special_error)
			end
		end

feature -- Typing

	new_type (data: CL_TYPE_I): SPECIAL_CLASS_TYPE is
			-- New class type for class SPECIAL
		do
			create Result.make (data)
				-- Unlike the parent version, each time a new SPECIAL derivation
				-- is added we need to freeze so that we call the right version of
				-- `put' and `item'.
			system.set_freeze
			if already_compiled then
					-- Melt all the code written in the associated class of the new class type
				melt_all
			end
		end

feature -- Status report

	is_special: BOOLEAN is True
			-- Is class SPECIAL?
	
feature -- Code generation

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
			pointer_dtype, boolean_dtype, ref_dtype: INTEGER
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
				ref_dtype := -1
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
				elseif not gen_param.is_expanded then
					ref_dtype := dtype
				end
				types.forth
			end
			buffer.put_string ("%N%Tegc_sp_char = (uint32)")
			buffer.put_integer (char_dtype)
			buffer.put_string (";%N%Tegc_sp_wchar = (uint32)")
			buffer.put_integer (wchar_dtype)
			buffer.put_string (";%N%Tegc_sp_bool = (uint32)")
			buffer.put_integer (boolean_dtype)
			buffer.put_string (";%N%Tegc_sp_int8 = (uint32)")
			buffer.put_integer (int8_dtype)
			buffer.put_string (";%N%Tegc_sp_int16 = (uint32)")
			buffer.put_integer (int16_dtype)
			buffer.put_string (";%N%Tegc_sp_int32 = (uint32)")
			buffer.put_integer (int32_dtype)
			buffer.put_string (";%N%Tegc_sp_int64 = (uint32)")
			buffer.put_integer (int64_dtype)
			buffer.put_string (";%N%Tegc_sp_real = (uint32)")
			buffer.put_integer (float_dtype)
			buffer.put_string (";%N%Tegc_sp_double = (uint32)")
			buffer.put_integer (double_dtype)
			buffer.put_string (";%N%Tegc_sp_pointer = (uint32)")
			buffer.put_integer (pointer_dtype)
			buffer.put_string (";%N%Tegc_sp_ref = (uint32)")
			buffer.put_integer (ref_dtype)
			buffer.put_string (";%N")
		end

feature {NONE} -- Implementation

	make_signature: DYN_PROC_I is
			-- Required signature for feature `make' of class SPECIAL
		local
			args: FEAT_ARG
		do
			create args.make (1)
			args.put_i_th (Integer_type, 1)
			create Result
			Result.set_arguments (args)
			Result.set_feature_name_id (Names_heap.make_name_id)
		ensure
			item_signature_not_void: Result /= Void
		end

	item_signature: DYN_FUNC_I is
			-- Required signature for feature `item' of class SPECIAL
		local
			args: FEAT_ARG
			f: FORMAL_A
		do
			create args.make (1)
			args.put_i_th (Integer_type, 1)
			create Result
			Result.set_arguments (args)
			create f.make (False, False, 1)
			Result.set_type (f)
			Result.set_feature_name_id (Names_heap.item_name_id)
		ensure
			item_signature_not_void: Result /= Void
		end

	put_signature: DYN_PROC_I is
			-- Required signature for feature `put' of class SPECIAL
		local
			args: FEAT_ARG
			f: FORMAL_A
		do
			create f.make (False, False, 1)
			create args.make (2)
			args.put_i_th (f, 1)
			args.put_i_th (Integer_type, 2)
			create Result
			Result.set_arguments (args)
			Result.set_feature_name_id (Names_heap.put_name_id)
		ensure
			put_signature_not_void: Result /= Void
		end

end
