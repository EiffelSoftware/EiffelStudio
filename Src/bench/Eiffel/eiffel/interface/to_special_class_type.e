indexing
	description: "Class type for class TO_SPECIAL"
	date: "$Date$"
	revision: "$Revision$"

class TO_SPECIAL_CLASS_TYPE 

inherit
	CLASS_TYPE
		redefine
			generate_feature
		end

	SHARED_TABLE
		export
			{NONE} all
		end

	SHARED_BODY_ID
		export
			{NONE} all
		end

create
	make

feature -- Access

	first_generic: TYPE_I is
			-- First generic parameter type
		require
			has_generics: type.meta_generic /= Void
			good_generic_count: type.meta_generic.count = 1
		do
			Result := type.meta_generic.item (1)
		end

feature -- C Code generation

	generate_feature (feat: FEATURE_I; buffer: GENERATION_BUFFER) is
			-- Generate feature `feat' in `buffer'.
		local
			f_name_id: INTEGER
		do
			f_name_id := feat.feature_name_id

			if f_name_id = Names_heap.make_area_name_id then
					-- Generate built-in feature `put' of class SPECIAL
				generate_make_area (feat, buffer)
			else
					-- Basic generation
				Precursor {CLASS_TYPE} (feat, buffer)
			end
		end

	generate_make_area (feat: FEATURE_I; buffer: GENERATION_BUFFER) is
			-- Generates built-in feature `make_area' of class TO_SPECIAL
		require
			good_argument: buffer /= Void
			feat_exists: feat /= Void
		local
			gen_param: TYPE_I
			bit_i: BIT_I
			is_expanded: BOOLEAN
			type_c: TYPE_C
			expanded_type, non_expanded_type: CL_TYPE_I
			exp_class_type: CLASS_TYPE
			gen_type: GEN_TYPE_I
			gen_ptype: GEN_TYPE_I
			dtype: INTEGER
			final_mode: BOOLEAN
			has_creation: BOOLEAN
			encoded_name: STRING
			use_init: BOOLEAN
			idx_cnt: COUNTER
			l_local_b: LOCAL_B
		do
			gen_param := first_generic
			is_expanded := gen_param.is_true_expanded
			type_c := gen_param.c_type

				-- Generate header of feature `make_area'.
			buffer.putstring ("/* make_area */%N")
			encoded_name := Encoder.feature_name (static_type_id, feat.body_index)

			System.used_features_log_file.add (Current, "make_area", encoded_name)

			buffer.generate_function_signature ("void", encoded_name, True, buffer,
				<<"Current", "arg1">>, <<"EIF_REFERENCE", "EIF_INTEGER">>)

				-- Generate body
			buffer.indent
			buffer.putstring ("EIF_REFERENCE ref;")
			buffer.new_line
			buffer.putstring ("EIF_REFERENCE loc1 = NULL;")
			buffer.new_line
			buffer.putstring ("union overhead *zone;")
			buffer.new_line

			if is_expanded then
				buffer.putstring ("EIF_REFERENCE loc2 = NULL;")
				buffer.new_line
				buffer.putstring ("int16 pdtype;")
				buffer.new_line
				buffer.putstring ("EIF_INTEGER elem_size = (EIF_Size(")
				expanded_type ?= gen_param
				non_expanded_type := clone (expanded_type)
				non_expanded_type.set_is_true_expanded (False)
				dtype := non_expanded_type.type_id - 1
				buffer.putint (dtype)
				buffer.putstring (") + OVERHEAD);")
				buffer.new_line
				create l_local_b
				l_local_b.set_position (2)
			end

			buffer.putstring ("RTLD;")
			buffer.new_line

				-- Garbage collector hooks
			if is_expanded then
				buffer.putstring ("RTLI(3);")
			else
				buffer.putstring ("RTLI(2);")
			end
			buffer.new_line
			buffer.put_current_registration (0)
			buffer.new_line
			buffer.put_local_registration (1, "loc1")
			buffer.new_line
			if is_expanded then
				buffer.put_local_registration  (2, "loc2")
			end

			final_mode := byte_context.final_mode
			if not final_mode or else associated_class.assertion_level.check_precond then
					-- Generate precondition
				if not final_mode then
					buffer.putstring ("if (~in_assertion & WASC(Dtype(Current)) & CK_REQUIRE) {")
				else
					buffer.putstring ("if (~in_assertion) {")
				end
				buffer.new_line
				buffer.indent
				buffer.putstring ("RTCT(%"positive_argument%", EX_PRE);")
				buffer.new_line
				buffer.putstring ("if (arg1 >= 0) {")
				buffer.new_line
				buffer.indent
				buffer.putstring ("RTCK;")
				buffer.exdent
				buffer.new_line
				buffer.putstring ("} else {")
				buffer.indent
				buffer.new_line
				buffer.putstring ("RTCF;")
				buffer.exdent
				buffer.new_line
				buffer.putchar ('}')
				buffer.new_line
				buffer.exdent
				buffer.putchar ('}')
				buffer.new_line
			end

				-- Allocation of a special object
				--		loc1 = spmalloc(arg1 * sizeof(EIF_REFERENCE) + LNGPAD(2))
			buffer.putstring ("loc1 = spmalloc(CHRPAD(arg1 * ")
		
			if is_expanded then
				buffer.putstring ("elem_size")
			else
				type_c.generate_size (buffer)
			end
			buffer.putstring (") + LNGPAD(2), ")
			if gen_param.is_basic then
				buffer.putstring ("EIF_TRUE);")
			else
				buffer.putstring ("EIF_FALSE);")
			end

			buffer.new_line

				-- Header evaluation
			buffer.putstring ("zone = HEADER(loc1);")
			buffer.new_line
			buffer.putstring ("ref = loc1 + (zone->ov_size & B_SIZE) - LNGPAD(2);")
			buffer.new_line

				-- Set dynamic type
			create gen_type.make (System.special_id)
			gen_type.set_meta_generic (clone (type.meta_generic))
			gen_type.set_true_generics (clone (type.true_generics))

			generate_ov_flags_start (buffer, gen_type)
			buffer.putstring ("zone->ov_flags |= typres")

			if gen_param.is_reference or else gen_param.is_bit then
				buffer.putstring (" | EO_REF")
			end
			generate_ov_flags_finish (buffer)

			buffer.new_line

				-- Set count
			buffer.putstring ("*(EIF_INTEGER *) ref = arg1;")
			buffer.new_line

				-- Set element size
			buffer.putstring ("*(EIF_INTEGER *) (ref + sizeof(EIF_INTEGER)) = ")
			if is_expanded then
				exp_class_type := expanded_type.associated_class_type
				has_creation := exp_class_type.associated_class.creation_feature /= Void

				buffer.putstring ("elem_size;")
				buffer.new_line
				buffer.putstring ("zone->ov_flags |= EO_COMP;")
				buffer.new_line
			
				gen_ptype ?= expanded_type

				if gen_ptype = Void then
						-- Parameter type is not generic
					buffer.putstring ("pdtype = ")
					buffer.putint (dtype)
					buffer.putstring (";")
					buffer.new_line
				else
						-- Parameter is generic
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
						create idx_cnt
						idx_cnt.set_value (1)
						gen_ptype.generate_cid_array (buffer, final_mode, True, idx_cnt)
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
						gen_ptype.generate_cid_init (buffer, final_mode, True, idx_cnt)
					else
						gen_ptype.generate_cid (buffer, final_mode, True)
					end

					buffer.putstring ("pdtype = RTCID(&typcache, Current,")
					buffer.putint (gen_ptype.generated_id (final_mode))
					buffer.putstring (", typarr);")
					buffer.new_line
					buffer.exdent
					buffer.putchar ('}')
					buffer.new_line
				end

				buffer.putchar ('{')
				buffer.new_line
				buffer.indent
				buffer.putstring ("EIF_REFERENCE ref;")
				buffer.new_line
				buffer.putstring ("EIF_INTEGER i;")
				buffer.new_line

				buffer.putstring ("for (ref = loc1+OVERHEAD, i = 0; i < arg1; i++,%
					% ref += elem_size) {")
				buffer.new_line
				buffer.indent
				buffer.putstring ("HEADER(ref)->ov_size = ref - loc1;")
				buffer.new_line
				buffer.putstring ("HEADER(ref)->ov_flags = pdtype | EO_EXP;")
				buffer.new_line

				expanded_type.generate_expanded_creation (Byte_context.byte_code, l_local_b,
					not final_mode)
				buffer.putstring ("ecopy (")
				l_local_b.print_register
				buffer.putstring (", ref);")
				buffer.new_line
				buffer.exdent
				buffer.putchar ('}')
				buffer.new_line
				buffer.exdent
				buffer.putchar ('}')
				buffer.new_line
			else
				type_c.generate_size (buffer)
				buffer.putchar (';')
				buffer.new_line
				if gen_param.is_bit then
						-- Initialize array of bits with default values
					shared_include_queue.put (Names_heap.eif_plug_header_name_id)
					bit_i ?= gen_param
					buffer.putchar ('{')
					buffer.indent
					buffer.new_line
					buffer.putstring ("EIF_INTEGER i;")
					buffer.new_line
					buffer.putstring ("for (i = 0; i < arg1; i++) {")
					buffer.new_line
					buffer.indent
					buffer.putstring ("*((EIF_REFERENCE *) loc1 + i) = RTLB(")
					buffer.putint (bit_i.size)
					buffer.putstring (");")
					buffer.new_line
					buffer.putstring ("RTAS_OPT(*((EIF_REFERENCE *) loc1 + i), i, loc1);")
					buffer.new_line
					buffer.exdent
					buffer.putchar ('}')
					buffer.new_line
					buffer.exdent
					buffer.new_line
				end
			end
				-- Assignment of result to `area'.
			buffer.putstring ("RTAR(loc1, Current);")
			buffer.new_line
			generate_area_access (buffer)
			buffer.putstring (" = loc1;")
			buffer.new_line
			buffer.putstring ("RTLE;")
			buffer.new_line
			buffer.exdent
			buffer.putchar ('}')
			buffer.new_line
			buffer.new_line
		end

	generate_area_access (buffer: GENERATION_BUFFER) is
			-- Generate access to area.
		require
			good_argument: buffer /= Void
		local
			area_feature: FEATURE_I
			rout_id: INTEGER
			table_name: STRING
			array_index: INTEGER
			rout_info: ROUT_INFO
		do
			buffer.putstring ("*(EIF_REFERENCE *) (Current")

			area_feature := associated_class.feature_table.item ("area")

			rout_id := area_feature.rout_id_set.first
			if byte_context.final_mode then
				array_index := Eiffel_table.is_polymorphic (rout_id, type_id, False)
			
				if array_index >= 0 then
						-- Access to area is polymorphic
					table_name := Encoder.table_name (rout_id)

						-- Generate following dispatch:
						-- table [Actual_offset - base_offset]
					buffer.putstring (" + ")
					buffer.putstring (table_name)
					buffer.putstring ("[Dtype(Current) - ")
					buffer.putint (array_index)
					buffer.putchar (']')
						
						-- Remember extern declaration
					Extern_declarations.add_attribute_table (table_name)
					   -- Mark attribute table used
					Eiffel_table.mark_used (rout_id)
				else
						--| In this instruction, we put `False' as second
						--| arguments. This means we won't generate anything if there is nothing
						--| to generate. Remember that `True' is used in the generation of attributes
						--| table in Final mode.
					skeleton.generate_offset (buffer, area_feature.feature_id, False)
				end
				buffer.putchar (')')
			elseif
				Compilation_modes.is_precompiling or
				associated_class.is_precompiled
			then
				rout_info := System.rout_info_table.item (rout_id)
				buffer.putstring ("+ RTWPA(")
				buffer.generate_class_id (rout_info.origin)
				buffer.putstring (", ")
				buffer.putint (rout_info.offset)
				buffer.putstring (", Dtype(Current)))")
			else
				buffer.putstring ("+ RTWA(")
				buffer.putint (static_type_id - 1)
				buffer.putstring (", ")
				buffer.putint (area_feature.feature_id)
				buffer.putstring (", Dtype(Current)))")
			end;				
		end

end


