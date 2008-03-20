indexing
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

	is_any_array: BOOLEAN is
			-- Is Current an array of ANY?
		local
			any_type: CL_TYPE_A
		do
			create any_type.make (System.any_id)
			Result := first_generic.same_as (any_type)
		end

feature -- Access

	first_generic: TYPE_A is
			-- First generic parameter type
		require
			has_generics: type.generics /= Void;
			good_generic_count: type.generics.count = 1;
		do
				-- No need to call `meta_type' here since this must have been done already when
				-- creating `type'.
			Result := type.generics.item (1)
		end

	type: GEN_TYPE_A
			-- Type of the class. It includes meta-instantiation of possible
			-- generic parameters.

feature -- Byte code generation

	make_creation_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for creation of a special instance.
		require
			ba_not_void: ba /= Void
		local
			gen_param: TYPE_A
			l_bit: BITS_A
			l_param_is_expanded: BOOLEAN
			final_mode: BOOLEAN
		do
			gen_param := first_generic
			l_param_is_expanded := gen_param.is_true_expanded
			final_mode := byte_context.final_mode

			ba.append_boolean (not gen_param.is_expanded)
			ba.append_boolean (gen_param.is_basic)
			ba.append_boolean (gen_param.is_bit)
			ba.append_boolean (l_param_is_expanded)
			if l_param_is_expanded then
				ba.append_short_integer (gen_param.static_type_id (Void) - 1)
			else
				ba.append_uint32_integer (gen_param.sk_value (Void))
			end
			if gen_param.is_bit then
					-- Initialize array of bits with default values
				l_bit ?= gen_param
				ba.append_uint32_integer (l_bit.bit_count)
			end
		end

feature -- C code generation

	generate_creation (buffer: GENERATION_BUFFER; info: CREATE_INFO; target_register: REGISTRABLE; nb_register: PARAMETER_BL) is
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
			l_bit: BITS_A
			l_param_is_expanded: BOOLEAN
			type_c: TYPE_C
			final_mode: BOOLEAN
		do
			gen_param := first_generic
			l_param_is_expanded := gen_param.is_true_expanded
			final_mode := byte_context.final_mode
			type_c := gen_param.c_type

				-- Check validity of call
			if not final_mode or else associated_class.assertion_level.is_precondition then
				buffer.put_new_line
				buffer.put_string ("if (")
				nb_register.print_immediate_register
				buffer.put_string ("< 0) {")
				buffer.put_new_line
				buffer.indent
				buffer.put_string ("eraise (%"non_negative_argument%", EN_RT_CHECK);")
				buffer.put_new_line
				buffer.exdent
				buffer.put_character ('}')
				buffer.put_new_line
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
			if not gen_param.is_expanded or else l_exp_has_references or else gen_param.is_bit then
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
					buffer.put_string("(EIF_Size(RTUD(")
					buffer.put_static_type_id (l_exp_class_type.static_type_id)
					buffer.put_string (")) + OVERHEAD)")
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

			if gen_param.is_bit then
					-- Initialize array of bits with default values
				shared_include_queue.put (Names_heap.eif_plug_header_name_id)
				l_bit ?= gen_param
				buffer.put_new_line
				buffer.put_character ('{')
				buffer.indent
				buffer.put_new_line
				buffer.put_string ("EIF_INTEGER i;")
				buffer.put_new_line
				buffer.put_string ("for (i = 0; i < ")
				nb_register.print_immediate_register
				buffer.put_string ("; i++) {")
				buffer.put_new_line
				buffer.indent
				buffer.put_string ("*((EIF_REFERENCE *) ")
				target_register.print_register
				buffer.put_string (" + i) = RTLB(")
				buffer.put_integer (l_bit.bit_count)
				buffer.put_string (");")
				buffer.put_new_line
				buffer.put_string ("RTAR(")
				target_register.print_register
				buffer.put_string (", *((EIF_REFERENCE *) ")
				target_register.print_register
				buffer.put_string (" + i));")
				buffer.put_new_line
				buffer.exdent
				buffer.put_character ('}')
				buffer.put_new_line
				buffer.exdent
				buffer.put_character ('}')
			end
		end

	generate_feature (feat: FEATURE_I; buffer: GENERATION_BUFFER) is
			-- Generate feature `feat' in `buffer'.
		local
			f_name_id: INTEGER
		do
			f_name_id := feat.feature_name_id

			inspect feat.feature_name_id
			when {PREDEFINED_NAMES}.put_name_id then
					-- Generate built-in feature `put' of class SPECIAL
				generate_put (feat, buffer)
			when
				{PREDEFINED_NAMES}.item_name_id,
				{PREDEFINED_NAMES}.infix_at_name_id
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
					Precursor {CLASS_TYPE} (feat, buffer)
				else
					generate_clear_all (feat, buffer)
				end

			else
					-- Basic generation
				Precursor {CLASS_TYPE} (feat, buffer);
			end;
		end;

feature {NONE} -- C code generation

	generate_put (feat: FEATURE_I; buffer: GENERATION_BUFFER) is
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
				index_type_name := "EIF_INTEGER"
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
				if not type_c.is_pointer then
					buffer.put_new_line
					buffer.put_string ("if (arg1x.type == SK_REF) arg1x.")
					type_c.generate_typed_field (buffer)
					buffer.put_string (" = * ")
					type_c.generate_access_cast (buffer)
					buffer.put_string ("arg1x.it_r;")
				end
				buffer.put_new_line
				buffer.put_string ("if (arg2x.type == SK_REF) arg2x.it_i4 = * (EIF_INTEGER_32 *) arg2x.it_r;")
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
				if gen_param.c_type.is_pointer then
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
							-- Optimization: size is know at compile time
						buffer.put_string ("ecopy(arg1, Current + OVERHEAD + arg2 * (");
						l_exp_class_type.skeleton.generate_size (buffer, True)
						buffer.put_string (" + OVERHEAD));")
					else
							-- No references, do a simple `memcpy'.
						buffer.put_new_line
						buffer.put_string ("memcpy(Current + arg2 * ")
						l_exp_class_type.skeleton.generate_size (buffer, True)
						buffer.put_string (", arg1, ")
						l_exp_class_type.skeleton.generate_size (buffer, True)
						buffer.put_string (");")
					end
				else
					buffer.put_new_line
					buffer.put_string ("ecopy(arg1, Current + OVERHEAD + arg2 * (%
						%*(EIF_INTEGER *) (Current + %
						%(HEADER(Current)->ov_size & B_SIZE) - LNGPAD(2) + %
						%sizeof(EIF_INTEGER))));")
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
					<<"EIF_REFERENCE", "EIF_REFERENCE", "EIF_INTEGER">>)
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

	generate_item (feat: FEATURE_I; buffer: GENERATION_BUFFER) is
			-- Generates built-in feature `item' of class SPECIAL
		require
			good_argument: buffer /= Void
			feat_exists: feat /= Void
			consistency: feat.feature_name_id = {PREDEFINED_NAMES}.item_name_id or
				feat.feature_name_id = {PREDEFINED_NAMES}.infix_at_name_id
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
				arg_type_name := "EIF_INTEGER"
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
				buffer.put_string ("if (arg1x.type == SK_REF) arg1x.it_i4 = * (EIF_INTEGER_32 *) arg1x.it_r;")
				buffer.put_new_line_only
				buffer.put_string ("#define arg1 arg1x.it_i4")
			end

			generate_precondition (buffer, final_mode, "arg1")

			buffer.put_new_line
			if l_param_is_expanded then
				if final_mode then
						-- Optimization: size of expanded is known at compile time
					if l_exp_has_references then
						buffer.put_string ("return RTCL(Current + OVERHEAD + arg1 * (")
						l_exp_class_type.skeleton.generate_size (buffer, True)
						buffer.put_string (" + OVERHEAD));")
					else
						buffer.generate_block_open
						buffer.put_new_line
						buffer.put_string ("RTLD;")
						buffer.put_new_line
						buffer.put_string ("RTLI(1);")
						buffer.put_new_line
						buffer.put_string ("RTLR(0, Current);")
							-- Create expanded type based on the actual generic parameter, and not
							-- on the recorded derivation (as it would not work if `gen_param' is
							-- generic. (See eweasel test#exec282 for an example where it does not work).
						l_exp_class_type.generate_expanded_creation (buffer, "Result", create {FORMAL_A}.make (False, False, 1), Current)
						buffer.put_new_line
						buffer.put_string ("memcpy (Result, ")
						buffer.put_string ("Current + arg1 * (")
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
					buffer.put_string (" = RTCL(Current + OVERHEAD + arg1 * (%
						%*(EIF_INTEGER *) (Current + %
						%(HEADER(Current)->ov_size & B_SIZE) - LNGPAD(2) + %
						%sizeof(EIF_INTEGER))));%N")
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
					<<"EIF_REFERENCE", "EIF_INTEGER">>)
				buffer.generate_block_open
				basic_i ?= gen_param
				buffer.put_new_line
				if basic_i = Void then
					buffer.put_string ("return ")
				else
					buffer.put_string ("EIF_REFERENCE Result;")
					buffer.put_new_line
					basic_i.c_type.generate (buffer)
					buffer.put_string ("r = ")
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

	generate_item_address (feat: FEATURE_I; buffer: GENERATION_BUFFER) is
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
				index_type_name := "EIF_INTEGER"
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
				buffer.put_string ("if (arg1x.type == SK_REF) arg1x.it_i4 = * (EIF_INTEGER_32 *) arg1x.it_r;")
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
						buffer.put_string ("OVERHEAD + arg1 * (")
						l_exp_class_type.skeleton.generate_size (buffer, True)
						buffer.put_string (" + OVERHEAD));")
					else
						buffer.put_string ("arg1 * ")
						l_exp_class_type.skeleton.generate_size (buffer, True)
						buffer.put_character (')')
						buffer.put_character (';')
					end
				else
					buffer.put_string ("OVERHEAD + arg1 * sp_elem_size (Current));")
				end
			else
				buffer.put_string ("arg1 * sizeof(")
				type_c.generate (buffer)
				buffer.put_string ("));")
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

	generate_base_address (feat: FEATURE_I; buffer: GENERATION_BUFFER) is
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

	generate_clear_all (feat: FEATURE_I; buffer: GENERATION_BUFFER) is
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
			buffer.put_string ("memset (Current, 0, (HEADER(Current)->ov_size & B_SIZE) - LNGPAD_2);")
			buffer.generate_block_close
				-- Separation for formatting
			buffer.put_new_line
			byte_context.clear_feature_data
		end

	generate_precondition (buffer: GENERATION_BUFFER; final_mode: BOOLEAN; arg_name: STRING) is
			-- Generate precondition for `item', `put' and `item_address' where index
			-- is stored in `arg_name'.
		require
			buffer_not_void: buffer /= Void
			arg_name_not_void: arg_name /= Void
		do
			if not final_mode then
				buffer.put_new_line
				buffer.put_string ("%
					%if (")
				buffer.put_string (arg_name)
				buffer.put_string ("< 0) {%N%
					%%Teraise (%"index_large_enough%", EN_RT_CHECK);%N%T}%N");

				buffer.put_string ("%
					%if (")
				buffer.put_string (arg_name)
				buffer.put_string (">= *(EIF_INTEGER *) %
						%(Current + (HEADER(Current)->ov_size & B_SIZE)%
						% - LNGPAD(2))) {%N%
					%%Teraise (%"index_small_enough%", EN_RT_CHECK);%N}");
			elseif associated_class.assertion_level.is_precondition then
				buffer.put_new_line
				buffer.put_string ("if (~in_assertion) {%N");
				buffer.put_string ("%
					%RTCT(%"index_large_enough%", EX_PRE);%N%
					%if (")
				buffer.put_string (arg_name)
				buffer.put_string (">= 0) {%N%
					%%TRTCK;%N%
					%} else {%N%
					%%TRTCF;%N}%N");

				buffer.put_string ("%
					%RTCT(%"index_small_enough%", EX_PRE);%N%
					%if (")
				buffer.put_string (arg_name)
				buffer.put_string ("< *(EIF_INTEGER *) %
						%(Current + (HEADER(Current)->ov_size & B_SIZE)%
						% - LNGPAD(2))) {%N%
					%%TRTCK;%N%
					%} else {%N%
					%%TRTCF;%N}%N");

				buffer.put_string ("}");
			end
		end

feature -- IL code generation

	prepare_generate_il (name_id: INTEGER; special_type: CL_TYPE_A) is
			-- Generate call to `name_id' from SPECIAL so that it is
			-- very efficient.
		require
			valid_name_id:
				name_id = {PREDEFINED_NAMES}.Item_name_id or
				name_id = {PREDEFINED_NAMES}.Infix_at_name_id or
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

	generate_il (name_id: INTEGER; special_type, a_context_type: CL_TYPE_A) is
			-- Generate call to `name_id' from SPECIAL so that it is
			-- very efficient.
		require
			valid_name_id:
				name_id = {PREDEFINED_NAMES}.Item_name_id or
				name_id = {PREDEFINED_NAMES}.Infix_at_name_id or
				name_id = {PREDEFINED_NAMES}.Put_name_id
			special_type_not_void: special_type /= Void
			special_is_indeed_special: special_type.associated_class.is_special
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
				l_element_type := special_type.generics.item (1)
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
