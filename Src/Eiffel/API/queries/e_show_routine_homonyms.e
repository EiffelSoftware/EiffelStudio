indexing

	description:
		"Command to display homonyms of `current_feature'."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class E_SHOW_ROUTINE_HOMONYMNS

inherit

	E_SHOW_ROUTINE_HIERARCHY
		redefine
			has_valid_feature,
			is_branch_displayed,
			criterion,
			feature_name_tester
		end

	SHARED_EIFFEL_PROJECT


create
	make, default_create

feature -- Status report

	has_valid_feature: BOOLEAN is True
			-- Always a valid feature

	is_branch_displayed: BOOLEAN is False;
			-- Is branch information displayed?

feature{NONE} -- Implemetation

	criterion: QL_CRITERION is
			-- Criterion used in current command
		do
			create {QL_FEATURE_NAME_IS_CRI}Result.make_with_setting (current_feature.name, False, True)
		ensure then
			result_attached: Result /= Void
		end

	feature_name_tester (feature_a, feature_b: QL_FEATURE): BOOLEAN is
			-- Compare name of `feature_a' and `feature_b'.
		do
			Result := feature_a.class_c.topological_id < feature_b.class_c.topological_id
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

end -- class E_SHOW_ROUTINE_HOMONYMNS
