indexing
	description: "[
					Metric "OR" criterion
				]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_OR_CRITERION

inherit
	EB_METRIC_NARY_CRITERION
		redefine
			process,
			is_or_criterion,
			new_criterion,
			has_delayed_input_domain
		end

create
	make

feature -- Access

	new_criterion (a_scope: QL_SCOPE): QL_CRITERION is
			-- QL_CRITERION representing current criterion			
		local
			l_cursor: CURSOR
		do
			if operands.is_empty then
				Result := criterion_factory_table.item (a_scope).criterion_with_name ("true", [])
			else
				l_cursor := operands.cursor
				from
					operands.start
					Result := operands.item.new_criterion (a_scope)
					operands.forth
				until
					operands.after
				loop
					Result := Result or operands.item.new_criterion (a_scope)
					operands.forth
				end
				operands.go_to (l_cursor)
			end
			if Result /= Void and then is_negation_used then
				Result := not Result
			end
		end

feature -- Process

	process (a_visitor: EB_METRIC_VISITOR) is
			-- Process current using `a_visitor'.
		do
			a_visitor.process_or_criterion (Current)
		end

feature -- Status report

	is_or_criterion: BOOLEAN is True;
			-- Is current an "or" criterion?	

	has_delayed_input_domain: BOOLEAN is
			-- Does current domain contain reference to a delayed domain which represents an delayed input domain?
			-- An delayed input domain should be replaced by actual input domain before metric calculation.
		do
			Result := operands.there_exists (agent delayed_input_domain_in_operand)
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
