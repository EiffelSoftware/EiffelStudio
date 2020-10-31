note
	description: "Specific description of the ARRAY class which has special requirements for `check_validity'."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ARRAY_CLASS_B

inherit
	EIFFEL_CLASS_C
		redefine
			check_validity
		end

	SPECIAL_CONST

create
	make

feature

	check_validity
			-- Check validity of class ARRAY
		local
			creat_feat: FEATURE_I
			area_feature: ATTRIBUTE_I
			done: BOOLEAN
		do
				-- First check if current class has one formal generic parameter
			if not attached generics as g or else g.count /= 1 then
				Error_handler.insert_error (create {SPECIAL_ERROR}.make (array_case_1, Current))
			end

				-- Check if class has an attribute `area' of type SPECIAL [T].
			area_feature := {ATTRIBUTE_I} / feature_table.item_id ({PREDEFINED_NAMES}.area_name_id)
			if not attached area_feature or else not area_type.same_as (area_feature.type) then
				Error_handler.insert_error (create {SPECIAL_ERROR}.make (array_case_2, Current))
			end

				-- Third check if class has only one reference attribute
				-- only (which is necessary `area' then).
			if types.first.skeleton.nb_reference /= 1 then
				Error_handler.insert_error (create {SPECIAL_ERROR}.make (array_case_3, Current))
			end

				-- Fouth, check if there is only one creation procedure
				-- having only two integer arguments
			if attached creators as cs then
				across
					cs as c
				until
					done
				loop
					creat_feat := feature_table.item_id (c.key)
					done :=
						creat_feat.feature_name_id = {PREDEFINED_NAMES}.make_name_id and then
						creat_feat.same_signature (make_signature)
				end
			end
			if not done then
				Error_handler.insert_error (create {SPECIAL_ERROR}.make (array_case_4, Current))
			end
		end

feature {NONE}

	make_signature: DYN_PROC_I
			-- Required signature for feature `make' of class STRING
		local
			args: FEAT_ARG;
		do
			create args.make (2)
			args.extend (Integer_type)
			args.extend (Integer_type)
			create Result
			Result.set_arguments (args)
			Result.set_feature_name_id ({PREDEFINED_NAMES}.make_name_id, Void)
		end;

	area_type: GEN_TYPE_A
			-- Type SPECIAL [T]
		local
			l_generics: ARRAYED_LIST [TYPE_A]
		do
			create l_generics.make (1)
			l_generics.extend (actual_type.generics.first)
			create Result.make (System.special_id, l_generics)
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
