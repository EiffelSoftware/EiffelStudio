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

feature -- Byte code generation

	make_creation_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for creation of a special instance.
		require
			ba_not_void: ba /= Void
		local
			gen_param: TYPE_I
			expanded_type: CL_TYPE_I
			l_bit: BIT_I
			l_param_is_expanded: BOOLEAN
			type_c: TYPE_C
			final_mode: BOOLEAN
		do
			gen_param := first_generic
			l_param_is_expanded := gen_param.is_true_expanded
			final_mode := byte_context.final_mode
			type_c := gen_param.c_type

			ba.append_boolean (gen_param.is_reference)
			ba.append_boolean (gen_param.is_basic)
			ba.append_boolean (gen_param.is_bit)
			ba.append_boolean (l_param_is_expanded)
			if l_param_is_expanded then
				expanded_type ?= gen_param
				check
					expanded_type_not_void: expanded_type /= Void
				end
				ba.append_short_integer (expanded_type.associated_class_type.static_type_id - 1)
			else
				ba.append_uint32_integer (gen_param.sk_value)
			end
			if gen_param.is_bit then
					-- Initialize array of bits with default values
				l_bit ?= gen_param
				ba.append_uint32_integer (l_bit.size)
			end
		end

feature -- C code generation

	generate_creation (buffer: GENERATION_BUFFER; info: CREATE_INFO; target_register, nb_register: REGISTRABLE) is
			-- Generate creation of a special instance using `info' to get the exact type
			-- to create.
		require
			buffer_not_void: buffer /= Void
			info_not_void: info /= Void
			target_register_not_void: target_register /= Void
			nb_register_not_void: nb_register /= Void
		local
			gen_param: TYPE_I
			expanded_type: CL_TYPE_I
			l_exp_class_type: CLASS_TYPE
			l_exp_has_references: BOOLEAN
			l_bit: BIT_I
			l_param_is_expanded: BOOLEAN
			type_c: TYPE_C
			final_mode: BOOLEAN
		do
			gen_param := first_generic
			l_param_is_expanded := gen_param.is_true_expanded
			final_mode := byte_context.final_mode
			type_c := gen_param.c_type

				-- Check validity of call
			if not final_mode or else associated_class.assertion_level.check_precond then
				buffer.put_string ("if (")
				nb_register.print_register
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
				expanded_type ?= gen_param
				check
					expanded_type_not_void: expanded_type /= Void
				end
				l_exp_class_type := expanded_type.associated_class_type
				l_exp_has_references := l_exp_class_type.skeleton.has_references
			end

				-- Generate recipient of newly created SPECIAL instance.
			target_register.print_register

				-- 1. Dynamic type with flags
			buffer.put_string (" = RTLNSP(")
			info.generate_type_id (buffer, final_mode)
			if gen_param.is_reference or else l_exp_has_references or else gen_param.is_bit then
				buffer.put_string (" | EO_REF")
			end
			if l_param_is_expanded then
				buffer.put_string (" | EO_COMP")
			end
			buffer.put_string (", ")

				-- 2. Number of elements
			nb_register.print_register
			buffer.put_string (", ")

				-- 3. Element size
			if l_param_is_expanded then
				if final_mode then
					l_exp_class_type.skeleton.generate_size (buffer)
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
				nb_register.print_register
				buffer.put_string ("; i++) {")
				buffer.put_new_line
				buffer.indent
				buffer.put_string ("*((EIF_REFERENCE *) ")
				target_register.print_register
				buffer.put_string (" + i) = RTLB(")
				buffer.put_integer (l_bit.size)
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
			buffer.put_new_line
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
			consistency: feat.feature_name_id = {PREDEFINED_NAMES}.put_name_id;
		local
			gen_param: TYPE_I;
			expanded_type: CL_TYPE_I;
			l_exp_class_type: CLASS_TYPE
			l_param_is_expanded: BOOLEAN;
			type_c: TYPE_C;
			final_mode: BOOLEAN;
			encoded_name: STRING;
		do
			gen_param := first_generic;
			l_param_is_expanded := gen_param.is_true_expanded;
			type_c := gen_param.c_type;

			buffer.put_string ("/* put */%N");
			encoded_name := Encoder.feature_name (static_type_id, feat.body_index);

			System.used_features_log_file.add (Current, "put", encoded_name);

			buffer.generate_function_signature ("void", encoded_name, True,
				Byte_context.header_buffer, <<"Current", "arg1", "arg2">>,
				<<"EIF_REFERENCE", type_c.c_string, "EIF_INTEGER">>);

			final_mode := byte_context.final_mode;

			if not final_mode and then l_param_is_expanded then
				buffer.put_string ("%
					%%Tif (arg1 == (EIF_REFERENCE) 0)%N%
					%%T%TRTEC(EN_VEXP);%N");
			end;

			generate_precondition (buffer, final_mode, "arg2")

			if l_param_is_expanded then
				if final_mode then
					expanded_type ?= gen_param;
					l_exp_class_type := expanded_type.associated_class_type
					if l_exp_class_type.skeleton.has_references then
							-- Optimization: size is know at compile time
						buffer.put_string ("%Tecopy(arg1, Current + OVERHEAD + arg2 * (");
						l_exp_class_type.skeleton.generate_size (buffer)
						buffer.put_string (" + OVERHEAD));%N")
					else
							-- No references, do a simple `memcpy'.
						buffer.put_string ("%Tmemcpy(Current + arg2 * ");
						l_exp_class_type.skeleton.generate_size (buffer)
						buffer.put_string (", arg1, ")
						l_exp_class_type.skeleton.generate_size (buffer)
						buffer.put_string (");%N")
					end
				else
					buffer.put_string ("%Tecopy(arg1, Current + OVERHEAD + arg2 * (");
					buffer.put_string ("*(EIF_INTEGER *) (Current + %
						%(HEADER(Current)->ov_size & B_SIZE) - LNGPAD(2) + %
						%sizeof(EIF_INTEGER))));%N")
				end
			else
				buffer.put_string ("%T*(")
				type_c.generate_access_cast (buffer)
				buffer.put_string (" Current + arg2) = arg1;")
				if type_c.level = c_ref then
					buffer.put_string ("%TRTAR(Current, arg1);%N");
				end;
			end;

			buffer.put_string ("%N}%N%N");
		end;

	generate_item (feat: FEATURE_I; buffer: GENERATION_BUFFER) is
			-- Generates built-in feature `item' of class SPECIAL
		require
			good_argument: buffer /= Void;
			feat_exists: feat /= Void;
			consistency: feat.feature_name_id = {PREDEFINED_NAMES}.item_name_id or
				feat.feature_name_id = {PREDEFINED_NAMES}.infix_at_name_id
		local
			gen_param: TYPE_I;
			expanded_type: CL_TYPE_I;
			l_exp_class_type: CLASS_TYPE
			l_param_is_expanded: BOOLEAN;
			type_c: TYPE_C;
			final_mode: BOOLEAN;
			encoded_name: STRING
			l_exp_has_references: BOOLEAN
		do
			gen_param := first_generic;
			l_param_is_expanded := gen_param.is_true_expanded;
			type_c := gen_param.c_type;

			buffer.put_string ("/* item */%N");

			encoded_name := Encoder.feature_name (static_type_id, feat.body_index);

			System.used_features_log_file.add (Current, "item", encoded_name);

			buffer.generate_function_signature (type_c.c_string, encoded_name, True,
				byte_context.header_buffer,
				<<"Current", "arg1">>, <<"EIF_REFERENCE", "EIF_INTEGER">>);

			final_mode := byte_context.final_mode;

			if l_param_is_expanded and final_mode then
				expanded_type ?= gen_param;
				l_exp_class_type := expanded_type.associated_class_type
				l_exp_has_references := l_exp_class_type.skeleton.has_references
				if not l_exp_has_references then
					buffer.indent
					buffer.put_string ("EIF_REFERENCE Result;")
					buffer.put_new_line
				end
			end

			generate_precondition (buffer, final_mode, "arg1")

			if l_param_is_expanded then
				if final_mode then
						-- Optimization: size of expanded is known at compile time
					if l_exp_has_references then
						buffer.put_string ("%Treturn RTCL(Current + OVERHEAD + arg1 * (");
						l_exp_class_type.skeleton.generate_size (buffer)
						buffer.put_string (" + OVERHEAD));%N")
					else
						buffer.put_string ("RTLD;")
						buffer.put_new_line
						buffer.put_string ("RTLI(1);")
						buffer.put_new_line
						buffer.put_string ("RTLR(0, Current);")
						buffer.put_new_line
						expanded_type.generate_expanded_creation (buffer, "Result")
						buffer.put_string ("memcpy (Result, ")
						buffer.put_string ("Current + arg1 * (");
						l_exp_class_type.skeleton.generate_size (buffer)
						buffer.put_string ("), ")
						l_exp_class_type.skeleton.generate_size (buffer)
						buffer.put_string (");")
						buffer.put_new_line
						buffer.put_string ("RTLE;")
						buffer.put_new_line
						buffer.put_string ("return Result;")
						buffer.exdent
					end
				else
					buffer.put_string ("%Treturn RTCL(Current + OVERHEAD + arg1 * (");
					buffer.put_string ("*(EIF_INTEGER *) (Current + %
						%(HEADER(Current)->ov_size & B_SIZE) - LNGPAD(2) + %
						%sizeof(EIF_INTEGER))));%N")
				end
			else
				buffer.put_string ("%Treturn *(")
				type_c.generate_access_cast (buffer)
				buffer.put_string (" Current + arg1);")
			end;

			buffer.put_string ("%N}%N%N");
		end;

	generate_item_address (feat: FEATURE_I; buffer: GENERATION_BUFFER) is
			-- Generates built-in feature `item_address' of class SPECIAL
		require
			good_argument: buffer /= Void;
			feat_exists: feat /= Void;
			consistency: feat.feature_name_id = {PREDEFINED_NAMES}.item_address_name_id
		local
			result_type, gen_param: TYPE_I;
			l_param_is_expanded: BOOLEAN;
			type_c: TYPE_C;
			encoded_name: STRING
			expanded_type: CL_TYPE_I
			l_exp_class_type: CLASS_TYPE
		do
			gen_param := first_generic;
			l_param_is_expanded := gen_param.is_true_expanded;
			type_c := gen_param.c_type;

			buffer.put_string ("/* item_address */%N");

			result_type := feat.type.type_i.instantiation_in (Current)

			encoded_name := Encoder.feature_name (static_type_id, feat.body_index);

			System.used_features_log_file.add (Current, "item_address", encoded_name);

			buffer.generate_function_signature (result_type.c_type.c_string, encoded_name, True,
				byte_context.header_buffer,
				<<"Current", "arg1">>, <<"EIF_REFERENCE", "EIF_INTEGER">>);

			generate_precondition (buffer, byte_context.final_mode, "arg1")

			buffer.put_string ("%Treturn ")
			result_type.c_type.generate_cast (buffer)
			buffer.put_string ("(Current + ")
			if l_param_is_expanded then
				if byte_context.final_mode then
					expanded_type ?= gen_param
					l_exp_class_type := expanded_type.associated_class_type
						-- It is set to True because at the moment we need a header in
						-- order to call inherited features in an expanded class. This is
						-- necessary until we are able to do a flat code generation for
						-- expanded.
					if True or l_exp_class_type.skeleton.has_references then
						buffer.put_string ("OVERHEAD + arg1 * (")
						l_exp_class_type.skeleton.generate_size (buffer)
						buffer.put_string (" + OVERHEAD));")
					else
						buffer.put_string ("arg1 * ")
						l_exp_class_type.skeleton.generate_size (buffer)
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
			buffer.put_string ("%N}%N%N");
		end;

	generate_base_address (feat: FEATURE_I; buffer: GENERATION_BUFFER) is
			-- Generates built-in feature `base_address' of class SPECIAL
		require
			good_argument: buffer /= Void;
			feat_exists: feat /= Void;
			consistency: feat.feature_name_id = {PREDEFINED_NAMES}.base_address_name_id
		local
			gen_param, result_type: TYPE_I;
			l_param_is_expanded: BOOLEAN;
			type_c: TYPE_C;
			final_mode: BOOLEAN;
			encoded_name: STRING
		do
			gen_param := first_generic;
			l_param_is_expanded := gen_param.is_true_expanded;
			type_c := gen_param.c_type;

			buffer.put_string ("/* base_address */%N");

			result_type := feat.type.type_i.instantiation_in (Current)

			encoded_name := Encoder.feature_name (static_type_id, feat.body_index);

			System.used_features_log_file.add (Current, "base_address", encoded_name);

			buffer.generate_function_signature (result_type.c_type.c_string, encoded_name, True,
				byte_context.header_buffer,
				<<"Current">>, <<"EIF_REFERENCE">>);

			final_mode := byte_context.final_mode;

			buffer.put_string ("%Treturn ")
			result_type.c_type.generate_cast (buffer)
			buffer.put_string (" Current;")

			buffer.put_string ("%N}%N%N");
		end;

	generate_precondition (buffer: GENERATION_BUFFER; final_mode: BOOLEAN; arg_name: STRING) is
			-- Generate precondition for `item', `put' and `item_address' where index
			-- is stored in `arg_name'.
		require
			buffer_not_void: buffer /= Void
			arg_name_not_void: arg_name /= Void
		do
			if final_mode and then associated_class.assertion_level.check_precond then
				buffer.put_string ("%Tif (~in_assertion) {%N");
				buffer.put_string ("%
					%%TRTCT(%"index_large_enough%", EX_PRE);%N%
					%%Tif (")
				buffer.put_string (arg_name)
				buffer.put_string (">= 0) {%N%
					%%T%TRTCK;%N%
					%%T} else {%N%
					%%T%TRTCF;%N%T}%N");

				buffer.put_string ("%
					%%TRTCT(%"index_small_enough%", EX_PRE);%N%
					%%Tif (")
				buffer.put_string (arg_name)
				buffer.put_string ("< *(EIF_INTEGER *) %
						%(Current + (HEADER(Current)->ov_size & B_SIZE)%
						% - LNGPAD(2))) {%N%
					%%T%TRTCK;%N%
					%%T} else {%N%
					%%T%TRTCF;%N%T}%N");

				buffer.put_string ("%T}%N");
			elseif not final_mode then
				buffer.put_string ("%
					%%Tif (")
				buffer.put_string (arg_name)
				buffer.put_string ("< 0) {%N%
					%%T%Teraise (%"index_large_enough%", EN_RT_CHECK);%N%T}%N");

				buffer.put_string ("%
					%%Tif (")
				buffer.put_string (arg_name)
				buffer.put_string (">= *(EIF_INTEGER *) %
						%(Current + (HEADER(Current)->ov_size & B_SIZE)%
						% - LNGPAD(2))) {%N%
					%%T%Teraise (%"index_small_enough%", EN_RT_CHECK);%N%T}%N");
			end
		end

feature -- IL code generation

	prepare_generate_il (name_id: INTEGER; special_type: CL_TYPE_I) is
			-- Generate call to `name_id' from SPECIAL so that it is
			-- very efficient.
		require
			valid_name_id:
				name_id = {PREDEFINED_NAMES}.Item_name_id or
				name_id = {PREDEFINED_NAMES}.Infix_at_name_id or
				name_id = {PREDEFINED_NAMES}.Put_name_id
			special_type_not_void: special_type /= Void
			has_generics: type.true_generics /= Void
			good_generic_count: type.true_generics.count = 1
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

	generate_il (name_id: INTEGER; special_type: CL_TYPE_I) is
			-- Generate call to `name_id' from SPECIAL so that it is
			-- very efficient.
		require
			valid_name_id:
				name_id = {PREDEFINED_NAMES}.Item_name_id or
				name_id = {PREDEFINED_NAMES}.Infix_at_name_id or
				name_id = {PREDEFINED_NAMES}.Put_name_id
			special_type_not_void: special_type /= Void
			has_generics: type.true_generics /= Void
			good_generic_count: type.true_generics.count = 1
		local
			l_native_array: ATTRIBUTE_I
			l_native_array_type: CL_TYPE_I
			l_element_type: TYPE_I
			l_index, l_element: INTEGER
			l_native_array_class_type: NATIVE_ARRAY_CLASS_TYPE
		do
				-- Get `native_array' field info.
			l_native_array ?= associated_class.feature_table.item_id ({PREDEFINED_NAMES}.internal_native_array_name_id)
			check
				l_native_array_not_void: l_native_array /= Void
			end

				-- Let's evaluate type of NATIVE_ARRAY			
			l_native_array_type ?= Byte_context.real_type_in (l_native_array.type.type_i, Current)
			check
				l_native_array_type_not_void: l_native_array_type /= Void
			end

				-- Call feature from NATIVE_ARRAY
			l_native_array_class_type ?= l_native_array_type.associated_class_type
			check
				l_native_array_class_not_void: l_native_array_type /= Void
			end

			if name_id = {PREDEFINED_NAMES}.Put_name_id then
					-- Because `put' from SPECIAL and `put' from NATIVE_ARRAY
					-- have their argument inverted, we need to swap the two
					-- elements on top of the stack.
				l_element_type := first_generic

					-- Variable to store element to be stored in SPECIAL
				Byte_context.add_local (l_element_type)
				l_element := Byte_context.local_list.count
				il_generator.put_dummy_local_info (l_element_type, l_element)

					-- Variable to store index where element will be stored in SPECIAL.
				Byte_context.add_local (int32_c_type)
				l_index := Byte_context.local_list.count
				il_generator.put_dummy_local_info (int32_c_type, l_index)

				Il_generator.generate_local_assignment (l_index)
				Il_generator.generate_local_assignment (l_element)
				Il_generator.generate_local (l_index)
				l_native_array_class_type.generate_il_put_preparation (l_native_array_type)
				Il_generator.generate_local (l_element)
			end
			l_native_array_class_type.generate_il (name_id, l_native_array_type)
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
