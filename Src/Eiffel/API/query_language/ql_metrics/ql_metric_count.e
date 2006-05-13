indexing
	description: "Object that represents a special metric which only returns number of items in a given domain as value"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QL_METRIC_COUNT

inherit
	QL_METRIC

	QL_SHARED_UNIT

feature -- Value

	value (a_domain: QL_DOMAIN): QL_QUANTITY_DOMAIN is
			-- Value of current metric
		local
			l_quantity: QL_QUANTITY
		do
			unit := no_unit
			create l_quantity.make_with_value (a_domain.count)
			Result := l_quantity.wrapped_domain
		end

feature -- Setting

	set_criterion (a_criterion: QL_CRITERION) is
			-- Set criterion used when calculate metric
			-- A metric can have several basic scopes, and `a_criterion' is only set into
			-- that scope which has the same scope as `a_criterion'.
		do
			-- Current metric doesn't need a criterion
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
