note
	description: "Representation of a once function"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class ONCE_FUNC_I

inherit
	ONCE_PROC_I
		redefine
			assigner_name_id, unselected, replicated, set_type, is_function, type,
			new_api_feature, transfer_to, transfer_from, selected,
			prepare_object_relative_once
		end

feature -- Access

	type: TYPE_A
			-- Type of the function

	assigner_name_id: INTEGER
			-- Id of `assigner_name' in `Names_heap' table

	set_type (t: like type; a: like assigner_name_id)
			-- Assign `t' to `type' and `a' to `assigner_name_id'.
		do
			type := t
			assigner_name_id := a
		end

	is_function: BOOLEAN = True

	transfer_to (other: like Current)
			-- Transfer data from Current into `other'
		do
			Precursor {ONCE_PROC_I} (other)
			other.set_type (type, assigner_name_id)
		end

	transfer_from (other: like Current)
			-- Transfer data from `other' into Current
		do
			Precursor {ONCE_PROC_I} (other)
			set_type (other.type, other.assigner_name_id)
		end

	replicated (in: INTEGER): FEATURE_I
			-- Replication
		local
			rep: R_ONCE_FUNC_I
		do
			create rep;
			transfer_to (rep);
			rep.set_code_id (new_code_id);
			rep.set_access_in (in)
			Result := rep;
		end;

	selected: ONCE_FUNC_I
			-- <Precursor>
		do
			create Result
			Result.transfer_from (Current)
		end

	unselected (in: INTEGER): FEATURE_I
			-- Unselected feature
		local
			unselect: D_ONCE_FUNC_I
		do
			create unselect;
			transfer_to (unselect);
			unselect.set_access_in (in);
			Result := unselect;
		end;

feature -- Object relative once

	prepare_object_relative_once (a_byte_code: BYTE_CODE)
		local
			l_hidden_b: HIDDEN_B
			l_assign_b: ASSIGN_B
			l_attr_b: ATTRIBUTE_B
			l_compound, l_new_compound: BYTE_LIST [BYTE_NODE]
		do
			if is_object_relative then
				if
					has_return_value and
					attached written_class.object_relative_once_info_of_rout_id_set (rout_id_set) as l_obj_once_info
				then
					if attached {STD_BYTE_CODE} a_byte_code as bc then

						create l_assign_b
						create l_attr_b.make (l_obj_once_info.result_attribute_i)
						l_attr_b.set_type (a_byte_code.real_type (l_obj_once_info.result_type_a))
						l_attr_b.set_is_attachment
						l_assign_b.set_target (l_attr_b)
						l_assign_b.set_source (create {RESULT_B})
						l_compound := a_byte_code.compound
						if l_compound /= Void then
							create l_new_compound.make (l_compound.count + 1)
							l_new_compound.append (l_compound)
						else
							create l_new_compound.make (1)
						end
						create l_hidden_b.make (l_assign_b)
						l_new_compound.extend (l_hidden_b)
						bc.set_compound (l_new_compound)
					end
				end
			end
		end


feature {NONE} -- Implementation

	new_api_feature: E_FUNCTION
			-- API feature creation
		do
			create Result.make (feature_name_id, alias_name, has_convert_mark, feature_id)
			Result.set_type (type, assigner_name)
			update_api (Result)
		end

note
	copyright:	"Copyright (c) 1984-2010, Eiffel Software"
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
