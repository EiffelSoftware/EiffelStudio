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
			l_param_is_expanded: BOOLEAN
			type_c: TYPE_C
			expanded_type: CL_TYPE_I
			exp_class_type: CLASS_TYPE
			gen_type: GEN_TYPE_I
			gen_ptype: GEN_TYPE_I
			final_mode: BOOLEAN
			has_creation: BOOLEAN
			encoded_name: STRING
			use_init: BOOLEAN
			idx_cnt: COUNTER
			l_local_b: LOCAL_B
		do
			gen_param := first_generic
			l_param_is_expanded := gen_param.is_true_expanded
			final_mode := byte_context.final_mode
			type_c := gen_param.c_type

				-- Generate header of feature `make_area'.
			buffer.put_string ("/* make_area */%N")
			encoded_name := Encoder.feature_name (static_type_id, feat.body_index)

			System.used_features_log_file.add (Current, "make_area", encoded_name)

			buffer.generate_function_signature ("void", encoded_name, True, buffer,
				<<"Current", "arg1">>, <<"EIF_REFERENCE", "EIF_INTEGER">>)

				-- Generate body
			buffer.indent
			buffer.put_string ("EIF_REFERENCE ref;")
			buffer.put_new_line
			buffer.put_string ("EIF_REFERENCE loc1 = NULL;")
			buffer.put_new_line
			buffer.put_string ("union overhead *zone;")
			buffer.put_new_line

			if l_param_is_expanded then
				buffer.put_string ("int16 pdtype;")
				buffer.put_new_line
				buffer.put_string ("EIF_INTEGER elem_size = (EIF_Size(")
				expanded_type ?= gen_param
				if final_mode then
					buffer.put_type_id (expanded_type.type_id)
				else
					buffer.put_string("RTUD(")
					buffer.put_static_type_id (expanded_type.associated_class_type.static_type_id)
					buffer.put_character (')')
				end
				buffer.put_string (") + OVERHEAD);")
				buffer.put_new_line
				create l_local_b
				l_local_b.set_position (2)
			end

			buffer.put_string ("RTLD;")
			buffer.put_new_line

				-- Garbage collector hooks
			buffer.put_string ("RTLI(2);")
			buffer.put_new_line
			buffer.put_current_registration (0)
			buffer.put_new_line
			buffer.put_local_registration (1, "loc1")
			buffer.put_new_line

			if not final_mode or else associated_class.assertion_level.check_precond then
					-- Generate precondition
				buffer.put_new_line
				if not final_mode then
					buffer.put_string ("if (~in_assertion & WASC(Dtype(Current)) & CK_REQUIRE) {")
				else
					buffer.put_string ("if (~in_assertion) {")
				end
				buffer.put_new_line
				buffer.indent
				buffer.put_string ("RTCT(%"positive_argument%", EX_PRE);")
				buffer.put_new_line
				buffer.put_string ("if (arg1 >= 0) {")
				buffer.put_new_line
				buffer.indent
				buffer.put_string ("RTCK;")
				buffer.exdent
				buffer.put_new_line
				buffer.put_string ("} else {")
				buffer.indent
				buffer.put_new_line
				buffer.put_string ("RTCF;")
				buffer.exdent
				buffer.put_new_line
				buffer.put_character ('}')
				buffer.put_new_line
				buffer.exdent
				buffer.put_character ('}')
				buffer.put_new_line
			end

				-- Allocation of a special object
				--		loc1 = spmalloc(arg1 * sizeof(EIF_REFERENCE) + LNGPAD(2))
			buffer.put_string ("loc1 = spmalloc(CHRPAD(arg1 * ")
		
			if l_param_is_expanded then
				buffer.put_string ("elem_size")
			else
				type_c.generate_size (buffer)
			end
			buffer.put_string (") + LNGPAD(2), ")
			if gen_param.is_basic then
				buffer.put_string ("EIF_TRUE);")
			else
				buffer.put_string ("EIF_FALSE);")
			end

			buffer.put_new_line

				-- Header evaluation
			buffer.put_string ("zone = HEADER(loc1);")
			buffer.put_new_line
			buffer.put_string ("ref = loc1 + (zone->ov_size & B_SIZE) - LNGPAD(2);")
			buffer.put_new_line

				-- Set dynamic type
			create gen_type.make (System.special_id)
			gen_type.set_meta_generic (type.meta_generic.twin)
			gen_type.set_true_generics (type.true_generics.twin)

			generate_ov_flags_start (buffer, gen_type)
			buffer.put_string ("zone->ov_flags |= typres")

			if gen_param.is_reference or else gen_param.is_bit then
				buffer.put_string (" | EO_REF")
			end
			generate_ov_flags_finish (buffer)

			buffer.put_new_line

				-- Set count
			buffer.put_string ("*(EIF_INTEGER *) ref = arg1;")
			buffer.put_new_line

				-- Set element size
			buffer.put_string ("*(EIF_INTEGER *) (ref + sizeof(EIF_INTEGER)) = ")
			if l_param_is_expanded then
				exp_class_type := expanded_type.associated_class_type
				has_creation := exp_class_type.associated_class.creation_feature /= Void

				buffer.put_string ("elem_size;")
				buffer.put_new_line
				buffer.put_string ("zone->ov_flags |= EO_COMP;")
				buffer.put_new_line
			
				gen_ptype ?= expanded_type

				if gen_ptype = Void then
						-- Parameter type is not generic
					buffer.put_string ("pdtype = ")
					if final_mode then
						buffer.put_integer (exp_class_type.type_id)
					else
						buffer.put_string("RTUD(")
						buffer.put_static_type_id (exp_class_type.static_type_id)
						buffer.put_character (')')
					end
					buffer.put_character (';')
					buffer.put_new_line
				else
						-- Parameter is generic
					buffer.put_character ('{')
					buffer.put_new_line
					buffer.indent

					use_init := not gen_type.is_explicit
			
						-- Optimize: Use static array only when `typarr' is
						-- not modified by generated code in multithreaded mode only.
						-- It is safe in monothreaded code as we are guaranteed that
						-- only one thread of execution will use the modified `typarr'.
					if not System.has_multithreaded or else not use_init then
						buffer.put_string ("static ")
					end
					buffer.put_string ("int16 typarr [] = {")

					buffer.put_integer (byte_context.current_type.generated_id (final_mode))
					buffer.put_string (", ")
					if use_init then
						create idx_cnt
						idx_cnt.set_value (1)
						gen_ptype.generate_cid_array (buffer, final_mode, True, idx_cnt)
					else
						gen_ptype.generate_cid (buffer, final_mode, True)
					end

					buffer.put_string ("-1};")
					buffer.put_new_line
					if not use_init then
						buffer.put_string ("static int16 typcache = -1;")
						buffer.put_new_line
					end
					buffer.put_new_line
					if use_init then
						idx_cnt.set_value (1)
						gen_ptype.generate_cid_init (buffer, final_mode, True, idx_cnt)
					else
						gen_ptype.generate_cid (buffer, final_mode, True)
					end

					if not use_init then
						buffer.put_string ("pdtype = RTCID2(&typcache, Dftype(Current),")
					else
						buffer.put_string ("pdtype = RTCID2(NULL, Dftype(Current),")
					end
					buffer.put_integer (gen_ptype.generated_id (final_mode))
					buffer.put_string (", typarr);")
					buffer.put_new_line
					buffer.exdent
					buffer.put_character ('}')
					buffer.put_new_line
				end

				buffer.put_string ("loc1 = sp_init (loc1, pdtype, 0, arg1 - 1);")
				buffer.put_new_line
			else
				type_c.generate_size (buffer)
				buffer.put_character (';')
				buffer.put_new_line
				if gen_param.is_bit then
						-- Initialize array of bits with default values
					shared_include_queue.put (Names_heap.eif_plug_header_name_id)
					bit_i ?= gen_param
					buffer.put_character ('{')
					buffer.indent
					buffer.put_new_line
					buffer.put_string ("EIF_INTEGER i;")
					buffer.put_new_line
					buffer.put_string ("for (i = 0; i < arg1; i++) {")
					buffer.put_new_line
					buffer.indent
					buffer.put_string ("*((EIF_REFERENCE *) loc1 + i) = RTLB(")
					buffer.put_integer (bit_i.size)
					buffer.put_string (");")
					buffer.put_new_line
					buffer.put_string ("RTAR(loc1, *((EIF_REFERENCE *) loc1 + i));")
					buffer.put_new_line
					buffer.exdent
					buffer.put_character ('}')
					buffer.put_new_line
					buffer.exdent
					buffer.put_character ('}')
					buffer.put_new_line
				end
			end
				-- Assignment of result to `area'.
			buffer.put_string ("RTAR(Current, loc1);")
			buffer.put_new_line
			generate_area_access (buffer)
			buffer.put_string (" = loc1;")
			buffer.put_new_line
			buffer.put_string ("RTLE;")
			buffer.put_new_line
			buffer.exdent
			buffer.put_character ('}')
			buffer.put_new_line
			buffer.put_new_line
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
			buffer.put_string ("*(EIF_REFERENCE *) (Current")

			area_feature := associated_class.feature_table.item ("area")

			rout_id := area_feature.rout_id_set.first
			if byte_context.final_mode then
				array_index := Eiffel_table.is_polymorphic (rout_id, type_id, False)
			
				if array_index >= 0 then
						-- Access to area is polymorphic
					table_name := Encoder.table_name (rout_id)

						-- Generate following dispatch:
						-- table [Actual_offset - base_offset]
					buffer.put_string (" + ")
					buffer.put_string (table_name)
					buffer.put_string ("[Dtype(Current) - ")
					buffer.put_integer (array_index)
					buffer.put_character (']')
						
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
				buffer.put_character (')')
			elseif
				Compilation_modes.is_precompiling or
				associated_class.is_precompiled
			then
				rout_info := System.rout_info_table.item (rout_id)
				buffer.put_string ("+ RTWPA(")
				buffer.put_class_id (rout_info.origin)
				buffer.put_string (", ")
				buffer.put_integer (rout_info.offset)
				buffer.put_string (", Dtype(Current)))")
			else
				buffer.put_string ("+ RTWA(")
				buffer.put_static_type_id (static_type_id)
				buffer.put_string (", ")
				buffer.put_integer (area_feature.feature_id)
				buffer.put_string (", Dtype(Current)))")
			end;				
		end

end


