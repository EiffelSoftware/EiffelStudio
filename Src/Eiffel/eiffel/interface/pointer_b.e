note
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
			initialize_actual_type, partial_actual_type, constraint_actual_type,
			is_typed_pointer, check_validity
		end

create
	make

feature {NONE} -- Initialization

	make (l: like original_class; a_is_typed_pointer: like is_typed_pointer)
			-- Creation of POINTER_B instance where `is_typed_pointer' is initialized
			-- with `a_is_typed_pointer'.
		do
			basic_make (l)
			is_typed_pointer := a_is_typed_pointer
		ensure
			is_typed_pointer_set: is_typed_pointer = a_is_typed_pointer
		end

feature -- Access

	constraint_actual_type: CL_TYPE_A
			-- Actual double type
		obsolete
			"See {CLASS_C}.constraint_actual_type obsolete clause."
		do
			if generics = Void then
				Result := actual_type
			else
				if is_typed_pointer then
					create {TYPED_POINTER_A} Result.make_typed (single_constraint (1))
				else
					Result := Pointer_type
				end
			end
		end

	is_typed_pointer: BOOLEAN
			-- Is current representing TYPED_POINTER?

feature {NONE} -- Initialization

	initialize_actual_type
			-- <Precursor>
		do
			if is_typed_pointer and then attached generics as g and then g.count = 1 then
				create {TYPED_POINTER_A} actual_type.make_typed
					(type_a_generator.evaluate_type (g.first.formal, Current))
			else
				actual_type := Pointer_type
			end
		end

feature {CLASS_TYPE_AS} -- Actual class type

	partial_actual_type (gen: detachable ARRAYED_LIST [TYPE_A]; a: CLASS_TYPE_AS; c: CLASS_C): CL_TYPE_A
			-- <Precursor>
		do
			if is_typed_pointer then
				if attached gen then
					create {TYPED_POINTER_A} Result.make_typed (gen.first)
				else
					create Result.make (class_id)
				end
			else
				Result := Precursor {CLASS_B} (gen, a, c)
			end
		end

feature -- Validity

	check_validity
			-- Check validity of a simple type reference class.
		local
			special_error: SPECIAL_ERROR
			l_feat: FEATURE_I
		do
			if not is_typed_pointer then
				Precursor
			else
					-- First check there is only one generic.
				if generics = Void or else generics.count > 1 then
					create special_error.make (typed_pointer_case_1, Current)
					Error_handler.insert_error (special_error)
				end

					-- Check for `to_pointer' query.
				l_feat := feature_table.item_id ({PREDEFINED_NAMES}.to_pointer_name_id)
				if l_feat = Void or else not l_feat.is_attribute then
					create special_error.make (typed_pointer_case_3, Current)
					Error_handler.insert_error (special_error)
				elseif not l_feat.type.same_as (pointer_type) then
					create special_error.make (typed_pointer_case_2, Current)
					Error_handler.insert_error (special_error)
				end

					-- Check for a procedure `set_item'.
				if
					not attached {PROCEDURE_I} feature_table.item_id ({PREDEFINED_NAMES}.set_item_name_id) as l_proc or else
					l_proc.argument_count /= 1 or else
					not l_proc.arguments.i_th (1).conformance_type.same_as (pointer_type)
				then
					create special_error.make (typed_pointer_case_4, Current)
					Error_handler.insert_error (special_error)
				end
			end
		end

note
	copyright:	"Copyright (c) 1984-2015, Eiffel Software"
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
