note
	description: "Objects that represents a wrapper criterion to require that an item must be a compiled item"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QL_GROUP_IS_COMPILED_CRI_IMP

inherit
	QL_GROUP_CRITERION
		undefine
			has_inclusive_intrinsic_domain,
			has_exclusive_intrinsic_domain,
			set_source_domain,
			require_compiled,
			process,
			set_used_in_domain_generator
		redefine
			compiled_criterion,
			intrinsic_domain
		end

	QL_ITEM_IS_COMPILED_CRI_IMP
		redefine
			compiled_criterion,
			wrapped_criterion,
			intrinsic_domain
		end

create
	make

feature -- Access

	wrapped_criterion: QL_GROUP_CRITERION
			-- Wrapped criterion

	compiled_criterion: QL_GROUP_CRITERION
			-- A criterion which takes `require_compiled' into account
		do
			Result := Current
		ensure then
			Result = Current
		end

	intrinsic_domain: QL_GROUP_DOMAIN
			-- Intrinsic_domain which can be inferred from current criterion
		do
			create Result.make
			fill_intrinsic_domain (wrapped_criterion.intrinsic_domain, Result)
		end

feature -- Evaluate

	is_satisfied_by (a_item: QL_GROUP): BOOLEAN
			-- Evaluate `a_item'.
		do
			if a_item.is_compiled then
				Result := wrapped_criterion.is_satisfied_by (a_item)
			end
		ensure then
			good_result: Result implies (a_item.is_compiled) and then wrapped_criterion.is_satisfied_by (a_item)
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
