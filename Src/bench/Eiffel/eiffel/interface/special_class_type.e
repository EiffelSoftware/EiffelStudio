indexing
	description: "Class type for SPECIAL class.";
	date: "$Date$";
	revision: "$Revision$"


class SPECIAL_CLASS_TYPE 

inherit
	CLASS_TYPE
		redefine
			generate_feature, type
		end

	SHARED_C_LEVEL

	SHARED_IL_CODE_GENERATOR

	IL_CONST
	
create
	make

feature -- Status

	is_character_array: BOOLEAN is
			-- Is Current an array of character?
		do
			Result := first_generic.c_type.level = C_char
		end

	is_any_array: BOOLEAN is
			-- Is Current an array of ANY?
		local
			any_type: CL_TYPE_I
		do
			create any_type.make (System.any_id)
			Result := first_generic.same_as (any_type)
		end

feature -- Access

	first_generic: TYPE_I is
			-- First generic parameter type
		require
			has_generics: type.meta_generic /= Void;
			good_generic_count: type.meta_generic.count = 1;
		do
			Result := type.meta_generic.item (1);
		end

	type: GEN_TYPE_I
			-- Type of the class. It includes meta-instantiation of possible
			-- generic parameters.

feature -- C code generation

	generate_feature (feat: FEATURE_I; buffer: GENERATION_BUFFER) is
			-- Generate feature `feat' in `buffer'.
		local
			f_name_id: INTEGER
		do
			f_name_id := feat.feature_name_id
			
			inspect feat.feature_name_id
			when feature {PREDEFINED_NAMES}.put_name_id then
					-- Generate built-in feature `put' of class SPECIAL
				generate_put (feat, buffer)
			when
				feature {PREDEFINED_NAMES}.item_name_id,
				feature {PREDEFINED_NAMES}.infix_at_name_id
			then
					-- Generate built-in feature `item' of class SPECIAL
				generate_item (feat, buffer)
			
			when feature {PREDEFINED_NAMES}.Item_address_name_id then
					-- Temporary code generation of `item_address' so
					-- that it is thread safe (no GC sync calls in body).
				generate_item_address (feat, buffer)
				
			when feature {PREDEFINED_NAMES}.base_address_name_id then
					-- Temporary code generation of `base_address'
					-- so that it is thread safe (no GC sync calls in body).
				generate_base_address (feat, buffer)
				
			else
					-- Basic generation
				Precursor {CLASS_TYPE} (feat, buffer);
			end;
		end;

feature {NONE} -- C code generation

	generate_put (feat: FEATURE_I; buffer: GENERATION_BUFFER) is
			-- Generates built-in feature `put' of class SPECIAL
		require
			good_argument: buffer /= Void;
			feat_exists: feat /= Void;
			consistency: feat.feature_name_id = feature {PREDEFINED_NAMES}.put_name_id;
		local
			gen_param: TYPE_I;
			non_expanded_type: CL_TYPE_I;
			is_expanded: BOOLEAN;
			type_c: TYPE_C;
			final_mode: BOOLEAN;
			encoded_name: STRING;
		do
			gen_param := first_generic;
			is_expanded := gen_param.is_true_expanded;
			type_c := gen_param.c_type;

			buffer.putstring ("/* put */%N");
			encoded_name := Encoder.feature_name (static_type_id, feat.body_index);

			System.used_features_log_file.add (Current, "put", encoded_name);

			buffer.generate_function_signature ("void", encoded_name, True,
				Byte_context.header_buffer, <<"Current", "arg1", "arg2">>,
				<<"EIF_REFERENCE", type_c.c_string, "EIF_INTEGER">>);

			final_mode := byte_context.final_mode;

			if is_expanded then
				buffer.putstring ("%
					%%Tif (arg1 == (EIF_REFERENCE) 0)%N%
					%%T%TRTEC(EN_VEXP);%N");
			end;

			generate_precondition (buffer, final_mode, "arg2")

			if is_expanded then
				if final_mode then
						-- Optimization: size is know at compile time

					buffer.putstring ("%Tecopy(arg1, Current + OVERHEAD + arg2 * (EIF_Size(");
					non_expanded_type ?= gen_param;
					non_expanded_type := clone (non_expanded_type);
					non_expanded_type.set_is_true_expanded (False);
					buffer.putint (non_expanded_type.type_id - 1);
					buffer.putstring (") + OVERHEAD));%N")
				else
					buffer.putstring ("%Tecopy(arg1, Current + OVERHEAD + arg2 * (");
					buffer.putstring ("*(EIF_INTEGER *) (Current + %
						%(HEADER(Current)->ov_size & B_SIZE) - LNGPAD(2) + %
						%sizeof(EIF_INTEGER))));%N")
				end
			else
				buffer.putstring ("%T*(")
				type_c.generate_access_cast (buffer)
				buffer.putstring (" Current + arg2) = arg1;")
				if type_c.level = c_ref then
					buffer.putstring ("%TRTAS_OPT(arg1, arg2, Current);%N");
				end;
			end;

			buffer.putstring ("%N}%N%N");
		end;

	generate_item (feat: FEATURE_I; buffer: GENERATION_BUFFER) is
			-- Generates built-in feature `item' of class SPECIAL
		require
			good_argument: buffer /= Void;
			feat_exists: feat /= Void;
			consistency: feat.feature_name_id = feature {PREDEFINED_NAMES}.item_name_id or
				feat.feature_name_id = feature {PREDEFINED_NAMES}.infix_at_name_id
		local
			gen_param: TYPE_I;
			non_expanded_type: CL_TYPE_I;
			is_expanded: BOOLEAN;
			type_c: TYPE_C;
			final_mode: BOOLEAN;
			encoded_name: STRING
		do
			gen_param := first_generic;
			is_expanded := gen_param.is_true_expanded;
			type_c := gen_param.c_type;

			buffer.putstring ("/* item */%N");

			encoded_name := Encoder.feature_name (static_type_id, feat.body_index);

			System.used_features_log_file.add (Current, "item", encoded_name);

			buffer.generate_function_signature (type_c.c_string, encoded_name, True,
				byte_context.header_buffer,
				<<"Current", "arg1">>, <<"EIF_REFERENCE", "EIF_INTEGER">>);

			final_mode := byte_context.final_mode;

			generate_precondition (buffer, final_mode, "arg1")

			if is_expanded then
				if final_mode then
						-- Optimization: size of expanded is known at compile time

					buffer.putstring ("%Treturn Current + OVERHEAD + arg1 * (EIF_Size(");
					non_expanded_type ?= gen_param;
					non_expanded_type := clone (non_expanded_type);
					non_expanded_type.set_is_true_expanded (False);
					buffer.putint (non_expanded_type.type_id - 1);
					buffer.putstring (") + OVERHEAD);%N")
				else
					buffer.putstring ("%Treturn Current + OVERHEAD + arg1 * (");
					buffer.putstring ("*(EIF_INTEGER *) (Current + %
						%(HEADER(Current)->ov_size & B_SIZE) - LNGPAD(2) + %
						%sizeof(EIF_INTEGER)));%N")
				end
			else
				buffer.putstring ("%Treturn *(")
				type_c.generate_access_cast (buffer)
				buffer.putstring (" Current + arg1);")
			end;

			buffer.putstring ("%N}%N%N");
		end;

	generate_item_address (feat: FEATURE_I; buffer: GENERATION_BUFFER) is
			-- Generates built-in feature `item_address' of class SPECIAL
		require
			good_argument: buffer /= Void;
			feat_exists: feat /= Void;
			consistency: feat.feature_name_id = feature {PREDEFINED_NAMES}.item_address_name_id
		local
			result_type, gen_param: TYPE_I;
			is_expanded: BOOLEAN;
			type_c: TYPE_C;
			encoded_name: STRING
		do
			gen_param := first_generic;
			is_expanded := gen_param.is_true_expanded;
			type_c := gen_param.c_type;

			buffer.putstring ("/* item_address */%N");

			result_type := feat.type.actual_type.type_i
			if result_type.has_formal then
				result_type := result_type.instantiation_in (type)
			end

			encoded_name := Encoder.feature_name (static_type_id, feat.body_index);

			System.used_features_log_file.add (Current, "item_address", encoded_name);

			buffer.generate_function_signature (result_type.c_type.c_string, encoded_name, True,
				byte_context.header_buffer,
				<<"Current", "arg1">>, <<"EIF_REFERENCE", "EIF_INTEGER">>);

			generate_precondition (buffer, byte_context.final_mode, "arg1")

			buffer.putstring ("%Treturn ")
			result_type.c_type.generate_cast (buffer)
			buffer.putstring ("(Current + ")
			if is_expanded then
				buffer.putstring ("OVERHEAD + arg1 * sp_elem_size (Current));")
			else
				buffer.putstring ("arg1 * sizeof(")
				type_c.generate (buffer)
				buffer.putstring ("));")
			end
			buffer.putstring ("%N}%N%N");
		end;

	generate_base_address (feat: FEATURE_I; buffer: GENERATION_BUFFER) is
			-- Generates built-in feature `base_address' of class SPECIAL
		require
			good_argument: buffer /= Void;
			feat_exists: feat /= Void;
			consistency: feat.feature_name_id = feature {PREDEFINED_NAMES}.base_address_name_id
		local
			gen_param, result_type: TYPE_I;
			is_expanded: BOOLEAN;
			type_c: TYPE_C;
			final_mode: BOOLEAN;
			encoded_name: STRING
		do
			gen_param := first_generic;
			is_expanded := gen_param.is_true_expanded;
			type_c := gen_param.c_type;

			buffer.putstring ("/* base_address */%N");

			result_type := feat.type.actual_type.type_i
			if result_type.has_formal then
				result_type := result_type.instantiation_in (type)
			end

			encoded_name := Encoder.feature_name (static_type_id, feat.body_index);

			System.used_features_log_file.add (Current, "base_address", encoded_name);

			buffer.generate_function_signature (result_type.c_type.c_string, encoded_name, True,
				byte_context.header_buffer,
				<<"Current">>, <<"EIF_REFERENCE">>);

			final_mode := byte_context.final_mode;

			if is_expanded and not final_mode then
				buffer.putstring ("%TEIF_INTEGER elem_size;%N");
			end;

			buffer.putstring ("%Treturn ")
			result_type.c_type.generate_cast (buffer)
			buffer.putstring (" Current;")

			buffer.putstring ("%N}%N%N");
		end;

	generate_precondition (buffer: GENERATION_BUFFER; final_mode: BOOLEAN; arg_name: STRING) is
			-- Generate precondition for `item', `put' and `item_address' where index
			-- is stored in `arg_name'.
		require
			buffer_not_void: buffer /= Void
			arg_name_not_void: arg_name /= Void
		do
			if (not final_mode) or else associated_class.assertion_level.check_precond then
				if final_mode then
					buffer.putstring ("%Tif (~in_assertion) {%N");
					buffer.putstring ("%
						%%TRTCT(%"index_large_enough%", EX_PRE);%N%
						%%Tif (")
					buffer.putstring (arg_name)
					buffer.putstring (">= 0) {%N%
						%%T%TRTCK;%N%
						%%T} else {%N%
						%%T%TRTCF;%N%T}%N");

					buffer.putstring ("%
						%%TRTCT(%"index_small_enough%", EX_PRE);%N%
						%%Tif (")
					buffer.putstring (arg_name)
					buffer.putstring ("< *(EIF_INTEGER *) %
							%(Current + (HEADER(Current)->ov_size & B_SIZE)%
							% - LNGPAD(2))) {%N%
						%%T%TRTCK;%N%
						%%T} else {%N%
						%%T%TRTCF;%N%T}%N");

					buffer.putstring ("%T}%N");
				else
					buffer.putstring ("%
						%%Tif (")
					buffer.putstring (arg_name)
					buffer.putstring ("< 0) {%N%
						%%T%Teraise (%"index_large_enough%", EN_RT_CHECK);%N%T}%N");

					buffer.putstring ("%
						%%Tif (")
					buffer.putstring (arg_name)
					buffer.putstring (">= *(EIF_INTEGER *) %
							%(Current + (HEADER(Current)->ov_size & B_SIZE)%
							% - LNGPAD(2))) {%N%
						%%T%Teraise (%"index_small_enough%", EN_RT_CHECK);%N%T}%N");
				end
			end;
		end

feature -- IL code generation

	prepare_generate_il (name_id: INTEGER; special_type: CL_TYPE_I) is
			-- Generate call to `name_id' from SPECIAL so that it is
			-- very efficient.
		require
			valid_name_id:
				name_id = feature {PREDEFINED_NAMES}.Item_name_id or
				name_id = feature {PREDEFINED_NAMES}.Infix_at_name_id or
				name_id = feature {PREDEFINED_NAMES}.Put_name_id 
			special_type_not_void: special_type /= Void
			has_generics: type.true_generics /= Void
			good_generic_count: type.true_generics.count = 1
		local
			l_native_array: ATTRIBUTE_I
		do
				-- Get `native_array' field info.
			l_native_array ?= associated_class.feature_table.item_id (
				feature {PREDEFINED_NAMES}.Native_array_name_id)
			check
				l_native_array_not_void: l_native_array /= Void
			end
			
				-- Load `native_array' on stack.
			Il_generator.generate_attribute (True, special_type, l_native_array.feature_id)
		end

	generate_il (name_id: INTEGER; special_type: CL_TYPE_I) is
			-- Generate call to `name_id' from SPECIAL so that it is
			-- very efficient.
		require
			valid_name_id:
				name_id = feature {PREDEFINED_NAMES}.Item_name_id or
				name_id = feature {PREDEFINED_NAMES}.Infix_at_name_id or
				name_id = feature {PREDEFINED_NAMES}.Put_name_id 
			special_type_not_void: special_type /= Void
			has_generics: type.true_generics /= Void
			good_generic_count: type.true_generics.count = 1
		local
			l_native_array: ATTRIBUTE_I
			l_native_array_type: CL_TYPE_I
			l_element_type: TYPE_I
			l_index, l_element: INTEGER
			l_class_type: CLASS_TYPE
			l_native_array_class_type: NATIVE_ARRAY_CLASS_TYPE
		do
			if name_id = feature {PREDEFINED_NAMES}.Put_name_id then
					-- Because `put' from SPECIAL and `put' from NATIVE_ARRAY
					-- have their argument inverted, we need to swap the two
					-- elements on top of the stack.
				l_element_type := first_generic
				
					-- Variable to store element to be stored in SPECIAL
				Byte_context.add_local (l_element_type)
				l_element := Byte_context.local_list.count
				il_generator.put_dummy_local_info (l_element_type, l_element)
				
					-- Variable to store index where element will be stored in SPECIAL.
				Byte_context.add_local (Long_c_type)
				l_index := Byte_context.local_list.count
				il_generator.put_dummy_local_info (Long_c_type, l_index)
				
				Il_generator.generate_local_assignment (l_index)
				Il_generator.generate_local_assignment (l_element)
				Il_generator.generate_local (l_index)
				Il_generator.generate_local (l_element)
			end
				-- Get `native_array' field info.
			l_native_array ?= associated_class.feature_table.item_id (feature {PREDEFINED_NAMES}.Native_array_name_id)
			check
				l_native_array_not_void: l_native_array /= Void
			end
			
				-- Let's evaluate type of NATIVE_ARRAY			
			l_class_type := Byte_context.class_type
			Byte_context.set_class_type (Current)
			l_native_array_type ?= Byte_context.real_type (l_native_array.type.actual_type.type_i)
			check
				l_native_array_type_not_void: l_native_array_type /= Void
			end
			Byte_context.set_class_type (l_class_type)
			
				-- Call feature from NATIVE_ARRAY
			l_native_array_class_type ?= l_native_array_type.associated_class_type
			check
				l_native_array_class_not_void: l_native_array_type /= Void
			end
			l_native_array_class_type.generate_il (name_id, l_native_array_type)
		end

end
