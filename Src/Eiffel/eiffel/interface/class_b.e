note
	description: "Internal description of a basic class such as INTEGER, BOOLEAN etc.."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class CLASS_B

inherit
	EIFFEL_CLASS_C
		redefine
			is_basic, partial_actual_type, check_validity, make
		end

	SPECIAL_CONST
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	make (l: like original_class)
			-- <Precursor>
		do
			Precursor {EIFFEL_CLASS_C} (l)
			is_expanded := True
		end

feature

	is_basic: BOOLEAN = True
			-- Is the current class a basic class ?

feature {CLASS_TYPE_AS} -- Actual class type

	partial_actual_type (gen: detachable ARRAYED_LIST [TYPE_A]; a: CLASS_TYPE_AS; c: CLASS_C): CL_TYPE_A
			-- <Precursor>
		do
			if attached gen then
				create {GEN_TYPE_A} Result.make (class_id, gen)
			else
				initialize_actual_type
				Result := actual_type
			end
		end

feature -- Validity

	check_validity
			-- Check validity of a simple type reference class.
		local
			special_error: SPECIAL_ERROR
			l_feat: FEATURE_I
		do
				-- First, no generics
			if generics /= Void then
				create special_error.make (basic_case_1, Current)
				Error_handler.insert_error (special_error)
			end

				-- Check for `item' query.
			l_feat := feature_table.item_id ({PREDEFINED_NAMES}.item_name_id)
			if l_feat = Void or else not l_feat.is_attribute then
				create special_error.make (basic_case_3, Current)
				Error_handler.insert_error (special_error)
			elseif not l_feat.type.conformance_type.same_as (actual_type) then
				create special_error.make (basic_case_2, Current)
				Error_handler.insert_error (special_error)
			end

				-- Check for a procedure `set_item'.
			if
				not attached {PROCEDURE_I} feature_table.item_id ({PREDEFINED_NAMES}.set_item_name_id) as l_proc or else
				l_proc.argument_count /= 1 or else
				not l_proc.arguments.i_th (1).conformance_type.same_as (actual_type)
			then
				create special_error.make (basic_case_4, Current)
				Error_handler.insert_error (special_error)
			end
		end

invariant
	is_expanded: is_expanded

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
