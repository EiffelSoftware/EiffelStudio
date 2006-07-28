indexing
	description: "Criterion which requires a domain"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	QL_DOMAIN_CRITERION

inherit
	QL_CRITERION
		undefine
			item_type
		redefine
			process
		end

feature -- Status report

	is_criterion_domain_evaluated: BOOLEAN
			-- Is criterion domain result found and ready to use?
			-- Every time after `set_criterion_domain' is used to set `criterion_domain' with a new domain,
			-- this should be set to False, and next time before this criterion can be used, `initialize_domain' should
			-- be invoked again to prepare the intrinsic domain result.

feature -- Access

	criterion_domain: QL_DOMAIN
			-- Criterion domain

feature -- Setting

	set_criterion_domain (a_domain: QL_DOMAIN) is
			-- Set `criterion_domain' with `a_domain'
		require
			a_domain_attached: a_domain /= Void
		deferred
		ensure
			criterion_domain_set: criterion_domain = a_domain
		end

feature -- Process

	process (a_criterion_visitor: QL_CRITERION_VISITOR) is
			-- Process Current using `a_criterion_visitor'.
		do
			a_criterion_visitor.process_domain_criterion (Current)
		end

feature{NONE} -- Initialization

	initialize_domain is
			-- Initialize for `criterion_domain'.
		deferred
		end

	initialize_agent: PROCEDURE [ANY, TUPLE] is
			-- Agent of `initialize_domain'
		do
			if initialize_agent_internal = Void then
				initialize_agent_internal := agent initialize_domain
			end
			Result := initialize_agent_internal
		ensure
			result_attached: Result /= Void
		end

	initialize_agent_internal: like initialize_agent;
			-- Implementation of `initialize_agent'

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
