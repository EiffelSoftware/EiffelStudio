indexing
	description: "Object that represents an No operation on another target criterion"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QL_TARGET_NOT_CRITERION

inherit
	QL_TARGET_CRITERION
		undefine
			set_used_in_domain_generator,
			is_atomic,
			set_source_domain,
			has_inclusive_intrinsic_domain,
			has_exclusive_intrinsic_domain,
			require_compiled,
			process
		redefine
			intrinsic_domain
		end

	QL_NOT_CRITERION
		redefine
			wrapped_criterion,
			intrinsic_domain
		end

create
	make

feature -- Evaluate

	is_satisfied_by (a_item: QL_TARGET): BOOLEAN is
			-- Evaluate `a_item'.
		do
			Result := not wrapped_criterion.is_satisfied_by (a_item)
		end

feature -- Access

	wrapped_criterion: QL_TARGET_CRITERION
			-- Criterion to which NOT operation is applied

	intrinsic_domain: QL_TARGET_DOMAIN is
			-- Intrinsic_domain which can be inferred from current criterion
		do
			Result := wrapped_criterion.intrinsic_domain
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
