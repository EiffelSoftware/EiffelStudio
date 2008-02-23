indexing
	description: "Internal representation of class POINTER and TYPED_POINTER"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class POINTER_B

inherit
	CLASS_B
		rename
			make as basic_make
		redefine
			actual_type, partial_actual_type, constraint_actual_type,
			is_typed_pointer, check_validity
		end

create
	make

feature {NONE} -- Initialization

	make (l: like original_class; a_is_typed_pointer: like is_typed_pointer) is
			-- Creation of POINTER_B instance where `is_typed_pointer' is initialized
			-- with `a_is_typed_pointer'.
		do
			basic_make (l)
			is_typed_pointer := a_is_typed_pointer
		ensure
			is_typed_pointer_set: is_typed_pointer = a_is_typed_pointer
		end

feature -- Access

	actual_type: BASIC_A is
			-- Actual double type
		local
			l_formal: FORMAL_A
		do
			if is_typed_pointer then
				create l_formal.make (False, False, 1)
				create {TYPED_POINTER_A} Result.make_typed (l_formal)
			else
				Result := Pointer_type
			end
		end

	constraint_actual_type: BASIC_A is
			-- Actual double type
		do
			if generics = Void then
				Result := actual_type
			else
				if is_typed_pointer then
					create {TYPED_POINTER_A} Result.make_typed (constraints (1))
				else
					Result := Pointer_type
				end
			end
		end

	is_typed_pointer: BOOLEAN
			-- Is current representing TYPED_POINTER?

feature {CLASS_TYPE_AS} -- Actual class type

	partial_actual_type (gen: ARRAY [TYPE_A]; is_exp: BOOLEAN; is_sep: BOOLEAN): CL_TYPE_A is
			-- Actual type of `current depending on the context in which it is declared
			-- in CLASS_TYPE_AS. That is to say, it could have generics `gen' but not
			-- be a generic class. It simplifies creation of `CL_TYPE_A' instances in
			-- CLASS_TYPE_AS when trying to resolve types, by using dynamic binding
			-- rather than if statements.
		do
			if is_typed_pointer then
				if gen /= Void then
					create {TYPED_POINTER_A} Result.make (class_id, gen)
				else
					create Result.make (class_id)
				end
			else
				Result := Precursor {CLASS_B} (gen, is_exp, is_sep)
			end
		end

feature -- Validity

	check_validity is
			-- Check validity of a simple type reference class.
		local
			skelet: SKELETON
			special_error: SPECIAL_ERROR
			l_feat: FEATURE_I
			l_proc: PROCEDURE_I
			l_attr: ATTRIBUTE_I
		do
			if not is_typed_pointer then
				Precursor {CLASS_B}
			else
					-- First check there is only one generic.
				if generics = Void or else generics.count > 1 then
					create special_error.make (typed_pointer_case_1, Current)
					Error_handler.insert_error (special_error)
				end

					-- Check for `to_pointer' query.
				l_feat := feature_table.item_id ({PREDEFINED_NAMES}.to_pointer_name_id)
				if l_feat = Void or else not l_feat.has_return_value then
					create special_error.make (typed_pointer_case_3, Current)
					Error_handler.insert_error (special_error)
				else
					l_attr ?= l_feat
					if l_attr /= Void then
							-- We are compiling for Eiffel Software implementation
						skelet := types.first.skeleton
						if
							skelet.count /= 1 or else
							not skelet.first.type_i.same_as (pointer_type)
						then
							create special_error.make (typed_pointer_case_2, Current)
							Error_handler.insert_error (special_error)
						else
						end
					else
						create special_error.make (typed_pointer_case_3, Current)
						Error_handler.insert_error (special_error)
					end
				end

					-- Check for a procedure `set_item'.
				l_proc ?= feature_table.item_id ({PREDEFINED_NAMES}.set_item_name_id)
				if
					l_proc = Void or else
					l_proc.argument_count /= 1 or else
					not l_proc.arguments.i_th (1).actual_type.same_as (pointer_type)
				then
					create special_error.make (typed_pointer_case_4, Current)
					Error_handler.insert_error (special_error)
				end
			end
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
