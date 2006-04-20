indexing
	description: "Representation of a deferred function"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class DEF_FUNC_I

inherit
	DEF_PROC_I
		redefine
			assigner_name_id, transfer_to,
			unselected, replicated, set_type, is_function, type,
			new_api_feature
		end

feature

	type: TYPE_A
			-- Type of the function

	assigner_name_id: INTEGER
			-- Id of `assigner_name' in `Names_heap' table

	set_type (t: like type; a: like assigner_name_id) is
			-- Assign `t' to `type' and `a' to `assigner_name_id'.
		do
			type := t
			assigner_name_id := a
		end

	is_function: BOOLEAN is True;
			-- Is the current feature a function ?

	replicated: FEATURE_I is
			-- Replication
		local
			rep: R_DEF_FUNC_I;
		do
			create rep;
			transfer_to (rep);
			rep.set_code_id (new_code_id);
			Result := rep;
		end;

	unselected (in: INTEGER): FEATURE_I is
			-- Unselected feature
		local
			unselect: D_DEF_FUNC_I
		do
			create unselect;
			transfer_to (unselect);
			unselect.set_access_in (in);
			Result := unselect;
		end;

	transfer_to (other: like Current) is
			-- Transfer datas form `other' into Current
		do
			Precursor {DEF_PROC_I} (other)
			other.set_type (type, assigner_name_id)
		end

feature {NONE} -- Implementation

	new_api_feature: E_FUNCTION is
		do
			create Result.make (feature_name, alias_name, has_convert_mark, feature_id)
			Result.set_type (type, assigner_name)
			update_api (Result)
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
