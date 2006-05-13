indexing
	description: "Object that represents a criterion in Eiffel query lanagage"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	QL_CRITERION

inherit
	QL_SHARED_SCOPES

	REFACTORING_HELPER

feature -- Evaluate

	is_satisfied_by (a_item: QL_ITEM): BOOLEAN is
			-- Evaluate `a_item'.
		require
			a_item_attached: a_item /= Void
			source_domain_attached: source_domain /= Void
		deferred
		end

feature -- Status report

	require_compiled: BOOLEAN is
			-- Does current criterion require a compiled item?
		deferred
		end

	scope: QL_SCOPE is
			-- Scope of current ciretrion
		deferred
		ensure
			result_attached: Result /= Void
		end

	is_atomic: BOOLEAN is
			-- Is current criterion atomic?
		do
			Result := True
		end

	has_intrinsic_domain: BOOLEAN is
			-- Does current criterion has a domain by default?
		do
			Result := False
		end

feature -- Logic operations

	infix "and" (other: QL_CRITERION): QL_CRITERION is
			-- Boolean conjunction with `other'
		require
			other_exists: other /= Void
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	prefix "not": QL_CRITERION is
			-- Negation
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	infix "or" (other: QL_CRITERION): QL_CRITERION is
			-- Boolean disjunction with `other'
		require
			other_exists: other /= Void
		deferred
		ensure
			Result_not_void: Result /= Void
		end

feature -- Access

	compiled_criterion: QL_CRITERION is
			-- A criterion which takes `require_compiled' into account
		deferred
		ensure
			result_attached: Result /= Void
		end

	source_domain: QL_DOMAIN
			-- Source domain
			-- e.g, Current criterion is used in a domain generator when we want to
			-- generate a new domain from `source_domain'
			-- For example: in query:
			--
			--         from target select class where is_deferred
			--
			-- This query will give you all deferred classes in current system target.
			-- Here, "target" is source domain, and "class" will be the generated domain.
			-- Internally, a class domain generator will
			-- try to find all classes in "target" and then check if it satisfied by criterion "is_deferred",
			-- if so, the domain generator will put this class in newly generated domain.

feature{QL_CRITERION, QL_DOMAIN_GENERATOR} -- Setting

	set_source_domain (a_domain: like source_domain) is
			-- Set `source_domain' with `a_domain'.
		require
			a_domain_attached: a_domain /= Void
		do
			source_domain := a_domain
		ensure
			source_domain_set: source_domain = a_domain
		end

feature{QL_CRITERION, QL_DOMAIN_GENERATOR} -- Intrinsic domain

	intrinsic_domain: QL_DOMAIN is
			-- Intrinsic_domain which can be inferred from current criterion
		require
			source_domain_attached: source_domain /= Void
			current_has_intrinsic_domain: has_intrinsic_domain
		deferred
		ensure
			result_attached: has_intrinsic_domain implies Result /= Void
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
