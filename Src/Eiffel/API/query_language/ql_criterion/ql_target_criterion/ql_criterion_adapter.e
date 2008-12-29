note
	description: "Object that represents a criterion adapter"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	QL_CRITERION_ADAPTER

inherit
	QL_CRITERION
		undefine
			process,
			item_type
		redefine
			set_source_domain,
			intrinsic_domain,
			set_used_in_domain_generator
		end

feature{NONE} -- Initialization

	make (a_criterion: like wrapped_criterion)
			-- Initialize `wrapped_criterion' with `a_criterion'.
		require
			a_criterion_attached: a_criterion /= Void
		do
			wrapped_criterion := a_criterion
		ensure
			wrapped_criterion_attached: wrapped_criterion = a_criterion
		end

feature -- Access

	wrapped_criterion: QL_CRITERION
			-- Criterion to which NOT operation is applied

	intrinsic_domain: QL_DOMAIN
			-- Intrinsic_domain which can be inferred from current criterion
		deferred
		end

feature -- Setting

	set_source_domain (a_domain: like source_domain)
			-- Set `source_domain' with `a_domain'.
		do
			Precursor (a_domain)
			wrapped_criterion.set_source_domain (a_domain)
		ensure then
			current_domain_set_recursively: wrapped_criterion.source_domain = source_domain
		end

feature{QL_DOMAIN_GENERATOR, QL_CRITERION} -- Setting

	set_used_in_domain_generator (a_domain_generator: QL_DOMAIN_GENERATOR)
			-- Set `used_in_domain_generator' with
			-- If `a_domain_generator' is Void, current `used_in_domain_generator' will be removed.
		do
			used_in_domain_generator := a_domain_generator
			wrapped_criterion.set_used_in_domain_generator (a_domain_generator)
		ensure then
			wrapped_criterion_used_in_domain_generator_set: wrapped_criterion.used_in_domain_generator = a_domain_generator
		end

feature -- Process

	process (a_criterion_visitor: QL_CRITERION_VISITOR)
			-- Process Current using `a_criterion_visitor'.
		do
			a_criterion_visitor.process_criterion_adapter (Current)
		end

invariant
	wrapped_criterion_attached: wrapped_criterion /= Void

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
