-- Class type for class SPECIAL

class SPECIAL_CLASS_TYPE 

inherit

	CLASS_TYPE
		rename
			generate_feature as basic_generate_feature
		end;
	CLASS_TYPE
		redefine
			generate_feature
		select
			generate_feature
		end;
	SHARED_C_LEVEL;

creation

	make

	
feature

	generate_feature (feat: FEATURE_I; file: INDENT_FILE) is
			-- Generate feature `feat' in `file'.
		local
			feature_name: STRING;
		do
			feature_name := feat.feature_name;
			if feature_name.is_equal ("put") then
					-- Generate built-in feature `put' of class SPECIAL
				generate_put (feat, file);
			elseif feature_name.is_equal ("item") then
					-- Generate built-in feature `item' of class SPECIAL
				generate_item (feat, file);
			else
					-- Basic generation
				basic_generate_feature (feat, file);
			end;
		end;

	generate_put (feat: FEATURE_I; file: INDENT_FILE) is
			-- Generates built-in feature `put' of class SPECIAL
		require
			good_argument: file /= Void;
			feat_exists: feat /= Void;
			consistency: feat.feature_name.is_equal ("put");
		local
			gen_param: TYPE_I;
			is_expanded, has_local: BOOLEAN;
			type_c: TYPE_C;
			assertion_level: ASSERTION_I;
			final_mode: BOOLEAN;
		do
			gen_param := first_generic;
			is_expanded := gen_param.is_expanded;
			type_c := gen_param.c_type;
			assertion_level := associated_class.assertion_level;

			file.putstring ("%
				%/*%N%
				% * put%N%
				% */%N%
				%void ");
			file.putstring (Encoder.feature_name (id, feat.body_id));
			file.putstring ("%
				%(Current, arg1, arg2)%N%
				%char *Current;%N");
			type_c.generate (file);
			file.putstring ("%
				%arg1;%N%
				%long arg2;%N%
				%{%N");

			if is_expanded then
				file.putstring ("%
					%%Tlong elem_size;%N%
					%%Tif (arg1 == (char *) 0)%N%
					%%T%TRTEC(EN_VEXP);%N");
			end;

			final_mode := byte_context.final_mode;
			if	(not final_mode) or else assertion_level.check_precond then
				if not final_mode then
					file.putstring
						("%Tif (WASC(Dtype(Current)) & CK_REQUIRE) {%N");
				end;
				file.putstring ("%
					%%TRTCT(%"index_large_enough%", EX_PRE);%N%
					%%Tif (arg2 >= 0)%N%
					%%T%TRTCK;%N%
					%%Telse%N%
					%%T%TRTCF;%N");

				file.putstring ("%
					%%TRTCT(%"index_small_enough%", EX_PRE);%N%
					%%Tif (arg2 < *(long *) %
						%(Current + (HEADER(Current)->ov_size & B_SIZE)%
						% - LNGPAD(2)))%N%
					%%T%TRTCK;%N%
					%%Telse%N%
					%%T%TRTCF;%N");
				if not final_mode then
					file.putstring ("%T}%N");
				end;
			end;

			if is_expanded then
				file.putstring ("%
					%%Telem_size = *(long *) %
						%(Current + (HEADER(Current)->ov_size & B_SIZE)%
						% - LNGPAD(2) + sizeof(long));%N%
					%%Tecopy(arg1, Current + OVERHEAD + arg2 * elem_size);%N");
			else
				inspect
					type_c.level
				when C_char then
					file.putstring
					("%T*(Current + arg2 * sizeof(char)) = arg1;");
				when C_long then
					file.putstring
					("%T*(long *)(Current + arg2 * sizeof(long)) = arg1;");
				when C_float then
					file.putstring
					("%T*(float *)(Current + arg2 * sizeof(float)) = arg1;");
				when C_double then
					file.putstring
					("%T*(double *)(Current + arg2 * sizeof(double)) = arg1;");
				when C_ref then
					--! Could be bit or ref
					file.putstring ("%TRTAS(arg1, Current);%N");
					file.putstring
					("%T*(char **)(Current + arg2 * "); 
					type_c.generate_size (file);
					file.putstring (") = arg1;");
				when C_pointer then
					file.putstring
					("%T*(fnptr *)(Current + arg2 * sizeof(fnptr)) = arg1;");
				end;
				file.new_line;
			end;

			file.putstring ("};%N%N");

		end;

	generate_item (feat: FEATURE_I; file: INDENT_FILE) is
			-- Generates built-in feature `item' of class SPECIAL
		require
			good_argument: file /= Void;
			feat_exists: feat /= Void;
			consistency: feat.feature_name.is_equal ("item");
		local
			gen_param: TYPE_I;
			is_expanded, has_local: BOOLEAN;
			type_c: TYPE_C;
			assertion_level: ASSERTION_I;
			final_mode: BOOLEAN;
		do
			gen_param := first_generic;
			is_expanded := gen_param.is_expanded;
			type_c := gen_param.c_type;
			assertion_level := associated_class.assertion_level;

			file.putstring ("%
				%/*%N%
				% * item%N%
				% */%N");
			type_c.generate (file);
			file.putstring (Encoder.feature_name (id, feat.body_id));
			file.putstring ("%
				%(Current, arg1)%N%
				%char *Current;%N%
				%long arg1;%N%
				%{%N");

			if is_expanded then
				file.putstring ("long elem_size;%N");
			end;

			final_mode := byte_context.final_mode;
			if (not final_mode) or else assertion_level.check_precond then
				if not final_mode then
					file.putstring
						("%Tif (WASC(Dtype(Current)) & CK_REQUIRE) {%N");
				end;
				file.putstring ("%
					%%TRTCT(%"index_large_enough%", EX_PRE);%N%
					%%Tif (arg1 >= 0)%N%
					%%T%TRTCK;%N%
					%%Telse%N%
					%%T%TRTCF;%N");
	
				file.putstring ("%
					%%TRTCT(%"index_small_enough%", EX_PRE);%N%
					%%Tif (arg1 < *(long *) %
						%(Current + (HEADER(Current)->ov_size & B_SIZE) %
						%- LNGPAD(2)))%N%
					%%T%TRTCK;%N%
					%%Telse%N%
					%%T%TRTCF;%N");
				if not final_mode then
					file.putstring ("%T}%N");
				end;
			end;

			if is_expanded then
				file.putstring ("%
					%%Telem_size = *(long *) %
						%(Current + (HEADER(Current)->ov_size & B_SIZE) %
						%- LNGPAD(2) + sizeof(long));%N%
					%%Treturn Current + OVERHEAD + arg1 * elem_size;%N");
			else
				inspect
					type_c.level
				when C_char then
					file.putstring
					("%Treturn *(Current + arg1 * sizeof(char));");
				when C_long then
					file.putstring
					("%Treturn *(long *)(Current + arg1 * sizeof(long));");
				when C_float then
					file.putstring
					("%Treturn *(float *)(Current + arg1 * sizeof(float));");
				when C_double then
					file.putstring
					("%Treturn *(double *)(Current + arg1 * sizeof(double));");
				when C_ref then
					--! Could be bit or ref
					file.putstring
					("%Treturn *(char **)(Current + arg1 * ");
					type_c.generate_size (file);
					file.putstring (");");
				when C_pointer then
					file.putstring
					("%Treturn *(fnptr *)(Current + arg1 * sizeof(fnptr));");
				end;
				file.new_line;
			end;

			file.putstring ("}%N%N");

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
