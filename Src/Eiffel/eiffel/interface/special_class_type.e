note
	description: "Class type for SPECIAL class."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
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

	BYTE_CONST
		export
			{NONE} all
		end

	SHARED_TYPE_I
		export
			{NONE} all
		end

create
	make

feature -- Status

	is_any_array: BOOLEAN
			-- Is Current an array of ANY?
		local
			any_type: CL_TYPE_A
		do
			create any_type.make (System.any_id)
			Result := first_generic.same_as (any_type)
		end

feature -- Access

	first_generic: TYPE_A
			-- First generic parameter type
		require
			has_generics: type.generics /= Void;
			good_generic_count: type.generics.count = 1;
		do
				-- No need to call `meta_type' here since this must have been done already when
				-- creating `type'.
			Result := type.generics.first
		end

	type: GEN_TYPE_A
			-- Type of the class. It includes meta-instantiation of possible
			-- generic parameters.

feature -- Byte code generation

	make_creation_byte_code (ba: BYTE_ARRAY)
			-- Generate byte code for creation of a special instance.
		require
			ba_not_void: ba /= Void
		local
			gen_param: TYPE_A
			l_param_is_expanded: BOOLEAN
			final_mode: BOOLEAN
		do
			gen_param := first_generic
			l_param_is_expanded := gen_param.is_true_expanded
			final_mode := byte_context.final_mode
			ba.append_boolean (l_param_is_expanded)
			if l_param_is_expanded then
				ba.append_short_integer (gen_param.static_type_id (Void) - 1)
			else
				ba.append_natural_32 (gen_param.sk_value (Void))
			end
		end

feature -- C code generation

	generate_creation (buffer: GENERATION_BUFFER; info: CREATE_INFO; target_register: REGISTRABLE; nb_register: PARAMETER_BL; a_make_filled, a_make_empty, a_check_prec: BOOLEAN)
			-- Generate creation of a special instance using `info' to get the exact type
			-- to create.
		require
			buffer_not_void: buffer /= Void
			info_not_void: info /= Void
			target_register_not_void: target_register /= Void
			nb_register_not_void: nb_register /= Void
		local
			gen_param: TYPE_A
			l_exp_class_type: CLASS_TYPE
			l_exp_has_references: BOOLEAN
			l_param_is_expanded: BOOLEAN
			type_c: TYPE_C
			final_mode: BOOLEAN
		do
			gen_param := first_generic
			l_param_is_expanded := gen_param.is_true_expanded
			final_mode := byte_context.final_mode
			type_c := gen_param.c_type

				-- Check validity of call
			if a_check_prec and (not final_mode or else associated_class.assertion_level.is_precondition) then
				buffer.put_new_line
				buffer.put_string ("if (")
				nb_register.print_immediate_register
				buffer.put_string ("< 0) {")
				buffer.indent
				buffer.put_new_line
				buffer.put_string ("eraise (%"non_negative_argument%", EN_RT_CHECK);")
				buffer.exdent
				buffer.put_new_line
				buffer.put_character ('}')
			end

			if l_param_is_expanded then
				l_exp_class_type := gen_param.associated_class_type (Void)
				l_exp_has_references := l_exp_class_type.skeleton.has_references
			end

				-- Generate recipient of newly created SPECIAL instance.
			buffer.put_new_line
			target_register.print_register

				-- 1. Dynamic type with flags
			buffer.put_string (" = RTLNSP2(")
			info.generate_type_id (buffer, final_mode, 0)
			buffer.put_character (',')
			if not gen_param.is_expanded or else l_exp_has_references then
				buffer.put_string ("EO_REF")
				if l_param_is_expanded then
					buffer.put_string (" | EO_COMP")
				end
			elseif l_param_is_expanded then
				buffer.put_string ("EO_COMP")
			else
				buffer.put_character ('0')
			end
			buffer.put_character (',')

				-- 2. Number of elements
			nb_register.print_immediate_register
			buffer.put_character (',')

				-- 3. Element size
			if l_param_is_expanded then
				if final_mode then
					l_exp_class_type.skeleton.generate_size (buffer, True)
					if l_exp_has_references then
						buffer.put_string (" + OVERHEAD")
					end
				else
					buffer.put_string("(EIF_Size(")
					buffer.put_static_type_id (l_exp_class_type.static_type_id)
					buffer.put_string (") + OVERHEAD)")
				end
			else
				type_c.generate_size (buffer)
			end
			buffer.put_string (", ")

				-- 4. Is it a basic type.
			if gen_param.is_basic then
				buffer.put_string ("EIF_TRUE);")
			else
				buffer.put_string ("EIF_FALSE);")
			end

			if a_make_empty then
				buffer.put_new_line
				buffer.put_string ("RT_SPECIAL_COUNT(")
				target_register.print_register
				buffer.put_three_character (')', ' ', '=')
				buffer.put_three_character (' ', '0', ';')
			end
		end

	generate_feature (feat: FEATURE_I; buffer, header_buffer: GENERATION_BUFFER)
			-- Generate feature `feat' in `buffer'.
		local
			f_name_id: INTEGER
		do
			f_name_id := feat.feature_name_id

			inspect feat.feature_name_id
			when {PREDEFINED_NAMES}.put_name_id then
					-- Generate built-in feature `put' of class SPECIAL
				generate_put (feat, buffer)

			when {PREDEFINED_NAMES}.extend_name_id then
					-- Generate built-in feature `extend' of class SPECIAL
				generate_extend (feat, buffer)

			when {PREDEFINED_NAMES}.force_name_id then
					-- Generate built-in feature `force' of class SPECIAL
				generate_force (feat, buffer)

			when {PREDEFINED_NAMES}.put_default_name_id then
					-- Generate built-in feature `put_default' of class SPECIAL
				generate_put_default (feat, buffer)

			when
				{PREDEFINED_NAMES}.item_name_id,
				{PREDEFINED_NAMES}.infix_at_name_id,
				{PREDEFINED_NAMES}.at_name_id
			then
					-- Generate built-in feature `item' of class SPECIAL
				generate_item (feat, buffer)

			when {PREDEFINED_NAMES}.Item_address_name_id then
					-- Temporary code generation of `item_address' so
					-- that it is thread safe (no GC sync calls in body).
				generate_item_address (feat, buffer)

			when {PREDEFINED_NAMES}.base_address_name_id then
					-- Temporary code generation of `base_address'
					-- so that it is thread safe (no GC sync calls in body).
				generate_base_address (feat, buffer)

			when {PREDEFINED_NAMES}.clear_all_name_id then
					-- Generate `clear_all' of class SPECIAL for more efficiency.
				if first_generic.is_true_expanded then
					Precursor {CLASS_TYPE} (feat, buffer, header_buffer)
				else
					generate_clear_all (feat, buffer)
				end

			when {PREDEFINED_NAMES}.fill_with_name_id then
				if first_generic.is_true_expanded then
					Precursor {CLASS_TYPE} (feat, buffer, header_buffer)
				else
					generate_fill_with (feat, buffer)
				end

			else
					-- Basic generation
				Precursor {CLASS_TYPE} (feat, buffer, header_buffer);
			end;
		end;

feature {NONE} -- C code generation

	generate_put (feat: FEATURE_I; buffer: GENERATION_BUFFER)
			-- Generates built-in feature `put' of class SPECIAL
		require
			good_argument: buffer /= Void
			feat_exists: feat /= Void
			consistency: feat.feature_name_id = {PREDEFINED_NAMES}.put_name_id
		local
			gen_param: TYPE_A
			l_exp_class_type: CLASS_TYPE
			l_param_is_expanded: BOOLEAN
			type_c: TYPE_C
			final_mode: BOOLEAN
			encoded_name: STRING
			value_type_name: STRING
			index_type_name: STRING
			value_arg_name: STRING
			index_arg_name: STRING
			l_byte_context: like byte_context
			l_arg: ARGUMENT_BL
		do
			l_byte_context := byte_context
			gen_param := first_generic
			l_param_is_expanded := gen_param.is_true_expanded
			type_c := gen_param.c_type

			feat.generate_header (Current, buffer)
			encoded_name := Encoder.feature_name (type_id, feat.body_index)

			System.used_features_log_file.add (Current, "put", encoded_name)

			final_mode := l_byte_context.final_mode

			if final_mode then
				value_type_name := type_c.c_string
				index_type_name := "EIF_INTEGER_32"
				value_arg_name := "arg1"
				index_arg_name := "arg2"
			else
				value_type_name := "EIF_TYPED_VALUE"
				index_type_name := "EIF_TYPED_VALUE"
				value_arg_name := "arg1x"
				index_arg_name := "arg2x"
			end

			buffer.generate_function_signature ("void", encoded_name, True,
				l_byte_context.header_buffer, <<"Current", value_arg_name, index_arg_name>>,
				<<"EIF_REFERENCE", value_type_name, index_type_name>>)

			buffer.generate_block_open
			buffer.put_gtcx

			if not final_mode then
				if not type_c.is_reference then
					buffer.put_new_line
					buffer.put_string ("if ((arg1x.type & SK_HEAD) == SK_REF) arg1x.")
					type_c.generate_typed_field (buffer)
					buffer.put_string (" = * ")
					type_c.generate_access_cast (buffer)
					buffer.put_string ("arg1x.it_r;")
				end
				buffer.put_new_line
				buffer.put_string ("if ((arg2x.type & SK_HEAD) == SK_REF) arg2x.it_i4 = * (EIF_INTEGER_32 *) arg2x.it_r;")
				buffer.put_new_line_only
				buffer.put_string ("#define arg1 arg1x.")
				type_c.generate_typed_field (buffer)
				buffer.put_new_line_only
				buffer.put_string ("#define arg2 arg2x.it_i4")
			end

			if not final_mode and then l_param_is_expanded then
				buffer.put_new_line
				buffer.put_string ("if (arg1 == NULL) RTEC(EN_VEXP);")
			end

			if not final_mode or else system.check_for_catcall_at_runtime then
				if gen_param.c_type.is_reference then
					byte_context.set_byte_code (byte_server.disk_item (feat.body_index))
					byte_context.set_current_feature (feat)
					if l_param_is_expanded then
							-- Minor hack because expanded arguments are generated with a `e' prefix
							-- but for SPECIAL we use without the prefix because the generation is done
							-- manually.
						buffer.put_new_line_only
						buffer.put_string ("#define earg1 arg1")
					end
					byte_context.set_has_feature_name_stored (False)
					create l_arg
					l_arg.set_position (1)
					byte_context.generate_catcall_check (l_arg, create {FORMAL_A}.make (False, False, 1), 1, False)
					if l_param_is_expanded then
						buffer.put_new_line_only
						buffer.put_string ("#undef earg1")
					end
				end
			end

			generate_precondition (buffer, final_mode, "arg2")

			if l_param_is_expanded then
				if final_mode then
					l_exp_class_type := gen_param.associated_class_type (Void)
					buffer.put_new_line
					if l_exp_class_type.skeleton.has_references then
							-- Optimization: size is known at compile time
						buffer.put_string ("ecopy(arg1, Current + OVERHEAD + (rt_uint_ptr) arg2 * (rt_uint_ptr) (");
						l_exp_class_type.skeleton.generate_size (buffer, True)
						buffer.put_string (" + OVERHEAD));")
					else
							-- No references, do a simple `memcpy'.
						buffer.put_new_line
						buffer.put_string ("memcpy(Current + (rt_uint_ptr) arg2 * (rt_uint_ptr) ")
						l_exp_class_type.skeleton.generate_size (buffer, True)
						buffer.put_string (", arg1, ")
						l_exp_class_type.skeleton.generate_size (buffer, True)
						buffer.put_string (");")
					end
				else
					buffer.put_new_line
					buffer.put_string ("ecopy(arg1, Current + OVERHEAD + (rt_uint_ptr) arg2 * %
						%RT_SPECIAL_ELEM_SIZE(Current));")
				end
			else
				buffer.put_new_line
				buffer.put_string ("*(")
				type_c.generate_access_cast (buffer)
				buffer.put_string (" Current + arg2) = arg1;")
				if type_c.level = c_ref then
					buffer.put_new_line
					buffer.put_string ("RTAR(Current, arg1);%N")
				end
			end

			buffer.generate_block_close
			if not final_mode then
				buffer.put_new_line_only
				buffer.put_string ("#undef arg1")
				buffer.put_new_line_only
				buffer.put_string ("#undef arg2")
			end
				-- Separation for formatting
			buffer.put_new_line

			if final_mode then
					-- Generate generic wrapper.
				buffer.generate_function_signature ("void", encoded_name + "2", True,
					l_byte_context.header_buffer, <<"Current", "arg1", "arg2">>,
					<<"EIF_REFERENCE", "EIF_REFERENCE", "EIF_INTEGER_32">>)
				buffer.generate_block_open
				buffer.put_new_line
				if l_param_is_expanded or else type_c.level = c_ref or else associated_class.assertion_level.is_precondition then
					buffer.put_string (encoded_name)
					buffer.put_string (" (Current, ")
					if gen_param.is_basic then
						buffer.put_character ('*')
						gen_param.c_type.generate_access_cast (buffer)
					end
					buffer.put_string ("arg1, arg2);")
				else
					buffer.put_string ("*(")
					type_c.generate_access_cast (buffer)
					buffer.put_string (" Current + arg2) = ")
					if gen_param.is_basic then
						buffer.put_character ('*')
						gen_param.c_type.generate_access_cast (buffer)
					end
					buffer.put_string ("arg1;")
				end
				buffer.generate_block_close
					-- Separation for formatting
				buffer.put_new_line
			end

			l_byte_context.clear_feature_data
		end

	generate_force (feat: FEATURE_I; buffer: GENERATION_BUFFER)
			-- Generates built-in feature `put' of class SPECIAL
		require
			good_argument: buffer /= Void
			feat_exists: feat /= Void
			consistency: feat.feature_name_id = {PREDEFINED_NAMES}.force_name_id
		local
			gen_param: TYPE_A
			l_exp_class_type: CLASS_TYPE
			l_param_is_expanded: BOOLEAN
			type_c: TYPE_C
			final_mode: BOOLEAN
			encoded_name: STRING
			value_type_name: STRING
			index_type_name: STRING
			value_arg_name: STRING
			index_arg_name: STRING
			l_byte_context: like byte_context
			l_arg: ARGUMENT_BL
		do
			l_byte_context := byte_context
			gen_param := first_generic
			l_param_is_expanded := gen_param.is_true_expanded
			type_c := gen_param.c_type

			feat.generate_header (Current, buffer)
			encoded_name := Encoder.feature_name (type_id, feat.body_index)

			System.used_features_log_file.add (Current, "force", encoded_name)

			final_mode := l_byte_context.final_mode

			if final_mode then
				value_type_name := type_c.c_string
				index_type_name := "EIF_INTEGER_32"
				value_arg_name := "arg1"
				index_arg_name := "arg2"
			else
				value_type_name := "EIF_TYPED_VALUE"
				index_type_name := "EIF_TYPED_VALUE"
				value_arg_name := "arg1x"
				index_arg_name := "arg2x"
			end

			buffer.generate_function_signature ("void", encoded_name, True,
				l_byte_context.header_buffer, <<"Current", value_arg_name, index_arg_name>>,
				<<"EIF_REFERENCE", value_type_name, index_type_name>>)

			buffer.generate_block_open
			buffer.put_gtcx

			buffer.put_new_line
			buffer.put_string ("EIF_INTEGER_32 arg3 = RT_SPECIAL_COUNT(Current);")

			if not final_mode then
				if not type_c.is_reference then
					buffer.put_new_line
					buffer.put_string ("if ((arg1x.type & SK_HEAD) == SK_REF) arg1x.")
					type_c.generate_typed_field (buffer)
					buffer.put_string (" = * ")
					type_c.generate_access_cast (buffer)
					buffer.put_string ("arg1x.it_r;")
				end
				buffer.put_new_line
				buffer.put_string ("if ((arg2x.type & SK_HEAD) == SK_REF) arg2x.it_i4 = * (EIF_INTEGER_32 *) arg2x.it_r;")
				buffer.put_new_line_only
				buffer.put_string ("#define arg1 arg1x.")
				type_c.generate_typed_field (buffer)
				buffer.put_new_line_only
				buffer.put_string ("#define arg2 arg2x.it_i4")
			end

			if not final_mode and then l_param_is_expanded then
				buffer.put_new_line
				buffer.put_string ("if (arg1 == NULL) RTEC(EN_VEXP);")
			end

			if not final_mode or else system.check_for_catcall_at_runtime then
				if gen_param.c_type.is_reference then
					byte_context.set_byte_code (byte_server.disk_item (feat.body_index))
					byte_context.set_current_feature (feat)
					if l_param_is_expanded then
							-- Minor hack because expanded arguments are generated with a `e' prefix
							-- but for SPECIAL we use without the prefix because the generation is done
							-- manually.
						buffer.put_new_line_only
						buffer.put_string ("#define earg1 arg1")
					end
					byte_context.set_has_feature_name_stored (False)
					create l_arg
					l_arg.set_position (1)
					byte_context.generate_catcall_check (l_arg, create {FORMAL_A}.make (False, False, 1), 1, False)
					if l_param_is_expanded then
						buffer.put_new_line_only
						buffer.put_string ("#undef earg1")
					end
				end
			end

			generate_force_precondition (buffer, final_mode, "arg2", "arg3")

			if l_param_is_expanded then
				if final_mode then
					l_exp_class_type := gen_param.associated_class_type (Void)
					buffer.put_new_line
					if l_exp_class_type.skeleton.has_references then
							-- Optimization: size is known at compile time
						buffer.put_string ("ecopy(arg1, Current + OVERHEAD + (rt_uint_ptr) arg2 * (rt_uint_ptr) (");
						l_exp_class_type.skeleton.generate_size (buffer, True)
						buffer.put_string (" + OVERHEAD));")
					else
							-- No references, do a simple `memcpy'.
						buffer.put_new_line
						buffer.put_string ("memcpy(Current + (rt_uint_ptr) arg2 * (rt_uint_ptr) ")
						l_exp_class_type.skeleton.generate_size (buffer, True)
						buffer.put_string (", arg1, ")
						l_exp_class_type.skeleton.generate_size (buffer, True)
						buffer.put_string (");")
					end
				else
					buffer.put_new_line
					buffer.put_string ("ecopy(arg1, Current + OVERHEAD + (rt_uint_ptr) arg2 * %
						%RT_SPECIAL_ELEM_SIZE(Current));")
				end
					-- Increment count if we are extending.
				buffer.put_new_line
				buffer.put_string ("if (arg2 == arg3) { RT_SPECIAL_COUNT(Current) = arg3 + 1; }")
			else
				buffer.put_new_line
				buffer.put_string ("*(")
				type_c.generate_access_cast (buffer)
				buffer.put_string (" Current + arg2) = arg1;")
					-- Increment count if we are extending.
				buffer.put_new_line
				buffer.put_string ("if (arg2 == arg3) { RT_SPECIAL_COUNT(Current) = arg3 + 1; }")
				if type_c.level = c_ref then
					buffer.put_new_line
					buffer.put_string ("RTAR(Current, arg1);%N")
				end
			end

			buffer.generate_block_close
			if not final_mode then
				buffer.put_new_line_only
				buffer.put_string ("#undef arg1")
				buffer.put_new_line_only
				buffer.put_string ("#undef arg2")
			end
				-- Separation for formatting
			buffer.put_new_line

			if final_mode then
					-- Generate generic wrapper.
				buffer.generate_function_signature ("void", encoded_name + "2", True,
					l_byte_context.header_buffer, <<"Current", "arg1", "arg2">>,
					<<"EIF_REFERENCE", "EIF_REFERENCE", "EIF_INTEGER_32">>)
				buffer.generate_block_open
				buffer.put_new_line
				if l_param_is_expanded or else type_c.level = c_ref or else associated_class.assertion_level.is_precondition then
					buffer.put_string (encoded_name)
					buffer.put_string (" (Current, ")
					if gen_param.is_basic then
						buffer.put_character ('*')
						gen_param.c_type.generate_access_cast (buffer)
					end
					buffer.put_string ("arg1, arg2);")
				else
					buffer.put_string ("*(")
					type_c.generate_access_cast (buffer)
					buffer.put_string (" Current + arg2) = ")
					if gen_param.is_basic then
						buffer.put_character ('*')
						gen_param.c_type.generate_access_cast (buffer)
					end
					buffer.put_string ("arg1;")
				end
				buffer.generate_block_close
					-- Separation for formatting
				buffer.put_new_line
			end

			l_byte_context.clear_feature_data
		end

	generate_extend (feat: FEATURE_I; buffer: GENERATION_BUFFER)
			-- Generates built-in feature `extend' of class SPECIAL
		require
			good_argument: buffer /= Void
			feat_exists: feat /= Void
			consistency: feat.feature_name_id = {PREDEFINED_NAMES}.extend_name_id
		local
			gen_param: TYPE_A
			l_exp_class_type: CLASS_TYPE
			l_param_is_expanded: BOOLEAN
			type_c: TYPE_C
			final_mode: BOOLEAN
			encoded_name: STRING
			value_type_name: STRING
			value_arg_name: STRING
			l_byte_context: like byte_context
			l_arg: ARGUMENT_BL
			l_is_multithreaded: BOOLEAN
		do
			l_byte_context := byte_context
			gen_param := first_generic
			l_param_is_expanded := gen_param.is_true_expanded
			type_c := gen_param.c_type

			feat.generate_header (Current, buffer)
			encoded_name := Encoder.feature_name (type_id, feat.body_index)

			System.used_features_log_file.add (Current, "extend", encoded_name)

			final_mode := l_byte_context.final_mode

			if final_mode then
				value_type_name := type_c.c_string
				value_arg_name := "arg1"
			else
				value_type_name := "EIF_TYPED_VALUE"
				value_arg_name := "arg1x"
			end

			buffer.generate_function_signature ("void", encoded_name, True,
				l_byte_context.header_buffer, <<"Current", value_arg_name>>,
				<<"EIF_REFERENCE", value_type_name>>)

			buffer.generate_block_open
			buffer.put_gtcx

			l_is_multithreaded := system.has_multithreaded

				-- To make the code more efficient, we update the count immediately,
				-- but only in non-MT mode. In MT mode we only update it later to ensure
				-- that visibility of change does not make a thread read junk if the
				-- count is updated before.
			buffer.put_new_line
			buffer.put_string ("EIF_INTEGER_32 arg2 = RT_SPECIAL_COUNT(Current)")
			if l_is_multithreaded then
				buffer.put_character (';')
			else
				buffer.put_string ("++;")
			end

			if not final_mode then
				buffer.put_new_line
				if not type_c.is_reference then
					buffer.put_new_line
					buffer.put_string ("if ((arg1x.type & SK_HEAD) == SK_REF) arg1x.")
					type_c.generate_typed_field (buffer)
					buffer.put_string (" = * ")
					type_c.generate_access_cast (buffer)
					buffer.put_string ("arg1x.it_r;")
				end
				buffer.put_new_line_only
				buffer.put_string ("#define arg1 arg1x.")
				type_c.generate_typed_field (buffer)
			end

			if not final_mode and then l_param_is_expanded then
				buffer.put_new_line
				buffer.put_string ("if (arg1 == NULL) RTEC(EN_VEXP);")
			end

			if not final_mode or else system.check_for_catcall_at_runtime then
				if gen_param.c_type.is_reference then
					byte_context.set_byte_code (byte_server.disk_item (feat.body_index))
					byte_context.set_current_feature (feat)
					if l_param_is_expanded then
							-- Minor hack because expanded arguments are generated with a `e' prefix
							-- but for SPECIAL we use without the prefix because the generation is done
							-- manually.
						buffer.put_new_line_only
						buffer.put_string ("#define earg1 arg1")
					end
					byte_context.set_has_feature_name_stored (False)
					create l_arg
					l_arg.set_position (1)
					byte_context.generate_catcall_check (l_arg, create {FORMAL_A}.make (False, False, 1), 1, False)
					if l_param_is_expanded then
						buffer.put_new_line_only
						buffer.put_string ("#undef earg1")
					end
				end
			end

			if not final_mode or else associated_class.assertion_level.is_precondition then
				buffer.put_new_line
				buffer.put_string ("if (arg2 >= RT_SPECIAL_CAPACITY(Current)) {%N")
				buffer.put_string ("%T%Teraise (%"count_small_enough%", EN_RT_CHECK);%N%T}%N");
			end

			if l_param_is_expanded then
				if final_mode then
					l_exp_class_type := gen_param.associated_class_type (Void)
					buffer.put_new_line
					if l_exp_class_type.skeleton.has_references then
							-- Optimization: size is known at compile time
						buffer.put_string ("ecopy(arg1, Current + OVERHEAD + (rt_uint_ptr) arg2 * (rt_uint_ptr) (");
						l_exp_class_type.skeleton.generate_size (buffer, True)
						buffer.put_string (" + OVERHEAD));")
					else
							-- No references, do a simple `memcpy'.
						buffer.put_new_line
						buffer.put_string ("memcpy(Current + (rt_uint_ptr) arg2 * (rt_uint_ptr) ")
						l_exp_class_type.skeleton.generate_size (buffer, True)
						buffer.put_string (", arg1, ")
						l_exp_class_type.skeleton.generate_size (buffer, True)
						buffer.put_string (");")
					end
				else
					buffer.put_new_line
					buffer.put_string ("ecopy(arg1, Current + OVERHEAD + (rt_uint_ptr) arg2 * %
						%RT_SPECIAL_ELEM_SIZE(Current));")
				end
					-- Update to new count
				if l_is_multithreaded then
					buffer.put_new_line
					buffer.put_string ("RT_SPECIAL_COUNT(Current) = arg2 + 1;")
				end
			else
				buffer.put_new_line
				buffer.put_string ("*(")
				type_c.generate_access_cast (buffer)
				buffer.put_string (" Current + arg2) = arg1;")
					-- Update to new count
				if l_is_multithreaded then
					buffer.put_new_line
					buffer.put_string ("RT_SPECIAL_COUNT(Current) = arg2 + 1;")
				end
				if type_c.level = c_ref then
					buffer.put_new_line
					buffer.put_string ("RTAR(Current, arg1);%N")
				end
			end

			buffer.generate_block_close
			if not final_mode then
				buffer.put_new_line_only
				buffer.put_string ("#undef arg1")
			end
				-- Separation for formatting
			buffer.put_new_line

			if final_mode then
					-- Generate generic wrapper.
				buffer.generate_function_signature ("void", encoded_name + "2", True,
					l_byte_context.header_buffer, <<"Current", "arg1">>,
					<<"EIF_REFERENCE", "EIF_REFERENCE">>)
				buffer.generate_block_open
				buffer.put_new_line
				if l_param_is_expanded or else type_c.level = c_ref or else associated_class.assertion_level.is_precondition then
					buffer.put_string (encoded_name)
					buffer.put_string (" (Current, ")
					if gen_param.is_basic then
						buffer.put_character ('*')
						gen_param.c_type.generate_access_cast (buffer)
					end
					buffer.put_string ("arg1);")
				else
						-- To make the code more efficient, we update the count immediately,
						-- but only in non-MT mode. In MT mode we only update it later to ensure
						-- that visibility of change does not make a thread read junk if the
						-- count is updated before.
					buffer.put_new_line
					buffer.put_string ("EIF_INTEGER_32 arg2 = RT_SPECIAL_COUNT(Current)")
					if l_is_multithreaded then
						buffer.put_character (';')
					else
						buffer.put_string ("++;")
					end
					buffer.put_new_line
					buffer.put_string ("*(")
					type_c.generate_access_cast (buffer)
					buffer.put_string (" Current + arg2) = ")
					if gen_param.is_basic then
						buffer.put_character ('*')
						gen_param.c_type.generate_access_cast (buffer)
					end
					buffer.put_string ("arg1;")

					if l_is_multithreaded then
							-- Update to new count
						buffer.put_new_line
						buffer.put_string ("RT_SPECIAL_COUNT(Current) = arg2 + 1;")
					end
				end
				buffer.generate_block_close
					-- Separation for formatting
				buffer.put_new_line
			end

			l_byte_context.clear_feature_data
		end

	generate_put_default (feat: FEATURE_I; buffer: GENERATION_BUFFER)
			-- Generates built-in feature `put_default' of class SPECIAL
		require
			good_argument: buffer /= Void
			feat_exists: feat /= Void
			consistency: feat.feature_name_id = {PREDEFINED_NAMES}.put_default_name_id
		local
			gen_param: TYPE_A
			l_exp_class_type: CLASS_TYPE
			l_param_is_expanded: BOOLEAN
			type_c: TYPE_C
			final_mode: BOOLEAN
			encoded_name: STRING
			index_type_name: STRING
			index_arg_name: STRING
			l_byte_context: like byte_context
		do
			l_byte_context := byte_context
			gen_param := first_generic
			l_param_is_expanded := gen_param.is_true_expanded
			type_c := gen_param.c_type

			feat.generate_header (Current, buffer)
			encoded_name := Encoder.feature_name (type_id, feat.body_index)

			System.used_features_log_file.add (Current, "put_default", encoded_name)

			final_mode := l_byte_context.final_mode

			if final_mode then
				index_type_name := "EIF_INTEGER_32"
				index_arg_name := "arg1"
			else
				index_type_name := "EIF_TYPED_VALUE"
				index_arg_name := "arg1x"
			end

			buffer.generate_function_signature ("void", encoded_name, True,
				l_byte_context.header_buffer, <<"Current", index_arg_name>>,
				<<"EIF_REFERENCE", index_type_name>>)

			buffer.generate_block_open

				-- Generate a local with a default value.
			if l_param_is_expanded then
				buffer.put_gtcx
				l_exp_class_type := gen_param.associated_class_type (Void)
				l_exp_class_type.generate_expanded_structure_declaration (buffer, "sloc1")
				buffer.put_new_line
				type_c.generate (buffer)
				buffer.put_string (" loc1 = ")
				type_c.generate_cast (buffer)
				buffer.put_string ("sloc1.data")
				buffer.put_character (';')
				buffer.put_new_line
				buffer.put_string ("RTLD;")
				buffer.put_new_line
				buffer.put_string ("RTLI(2);")
				buffer.put_current_registration (0)
				buffer.put_local_registration (1, "loc1")
				buffer.put_new_line
				buffer.put_string ("memset (&sloc1.overhead, 0, OVERHEAD + ")
				if final_mode then
					l_exp_class_type.skeleton.generate_size (buffer, True)
				else
					l_exp_class_type.skeleton.generate_workbench_size (buffer)
				end
				buffer.put_two_character (')', ';')
					-- Create expanded type based on the actual generic parameter, and not
					-- on the recorded derivation (as it would not work if `gen_param' is
					-- generic. (See eweasel test#exec282 and test#exec283 for an example where
					-- it does not work).
				l_exp_class_type.generate_expanded_type_initialization (buffer, "sloc1",
					create {FORMAL_A}.make (False, False, 1), Current)
			elseif final_mode and then associated_class.assertion_level.is_precondition then
				buffer.put_gtcx
			end

			if not final_mode then
				buffer.put_new_line
				buffer.put_string ("if ((arg1x.type & SK_HEAD) == SK_REF) arg1x.it_i4 = * (EIF_INTEGER_32 *) arg1x.it_r;")
				buffer.put_new_line_only
				buffer.put_string ("#define arg1 arg1x.it_i4")
			end

			generate_precondition (buffer, final_mode, "arg1")

			if l_param_is_expanded then
				l_exp_class_type.generate_expanded_initialization (buffer, "loc1", "loc1", True)
				if final_mode then
					buffer.put_new_line
					if l_exp_class_type.skeleton.has_references then
							-- Optimization: size is known at compile time
						buffer.put_string ("ecopy(loc1, Current + OVERHEAD + (rt_uint_ptr) arg1 * (rt_uint_ptr) (");
						l_exp_class_type.skeleton.generate_size (buffer, True)
						buffer.put_string (" + OVERHEAD));")
					else
							-- No references, do a simple `memcpy'.
						buffer.put_new_line
						buffer.put_string ("memcpy(Current + (rt_uint_ptr) arg1 * (rt_uint_ptr) ")
						l_exp_class_type.skeleton.generate_size (buffer, True)
						buffer.put_string (", loc1, ")
						l_exp_class_type.skeleton.generate_size (buffer, True)
						buffer.put_string (");")
					end
				else
					buffer.put_new_line
					buffer.put_string ("ecopy(loc1, Current + OVERHEAD + (rt_uint_ptr) arg1 * %
						%RT_SPECIAL_ELEM_SIZE(Current));")
				end
				buffer.put_new_line
				buffer.put_string ("RTLE;")
			else
				buffer.put_new_line
				buffer.put_string ("*(")
				type_c.generate_access_cast (buffer)
				buffer.put_string (" Current + arg1) = ")
				type_c.generate_cast (buffer)
				buffer.put_two_character ('0', ';')
			end

			buffer.generate_block_close
			if not final_mode then
				buffer.put_new_line_only
				buffer.put_string ("#undef arg1")
			end
				-- Separation for formatting
			buffer.put_new_line

			l_byte_context.clear_feature_data
		end

	generate_item (feat: FEATURE_I; buffer: GENERATION_BUFFER)
			-- Generates built-in feature `item' of class SPECIAL
		require
			good_argument: buffer /= Void
			feat_exists: feat /= Void
			consistency: feat.feature_name_id = {PREDEFINED_NAMES}.item_name_id or
				feat.feature_name_id = {PREDEFINED_NAMES}.infix_at_name_id or
				feat.feature_name_id = {PREDEFINED_NAMES}.at_name_id
		local
			gen_param: TYPE_A
			l_exp_class_type: CLASS_TYPE
			l_param_is_expanded: BOOLEAN
			type_c: TYPE_C
			final_mode: BOOLEAN
			encoded_name: STRING
			l_exp_has_references: BOOLEAN
			basic_i: BASIC_A
			result_type_name: STRING
			arg_name: STRING
			arg_type_name: STRING
		do
			gen_param := first_generic
			l_param_is_expanded := gen_param.is_true_expanded
			type_c := gen_param.c_type

			feat.generate_header (Current, buffer)

			encoded_name := Encoder.feature_name (type_id, feat.body_index)

			System.used_features_log_file.add (Current, "item", encoded_name)

			final_mode := byte_context.final_mode

			if final_mode then
				result_type_name := type_c.c_string
				arg_name := "arg1"
				arg_type_name := "EIF_INTEGER_32"
			else
				result_type_name := "EIF_TYPED_VALUE"
				arg_name := "arg1x"
				arg_type_name := "EIF_TYPED_VALUE"
			end

			buffer.generate_function_signature (result_type_name, encoded_name, True,
				byte_context.header_buffer,
				<<"Current", arg_name>>, <<"EIF_REFERENCE", arg_type_name>>)

			buffer.generate_block_open
			buffer.put_gtcx

			if l_param_is_expanded and final_mode then
				l_exp_class_type := gen_param.associated_class_type (Void)
				l_exp_has_references := l_exp_class_type.skeleton.has_references
				if not l_exp_has_references then
					buffer.put_new_line
					buffer.put_string ("EIF_REFERENCE Result;")
				end
			end

			if not final_mode then
				buffer.put_new_line
				buffer.put_string ("EIF_TYPED_VALUE r;")
				buffer.put_new_line
				buffer.put_string ("r.")
				type_c.generate_typed_tag (buffer)
				buffer.put_character (';')
				buffer.put_new_line
				buffer.put_string ("if ((arg1x.type & SK_HEAD) == SK_REF) arg1x.it_i4 = * (EIF_INTEGER_32 *) arg1x.it_r;")
				buffer.put_new_line_only
				buffer.put_string ("#define arg1 arg1x.it_i4")
			end

			generate_precondition (buffer, final_mode, "arg1")

			buffer.put_new_line
			if l_param_is_expanded then
				if final_mode then
						-- Optimization: size of expanded is known at compile time
					if l_exp_has_references then
						buffer.put_string ("return RTCL(Current + OVERHEAD + (rt_uint_ptr) arg1 * (rt_uint_ptr) (")
						l_exp_class_type.skeleton.generate_size (buffer, True)
						buffer.put_string (" + OVERHEAD));")
					else
						buffer.generate_block_open
						buffer.put_new_line
						buffer.put_string ("RTLD;")
						buffer.put_new_line
						buffer.put_string ("RTLI(1);")
						buffer.put_new_line
						buffer.put_current_registration (0)
							-- Create expanded type based on the actual generic parameter, and not
							-- on the recorded derivation (as it would not work if `gen_param' is
							-- generic. (See eweasel test#exec282 nd test#exec283 for an example where
							-- it does not work).
						l_exp_class_type.generate_expanded_creation (buffer, "Result",
							create {FORMAL_A}.make (False, False, 1), Current)
						buffer.put_new_line
						buffer.put_string ("memcpy (Result, ")
						buffer.put_string ("Current + (rt_uint_ptr) arg1 * (rt_uint_ptr) (")
						l_exp_class_type.skeleton.generate_size (buffer, True)
						buffer.put_string ("), ")
						l_exp_class_type.skeleton.generate_size (buffer, True)
						buffer.put_string (");")
						buffer.put_new_line
						buffer.put_string ("RTLE;")
						buffer.put_new_line
						buffer.put_string ("return Result;")
						buffer.generate_block_close
					end
				else
					buffer.put_string ("r.")
					type_c.generate_typed_field (buffer)
					buffer.put_string ("= RTCL(Current + OVERHEAD + (rt_uint_ptr) arg1 * %
						%RT_SPECIAL_ELEM_SIZE(Current));")
					buffer.put_new_line
					buffer.put_string ("return r;")
				end
			else
				buffer.put_string ("return ")
				if not final_mode then
					buffer.put_string ("(r.")
					type_c.generate_typed_field (buffer)
					buffer.put_string (" = ")
				end
				buffer.put_string ("*(")
				type_c.generate_access_cast (buffer)
				buffer.put_string (" Current + arg1)")
				if not final_mode then
					buffer.put_string ("), r")
				end
				buffer.put_character (';')
			end

			buffer.generate_block_close
			if not final_mode then
				buffer.put_new_line_only
				buffer.put_string ("#undef arg1")
			end
			buffer.put_new_line

			if final_mode then
					-- Generate generic wrapper.
				buffer.generate_function_signature ("EIF_REFERENCE", encoded_name + "1", True,
					Byte_context.header_buffer, <<"Current", "arg1">>,
					<<"EIF_REFERENCE", "EIF_INTEGER_32">>)
				buffer.generate_block_open
				basic_i ?= gen_param
				buffer.put_new_line
				if basic_i = Void then
					buffer.put_string ("return ")
				else
					buffer.put_string ({C_CONST}.eif_reference)
					buffer.put_character (' ')
					buffer.put_string ({C_CONST}.result_name)
					buffer.put_character (';')
					buffer.put_new_line
					basic_i.c_type.generate (buffer)
					buffer.put_character (' ')
					buffer.put_four_character ('r', ' ', '=', ' ')
				end
				if l_param_is_expanded or else associated_class.assertion_level.is_precondition then
						-- It's possible to repeat the code above, but it's complex enough.
					buffer.put_string (encoded_name)
					buffer.put_string (" (Current, arg1);")
				else
					buffer.put_string ("*(")
					type_c.generate_access_cast (buffer)
					buffer.put_string (" Current + arg1);")
				end
				if basic_i /= Void then
					basic_i.metamorphose (create {NAMED_REGISTER}.make ("Result", reference_c_type), create {NAMED_REGISTER}.make ("r", basic_i.c_type), buffer)
					buffer.put_character (';')
					buffer.put_new_line
					buffer.put_string ("return Result;")
				end
				buffer.generate_block_close
					-- Separation for formatting
				buffer.put_new_line
			end

			byte_context.clear_feature_data
		end

	generate_item_address (feat: FEATURE_I; buffer: GENERATION_BUFFER)
			-- Generates built-in feature `item_address' of class SPECIAL
		require
			good_argument: buffer /= Void;
			feat_exists: feat /= Void;
			consistency: feat.feature_name_id = {PREDEFINED_NAMES}.item_address_name_id
		local
			result_type, gen_param: TYPE_A
			l_param_is_expanded: BOOLEAN
			type_c: TYPE_C
			encoded_name: STRING
			l_exp_class_type: CLASS_TYPE
			result_type_name: STRING
			index_type_name: STRING
			index_arg_name: STRING
			l_byte_context: like byte_context
		do
			l_byte_context := byte_context
			gen_param := first_generic
			l_param_is_expanded := gen_param.is_true_expanded
			type_c := gen_param.c_type

			feat.generate_header (Current, buffer)

			result_type := feat.type.adapted_in (Current)

			encoded_name := Encoder.feature_name (type_id, feat.body_index)

			System.used_features_log_file.add (Current, "item_address", encoded_name)

			if l_byte_context.workbench_mode then
				result_type_name := "EIF_TYPED_VALUE"
				index_type_name := "EIF_TYPED_VALUE"
				index_arg_name := "arg1x"
			else
				result_type_name := result_type.c_type.c_string
				index_type_name := "EIF_INTEGER_32"
				index_arg_name := "arg1"
			end

			buffer.generate_function_signature (result_type_name, encoded_name, True,
				l_byte_context.header_buffer,
				<<"Current", index_arg_name>>, <<"EIF_REFERENCE", index_type_name>>)

			buffer.generate_block_open
			buffer.put_gtcx

			if l_byte_context.workbench_mode then
				buffer.put_new_line
				buffer.put_string ("EIF_TYPED_VALUE r;")
				buffer.put_new_line
				buffer.put_string ("r.")
				result_type.c_type.generate_typed_tag (buffer)
				buffer.put_character (';')
				buffer.put_new_line
				buffer.put_string ("if ((arg1x.type & SK_HEAD) == SK_REF) arg1x.it_i4 = * (EIF_INTEGER_32 *) arg1x.it_r;")
				buffer.put_new_line_only
				buffer.put_string ("#define arg1 arg1x.it_i4")
			end

			generate_precondition (buffer, l_byte_context.final_mode, "arg1")

			buffer.put_new_line
			if l_byte_context.workbench_mode then
				buffer.put_string ("r.")
				result_type.c_type.generate_typed_field (buffer)
				buffer.put_string (" = ")
			else
				buffer.put_string ("return ")
			end
			result_type.c_type.generate_cast (buffer)
			buffer.put_string ("(Current + ")
			if l_param_is_expanded then
				if l_byte_context.final_mode then
					l_exp_class_type := gen_param.associated_class_type (Void)
						-- It is set to True because at the moment we need a header in
						-- order to call inherited features in an expanded class. This is
						-- necessary until we are able to do a flat code generation for
						-- expanded.
					if True or l_exp_class_type.skeleton.has_references then
						buffer.put_string ("OVERHEAD + (rt_uint_ptr) arg1 * (rt_uint_ptr) (")
						l_exp_class_type.skeleton.generate_size (buffer, True)
						buffer.put_string (" + OVERHEAD));")
					else
						buffer.put_string ("(rt_uint_ptr) arg1 * (rt_uint_ptr) ")
						l_exp_class_type.skeleton.generate_size (buffer, True)
						buffer.put_character (')')
						buffer.put_character (';')
					end
				else
					buffer.put_string ("OVERHEAD + (rt_uint_ptr) arg1 * (rt_uint_ptr) RT_SPECIAL_ELEM_SIZE(Current));")
				end
			else
				buffer.put_string ("(rt_uint_ptr) arg1 * (rt_uint_ptr)")
				type_c.generate_size (buffer)
				buffer.put_two_character (')', ';')
			end
			if l_byte_context.workbench_mode then
				buffer.put_new_line
				buffer.put_string ("return r;")
			end
			buffer.generate_block_close
			if l_byte_context.workbench_mode then
				buffer.put_new_line_only
				buffer.put_string ("#undef arg1")
			end
				-- Separation for formatting
			buffer.put_new_line
			l_byte_context.clear_feature_data
		end

	generate_base_address (feat: FEATURE_I; buffer: GENERATION_BUFFER)
			-- Generates built-in feature `base_address' of class SPECIAL
		require
			good_argument: buffer /= Void;
			feat_exists: feat /= Void;
			consistency: feat.feature_name_id = {PREDEFINED_NAMES}.base_address_name_id
		local
			gen_param, result_type: TYPE_A
			l_param_is_expanded: BOOLEAN
			type_c: TYPE_C
			encoded_name, result_type_name: STRING
		do
			gen_param := first_generic
			l_param_is_expanded := gen_param.is_true_expanded
			type_c := gen_param.c_type

			feat.generate_header (Current, buffer)

			result_type := feat.type.adapted_in (Current)

			encoded_name := Encoder.feature_name (type_id, feat.body_index)

			System.used_features_log_file.add (Current, "base_address", encoded_name)

			if byte_context.workbench_mode then
				result_type_name := "EIF_TYPED_VALUE"
			else
				result_type_name := result_type.c_type.c_string
			end

			buffer.generate_function_signature (result_type_name, encoded_name, True,
				byte_context.header_buffer,
				<<"Current">>, <<"EIF_REFERENCE">>)

			buffer.generate_block_open

			buffer.put_new_line
			if byte_context.workbench_mode then
				buffer.put_string ("EIF_TYPED_VALUE r;")
				buffer.put_new_line
				buffer.put_string ("r.")
				result_type.c_type.generate_typed_tag (buffer)
				buffer.put_character (';')
				buffer.put_new_line
				buffer.put_string ("r.")
				result_type.c_type.generate_typed_field (buffer)
				buffer.put_string (" = ")
			else
				buffer.put_string ("return ")
			end
			result_type.c_type.generate_cast (buffer)
			buffer.put_string ("Current;")

			if byte_context.workbench_mode then
				buffer.put_new_line
				buffer.put_string ("return r;")
			end
			buffer.generate_block_close
				-- Separation for formatting
			buffer.put_new_line
			byte_context.clear_feature_data
		end

	generate_clear_all (feat: FEATURE_I; buffer: GENERATION_BUFFER)
			-- Generate `clear_all' from SPECIAL using `memset' for increased efficiency.
		require
			good_argument: buffer /= Void;
			feat_exists: feat /= Void;
			consistency: feat.feature_name_id = {PREDEFINED_NAMES}.clear_all_name_id
			not_is_expanded_with_side_effect: not first_generic.is_true_expanded
		local
			encoded_name: STRING
		do
			feat.generate_header (Current, buffer)
			encoded_name := Encoder.feature_name (type_id, feat.body_index)
			System.used_features_log_file.add (Current, "clear_all", encoded_name)

			buffer.generate_function_signature ("void", encoded_name, True,
				byte_context.header_buffer, <<"Current">>, <<"EIF_REFERENCE">>)

			buffer.generate_block_open
				-- We zeroed the memory used by the SPECIAL instance.
			buffer.put_new_line
			buffer.put_string ("memset (Current, 0, RT_SPECIAL_VISIBLE_SIZE(Current));")
			buffer.generate_block_close
				-- Separation for formatting
			buffer.put_new_line
			byte_context.clear_feature_data
		end

	generate_fill_with (feat: FEATURE_I; buffer: GENERATION_BUFFER)
			-- Generate `fill_with' from SPECIAL without using Eiffel code but a tight C loop.
		require
			good_argument: buffer /= Void;
			feat_exists: feat /= Void;
			consistency: feat.feature_name_id = {PREDEFINED_NAMES}.fill_with_name_id
			not_is_expanded_with_side_effect: not first_generic.is_true_expanded
		local
			gen_param: TYPE_A
			type_c: TYPE_C
			final_mode: BOOLEAN
			encoded_name: STRING
			value_type_name: STRING
			index_type_name: STRING
			value_arg_name: STRING
			start_index_name, end_index_name: STRING
			l_byte_context: like byte_context
			l_arg: ARGUMENT_BL
		do
			l_byte_context := byte_context
			gen_param := first_generic
			type_c := gen_param.c_type

			feat.generate_header (Current, buffer)
			encoded_name := Encoder.feature_name (type_id, feat.body_index)

			System.used_features_log_file.add (Current, "fill_with", encoded_name)

			final_mode := l_byte_context.final_mode

			if final_mode then
				value_type_name := type_c.c_string
				index_type_name := "EIF_INTEGER_32"
				value_arg_name := "arg1"
				start_index_name := "arg2"
				end_index_name := "arg3"
			else
				value_type_name := "EIF_TYPED_VALUE"
				index_type_name := value_type_name
				value_arg_name := "arg1x"
				start_index_name := "arg2x"
				end_index_name := "arg3x"
			end

				-- Add `eif_helpers.h' for C declaration of `eif_max_int32'.
			shared_include_queue_put ({PREDEFINED_NAMES}.eif_helpers_header_name_id)

			buffer.generate_function_signature ("void", encoded_name, True,
				l_byte_context.header_buffer, <<"Current", value_arg_name, start_index_name, end_index_name>>,
				<<"EIF_REFERENCE", value_type_name, index_type_name, index_type_name>>)

			buffer.generate_block_open
			buffer.put_gtcx

			buffer.put_new_line
			buffer.put_string ("EIF_INTEGER_32 i;")

			if not final_mode then
				if not type_c.is_reference then
					buffer.put_new_line
					buffer.put_string ("if ((arg1x.type & SK_HEAD) == SK_REF) arg1x.")
					type_c.generate_typed_field (buffer)
					buffer.put_string (" = * ")
					type_c.generate_access_cast (buffer)
					buffer.put_string ("arg1x.it_r;")
				end
				buffer.put_new_line
				buffer.put_string ("if ((arg2x.type & SK_HEAD) == SK_REF) arg2x.it_i4 = * (EIF_INTEGER_32 *) arg2x.it_r;")
				buffer.put_new_line_only
				buffer.put_string ("#define arg1 arg1x.")
				type_c.generate_typed_field (buffer)
				buffer.put_new_line_only
				buffer.put_string ("#define arg2 arg2x.it_i4")
				buffer.put_new_line_only
				buffer.put_string ("#define arg3 arg3x.it_i4")
			end

			if not final_mode or else system.check_for_catcall_at_runtime then
				if type_c.is_reference then
					byte_context.set_byte_code (byte_server.disk_item (feat.body_index))
					byte_context.set_current_feature (feat)
					byte_context.set_has_feature_name_stored (False)
					create l_arg
					l_arg.set_position (1)
					byte_context.generate_catcall_check (l_arg, create {FORMAL_A}.make (False, False, 1), 1, False)
				end
			end

			generate_fill_with_precondition (buffer, final_mode, "arg2", "arg3")

				-- Generate filling of SPECIAL
				-- for (i = arg2, i < arg3, i++) {
				--	Current [i] = arg1;
				-- }
			buffer.put_new_line
			buffer.put_string ("for (i = arg2; i <= arg3; i++) {")
			buffer.indent
			buffer.put_new_line
			buffer.put_string ("*(")
			type_c.generate_access_cast (buffer)
			buffer.put_string (" Current + i) = arg1;")
			buffer.exdent
			buffer.put_new_line
			buffer.put_character ('}')

				-- Update count.
			buffer.put_new_line
			buffer.put_string ("RT_SPECIAL_COUNT(Current) = eif_max_int32(RT_SPECIAL_COUNT(Current), arg3 + 1);")
				-- We need to remember Current if it is old and arg1 is new.
			if type_c.level = c_ref then
				buffer.put_new_line
				buffer.put_string ("RTAR(Current, arg1);")
			end

			buffer.generate_block_close
			if not final_mode then
				buffer.put_new_line_only
				buffer.put_string ("#undef arg1")
				buffer.put_new_line_only
				buffer.put_string ("#undef arg2")
				buffer.put_new_line_only
				buffer.put_string ("#undef arg3")
			end
				-- Separation for formatting
			buffer.put_new_line

			if final_mode then
					-- Generate generic wrapper.
				buffer.generate_function_signature ("void", encoded_name + "2", True,
					l_byte_context.header_buffer, <<"Current", "arg1", "arg2", "arg3">>,
					<<"EIF_REFERENCE", "EIF_REFERENCE", "EIF_INTEGER_32", "EIF_INTEGER_32">>)
				buffer.generate_block_open
				buffer.put_new_line
				if associated_class.assertion_level.is_precondition then
					buffer.put_string (encoded_name)
					buffer.put_string (" (Current, ")
					if gen_param.is_basic then
						buffer.put_character ('*')
						type_c.generate_access_cast (buffer)
					end
					buffer.put_string ("arg1, arg2, arg3);")
				else
					buffer.put_string ("EIF_INTEGER_32 i;")
					buffer.put_new_line
					type_c.generate (buffer)
					buffer.put_string (" arg1x = ")
					if gen_param.is_basic then
						buffer.put_character ('*')
						type_c.generate_access_cast (buffer)
					end
					buffer.put_string ("arg1;")

					buffer.put_new_line
					buffer.put_string ("for (i = arg2; i < arg3; i++) {")
					buffer.put_new_line
					buffer.indent
					buffer.put_string ("*(")
					type_c.generate_access_cast (buffer)
					buffer.put_string (" Current + i) = arg1x;")
					buffer.exdent
					buffer.put_new_line
					buffer.put_character ('}')

						-- Update count.
					buffer.put_new_line
					buffer.put_string ("RT_SPECIAL_COUNT(Current) = eif_max_int32(RT_SPECIAL_COUNT(Current), arg3 + 1);")
						-- We need to remember Current if it is old and arg1 is new.
					if type_c.level = c_ref then
						buffer.put_new_line
						buffer.put_string ("RTAR(Current, arg1);")
					end

				end
				buffer.generate_block_close
					-- Separation for formatting
				buffer.put_new_line
			end

			l_byte_context.clear_feature_data
		end

	generate_precondition (buffer: GENERATION_BUFFER; final_mode: BOOLEAN; arg_name: STRING)
			-- Generate precondition for `item', `put' and `item_address' where index
			-- is stored in `arg_name'.
		require
			buffer_not_void: buffer /= Void
			arg_name_not_void: arg_name /= Void
		do
			if not final_mode or else associated_class.assertion_level.is_precondition then
					-- First we check that `arg_name >= 0'.
				buffer.put_new_line
				buffer.put_string ("if (")
				buffer.put_string (arg_name)
				buffer.put_string (" < 0) {%N%T%Teraise (%"index_large_enough%", EN_RT_CHECK);%N%T}")
					-- Then we check that `arg_name < count'				
				buffer.put_new_line
				buffer.put_string ("if (")
				buffer.put_string (arg_name)
				buffer.put_string (" >= RT_SPECIAL_COUNT(Current)) {%N%T%Teraise (%"index_small_enough%", EN_RT_CHECK);%N%T}")
			end
		end

	generate_force_precondition (buffer: GENERATION_BUFFER; final_mode: BOOLEAN; arg_name, count_name: STRING)
			-- Generate precondition for `force' where index is stored in `arg_name' and count in `count_name'.
		require
			buffer_not_void: buffer /= Void
			arg_name_not_void: arg_name /= Void
		do
			if not final_mode or else associated_class.assertion_level.is_precondition then
					-- First we check that `arg_name >= 0'.
				buffer.put_new_line
				buffer.put_string ("if (")
				buffer.put_string (arg_name)
				buffer.put_string (" < 0) {%N%T%Teraise (%"index_large_enough%", EN_RT_CHECK);%N%T}")
				buffer.put_new_line
					-- Then we check that `arg_name <= count'
				buffer.put_string ("if (")
				buffer.put_string (arg_name)
				buffer.put_three_character (' ', '>', ' ')
				buffer.put_string (count_name)
				buffer.put_string (") {%N%T%Teraise (%"index_small_enough%", EN_RT_CHECK);%N%T}")
					-- Finaly we check `arg_name = count implies count < capacity' by simply checking
					-- that `count < capacity' as it is just a tiny bit slower and provides the same guarantee.
				buffer.put_new_line
				buffer.put_string ("if ((")
				buffer.put_string (arg_name)
				buffer.put_four_character (' ', '=', '=', ' ')
				buffer.put_string (count_name)
				buffer.put_string (") && (")
				buffer.put_string (count_name)
				buffer.put_string (" >= RT_SPECIAL_CAPACITY(Current))) {")
				buffer.put_string ("%N%T%Teraise (%"not_full%", EN_RT_CHECK);%N%T}")
			end
		end

	generate_fill_with_precondition (buffer: GENERATION_BUFFER; final_mode: BOOLEAN; start_index, end_index: STRING)
			-- Generate precondition for `fill_with' where indexes are stored in `start_index' and `end_index'.
		require
			buffer_not_void: buffer /= Void
			start_index_not_void: start_index /= Void
			end_index_not_void: end_index /= Void
		do
			if not final_mode or else associated_class.assertion_level.is_precondition then
					-- First we check that `start_index >= 0'.
				buffer.put_new_line
				buffer.put_string ("if (")
				buffer.put_string (start_index)
				buffer.put_string (" < 0) {%N%T%Teraise (%"start_index_non_negative%", EN_RT_CHECK);%N%T}")
					-- Then we check that `start_index <= count'
				buffer.put_new_line
				buffer.put_string ("if (")
				buffer.put_string (start_index)
				buffer.put_three_character (' ', '>', ' ')
				buffer.put_string ("RT_SPECIAL_CAPACITY(Current)) {")
				buffer.put_string ("%N%T%Teraise (%"start_index_in_bound%", EN_RT_CHECK);%N%T}")
					-- Then we check `start_index <= end_index + 1'
				buffer.put_new_line
				buffer.put_string ("if (")
				buffer.put_string (start_index)
				buffer.put_four_character (' ', '>', ' ', '(')
				buffer.put_string (end_index)
				buffer.put_string (" + 1)) {")
				buffer.put_string ("%N%T%Teraise (%"start_index_not_too_big%", EN_RT_CHECK);%N%T}")
				-- Finally we check that `end_index < capacity'
				buffer.put_new_line
				buffer.put_string ("if (")
				buffer.put_string (end_index)
				buffer.put_four_character (' ', '>', '=', ' ')
				buffer.put_string ("RT_SPECIAL_CAPACITY(Current)) {")
				buffer.put_string ("%N%T%Teraise (%"end_index_valid%", EN_RT_CHECK);%N%T}")
			end
		end

feature -- IL code generation

	prepare_generate_il (name_id: INTEGER; special_type: CL_TYPE_A)
			-- Generate call to `name_id' from SPECIAL so that it is
			-- very efficient.
		require
			valid_name_id:
				name_id = {PREDEFINED_NAMES}.Item_name_id or
				name_id = {PREDEFINED_NAMES}.Infix_at_name_id or
				name_id = {PREDEFINED_NAMES}.at_name_id or
				name_id = {PREDEFINED_NAMES}.Put_name_id
			special_type_not_void: special_type /= Void
			has_generics: type.generics /= Void
			good_generic_count: type.generics.count = 1
		local
			l_native_array: ATTRIBUTE_I
		do
				-- Get `native_array' field info.
			l_native_array ?= associated_class.feature_table.item_id (
				{PREDEFINED_NAMES}.internal_native_array_name_id)
			check
				l_native_array_not_void: l_native_array /= Void
			end

				-- Load `native_array' on stack.
			Il_generator.generate_attribute (True, special_type, l_native_array.feature_id)
		end

	generate_il (name_id: INTEGER; special_type, a_context_type: CL_TYPE_A)
			-- Generate call to `name_id' from SPECIAL so that it is
			-- very efficient.
		require
			valid_name_id:
				name_id = {PREDEFINED_NAMES}.Item_name_id or
				name_id = {PREDEFINED_NAMES}.Infix_at_name_id or
				name_id = {PREDEFINED_NAMES}.at_name_id or
				name_id = {PREDEFINED_NAMES}.Put_name_id
			special_type_not_void: special_type /= Void
			special_is_indeed_special: special_type.base_class.is_special
			a_context_type_not_void: a_context_type /= Void
			has_generics: type.generics /= Void
			good_generic_count: type.generics.count = 1
		local
			l_native_array: ATTRIBUTE_I
			l_native_array_type: CL_TYPE_A
			l_element_type: TYPE_A
			l_index, l_element: INTEGER
			l_native_array_class_type: NATIVE_ARRAY_CLASS_TYPE
		do
				-- Get `native_array' field info.
			l_native_array ?= associated_class.feature_table.item_id ({PREDEFINED_NAMES}.internal_native_array_name_id)
			check
				l_native_array_not_void: l_native_array /= Void
			end

				-- Let's evaluate type of NATIVE_ARRAY
			l_native_array_type ?= l_native_array.type.instantiated_in (special_type).actual_type
			check
				l_native_array_type_not_void: l_native_array_type /= Void
				l_native_array_has_type: l_native_array_type.has_associated_class_type (a_context_type)
			end

				-- Call feature from NATIVE_ARRAY
			l_native_array_class_type ?= l_native_array_type.associated_class_type (a_context_type)
			check
				l_native_array_class_type_not_void: l_native_array_class_type /= Void
			end

			if name_id = {PREDEFINED_NAMES}.Put_name_id then
					-- Because `put' from SPECIAL and `put' from NATIVE_ARRAY
					-- have their argument inverted, we need to swap the two
					-- elements on top of the stack.
				check
						-- Since `special_type' is a SPECIAL instances, it must have some generics.
					has_generics: special_type.generics /= Void
					valid_index: special_type.generics.valid_index (1)
				end
				l_element_type := special_type.generics.first
				if l_element_type.is_formal and not first_generic.is_formal then
						-- Type that was provided to us didn't have much type information, we have
						-- to rely on what we have from `Current' if it is not formal.
					l_element_type := first_generic
				end

					-- Variable to store element to be stored in SPECIAL
				Byte_context.add_local (l_element_type)
				l_element := Byte_context.local_list.count
				il_generator.put_dummy_local_info (l_element_type, l_element)

					-- Variable to store index where element will be stored in SPECIAL.
				Byte_context.add_local (integer_32_type)
				l_index := Byte_context.local_list.count
				il_generator.put_dummy_local_info (integer_32_type, l_index)

				Il_generator.generate_local_assignment (l_index)
				Il_generator.generate_local_assignment (l_element)
				Il_generator.generate_local (l_index)
				l_native_array_class_type.generate_il_put_preparation (l_native_array_type, a_context_type)
				Il_generator.generate_local (l_element)
			end
			l_native_array_class_type.generate_il (name_id, l_native_array_type, a_context_type)
		end

note
	copyright:	"Copyright (c) 1984-2013, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
