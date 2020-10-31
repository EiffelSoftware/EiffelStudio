note
	description: "Compiled class STRING"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class STRING_CLASS_B

inherit
	EIFFEL_CLASS_C
		rename
			make as basic_make
		redefine
			check_validity
		end

	SPECIAL_CONST

create
	make,
	make_immutable

feature {NONE} -- Initialization

	make (l: like original_class; a_is_string_32: BOOLEAN)
			-- Representation of STRING_8 class if not `a_is_string_32', STRING_32 otherwise.			
		do
			basic_make (l)
			is_string_32 := a_is_string_32
		ensure
			is_string_32_set: is_string_32 = a_is_string_32
		end

	make_immutable (l: like original_class; a_is_string_32: BOOLEAN)
			-- Representation of IMMUTABLE_STRING_8 class if not `a_is_string_32', IMMUTABLE_STRING_32 otherwise.
		do
			make (l, a_is_string_32)
			is_immutable := True
		end

feature -- Property

	is_string_32: BOOLEAN
			-- Is current class the STRING_32 class?

	is_immutable: BOOLEAN
			-- Is current class IMMUTABLE_STRING_* variants?

feature -- Checking

	check_for_area_attribute
		local
			special_error: SPECIAL_ERROR
		do
				-- Check if class has an attribute `area' of type SPECIAL [CHARACTER].
			if
				not attached feature_table.item_id (Names_heap.area_name_id) as area_feature
				or else not area_type.same_as (area_feature.type.actual_type)
			then
				create special_error.make (string_case_1, Current)
				Error_handler.insert_error (special_error)
			end

				-- Second check if class has only one reference attribute
				-- only (which is necessary `area' then).
			if types.first.skeleton.nb_reference /= 1 then
				create special_error.make (string_case_2, Current)
				Error_handler.insert_error (special_error)
			end
		end

	check_for_creation_procedure (a_for_immut: BOOLEAN)
			-- Check for creation procedure, depending on `a_for_immut` for immutable or mutable strings.
		local
			creat_feat: FEATURE_I
			done: BOOLEAN
		do
				-- Third check if class has one creation procedure with
				-- one integer argument
			if attached creators as cs then
				across
					cs as c
				until
					done
				loop
					creat_feat := feature_table.item_id (c.key)
					done :=
						if a_for_immut then
							creat_feat.feature_name_id = names_heap.make_from_c_byte_array_name_id and then
							creat_feat.same_signature (make_from_c_byte_array_signature)
						else
							creat_feat.feature_name_id = names_heap.make_name_id and then
							creat_feat.same_signature (make_signature)
						end
				end
			end
			if not done then
				error_handler.insert_error (create {SPECIAL_ERROR}.make (string_case_3, Current))
			end
		end

	check_for_set_count_procedure
		local
			set_count_feat: FEATURE_I
		do
				-- Fourthsence of a procedure `set_count'.
			set_count_feat := feature_table.item_id (Names_heap.set_count_name_id)
			if
				set_count_feat = Void
				or else	not set_count_feat.same_signature (set_count_signature)
				or else set_count_feat.written_in /= class_id
			then
				Error_handler.insert_error (create {SPECIAL_ERROR}.make (string_case_4, Current))
			end
		end

	check_validity
			-- Check validity of class STRING
		local
			special_error: SPECIAL_ERROR;
		do
			check_for_creation_procedure (is_immutable)
			if not is_immutable then
				check_for_area_attribute
				check_for_set_count_procedure
				if not System.il_generation then
						-- Presence of attribute `internal_hash_code'.
					if
						not attached {ATTRIBUTE_I} feature_table.item_id (Names_heap.internal_hash_code_name_id) as internal_hash_code_feat
						or else not internal_hash_code_feat.type.same_as (Integer_type)
					then
						create special_error.make (string_case_5, Current)
						Error_handler.insert_error (special_error)
					end

						-- Presence of attribute `count'.
					if
						not attached feature_table.item_id (Names_heap.count_name_id) as l_feat
						or else not l_feat.is_attribute or else not l_feat.type.same_as (integer_32_type)
					then
						create special_error.make (string_case_6, Current)
						Error_handler.insert_error (special_error)
					end
				else
						-- Presence of `to_cil'.
					if
						not attached feature_table.item_id ({PREDEFINED_NAMES}.to_cil_name_id) as l_feat
						or else l_feat.has_arguments
						or else not l_feat.has_return_value
						or else l_feat.type.base_class.class_id /= system.system_string_id
					then
						create special_error.make (string_case_7, Current)
						Error_handler.insert_error (special_error)
					end
				end
			end
		end

feature {NONE} -- Implementation

	make_signature: DYN_PROC_I
			-- Required signature for feature `make' of class STRING
		local
			args: FEAT_ARG;
		do
			create args.make (1);
			args.extend (Integer_type);
			create Result;
			Result.set_arguments (args);
			Result.set_feature_name_id (Names_heap.make_name_id, Void)
		end

	make_from_c_byte_array_signature: DYN_PROC_I
			-- Required signature for feature `make_from_c_byte_array' of class IMMUTABLE_STRING_*
		local
			args: FEAT_ARG;
		do
			create args.make (2);
			args.extend (Pointer_type);
			args.extend (Integer_type);
			create Result;
			Result.set_arguments (args);
			Result.set_feature_name_id (Names_heap.make_from_cil_name_id, Void)
		end

	area_type: GEN_TYPE_A
			-- Type SPECIAL [CHARACTER]
		local
			gen: ARRAYED_LIST [TYPE_A]
		do
			create gen.make (1)
			if is_string_32 then
				gen.extend (wide_char_type)
			else
				gen.extend (character_type)
			end
			create Result.make (System.special_id, gen)
		ensure
			area_type_not_void: Result /= Void
		end

	set_count_signature: DYN_PROC_I
			-- Required signature for `set_count' of class STRING
		local
			args: FEAT_ARG;
		do
			create args.make (1);
			args.extend (Integer_type);
			create Result;
			Result.set_arguments (args);
			Result.set_feature_name_id (Names_heap.set_count_name_id, Void)
		end;

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
