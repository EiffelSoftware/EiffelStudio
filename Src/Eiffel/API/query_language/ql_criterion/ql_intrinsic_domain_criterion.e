note
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

	make (a_domain: like criterion_domain)
			-- Initialize `criterion_domain' with `a_feature'.
		require
			a_domain_attached: a_domain /= Void
		do
			set_criterion_domain (a_domain)
		ensure
			criterion_domain_set: criterion_domain = a_domain
		end

feature -- Access

	intrinsic_domain: QL_DOMAIN
			-- Intrinsic_domain which can be inferred from current criterion
		deferred
		ensure then
			intrinsic_domain_found: is_criterion_domain_evaluated
		end

feature -- Status report

	require_compiled: BOOLEAN = True
			-- Does current criterion require a compiled item?

	has_inclusive_intrinsic_domain: BOOLEAN
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

feature -- Process

	process (a_criterion_visitor: QL_CRITERION_VISITOR)
			-- Process Current using `a_criterion_visitor'.
		do
			a_criterion_visitor.process_intrinsic_domain_criterion (Current)
		end

feature{NONE} -- Implementation

	find_result
			-- Find possible result (maybe classes or features) of current criterion.
		deferred
		ensure
			candidate_not_cached_in_domain_generator:
				not is_intrinsic_domain_cached_in_domain_generator
		end

	reset
			-- Reset internal structure
		deferred
		end

	initialize_domain
			-- Initialize for `criterion_domain'.
		do
			reset
			find_result
			is_criterion_domain_evaluated := True
		end

	cache_intrinsic_domain
			-- Cache `intrinsic_domain' in `used_in_domain_generator'.
		do
			check used_in_domain_generator.is_temp_domain_used end
			used_in_domain_generator.temp_domain.content.fill (intrinsic_domain.content)
			is_intrinsic_domain_cached_in_domain_generator := True
		ensure
			candidate_cached: is_intrinsic_domain_cached_in_domain_generator
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
