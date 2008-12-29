note
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

	path_separator: CHARACTER
			-- Path separator
		once
			Result := '.'
		ensure
			good_result: Result = '.'
		end

	criterion_with_index (a_scope: QL_SCOPE; a_index: INTEGER; a_argu: TUPLE): QL_CRITERION
			-- Criterion with `a_index' and argument `a_argu' in `a_scope'
		require
			a_scope_attached: a_scope /= Void
			criterion_exists: criterion_factory_table.item (a_scope).has_criterion_with_index (a_index)
		do
			Result := criterion_factory_table.item (a_scope).criterion_with_index (a_index, a_argu)
		end

	criterion_with_name (a_scope: QL_SCOPE; a_name: STRING; a_argu: TUPLE): QL_CRITERION
			-- Criterion with `a_name' and argument `a_argu' in `a_scope'
		require
			a_scope_attached: a_scope /= Void
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
			criterion_exists: criterion_factory_table.item (a_scope).has_criterion_with_name (a_name)
		do
			Result := criterion_factory_table.item (a_scope).criterion_with_name (a_name, a_argu)
		end

	metric_factory: QL_METRIC_FACTORY
			-- Metric factory
		once
			create Result
		ensure
			result_attached: Result /= Void
		end

feature -- Domain

	system_target_domain: QL_TARGET_DOMAIN
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

	system_target_path: STRING = "%"%""
			-- Path for `syatem_target_domain', an quoted empty string

	empty_assertion_name: STRING = "#";
			-- Name for an empty assertion

	dummy_domain: QL_DOMAIN
			-- Dummy domain
		do
			create {QL_QUANTITY_DOMAIN} Result.make
		ensure
			result_attached: Result /= Void
		end

feature -- Criterion factory

	criterion_factory_table: HASH_TABLE [QL_CRITERION_FACTORY, QL_SCOPE]
			-- Criterion factory table
			-- Key is criterion scope type, value is the factory of that scope type.
		once
			create Result.make (10)
			Result.put (target_criterion_factory, target_scope)
			Result.put (group_criterion_factory, group_scope)
			Result.put (class_criterion_factory, class_scope)
			Result.put (generic_criterion_factory, generic_scope)
			Result.put (feature_criterion_factory, feature_scope)
			Result.put (argument_criterion_factory, argument_scope)
			Result.put (local_criterion_factory, local_scope)
			Result.put (assertion_criterion_factory, assertion_scope)
			Result.put (line_criterion_factory, line_scope)
			Result.put (quantity_criterion_factory, quantity_scope)
		ensure
			result_attached: Result /= Void
		end

	target_criterion_factory: QL_TARGET_CRITERION_FACTORY
			-- Target criterion factory
		once
			create Result.make
		ensure
			result_attached: Result /= Void
		end

	group_criterion_factory: QL_GROUP_CRITERION_FACTORY
			-- Group criterion factory
		once
			create Result.make
		ensure
			result_attached: Result /= Void
		end

	class_criterion_factory: QL_CLASS_CRITERION_FACTORY
			-- Class criterion factory
		once
			create Result.make
		ensure
			result_attached: Result /= Void
		end

	generic_criterion_factory: QL_GENERIC_CRITERION_FACTORY
			-- Generic criterion factory
		once
			create Result.make
		ensure
			result_attached: Result /= Void
		end

	feature_criterion_factory: QL_FEATURE_CRITERION_FACTORY
			-- Feature criterion factory
		once
			create Result.make
		ensure
			result_attached: Result /= Void
		end

	argument_criterion_factory: QL_ARGUMENT_CRITERION_FACTORY
			-- Argument criterion factory
		once
			create Result.make
		ensure
			result_attached: Result /= Void
		end

	local_criterion_factory: QL_LOCAL_CRITERION_FACTORY
			-- Local criterion factory
		once
			create Result.make
		ensure
			result_attached: Result /= Void
		end

	assertion_criterion_factory: QL_ASSERTION_CRITERION_FACTORY
			-- Assertion criterion factory
		once
			create Result.make
		ensure
			result_attached: Result /= Void
		end

	line_criterion_factory: QL_LINE_CRITERION_FACTORY
			-- Line criterion factory
		once
			create Result.make
		ensure
			result_attached: Result /= Void
		end

	quantity_criterion_factory: QL_QUANTITY_CRITERION_FACTORY
			-- Line criterion factory
		once
			create Result.make
		ensure
			result_attached: Result /= Void
		end

note
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
