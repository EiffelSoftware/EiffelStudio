-- Class type for class TO_SPECIAL

class TO_SPECIAL_CLASS_TYPE 

inherit

	CLASS_TYPE
		redefine
			generate_feature
		end

	SHARED_TABLE

	SHARED_BODY_ID

creation

	make

feature

	generate_feature (feat: FEATURE_I; file: INDENT_FILE) is
			-- Generate feature `feat' in `file'.
		local
			feature_name: STRING;
		do
			feature_name := feat.feature_name

			if feature_name.is_equal ("make_area") then
					-- Generate built-in feature `put' of class SPECIAL
				generate_make_area (feat, file);
			else
					-- Basic generation
				{CLASS_TYPE} Precursor (feat, file);
			end;
		end;

	generate_make_area (feat: FEATURE_I; file: INDENT_FILE) is
			-- Generates built-in feature `make_area' of class TO_SPECIAL
		require
			good_argument: file /= Void;
			feat_exists: feat /= Void;
		local
			gen_param: TYPE_I;
			is_expanded: BOOLEAN;
			type_c: TYPE_C;
			expanded_type, non_expanded_type: CL_TYPE_I;
			exp_class_type: CLASS_TYPE;
			gen_type: GEN_TYPE_I;
			dtype: INTEGER;
			c_name: STRING;
			final_mode: BOOLEAN;
			has_init, has_creation: BOOLEAN
			encoded_name: STRING
		do
			gen_param := first_generic;
			is_expanded := gen_param.is_expanded;
			type_c := gen_param.c_type;

				-- HEADER:
				--		void make_area(Current, arg1)
				--		EIF_REFERENCE Current;
				--		EIF_INTEGER arg1;
				--		{
				--			char *ref;
				--			struct union overhead *zone;
			file.putstring ("/* make_area */%N");
			encoded_name := feat.body_id.feature_name (id);

			System.used_features_log_file.add (Current, "make_area", encoded_name);

			file.generate_function_signature ("void", encoded_name, True, file,
				<<"Current", "arg1">>, <<"EIF_REFERENCE", "EIF_INTEGER">>)

			file.putstring ("%
				%%Tchar *ref;%N%
				%%Tunion overhead *zone;%N%
				%%TRTLD;%N%N");

				-- Garbage collector hooks
			file.putstring ("%TRTLI(2);%N%
				%%Tl[0] = Current;%N%
				%%Tl[1] = (char *) 0;%N%N");

			final_mode := byte_context.final_mode;
			if 	(not final_mode)
				or else
				associated_class.assertion_level.check_precond
			then
				if not final_mode then
					file.putstring ("%Tif (~in_assertion & WASC(Dtype(Current)) & CK_REQUIRE) {%N");
				else
					file.putstring ("%Tif (~in_assertion) {%N");
				end;
					-- Precondition
					--		RTCT("positive_argument", EX_PRE);
					--		if (arg1 >= 0)
					--			RTCK;
					--		else
					--			RTCF;
				file.putstring ("%
					%%TRTCT(%"positive_argument%", EX_PRE);%N%
					%%Tif (arg1 >= 0) {%N%
					%%T%TRTCK;%N%
					%%T} else {%N%
					%%T%TRTCF;%N%T}%N");

				file.putstring ("%T}%N");
			end;

				-- Allocation of a special object
				--		l[1] = spmalloc(arg1 * sizeof(char *) + LNGPAD(2));
			file.putstring ("%Tl[1] = spmalloc(CHRPAD(arg1 * ");
		
			if is_expanded then
				file.putstring ("(Size(");
				expanded_type ?= gen_param;
				non_expanded_type := clone (expanded_type);
				non_expanded_type.set_is_expanded (False);
				dtype := non_expanded_type.type_id - 1;
				file.putint (dtype);
				file.putstring (")+OVERHEAD)");
			else
				type_c.generate_size (file);
			end;
			file.putstring (") + LNGPAD(2));%N");

				-- Header evaluation
				--		zone = HEADER(l[1]);
			file.putstring ("%Tzone = HEADER(l[1]);%N");
			file.putstring ("%Tref = l[1] + (zone->ov_size & B_SIZE) - LNGPAD(2);%N");

				-- Set dynamic type
			!!gen_type;
			gen_type.set_base_id (System.special_id);
			gen_type.set_meta_generic (clone (type.meta_generic));
			file.putstring ("%Tzone->ov_flags |= ");
			if final_mode then
				file.putint (gen_type.type_id - 1);
			else
				file.putstring ("RTUD(");
				file.putstring (gen_type.associated_class_type.id.generated_id);
				file.putchar (')');
			end;
			if gen_param.is_reference or else gen_param.is_bit then
				file.putstring (" | EO_REF");
			end;

				-- Set count
			file.putstring (";%N%T*(long *) ref = arg1;%N");

				-- Set element size
			file.putstring ("%T*(long *) (ref + sizeof(long)) = ");
			if is_expanded then
				if final_mode then
					file.putstring ("Size(");
					file.putint (dtype);
					file.putstring (") + OVERHEAD;%N");
					file.putstring ("%Tzone->ov_flags |= EO_COMP;%N");

					exp_class_type := expanded_type.associated_class_type

					has_init := exp_class_type.has_creation_routine
					has_creation :=
						exp_class_type.associated_class.creation_feature /= Void

					file.putstring ("%
						%%T{%N%
						%%T%Tchar *ref;%N%
						%%T%Tlong i;%N");

					if has_init then
							-- Call initialization routines
						file.putstring ("%T%Tinit = XCreate(")
						file.putint (dtype)
						file.putstring (");%N")
					end

					file.putstring ("%
						%%T%Tfor (ref = l[1]+OVERHEAD, i = 0; i < arg1; i++,%
								%ref += Size(");
					file.putint (dtype);
					file.putstring (")+OVERHEAD){%N%
						%%T%T%THEADER(ref)->ov_size = ref - l[1];%N%
						%%T%T%THEADER(ref)->ov_flags = ");
					file.putint (dtype);
					file.putstring (" + EO_EXP;%N")

						-- FIXME: call to creation routine?????

					if has_init then
						file.putstring ("%T%T%T(init)(ref, l[1]);%N")
					end

					file.putstring ("%T%T};%N%T};%N")
				else

						-- FIXME: call to creation routine?????

					file.putstring ("Size(");
					file.putint (dtype);
					file.putstring (") + OVERHEAD;%N%
									%%Tzone->ov_flags |= EO_COMP;%N");
				
						-- Call initialization routines
					file.putstring ("%
									%%T{%N%
									%%T%Tchar *ref;%N%
									%%T%Tlong i;%N%
									%%T%Tfnptr init;%N%
									%%T%Tinit = XCreate(");
					file.putint (dtype);
					file.putstring (");%N%
									%%T%Tfor (ref = l[1]+OVERHEAD, i = 0; i < arg1; i++,%
									%ref += Size(");
					file.putint (dtype);
					file.putstring (")+OVERHEAD){%N%
									%%T%T%THEADER(ref)->ov_size = ref - l[1];%N%
				   					%%T%T%THEADER(ref)->ov_flags = ");
					file.putint (dtype);
					file.putstring (" + EO_EXP;%N%
									%%T%T%Tif ((char *(*)()) 0 != init)%N%
									%%T%T%T%T(init)(ref, l[1]);%N%
									%%T%T};%N%T};%N");
				end
			else
				type_c.generate_size (file);
				file.putstring (";%N");
			end;
				-- Assignment of result to `area'.
			file.putstring ("%TRTAR(l[1], l[0]);%N%T");
			generate_area_access (file);
			file.putstring (" = l[1];%N%
							%%TRTLE;%N}%N%N");
		end;

	first_generic: TYPE_I is
			-- First generic parameter type
		require
			has_generics: type.meta_generic /= Void;
			good_generic_count: type.meta_generic.count = 1;
		do
			Result := type.meta_generic.item (1);
		end;

	generate_area_access (file: INDENT_FILE) is
			-- Generate access to area.
		require
			good_argument: file /= Void;
		local
			area_feature: FEATURE_I;
			rout_id: ROUTINE_ID;
			table: POLY_TABLE [ENTRY];
			table_name: STRING;
			rout_info: ROUT_INFO
		do
			file.putstring ("*(char **) (l[0] + ");

			area_feature := associated_class.feature_table.item ("area");

			rout_id := area_feature.rout_id_set.first;
			if byte_context.final_mode then
				table := Eiffel_table.poly_table (rout_id);
			
				if table.is_polymorphic (type_id) then
						-- Access to area is polymorphic
					table_name := rout_id.table_name;
					file.putchar ('(');
					file.putstring (table_name);
					file.putchar ('-');
					file.putint (table.min_type_id - 1);
					file.putchar (')');
					file.putstring ("[Dtype(l[0])]");
						-- Remember extern declaration
					Extern_declarations.add_attribute_table (clone (table_name));
					   -- Mark attribute table used
					Eiffel_table.mark_used (rout_id);
				else
					skeleton.generate_offset (file, area_feature.feature_id);
				end;
				file.putchar (')');
			elseif
				Compilation_modes.is_precompiling or
				associated_class.is_precompiled
			then
				rout_info := System.rout_info_table.item (rout_id);
				file.putstring ("RTWPA(");
				file.putstring (rout_info.origin.generated_id);
				file.putstring (", ");
				file.putint (rout_info.offset);
				file.putstring (", Dtype(l[0])))");
			else
				file.putstring ("RTWA(");
				file.putint (id.id - 1);
				file.putstring (", ");
				file.putint (area_feature.feature_id);
				file.putstring (", Dtype(l[0])))");
			end;				
		end;

end
