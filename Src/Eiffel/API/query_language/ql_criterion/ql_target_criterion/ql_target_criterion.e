indexing
	description: "Object that represents a target criterion in Eiffel query lanagage"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	QL_TARGET_CRITERION

inherit
	QL_CRITERION
		redefine
			is_satisfied_by,
			infix "and",
			prefix "not",
			infix "or",
			require_compiled,
			compiled_criterion,
			intrinsic_domain,
			domain_generator,
			item_type
		end

feature -- Evaluate

	is_satisfied_by (a_item: like item_type): BOOLEAN is
			-- Evaluate `a_item'.
		deferred
		end

feature -- Status report

	require_compiled: BOOLEAN is
			-- Does current criterion require a compiled item?
		do
			Result := False
		end

feature -- Access

	scope: QL_SCOPE is
			-- Scope of current ciretrion
		do
			Result := target_scope
		ensure then
			good_result: Result.is_equal (target_scope)
		end

	domain_generator (a_enable_fill_domain: BOOLEAN; a_apply_current: BOOLEAN): QL_TARGET_DOMAIN_GENERATOR is
			-- Domain generator in which current criterion can be used
			-- If `a_enable_fill_domain' is True, return a generator with `fill_domain_enabled' set to True.
			-- If `a_apply_current' is True, return a generator with `criterion' set to Current.
		do
			create Result
			setup_domain_generator (Result, a_enable_fill_domain, a_apply_current)
		end

	intrinsic_domain: QL_TARGET_DOMAIN is
			-- Intrinsic_domain which can be inferred from current criterion
		do
		end

feature -- Logic operations

	infix "and" (other: QL_TARGET_CRITERION): QL_TARGET_CRITERION is
			-- Boolean conjunction with `other'
		do
			create {QL_TARGET_AND_CRITERION}Result.make (Current, other)
		end

	prefix "not": QL_TARGET_CRITERION is
			-- Negation
		do
			create {QL_TARGET_NOT_CRITERION}Result.make (Current)
		end

	infix "or" (other: QL_TARGET_CRITERION): QL_TARGET_CRITERION is
			-- Boolean disjunction with `other'		
		do
			create {QL_TARGET_OR_CRITERION}Result.make (Current, other)
		end

feature -- Access

	compiled_criterion: QL_TARGET_CRITERION is
			-- A criterion which takes `require_compiled' into account
		do
			if require_compiled then
				create {QL_TARGET_IS_COMPILED_CRI_IMP}Result.make (Current)
			else
				Result := Current
			end
		end

feature{NONE} -- Implementation

	item_type: QL_TARGET is
			-- Anchor type
		do
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
