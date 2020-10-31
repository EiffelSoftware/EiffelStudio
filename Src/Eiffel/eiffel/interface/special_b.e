note
	description: "Compiled class SPECIAL"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class SPECIAL_B

inherit
	EIFFEL_CLASS_C
		redefine
			check_validity, new_type, is_special
		end

	SPECIAL_CONST

create
	make

feature -- Validity

	check_validity
			-- Check validity of class SPECIAL
		local
			special_error: SPECIAL_ERROR
			feat_table: FEATURE_TABLE
			item_feature, put_feature, make_feature, to_array_feature: FEATURE_I
		do
				-- Check if class has one formal generic parameter
			if generics = Void or else generics.count /= 1 or else not is_frozen then
				create special_error.make (special_case_1, Current)
				Error_handler.insert_error (special_error)
			end

			feat_table := feature_table

				-- Check if class has a feature `make (INTEGER)' or `make_empty (INTEGER)'.
			if system.is_using_new_special then
				make_feature := feat_table.item_id ({PREDEFINED_NAMES}.make_empty_name_id)
				if
					make_feature = Void or else
					make_feature.written_in /= class_id or else
					not make_feature.same_signature (make_empty_signature) or else
					not has_creation_routine (make_feature)
				then
					create special_error.make (special_case_3, Current)
					Error_handler.insert_error (special_error)
				end
			else
				make_feature := feat_table.item_id ({PREDEFINED_NAMES}.make_name_id)
				if
					make_feature = Void or else
					make_feature.written_in /= class_id or else
					not make_feature.same_signature (make_signature) or else
					not has_creation_routine (make_feature)
				then
					create special_error.make (special_case_2, Current)
					Error_handler.insert_error (special_error)
				end
			end

				-- Check if class has a feature `make_filled (G#1, INTEGER)'
			make_feature := feat_table.item_id ({PREDEFINED_NAMES}.make_filled_name_id)
			if
				make_feature = Void or else
				make_feature.written_in /= class_id or else
				not make_feature.same_signature (make_filled_signature) or else
				not has_creation_routine (make_feature)
			then
				create special_error.make (special_case_4, Current)
				Error_handler.insert_error (special_error)
			end

				-- Check if class has a feature item (INTEGER): G#1
			item_feature := feat_table.item_id ({PREDEFINED_NAMES}.item_name_id)
			if item_feature = Void
				or else item_feature.written_in /= class_id
				or else not item_feature.same_signature (item_signature)
			then
				create special_error.make (special_case_5, Current)
				Error_handler.insert_error (special_error)
			end

				-- Check if class has a feature put (G#1, INTEGER)
			put_feature := feat_table.item_id ({PREDEFINED_NAMES}.put_name_id)
			if put_feature = Void
				or else put_feature.written_in /= class_id
				or else not put_feature.same_signature (put_signature)
			then
				create special_error.make (special_case_6, Current)
				Error_handler.insert_error (special_error)
			end

				-- Check if class has a feature to_array: ARRAY [G#1]
			to_array_feature := feat_table.item_id ({PREDEFINED_NAMES}.to_array_name_id)
			if to_array_feature = Void
				or else to_array_feature.written_in /= class_id
				or else not to_array_feature.same_signature (to_array_signature)
			then
				create special_error.make (special_case_7, Current)
				Error_handler.insert_error (special_error)
			end

			if system.il_generation then
				if
					not attached feat_table.item_id ({PREDEFINED_NAMES}.internal_native_array_name_id) as l_feat or else
					not l_feat.is_attribute or else not l_feat.type.actual_type.same_as (native_array_type)
				then
					create special_error.make (special_case_8, Current)
					error_handler.insert_error (special_error)
				end

				if system.is_using_new_special then
						-- Check if class has a feature extend (G#1, INTEGER)
					put_feature := feat_table.item_id ({PREDEFINED_NAMES}.extend_name_id)
					if put_feature = Void
						or else put_feature.written_in /= class_id
						or else not put_feature.same_signature (extend_signature)
					then
						create special_error.make (special_case_9, Current)
						Error_handler.insert_error (special_error)
					end
				end
			end
		end

feature -- Typing

	new_type (data: CL_TYPE_A): SPECIAL_CLASS_TYPE
			-- New class type for class SPECIAL
		local
			l_data: GEN_TYPE_A
		do
			l_data ?= data
			check
				l_data_not_void: l_data /= Void
			end
			create Result.make (l_data)
				-- Unlike the parent version, each time a new SPECIAL derivation
				-- is added we need to freeze so that we call the right version of
				-- `put' and `item'.
			system.request_freeze
			if already_compiled then
					-- Melt all the code written in the associated class of the new class type
				melt_all
			end
		end

feature -- Status report

	is_special: BOOLEAN = True
			-- Is class SPECIAL?

feature -- Code generation

	generate_dynamic_types (buffer: GENERATION_BUFFER)
			-- Generate dynamic types of type classes available in the system
		local
			class_type: CLASS_TYPE
			gen_type: GEN_TYPE_A
			gen_param: TYPE_A
			int_i: INTEGER_A
			nat_i: NATURAL_A
			dtype, char_dtype, uint8_dtype, uint16_dtype,
			uint32_dtype, uint64_dtype, int8_dtype, int16_dtype,
			int32_dtype, int64_dtype, wchar_dtype,
			real32_dtype, real64_dtype,
			pointer_dtype, boolean_dtype, ref_dtype: NATURAL_16
		do
			from
				char_dtype := {SHARED_GEN_CONF_LEVEL}.invalid_dtype
				wchar_dtype := {SHARED_GEN_CONF_LEVEL}.invalid_dtype
				uint8_dtype := {SHARED_GEN_CONF_LEVEL}.invalid_dtype
				uint16_dtype := {SHARED_GEN_CONF_LEVEL}.invalid_dtype
				uint32_dtype := {SHARED_GEN_CONF_LEVEL}.invalid_dtype
				uint64_dtype := {SHARED_GEN_CONF_LEVEL}.invalid_dtype
				int8_dtype := {SHARED_GEN_CONF_LEVEL}.invalid_dtype
				int16_dtype := {SHARED_GEN_CONF_LEVEL}.invalid_dtype
				int32_dtype := {SHARED_GEN_CONF_LEVEL}.invalid_dtype
				int64_dtype := {SHARED_GEN_CONF_LEVEL}.invalid_dtype
				real32_dtype := {SHARED_GEN_CONF_LEVEL}.invalid_dtype
				real64_dtype := {SHARED_GEN_CONF_LEVEL}.invalid_dtype
				boolean_dtype := {SHARED_GEN_CONF_LEVEL}.invalid_dtype
				pointer_dtype := {SHARED_GEN_CONF_LEVEL}.invalid_dtype
				ref_dtype := {SHARED_GEN_CONF_LEVEL}.invalid_dtype
				types.start
			until
				types.after
			loop
				class_type := types.item
				check valid_type: class_type.type_id > 0 and class_type.type_id <= {NATURAL_16}.max_value end
				dtype := (class_type.type_id - 1).as_natural_16
				gen_type ?= class_type.type
				gen_param := gen_type.generics.first
				if gen_param.is_character then
					if gen_param.is_character_32 then
						wchar_dtype := dtype
					else
						char_dtype := dtype
					end
				elseif gen_param.is_natural then
					nat_i ?= gen_param
					inspect nat_i.size
					when 8 then uint8_dtype := dtype
					when 16 then uint16_dtype := dtype
					when 32 then uint32_dtype := dtype
					when 64 then uint64_dtype := dtype
					end
				elseif gen_param.is_integer then
					int_i ?= gen_param
					inspect int_i.size
					when 8 then int8_dtype := dtype
					when 16 then int16_dtype := dtype
					when 32 then int32_dtype := dtype
					when 64 then int64_dtype := dtype
					end
				elseif gen_param.is_real_32 then
					real32_dtype := dtype
				elseif gen_param.is_real_64 then
					real64_dtype := dtype
				elseif gen_param.is_boolean then
					boolean_dtype := dtype
				elseif gen_param.is_pointer or gen_param.is_typed_pointer then
					pointer_dtype := dtype
				elseif not gen_param.is_expanded then
					ref_dtype := dtype
				end
				types.forth
			end
			buffer.put_string ("%N%Tegc_sp_char = ")
			buffer.put_hex_natural_16 (char_dtype)
			buffer.put_string (";%N%Tegc_sp_wchar = ")
			buffer.put_hex_natural_16 (wchar_dtype)
			buffer.put_string (";%N%Tegc_sp_bool = ")
			buffer.put_hex_natural_16 (boolean_dtype)
			buffer.put_string (";%N%Tegc_sp_uint8 = ")
			buffer.put_hex_natural_16 (uint8_dtype)
			buffer.put_string (";%N%Tegc_sp_uint16 = ")
			buffer.put_hex_natural_16 (uint16_dtype)
			buffer.put_string (";%N%Tegc_sp_uint32 = ")
			buffer.put_hex_natural_16 (uint32_dtype)
			buffer.put_string (";%N%Tegc_sp_uint64 = ")
			buffer.put_hex_natural_16 (uint64_dtype)
			buffer.put_string (";%N%Tegc_sp_int8 = ")
			buffer.put_hex_natural_16 (int8_dtype)
			buffer.put_string (";%N%Tegc_sp_int16 = ")
			buffer.put_hex_natural_16 (int16_dtype)
			buffer.put_string (";%N%Tegc_sp_int32 = ")
			buffer.put_hex_natural_16 (int32_dtype)
			buffer.put_string (";%N%Tegc_sp_int64 = ")
			buffer.put_hex_natural_16 (int64_dtype)
			buffer.put_string (";%N%Tegc_sp_real32 = ")
			buffer.put_hex_natural_16 (real32_dtype)
			buffer.put_string (";%N%Tegc_sp_real64 = ")
			buffer.put_hex_natural_16 (real64_dtype)
			buffer.put_string (";%N%Tegc_sp_pointer = ")
			buffer.put_hex_natural_16 (pointer_dtype)
			buffer.put_string (";%N%Tegc_sp_ref = ")
			buffer.put_hex_natural_16 (ref_dtype)
			buffer.put_string (";%N")
		end

feature {NONE} -- Implementation

	has_creation_routine (a_feature: FEATURE_I): BOOLEAN
			-- Check that `a_feature' is indeed a creation procedure.
		require
			a_feature_attached: a_feature /= Void
		do
			Result :=
				attached creators as cs and then
				across cs as c some c.key = a_feature.feature_name_id end
		end

	make_signature: DYN_PROC_I
			-- Required signature for feature `make' of class SPECIAL
		local
			args: FEAT_ARG
		do
			create args.make (1)
			args.extend (Integer_type)
			create Result
			Result.set_arguments (args)
			Result.set_feature_name_id (Names_heap.make_name_id, Void)
		ensure
			item_signature_not_void: Result /= Void
		end

	make_empty_signature: DYN_PROC_I
			-- Required signature for feature `make_empty' of class NATIVE_ARRAY.
		local
			args: FEAT_ARG
		do
			create  args.make (1)
			args.extend (Integer_type)
			create  Result
			Result.set_arguments (args)
			Result.set_feature_name_id ({PREDEFINED_NAMES}.make_empty_name_id, Void)
		end

	make_filled_signature: DYN_PROC_I
			-- Required signature for feature `make_filled' of class SPECIAL
		local
			args: FEAT_ARG
		do
			create args.make (2)
			args.extend (actual_type.generics [1])
			args.extend (Integer_type)
			create Result
			Result.set_arguments (args)
			Result.set_feature_name_id (Names_heap.make_filled_name_id, Void)
		ensure
			put_signature_not_void: Result /= Void
		end

	item_signature: DYN_FUNC_I
			-- Required signature for feature `item' of class SPECIAL
		local
			args: FEAT_ARG
		do
			create args.make (1)
			args.extend (Integer_type)
			create Result
			Result.set_arguments (args)
			Result.set_type (actual_type.generics [1], 0)
			Result.set_feature_name_id (Names_heap.item_name_id, Void)
		ensure
			item_signature_not_void: Result /= Void
		end

	to_array_signature: DYN_FUNC_I
			-- Required signature for feature `to_array' of class SPECIAL
		local
			l_gen_type: GEN_TYPE_A
			l_generics: ARRAYED_LIST [TYPE_A]
		do
			create Result
			create l_generics.make (1)
			l_generics.extend (actual_type.generics.first)
			create l_gen_type.make (system.array_id, l_generics)
			if not lace_class.is_void_unsafe then
				l_gen_type.set_is_attached
			end
			Result.set_type (l_gen_type, 0)
			Result.set_feature_name_id ({PREDEFINED_NAMES}.to_array_name_id, Void)
		ensure
			to_array_signature_not_void: Result /= Void
		end

	native_array_type: NATIVE_ARRAY_TYPE_A
			-- Type of `NATIVE_ARRAY'.
		local
			l_generics: ARRAYED_LIST [TYPE_A]
		do
			create l_generics.make (1)
			l_generics.extend (actual_type.generics.first)
			create Result.make (system.native_array_id, l_generics)
			if not lace_class.is_void_unsafe then
				Result.set_is_attached
			end
		ensure
			to_array_signature_not_void: Result /= Void
		end

	put_signature: DYN_PROC_I
			-- Required signature for feature `put' of class SPECIAL
		local
			args: FEAT_ARG
		do
			create args.make (2)
			args.extend (actual_type.generics [1])
			args.extend (Integer_type)
			create Result
			Result.set_arguments (args)
			Result.set_feature_name_id ({PREDEFINED_NAMES}.put_name_id, Void)
		ensure
			put_signature_not_void: Result /= Void
		end

	extend_signature: DYN_PROC_I
			-- Required signature for feature `extend' of class SPECIAL
		local
			args: FEAT_ARG
		do
			create args.make (1)
			args.extend (actual_type.generics [1])
			create Result
			Result.set_arguments (args)
			Result.set_feature_name_id ({PREDEFINED_NAMES}.extend_name_id, Void)
		ensure
			put_signature_not_void: Result /= Void
		end
note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
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
