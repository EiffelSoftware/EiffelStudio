indexing
	description: "[
					Object that represents a criteiron in which an intrinsic domain is provided which may be
					used in query optimization.
				]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	QL_INTRINSIC_DOMAIN_CRITERION

inherit
	QL_CRITERION
		redefine
			has_intrinsic_domain
		end

feature{NONE} -- Initialization

	make (a_domain: like criterion_domain) is
			-- Initialize `criterion_domain' with `a_feature'.
		require
			a_domain_attached: a_domain /= Void
		do
			set_criterion_domain (a_domain)
		ensure
			criterion_domain_set: criterion_domain = a_domain
		end

feature -- Access

	criterion_domain: QL_DOMAIN
			-- Criterion domain from which `intrinsic_domain' are evaluated

feature -- Status report

	require_compiled: BOOLEAN is True
			-- Does current criterion require a compiled item?

	has_intrinsic_domain: BOOLEAN is
			-- Does current criterion has a domain by default?
		do
			Result := not criterion_domain.is_delayed
		ensure then
			good_result: Result implies (not criterion_domain.is_delayed)
		end

feature -- Setting

	set_criterion_domain (a_domain: QL_DOMAIN) is
			-- Set `criterion_domain' with `a_domain'
		require
			a_domain_attached: a_domain /= Void
		local
			l_delayed_domain: QL_DELAYED_DOMAIN
		do
			criterion_domain := a_domain
			reset
			if not criterion_domain.is_delayed then
				find_result
			else
				l_delayed_domain ?= a_domain
				check l_delayed_domain /= Void end
				l_delayed_domain.actions.extend (agent initialize_delayed_domain)
			end
		ensure
			criterion_domain_set: criterion_domain = a_domain
		end

feature{NONE} -- Implementation

	find_result is
			-- Find possible result (maybe classes or features) of current criterion.
		deferred
		end

	reset is
			-- Reset internal structure
		deferred
		end

	initialize_delayed_domain is
			-- Initialize_delayed_domain `criterion_domain' if it's a delayed domain.
		require
			criterion_domain_is_delayed: criterion_domain.is_delayed
		do
			reset
			find_result
		end

invariant
	criterion_domain_attached: criterion_domain /= Void

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
