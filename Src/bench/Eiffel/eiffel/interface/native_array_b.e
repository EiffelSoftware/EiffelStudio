indexing
	description: "Compiled class NATIVE_ARRAY"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class NATIVE_ARRAY_B

inherit
	CLASS_C
		redefine
			check_validity, new_type, is_native_array, partial_actual_type, actual_type
		end

	SPECIAL_CONST

create
	make

feature -- Validity

	check_validity is
			-- Check validity of class ARRAY
		local
			error: BOOLEAN
			special_error: SPECIAL_ERROR
			l_feat_tbl: like feature_table
			l_feat: FEATURE_I
			done: BOOLEAN
		do
			l_feat_tbl := feature_table
				-- First check if current class has one formal generic parameter
			if (generics = Void) or else generics.count /= 1 then
				create special_error.make (native_array_case_1, Current)
				Error_handler.insert_error (special_error)
			end

				-- Second, check if there is only one creation procedure
				-- having only one integer argument
			error := creators = Void
			if not error then
				from
					creators.start
				until
					done or else creators.after
				loop
					l_feat := l_feat_tbl.item (creators.key_for_iteration)
					if
						l_feat.feature_name_id = names_heap.make_name_id and then
						l_feat.same_signature (make_signature)
					then
						done := True
					else
						creators.forth
					end
				end
				error := not done
			end
			if error then
				create  special_error.make (native_array_case_2, Current)
				Error_handler.insert_error (special_error)
			end

				-- Third, check if class has a feature item and infix "@" (INTEGER): G#1
			l_feat := l_feat_tbl.item_id ({PREDEFINED_NAMES}.item_name_id)
			if
				l_feat = Void
				or else not (l_feat.written_in = class_id)
				or else not l_feat.same_signature (item_signature)
			then
				create special_error.make (native_array_case_3, Current)
				Error_handler.insert_error (special_error)
			end

			l_feat := l_feat_tbl.item_id ({PREDEFINED_NAMES}.infix_at_name_id)
			if
				l_feat = Void
				or else not (l_feat.written_in = class_id)
				or else not l_feat.same_signature (infix_at_signature)
			then
				create special_error.make (native_array_case_4, Current)
				Error_handler.insert_error (special_error)
			end

				-- Fourth, check if class has a feature put (G#1, INTEGER)
			l_feat := l_feat_tbl.item_id ({PREDEFINED_NAMES}.put_name_id)
			if
				l_feat = Void
				or else not (l_feat.written_in = class_id)
				or else not l_feat.same_signature (put_signature)
			then
				create special_error.make (native_array_case_5, Current)
				Error_handler.insert_error (special_error)
			end

				-- Fourth, check if class has a feature count, INTEGER)
			l_feat := l_feat_tbl.item_id ({PREDEFINED_NAMES}.count_name_id)
			if
				l_feat = Void
				or else not (l_feat.written_in = class_id)
				or else not l_feat.same_signature (count_signature)
			then
				create special_error.make (native_array_case_6, Current)
				Error_handler.insert_error (special_error)
			end
		end

feature -- Generic derivation

	new_type (data: CL_TYPE_I): NATIVE_ARRAY_CLASS_TYPE is
			-- New class type for class NATIVE_ARRAY.
		local
			l_data: NATIVE_ARRAY_TYPE_I
		do
			l_data ?= data
			check
				l_data_not_void: l_data /= Void
			end
			create Result.make (l_data)
			if already_compiled then
					-- Melt all the code written in the associated class of the new class type
				melt_all
			end
		end

feature -- Actual class type

	actual_type: CL_TYPE_A is
			-- Actual type of the class
		local
			i, nb: INTEGER
			actual_generic: ARRAY [FORMAL_A]
			formal: FORMAL_A
			l_formal_dec: FORMAL_DEC_AS
		do
			if generics = Void then
				create Result.make (class_id)
			else
				from
					i := 1
					nb := generics.count
					create actual_generic.make (1, nb)
					create {NATIVE_ARRAY_TYPE_A} Result.make (class_id, actual_generic)
				until
					i > nb
				loop
					l_formal_dec := generics.i_th (i)
					create formal.make (l_formal_dec.is_reference, l_formal_dec.is_expanded, i)
					actual_generic.put (formal, i)
					i := i + 1
				end
			end
				-- Note that NATIVE_ARRAY is not expanded by default
		end

feature {CLASS_TYPE_AS} -- Actual class type

	partial_actual_type (gen: ARRAY [TYPE_A]; is_exp: BOOLEAN; is_sep: BOOLEAN): CL_TYPE_A is
			-- Actual type of `current depending on the context in which it is declared
			-- in CLASS_TYPE_AS. That is to say, it could have generics `gen' but not
			-- be a generic class. It simplifies creation of `CL_TYPE_A' instances in
			-- CLASS_TYPE_AS when trying to resolve types, by using dynamic binding
			-- rather than if statements.
		do
			if gen /= Void then
				create {NATIVE_ARRAY_TYPE_A} Result.make (class_id, gen)
			else
				create Result.make (class_id)
			end
				-- Note that NATIVE_ARRAY is not expanded by default
			if is_exp then
				Result.set_expanded_mark
			elseif is_sep then
				Result.set_separate_mark
			end
			if is_expanded then
				Result.set_expanded_class_mark
			end
		end

feature -- Status report

	is_native_array: BOOLEAN is True
			-- Is the class special ?

feature {NONE}

	make_signature: DYN_PROC_I is
			-- Required signature for feature `make' of class NATIVE_ARRAY.
		local
			args: FEAT_ARG
		do
			create  args.make (1)
			args.put_i_th (Integer_type, 1)
			create  Result
			Result.set_arguments (args)
			Result.set_feature_name_id ({PREDEFINED_NAMES}.make_name_id, 0)
		end

	count_signature: DYN_FUNC_I is
			-- Required signature for feature `count' of class NATIVE_ARRAY.
		local
			args: FEAT_ARG
		do
			create args.make (0)
			create Result
			Result.set_arguments (args)
			Result.set_type (Integer_type, 0)
			Result.set_feature_name_id ({PREDEFINED_NAMES}.count_name_id, 0)
		ensure
			item_signature_not_void: Result /= Void
		end

	item_signature: DYN_FUNC_I is
			-- Required signature for feature `item' of class NATIVE_ARRAY.
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
			Result.set_feature_name_id ({PREDEFINED_NAMES}.item_name_id, 0)
		ensure
			item_signature_not_void: Result /= Void
		end

	infix_at_signature: DYN_FUNC_I is
			-- Required signature for feature `infix "@"' of class NATIVE_ARRAY.
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
			Result.set_feature_name_id ({PREDEFINED_NAMES}.infix_at_name_id, 0)
		ensure
			item_signature_not_void: Result /= Void
		end

	put_signature: DYN_PROC_I is
			-- Required signature for feature `put' of class NATIVE_ARRAY.
		local
			args: FEAT_ARG
			f: FORMAL_A
		do
			create f.make (False, False, 1)
			create args.make (2)
			args.put_i_th (Integer_type, 1)
			args.put_i_th (f, 2)
			create Result
			Result.set_arguments (args)
			Result.set_feature_name_id ({PREDEFINED_NAMES}.put_name_id, 0)
		ensure
			put_signature_not_void: Result /= Void
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- end of NATIVE_ARRAY_B
