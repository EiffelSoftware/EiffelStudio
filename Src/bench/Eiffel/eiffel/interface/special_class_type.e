-- Class type for class SPECIAL

class SPECIAL_CLASS_TYPE 

inherit

	CLASS_TYPE
		redefine
			generate_feature
		end

	SHARED_C_LEVEL;

creation

	make

	
feature

	generate_feature (feat: FEATURE_I; buffer: GENERATION_BUFFER) is
			-- Generate feature `feat' in `buffer'.
		local
			feature_name: STRING;
		do
			feature_name := feat.feature_name

			if feature_name.is_equal ("put") then
					-- Generate built-in feature `put' of class SPECIAL
				generate_put (feat, buffer);
			elseif feature_name.is_equal ("item") then
					-- Generate built-in feature `item' of class SPECIAL
				generate_item (feat, buffer);
			else
					-- Basic generation
				{CLASS_TYPE} Precursor (feat, buffer);
			end;
		end;

	generate_put (feat: FEATURE_I; buffer: GENERATION_BUFFER) is
			-- Generates built-in feature `put' of class SPECIAL
		require
			good_argument: buffer /= Void;
			feat_exists: feat /= Void;
			consistency: feat.feature_name.is_equal ("put");
		local
			gen_param: TYPE_I;
			non_expanded_type: CL_TYPE_I;
			is_expanded, has_local: BOOLEAN;
			type_c: TYPE_C;
			assertion_level: ASSERTION_I;
			final_mode: BOOLEAN;
			encoded_name: STRING;
		do
			gen_param := first_generic;
			is_expanded := gen_param.is_expanded;
			type_c := gen_param.c_type;
			assertion_level := associated_class.assertion_level;

			buffer.putstring ("/* put */%N");
			encoded_name := feat.body_id.feature_name (id);

			System.used_features_log_file.add (Current, "put", encoded_name);

			buffer.generate_function_signature ("void", encoded_name, True,
				Byte_context.header_buffer, <<"Current", "arg1", "arg2">>,
				<<"EIF_REFERENCE", type_c.c_string, "EIF_INTEGER">>);

			final_mode := byte_context.final_mode;

			if is_expanded then
				if not final_mode then
					buffer.putstring ("%Tlong elem_size;%N")
				end
				buffer.putstring ("%
					%%Tif (arg1 == (char *) 0)%N%
					%%T%TRTEC(EN_VEXP);%N");
			end;

			if (not final_mode) or else assertion_level.check_precond then
				if not final_mode then
					buffer.putstring ("%Tif (~in_assertion & WASC(Dtype(Current)) & CK_REQUIRE) {%N");
				else
					buffer.putstring ("%Tif (~in_assertion) {%N");
				end;
				buffer.putstring ("%
					%%TRTCT(%"index_large_enough%", EX_PRE);%N%
					%%Tif (arg2 >= 0) {%N%
					%%T%TRTCK;%N%
					%%T} else {%N%
					%%T%TRTCF;%N%T}%N");

				buffer.putstring ("%
					%%TRTCT(%"index_small_enough%", EX_PRE);%N%
					%%Tif (arg2 < *(long *) %
						%(Current + (HEADER(Current)->ov_size & B_SIZE)%
						% - LNGPAD(2))) {%N%
					%%T%TRTCK;%N%
					%%T} else {%N%
					%%T%TRTCF;%N%T}%N");

				buffer.putstring ("%T}%N");
			end;

			if is_expanded then
				if final_mode then
						-- Optimization: size is know at compile time

					buffer.putstring ("%Tecopy(arg1, Current + OVERHEAD + arg2 * (Size(");
					non_expanded_type ?= gen_param;
					non_expanded_type := clone (non_expanded_type);
					non_expanded_type.set_is_expanded (False);
					buffer.putint (non_expanded_type.type_id - 1);
					buffer.putstring (") + OVERHEAD));%N")
				else
					buffer.putstring ("%
						%%Telem_size = *(long *) %
							%(Current + (HEADER(Current)->ov_size & B_SIZE)%
							% - LNGPAD(2) + sizeof(long));%N%
						%%Tecopy(arg1, Current + OVERHEAD + arg2 * elem_size);%N");
				end
			else
				inspect
					type_c.level
				when C_char then
					buffer.putstring ("%T*((EIF_CHARACTER *) Current + arg2) = arg1;");
				when C_long then
					buffer.putstring ("%T*((EIF_INTEGER *) Current + arg2) = arg1;");
				when C_float then
					buffer.putstring ("%T*((EIF_REAL *) Current + arg2) = arg1;");
				when C_double then
					buffer.putstring ("%T*((EIF_DOUBLE *) Current + arg2) = arg1;");
				when C_pointer then
					buffer.putstring ("%T*((EIF_POINTER *) Current + arg2) = arg1;");
				when C_ref then
						--! Could be bit or ref
					buffer.putstring ("%TRTAS(arg1, Current);%N");
					buffer.putstring ("%T*((EIF_REFERENCE *) Current + arg2) = arg1;");
				else
						-- Type is NONE
					buffer.putstring ("%T*((EIF_REFERENCE *) Current + arg2) = arg1;");
				end;
			end;

			buffer.putstring ("%N}%N%N");

		end;

	generate_item (feat: FEATURE_I; buffer: GENERATION_BUFFER) is
			-- Generates built-in feature `item' of class SPECIAL
		require
			good_argument: buffer /= Void;
			feat_exists: feat /= Void;
			consistency: feat.feature_name.is_equal ("item");
		local
			gen_param: TYPE_I;
			non_expanded_type: CL_TYPE_I;
			is_expanded, has_local: BOOLEAN;
			type_c: TYPE_C;
			assertion_level: ASSERTION_I;
			final_mode: BOOLEAN;
			encoded_name: STRING
		do
			gen_param := first_generic;
			is_expanded := gen_param.is_expanded;
			type_c := gen_param.c_type;
			assertion_level := associated_class.assertion_level;

			buffer.putstring ("/* item */%N");

			encoded_name := feat.body_id.feature_name (id);

			System.used_features_log_file.add (Current, "item", encoded_name);

			buffer.generate_function_signature (type_c.c_string, encoded_name, True,
				byte_context.header_buffer,
				<<"Current", "arg1">>, <<"EIF_REFERENCE", "EIF_INTEGER">>);

			final_mode := byte_context.final_mode;

			if is_expanded and not final_mode then
				buffer.putstring ("long elem_size;%N");
			end;

			if (not final_mode) or else assertion_level.check_precond then
				if not final_mode then
					buffer.putstring ("%Tif (~in_assertion & WASC(Dtype(Current)) & CK_REQUIRE) {%N");
				else
					buffer.putstring ("%Tif (~in_assertion) {%N");
				end;
				buffer.putstring ("%
					%%TRTCT(%"index_large_enough%", EX_PRE);%N%
					%%Tif (arg1 >= 0) {%N%
					%%T%TRTCK;%N%
					%%T } else {%N%
					%%T%TRTCF;%N%T}%N");
	
				buffer.putstring ("%
					%%TRTCT(%"index_small_enough%", EX_PRE);%N%
					%%Tif (arg1 < *(long *) %
						%(Current + (HEADER(Current)->ov_size & B_SIZE) %
						%- LNGPAD(2))) {%N%
					%%T%TRTCK;%N%
					%%T } else {%N%
					%%T%TRTCF;%N%T}%N");

				buffer.putstring ("%T}%N");
			end;

			if is_expanded then
				if final_mode then
						-- Optimization: size of expanded is known at compile time

					buffer.putstring ("%Treturn Current + OVERHEAD + arg1 * (Size(");
					non_expanded_type ?= gen_param;
					non_expanded_type := clone (non_expanded_type);
					non_expanded_type.set_is_expanded (False);
					buffer.putint (non_expanded_type.type_id - 1);
					buffer.putstring (") + OVERHEAD);%N")
				else
					buffer.putstring ("%
						%%Telem_size = *(long *) %
							%(Current + (HEADER(Current)->ov_size & B_SIZE) %
							%- LNGPAD(2) + sizeof(long));%N%
						%%Treturn Current + OVERHEAD + arg1 * elem_size;%N");
				end
			else
				inspect
					type_c.level
				when C_char then
					buffer.putstring ("%Treturn *((EIF_CHARACTER *) Current + arg1);");
				when C_long then
					buffer.putstring ("%Treturn *((EIF_INTEGER *) Current + arg1);");
				when C_float then
					buffer.putstring ("%Treturn *((EIF_REAL *) Current + arg1);");
				when C_double then
					buffer.putstring ("%Treturn *((EIF_DOUBLE *) Current + arg1);");
				when C_pointer then
					buffer.putstring ("%Treturn *((EIF_POINTER *) Current + arg1);");
				when C_ref then
						--! Could be bit or ref
					buffer.putstring ("%Treturn *((EIF_REFERENCE *) Current + arg1);");
				else
						-- Type is NONE
					buffer.putstring ("%Treturn *((EIF_REFERENCE *) Current + arg1);");
				end;
			end;

			buffer.putstring ("%N}%N%N");

		end;

	first_generic: TYPE_I is
			-- First generic parameter type
		require
			has_generics: type.meta_generic /= Void;
			good_generic_count: type.meta_generic.count = 1;
		do
			Result := type.meta_generic.item (1);
		end

end
