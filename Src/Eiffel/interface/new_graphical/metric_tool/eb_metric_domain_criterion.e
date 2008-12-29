note
	description: "Criterion that uses a domain as argument"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_DOMAIN_CRITERION

inherit
	EB_METRIC_CRITERION
		redefine
			process,
			is_domain_criterion,
			make
		end

	QL_SHARED

create
	make

feature{NONE} -- Initialization

	make (a_scope: like scope; a_name: STRING)
			-- Initialize `scope' with `a_scope' and `name' with `a_name'.
		do
			Precursor (a_scope, a_name)
			create domain.make
		ensure then
			domain_attached: domain /= Void
		end

feature -- Access

	domain: EB_METRIC_DOMAIN
			-- Domain used in current criterion

	new_criterion (a_scope: QL_SCOPE): QL_CRITERION
			-- QL_CRITERION representing current criterion
		local
			l_criterion_factory: QL_CRITERION_FACTORY
			l_domain: like domain
		do
			l_criterion_factory := criterion_factory_table.item (a_scope)
			l_domain := domain.actual_domain
			if l_domain.is_empty then
				Result := l_criterion_factory.criterion_with_name (name, [dummy_domain])
			else
				from
					l_domain.start
					Result := l_criterion_factory.criterion_with_name (name, [l_domain.item.domain (scope)])
					l_domain.forth
				until
					l_domain.after
				loop
					Result := Result or l_criterion_factory.criterion_with_name (name, [l_domain.item.domain (scope)])
					l_domain.forth
				end
			end
			if is_negation_used then
				Result := not Result
			end
		end

feature -- Status report

	is_parameter_valid: BOOLEAN
			-- Is parameters of current criterion valid?
			-- Parameter for current is `domain'.
		do
			Result := domain.is_valid
		end

	is_domain_criterion: BOOLEAN = True
			-- Is current a domain criterion?

feature -- Setting

	set_domain (a_domain: like domain)
			-- Set `domain' with `a_domain'.
		require
			a_domain_attached: a_domain /= Void
		do
			domain := a_domain.twin
		end

feature -- Process

	process (a_visitor: EB_METRIC_VISITOR)
			-- Process current using `a_visitor'.
		do
			a_visitor.process_domain_criterion (Current)
		end

invariant
	domain_attached: domain /= Void

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
