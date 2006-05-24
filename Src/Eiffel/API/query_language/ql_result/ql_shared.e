indexing
	description: "Constants for Eifel query language"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QL_SHARED

inherit
	SHARED_WORKBENCH

	QL_SHARED_NAMES

	QL_SHARED_SCOPES

feature -- Access

	path_separator: CHARACTER is
			-- Path separator
		once
			Result := '.'
		ensure
			good_result: Result = '.'
		end

feature -- Domain

	system_target_domain: QL_TARGET_DOMAIN is
			-- Target domain representing target of current system
		local
			l_target: QL_TARGET
		do
			create l_target.make (universe.target)
			create Result.make
			Result.extend (l_target)
		ensure
			result_attached: Result /= Void
			result_valid: Result.count = 1 and then Result.first.target = universe.target
		end

	system_target_path: STRING is "%"%""
			-- Path for `syatem_target_domain', an quoted empty string

	empty_assertion_name: STRING is "#";
			-- Name for an empty assertion

feature -- Criterion factory

	criterion_factory_table: HASH_TABLE [QL_CRITERION_FACTORY, QL_SCOPE] is
			-- Criterion factory table
			-- Key is criterion scope type, value is the factory of that scope type.
		once
			create Result.make (10)
			Result.put (create{QL_TARGET_CRITERION_FACTORY}.make, target_scope)
			Result.put (create{QL_GROUP_CRITERION_FACTORY}.make, group_scope)
			Result.put (create{QL_CLASS_CRITERION_FACTORY}.make, class_scope)
			Result.put (create{QL_GENERIC_CRITERION_FACTORY}.make, generic_scope)
			Result.put (create{QL_FEATURE_CRITERION_FACTORY}.make, feature_scope)
			Result.put (create{QL_ARGUMENT_CRITERION_FACTORY}.make, argument_scope)
			Result.put (create{QL_LOCAL_CRITERION_FACTORY}.make, local_scope)
			Result.put (create{QL_ASSERTION_CRITERION_FACTORY}.make, assertion_scope)
			Result.put (create{QL_LINE_CRITERION_FACTORY}.make, line_scope)
		ensure
			result_attached: Result /= Void
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
