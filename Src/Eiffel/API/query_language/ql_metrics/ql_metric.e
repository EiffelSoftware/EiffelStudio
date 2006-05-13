indexing
	description: "Object that represents a metric in Eiffel query language"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	QL_METRIC

inherit
	QL_SHARED_SCOPE_CONSTANTS

	QL_SHARED_SCOPES
		undefine
			is_equal,
			copy
		end

feature -- Access

	unit: QL_METRIC_UNIT
			-- Unit of current metric

	value (a_domain: QL_DOMAIN): QL_QUANTITY_DOMAIN is
			-- Value of current metric
		require
			a_domain_attached: a_domain /= Void
		deferred
		ensure
			result_attached: Result /= Void
			result_has_one_value: Result.count = 1
		end

	name: STRING is
			-- Name of current metric
		do
			if name_internal = Void then
				create name_internal.make (0)
			end
			Result := name_internal
		ensure
			result_attached: Result /= Void
		end

feature -- Setting

	set_name (a_name: STRING) is
			-- Set `name' with `a_name'.
		require
			a_name_attached: a_name /= Void
		do
			create name_internal.make_from_string (a_name)
		ensure
			name_internal_set: name_internal /= Void and then name_internal.is_equal (a_name)
		end

	set_criterion (a_criterion: QL_CRITERION) is
			-- Set criterion used when calculate metric
			-- A metric can have several basic scopes, and `a_criterion' is only set into
			-- that scope which has the same scope as `a_criterion'.
		deferred
		end

	set_criteria (a_criteria: LIST [QL_CRITERION]) is
			-- Set criteria used when calculate metric
		require
			a_criteria_attached: a_criteria /= Void
		do
			a_criteria.do_all (agent set_criterion)
		end

feature{NONE} -- Implementation

	name_internal: like name
			-- Implementation of `name'

invariant
	unit_set_attached: unit /= Void

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
