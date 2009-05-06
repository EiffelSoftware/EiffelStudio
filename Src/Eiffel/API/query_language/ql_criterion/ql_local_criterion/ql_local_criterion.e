note
	description: "Object that represents a class local criterion in Eiffel query lanagage"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	QL_LOCAL_CRITERION

inherit
	QL_CRITERION
		redefine
			is_satisfied_by,
			require_compiled,
			compiled_criterion,
			intrinsic_domain,
			domain_generator,
			item_type
		end

feature -- Evaluate

	is_satisfied_by (a_item: QL_LOCAL): BOOLEAN
			-- Evaluate `a_item'.
		deferred
		end

feature -- Status report

	require_compiled: BOOLEAN
			-- Does current criterion require a compiled item?
		do
			Result := True
		end

feature -- Access

	scope: QL_SCOPE
			-- Scope of current ciretrion
		do
			Result := local_scope
		ensure then
			good_result: Result.is_equal (local_scope)
		end

	domain_generator (a_enable_fill_domain: BOOLEAN; a_apply_current: BOOLEAN): QL_LOCAL_DOMAIN_GENERATOR
			-- Domain generator in which current criterion can be used
			-- If `a_enable_fill_domain' is True, return a generator with `fill_domain_enabled' set to True.
			-- If `a_apply_current' is True, return a generator with `criterion' set to Current.
		do
			create Result
			setup_domain_generator (Result, a_enable_fill_domain, a_apply_current)
		end

	intrinsic_domain: QL_LOCAL_DOMAIN
			-- Intrinsic_domain which can be inferred from current criterion
		do
		end

feature -- Logic operations

	conjuncted alias "and" (other: QL_LOCAL_CRITERION): QL_LOCAL_CRITERION
			-- Boolean conjunction with `other'
		do
			create {QL_LOCAL_AND_CRITERION}Result.make (Current, other)
		end

	negated alias "not": QL_LOCAL_CRITERION
			-- Negation
		do
			create {QL_LOCAL_NOT_CRITERION}Result.make (Current)
		end

	disjuncted alias "or" (other: QL_LOCAL_CRITERION): QL_LOCAL_CRITERION
			-- Boolean disjunction with `other'		
		do
			create {QL_LOCAL_OR_CRITERION}Result.make (Current, other)
		end

feature -- Access

	compiled_criterion: QL_LOCAL_CRITERION
			-- A criterion which takes `require_compiled' into account
		do
			if require_compiled then
				create {QL_LOCAL_IS_COMPILED_CRI_IMP}Result.make (Current)
			else
				Result := Current
			end
		end

feature{NONE} -- Implementation

	item_type: QL_LOCAL
			-- Anchor type
		do
		end

note
        copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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
