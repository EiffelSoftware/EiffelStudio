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
	QL_DOMAIN_CRITERION
		undefine
			process
		redefine
			has_inclusive_intrinsic_domain,
			intrinsic_domain
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

	intrinsic_domain: QL_DOMAIN is
			-- Intrinsic_domain which can be inferred from current criterion
		deferred
		ensure then
			intrinsic_domain_found: is_criterion_domain_evaluated
		end

feature -- Status report

	require_compiled: BOOLEAN is True
			-- Does current criterion require a compiled item?

	has_inclusive_intrinsic_domain: BOOLEAN is
			-- Does current criterion has a domain by default?
		do
			Result := not criterion_domain.is_delayed
		ensure then
			good_result: Result implies (not criterion_domain.is_delayed)
		end

	is_intrinsic_domain_cached_in_domain_generator: BOOLEAN
			-- Is `intrinsic_domain' stored in `used_in_domain_generator'?
			-- This is used only when `used_in_domain_generator' CANNOT use intrinsic domain or optimization switch is turned off.
			-- This is needed because if some items from `intrinsic_domain' is not visible from `source_domain', we will not get
			-- them by going through `source_domain'. So we store those items in `used_in_domain_generator', and after the going through,
			-- we processed those items separately.

feature -- Setting

	set_criterion_domain (a_domain: QL_DOMAIN) is
			-- Set `criterion_domain' with `a_domain'
		local
			l_delayed_domain: QL_DELAYED_DOMAIN
		do
			if criterion_domain /= Void and then criterion_domain.is_delayed then
				l_delayed_domain ?= criterion_domain
				if l_delayed_domain.actions.has (initialize_agent) then
					l_delayed_domain.actions.prune_all (initialize_agent)
				end
			end
			criterion_domain := a_domain
			is_criterion_domain_evaluated := False
			if criterion_domain.is_delayed then
				l_delayed_domain ?= a_domain
				check l_delayed_domain /= Void end
				if not l_delayed_domain.actions.has (initialize_agent) then
					l_delayed_domain.actions.extend (initialize_agent)
				end
			end
		end

feature -- Process

	process (a_criterion_visitor: QL_CRITERION_VISITOR) is
			-- Process Current using `a_criterion_visitor'.
		do
			a_criterion_visitor.process_intrinsic_domain_criterion (Current)
		end

feature{NONE} -- Implementation

	find_result is
			-- Find possible result (maybe classes or features) of current criterion.
		deferred
		ensure
			intrinsic_result_found: is_criterion_domain_evaluated
			candidate_not_cached_in_domain_generator:
				not is_intrinsic_domain_cached_in_domain_generator
		end

	reset is
			-- Reset internal structure
		deferred
		end

	initialize_domain is
			-- Initialize for `criterion_domain'.
		do
			reset
			find_result
		end

	cache_intrinsic_domain is
			-- Cache `intrinsic_domain' in `used_in_domain_generator'.
		do
			check used_in_domain_generator.is_temp_domain_used end
			used_in_domain_generator.temp_domain.content.fill (intrinsic_domain.content)
			is_intrinsic_domain_cached_in_domain_generator := True
		ensure
			candidate_cached: is_intrinsic_domain_cached_in_domain_generator
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
