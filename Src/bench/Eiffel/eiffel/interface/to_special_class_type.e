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

	generate_feature (feat: FEATURE_I; buffer: GENERATION_BUFFER) is
			-- Generate feature `feat' in `buffer'.
		local
			feature_name: STRING;
		do
			feature_name := feat.feature_name

			if feature_name.is_equal ("make_area") then
					-- Generate built-in feature `put' of class SPECIAL
				generate_make_area (feat, buffer);
			else
					-- Basic generation
				{CLASS_TYPE} Precursor (feat, buffer);
			end;
		end;

	generate_make_area (feat: FEATURE_I; buffer: GENERATION_BUFFER) is
			-- Generates built-in feature `make_area' of class TO_SPECIAL
		require
			good_argument: buffer /= Void;
			feat_exists: feat /= Void;
		local
			gen_param: TYPE_I;
			is_expanded: BOOLEAN;
			type_c: TYPE_C;
			expanded_type, non_expanded_type: CL_TYPE_I;
			exp_class_type: CLASS_TYPE;
			gen_type: GEN_TYPE_I;
			gen_ptype: GEN_TYPE_I;
			dtype: INTEGER;
			c_name: STRING;
			final_mode: BOOLEAN;
			has_init, has_creation: BOOLEAN
			encoded_name: STRING
			use_init: BOOLEAN
			idx_cnt: COUNTER
		do
			gen_param := first_generic;
			is_expanded := gen_param.is_expanded;
			type_c := gen_param.c_type;

				-- HEADER:
				--		void make_area(Current, arg1)
				--		EIF_REFERENCE Current;
				--		EIF_INTEGER arg1;
				--		{
				--			EIF_REFERENCE ref;
				--			struct union overhead *zone;
			buffer.putstring ("/* make_area */%N");
			encoded_name := feat.body_id.feature_name (id);

			System.used_features_log_file.add (Current, "make_area", encoded_name);

			buffer.generate_function_signature ("void", encoded_name, True, buffer,
				<<"Current", "arg1">>, <<"EIF_REFERENCE", "EIF_INTEGER">>)

			buffer.putstring ("%
				%%TEIF_REFERENCE ref;%N%
				%%Tunion overhead *zone;%N%
				%%TRTLD;%N%N");

				-- Garbage collector hooks
			buffer.putstring ("%TRTLI(2);%N%
				%%Tl[0] = Current;%N%
				%%Tl[1] = (EIF_REFERENCE) 0;%N%N");

			final_mode := byte_context.final_mode;
			if 	(not final_mode)
				or else
				associated_class.assertion_level.check_precond
			then
				if not final_mode then
					buffer.putstring ("%Tif (~in_assertion & WASC(Dtype(Current)) & CK_REQUIRE) {%N");
				else
					buffer.putstring ("%Tif (~in_assertion) {%N");
				end;
					-- Precondition
					--		RTCT("positive_argument", EX_PRE);
					--		if (arg1 >= 0)
					--			RTCK;
					--		else
					--			RTCF;
				buffer.putstring ("%
					%%TRTCT(%"positive_argument%", EX_PRE);%N%
					%%Tif (arg1 >= 0) {%N%
					%%T%TRTCK;%N%
					%%T} else {%N%
					%%T%TRTCF;%N%T}%N");

				buffer.putstring ("%T}%N");
			end;

				-- Allocation of a special object
				--		l[1] = spmalloc(arg1 * sizeof(EIF_REFERENCE) + LNGPAD(2));
			buffer.putstring ("%Tl[1] = spmalloc(CHRPAD(arg1 * ");
		
			if is_expanded then
				buffer.putstring ("(EIF_Size(");
				expanded_type ?= gen_param;
				non_expanded_type := clone (expanded_type);
				non_expanded_type.set_is_expanded (False);
				dtype := non_expanded_type.type_id - 1;
				buffer.putint (dtype);
				buffer.putstring (")+OVERHEAD)");
			else
				type_c.generate_size (buffer);
			end;
			buffer.putstring (") + LNGPAD(2));%N");

				-- Header evaluation
				--		zone = HEADER(l[1]);
			buffer.putstring ("%Tzone = HEADER(l[1]);%N");
			buffer.putstring ("%Tref = l[1] + (zone->ov_size & B_SIZE) - LNGPAD(2);");
			buffer.new_line

				-- Set dynamic type

			!!gen_type;
			gen_type.set_base_id (System.special_id);
			gen_type.set_meta_generic (clone (type.meta_generic));
			gen_type.set_true_generics (clone (type.true_generics));

			generate_ov_flags_start (buffer, gen_type)
			buffer.putstring ("zone->ov_flags |= typres");

			if gen_param.is_reference or else gen_param.is_bit then
				buffer.putstring (" | EO_REF");
			end;
			generate_ov_flags_finish (buffer)

			buffer.new_line

				-- Set count
			buffer.putstring ("%T*(EIF_INTEGER *) ref = arg1;%N");

				-- Set element size
			buffer.putstring ("%T*(EIF_INTEGER *) (ref + sizeof(EIF_INTEGER)) = ");
			if is_expanded then
				if final_mode then
					buffer.putstring ("EIF_Size(");
					buffer.putint (dtype);
					buffer.putstring (") + OVERHEAD;%N");
					buffer.putstring ("%Tzone->ov_flags |= EO_COMP;%N");

					exp_class_type := expanded_type.associated_class_type

					has_init := exp_class_type.has_creation_routine
					has_creation :=
						exp_class_type.associated_class.creation_feature /= Void

					buffer.putstring ("%
						%%T{%N%
						%%T%TEIF_REFERENCE ref;%N%
						%%T%TEIF_INTEGER i;%N%
						%%T%Tint16 pdtype;");

					buffer.new_line

					gen_ptype ?= expanded_type

					if gen_ptype = Void then
						-- Parameter type is not generic
						buffer.putstring ("%T%Tpdtype = ")
						buffer.putint (dtype)
						buffer.putstring (";%N")
					else
						-- Parameter is generic
						buffer.indent
						buffer.indent
						buffer.putchar ('{')
						buffer.new_line
						buffer.indent

						if gen_ptype.is_explicit then
							-- Optimize: Use static array
							buffer.putstring ("static int16 typarr [] = {")
						else
							buffer.putstring ("int16 typarr [] = {")
							use_init := True
						end

						buffer.putint (byte_context.current_type.generated_id (final_mode))
						buffer.putstring (", ")
						if use_init then
							!!idx_cnt
							idx_cnt.set_value (1)
							gen_ptype.generate_cid_array (buffer, final_mode, 
														  True, idx_cnt)
						else
							gen_ptype.generate_cid (buffer, final_mode, True)
						end

						buffer.putstring ("-1};")
						buffer.new_line
						buffer.putstring ("static int16 typcache = -1;")
						buffer.new_line
						buffer.new_line
						if use_init then
							idx_cnt.set_value (1)
							gen_ptype.generate_cid_init (buffer, final_mode, 
														 True, idx_cnt)
						else
							gen_ptype.generate_cid (buffer, final_mode, True)
						end

						buffer.putstring ("pdtype = RTCID(&typcache, l[0],")
						buffer.putint (gen_ptype.generated_id (final_mode))
						buffer.putstring (", typarr);")
						buffer.new_line
						buffer.exdent
						buffer.putchar ('}')
						buffer.new_line
						buffer.exdent
						buffer.exdent
					end

					if has_init then
							-- Call initialization routines
						buffer.putstring ("%T%Tinit = XCreate(")
						buffer.putint (dtype)
						buffer.putstring (");%N")
					end

					buffer.putstring ("%
						%%T%Tfor (ref = l[1]+OVERHEAD, i = 0; i < arg1; i++,%
								%ref += EIF_Size(");
					buffer.putint (dtype);
					buffer.putstring (")+OVERHEAD){%N%
						%%T%T%THEADER(ref)->ov_size = ref - l[1];%N%
						%%T%T%THEADER(ref)->ov_flags = pdtype");
					buffer.putstring (" + EO_EXP;%N")

						-- FIXME: call to creation routine?????

					if has_init then
						buffer.putstring ("%T%T%T(init)(ref, l[1]);%N")
					end

					buffer.putstring ("%T%T};%N%T};%N")
				else

						-- FIXME: call to creation routine?????

					buffer.putstring ("EIF_Size(");
					buffer.putint (dtype);
					buffer.putstring (") + OVERHEAD;%N%
									%%Tzone->ov_flags |= EO_COMP;%N");
				
						-- Call initialization routines
					buffer.putstring ("%
									%%T{%N%
									%%T%TEIF_REFERENCE ref;%N%
									%%T%TEIF_INTEGER i;%N%
									%%T%Tfnptr init;%N%
									%%T%Tint16 pdtype;")

					buffer.new_line
					gen_ptype ?= expanded_type

					if gen_ptype = Void then
						-- Parameter type is not generic
						buffer.putstring ("%T%Tpdtype = ")
						buffer.putint (dtype)
						buffer.putstring (";%N")
					else
						-- Parameter is generic
						buffer.indent
						buffer.indent
						buffer.putchar ('{')
						buffer.new_line
						buffer.indent

						if gen_ptype.is_explicit then
							-- Optimize: Use static array
							buffer.putstring ("static int16 typarr [] = {")
						else
							buffer.putstring ("int16 typarr [] = {")
							use_init := True
						end

						buffer.putint (byte_context.current_type.generated_id (final_mode))
						buffer.putstring (", ")
						if use_init then
							!!idx_cnt
							idx_cnt.set_value (1)
							gen_ptype.generate_cid_array (buffer, final_mode, 
														  True, idx_cnt)
						else
							gen_ptype.generate_cid (buffer, final_mode, True)
						end

						buffer.putstring ("-1};")
						buffer.new_line
						buffer.putstring ("static int16 typcache = -1;")
						buffer.new_line
						buffer.new_line
						if use_init then
							idx_cnt.set_value (1)
							gen_ptype.generate_cid_init (buffer, final_mode, 
														 True, idx_cnt)
						else
							gen_ptype.generate_cid (buffer, final_mode, True)
						end

						buffer.putstring ("pdtype = RTCID(&typcache, l[0],")
						buffer.putint (gen_ptype.generated_id (final_mode))
						buffer.putstring (", typarr);")
						buffer.new_line
						buffer.exdent
						buffer.putchar ('}')
						buffer.new_line
						buffer.exdent
						buffer.exdent
					end

					buffer.putstring ("%T%Tinit = XCreate(");
					buffer.putint (dtype);
					buffer.putstring (");%N%
									%%T%Tfor (ref = l[1]+OVERHEAD, i = 0; i < arg1; i++,%
									%ref += EIF_Size(");
					buffer.putint (dtype);
					buffer.putstring (")+OVERHEAD){%N%
									%%T%T%THEADER(ref)->ov_size = ref - l[1];%N%
									%%T%T%THEADER(ref)->ov_flags = pdtype");
					buffer.putstring (" + EO_EXP;%N%
									%%T%T%Tif ((char *(*)()) 0 != init)%N%
									%%T%T%T%T(init)(ref, l[1]);%N%
									%%T%T};%N%T};%N");
				end
			else
				type_c.generate_size (buffer);
				buffer.putstring (";%N");
			end;
				-- Assignment of result to `area'.
			buffer.putstring ("%TRTAR(l[1], l[0]);%N%T");
			generate_area_access (buffer);
			buffer.putstring (" = l[1];%N%
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

	generate_area_access (buffer: GENERATION_BUFFER) is
			-- Generate access to area.
		require
			good_argument: buffer /= Void;
		local
			area_feature: FEATURE_I;
			rout_id: ROUTINE_ID;
			table_name: STRING;
			array_index: INTEGER
			rout_info: ROUT_INFO
		do
			buffer.putstring ("*(EIF_REFERENCE *) (l[0]");

			area_feature := associated_class.feature_table.item ("area");

			rout_id := area_feature.rout_id_set.first;
			if byte_context.final_mode then
				array_index := Eiffel_table.is_polymorphic (rout_id, type_id, False);
			
				if array_index >= 0 then
						-- Access to area is polymorphic
					table_name := rout_id.table_name;
					buffer.putstring (" + (");
					buffer.putstring (table_name);
					buffer.putchar ('-');
					buffer.putint (array_index);
					buffer.putchar (')');
					buffer.putstring ("[Dtype(l[0])]");
						-- Remember extern declaration
					Extern_declarations.add_attribute_table (clone (table_name));
					   -- Mark attribute table used
					Eiffel_table.mark_used (rout_id);
				else
						--| In this instruction, we put `False' as second
						--| arguments. This means we won't generate anything if there is nothing
						--| to generate. Remember that `True' is used in the generation of attributes
						--| table in Final mode.
					skeleton.generate_offset (buffer, area_feature.feature_id, False);
				end;
				buffer.putchar (')');
			elseif
				Compilation_modes.is_precompiling or
				associated_class.is_precompiled
			then
				rout_info := System.rout_info_table.item (rout_id);
				buffer.putstring ("+ RTWPA(");
				rout_info.origin.generated_id (buffer);
				buffer.putstring (", ");
				buffer.putint (rout_info.offset);
				buffer.putstring (", Dtype(l[0])))");
			else
				buffer.putstring ("+ RTWA(");
				buffer.putint (id.id - 1);
				buffer.putstring (", ");
				buffer.putint (area_feature.feature_id);
				buffer.putstring (", Dtype(l[0])))");
			end;				
		end;

end
