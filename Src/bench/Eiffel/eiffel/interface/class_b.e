indexing
	description: "Internal description of a basic class such as INTEGER, BOOLEAN etc.."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class CLASS_B

inherit
	CLASS_C
		redefine
			is_basic, partial_actual_type, check_validity
		end

	SPECIAL_CONST
		export
			{NONE} all
		end

create
	make

feature

	is_basic: BOOLEAN is True
			-- Is the current class a basic class ?

feature {CLASS_TYPE_AS} -- Actual class type

	partial_actual_type (gen: ARRAY [TYPE_A]; is_exp: BOOLEAN; is_sep: BOOLEAN): CL_TYPE_A is
			-- Actual type of `current depending on the context in which it is declared
			-- in CLASS_TYPE_AS. That is to say, it could have generics `gen' but not
			-- be a generic class. It simplifies creation of `CL_TYPE_A' instances in
			-- CLASS_TYPE_AS when trying to resolve types, by using dynamic binding
			-- rather than if statements.
		do
			if gen /= Void then
				create {GEN_TYPE_A} Result.make (class_id, gen)
			else
				Result := actual_type
			end
		end

feature -- Validity

	check_validity is
			-- Check validity of a simple type reference class.
		local
			skelet: SKELETON
			special_error: SPECIAL_ERROR
			l_feat: PROCEDURE_I
			l_attr: ATTRIBUTE_I
		do
				-- First, no generics
			if generics /= Void then
				create special_error.make (basic_case_1, Current)
				Error_handler.insert_error (special_error)
			end

				-- Check for `item' attribute
			skelet := types.first.skeleton
			if
				skelet.count /= 1 or else
				not skelet.first.type_i.same_as (actual_type.type_i)
			then
				create special_error.make (basic_case_2, Current)
				Error_handler.insert_error (special_error)
			else
					-- Check it is indeed called `item'.
				l_attr ?= feature_table.item_id (names_heap.item_name_id)
				if l_attr = Void then
					create special_error.make (basic_case_3, Current)
					Error_handler.insert_error (special_error)
				end
			end

				-- Check for a procedure `set_item'.
			l_feat ?= feature_table.item_id (Names_heap.set_item_name_id)
			if
				l_feat = Void or else
				l_feat.argument_count /= 1 or else
				not l_feat.arguments.i_th (1).actual_type.same_as (actual_type)
			then
				create special_error.make (basic_case_4, Current)
				Error_handler.insert_error (special_error)
			end
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

end
