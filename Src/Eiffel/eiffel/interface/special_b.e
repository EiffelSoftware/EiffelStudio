indexing
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

	check_validity is
			-- Check validity of class SPECIAL
		local
			special_error: SPECIAL_ERROR
			feat_table: FEATURE_TABLE
			item_feature, put_feature, make_feature: FEATURE_I
			done: BOOLEAN
		do
				-- Check if class has one formal generic parameter
			if generics = Void or else generics.count /= 1 or else not is_frozen then
				create special_error.make (special_case_1, Current)
				Error_handler.insert_error (special_error)
			end

			feat_table := feature_table

				-- Check if class has a feature make (INTEGER)
			make_feature := feat_table.item_id (names_heap.make_name_id)
			if
				make_feature = Void
				or else not (make_feature.written_in = class_id)
				or else not make_feature.same_signature (make_signature)
			then
				create special_error.make (special_case_2, Current)
				Error_handler.insert_error (special_error)
			end

				-- Check that `make' is indeed a creation procedure
			if creators = Void then
				create special_error.make (special_case_3, Current)
				Error_handler.insert_error (special_error)
			else
				from
					creators.start
				until
					done or else creators.after
				loop
					done := creators.key_for_iteration.
						is_equal (names_heap.item (Names_heap.make_name_id))
					creators.forth
				end
				if not done then
					create special_error.make (special_case_3, Current)
					Error_handler.insert_error (special_error)
				end
			end

				-- Check if class has a feature item (INTEGER): G#1
			item_feature := feat_table.item_id (names_heap.item_name_id)
			if item_feature = Void
				or else not (item_feature.written_in = class_id)
				or else not item_feature.same_signature (item_signature)
			then
				create special_error.make (special_case_4, Current)
				Error_handler.insert_error (special_error)
			end

				-- Check if class has a feature put (G#1, INTEGER)
			put_feature := feat_table.item_id (names_heap.put_name_id)
			if put_feature = Void
				or else not (put_feature.written_in = class_id)
				or else not put_feature.same_signature (put_signature)
			then
				create special_error.make (special_case_5, Current)
				Error_handler.insert_error (special_error)
			end
		end

feature -- Typing

	new_type (data: CL_TYPE_A): SPECIAL_CLASS_TYPE is
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

	is_special: BOOLEAN is True
			-- Is class SPECIAL?

feature -- Code generation

	generate_dynamic_types (buffer: GENERATION_BUFFER) is
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
			pointer_dtype, boolean_dtype, ref_dtype: INTEGER
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
				dtype := class_type.type_id - 1
				gen_type ?= class_type.type
				gen_param := gen_type.generics.item (1)
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
			buffer.put_string ("%N%Tegc_sp_char = (EIF_TYPE_INDEX)")
			buffer.put_integer (char_dtype)
			buffer.put_string (";%N%Tegc_sp_wchar = (EIF_TYPE_INDEX)")
			buffer.put_integer (wchar_dtype)
			buffer.put_string (";%N%Tegc_sp_bool = (EIF_TYPE_INDEX)")
			buffer.put_integer (boolean_dtype)
			buffer.put_string (";%N%Tegc_sp_uint8 = (EIF_TYPE_INDEX)")
			buffer.put_integer (uint8_dtype)
			buffer.put_string (";%N%Tegc_sp_uint16 = (EIF_TYPE_INDEX)")
			buffer.put_integer (uint16_dtype)
			buffer.put_string (";%N%Tegc_sp_uint32 = (EIF_TYPE_INDEX)")
			buffer.put_integer (uint32_dtype)
			buffer.put_string (";%N%Tegc_sp_uint64 = (EIF_TYPE_INDEX)")
			buffer.put_integer (uint64_dtype)
			buffer.put_string (";%N%Tegc_sp_int8 = (EIF_TYPE_INDEX)")
			buffer.put_integer (int8_dtype)
			buffer.put_string (";%N%Tegc_sp_int16 = (EIF_TYPE_INDEX)")
			buffer.put_integer (int16_dtype)
			buffer.put_string (";%N%Tegc_sp_int32 = (EIF_TYPE_INDEX)")
			buffer.put_integer (int32_dtype)
			buffer.put_string (";%N%Tegc_sp_int64 = (EIF_TYPE_INDEX)")
			buffer.put_integer (int64_dtype)
			buffer.put_string (";%N%Tegc_sp_real32 = (EIF_TYPE_INDEX)")
			buffer.put_integer (real32_dtype)
			buffer.put_string (";%N%Tegc_sp_real64 = (EIF_TYPE_INDEX)")
			buffer.put_integer (real64_dtype)
			buffer.put_string (";%N%Tegc_sp_pointer = (EIF_TYPE_INDEX)")
			buffer.put_integer (pointer_dtype)
			buffer.put_string (";%N%Tegc_sp_ref = (EIF_TYPE_INDEX)")
			buffer.put_integer (ref_dtype)
			buffer.put_string (";%N")
		end

feature {NONE} -- Implementation

	make_signature: DYN_PROC_I is
			-- Required signature for feature `make' of class SPECIAL
		local
			args: FEAT_ARG
		do
			create args.make (1)
			args.put_i_th (Integer_type, 1)
			create Result
			Result.set_arguments (args)
			Result.set_feature_name_id (Names_heap.make_name_id, 0)
		ensure
			item_signature_not_void: Result /= Void
		end

	item_signature: DYN_FUNC_I is
			-- Required signature for feature `item' of class SPECIAL
		local
			args: FEAT_ARG
			f: FORMAL_A
		do
			create args.make (1)
			args.put_i_th (Integer_type, 1)
			create Result
			Result.set_arguments (args)
			create f.make (False, False, 1)
			Result.set_type (f, 0)
			Result.set_feature_name_id (Names_heap.item_name_id, 0)
		ensure
			item_signature_not_void: Result /= Void
		end

	put_signature: DYN_PROC_I is
			-- Required signature for feature `put' of class SPECIAL
		local
			args: FEAT_ARG
			f: FORMAL_A
		do
			create f.make (False, False, 1)
			create args.make (2)
			args.put_i_th (f, 1)
			args.put_i_th (Integer_type, 2)
			create Result
			Result.set_arguments (args)
			Result.set_feature_name_id (Names_heap.put_name_id, 0)
		ensure
			put_signature_not_void: Result /= Void
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
