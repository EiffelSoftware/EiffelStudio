indexing
	description: "Objects that represents a n-nary criterion"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_METRIC_NARY_CRITERION

inherit
	EB_METRIC_NORMAL_CRITERION
		rename
			make as old_make
		redefine
			is_parameter_valid,
			replace_delayed_input_domain,
			is_nary_criterion
		end

feature{NONE} -- Initialization

	make (a_scope: like scope; a_name: STRING) is
			-- Initialize `scope' with `a_scope', `name' with `a_name' and `operands'.
		require
			a_scope_attached: a_scope /= Void
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
		do
			set_name (a_name)
			set_scope (a_scope)
			create {LINKED_LIST [EB_METRIC_CRITERION]} operands.make
		ensure then
			name_set: name /= Void and then name.is_equal (a_name)
			scope_set: scope = a_scope
			result_attached: operands /= Void
		end

feature -- Access

	operands: LIST [EB_METRIC_CRITERION]
			-- Operands of current "AND" operation

feature -- Status report

	is_parameter_valid: BOOLEAN is
			-- Is parameters of current criterion valid?
		local
			l_cursor: CURSOR
		do
			Result := True
			if not operands.is_empty then
				l_cursor := operands.cursor
				from
					operands.start
				until
					operands.after or not Result
				loop
					Result := operands.item.is_valid
					operands.forth
				end
				operands.go_to (l_cursor)
			end
		end

	is_nary_criterion: BOOLEAN is True
			-- Is current a nary criterion?

feature{NONE} -- Implementation

	delayed_input_domain_in_operand (a_operand: EB_METRIC_CRITERION): BOOLEAN is
			-- Does `a_operand' contain delayed input domain?
		require
			a_operand_attached: a_operand /= Void
		do
			Result := a_operand.has_delayed_input_domain
		end

	replace_delayed_input_domain (a_domain: EB_METRIC_DOMAIN) is
			-- Replace delayed input domain contained in Current by `a_domain'.
		do
			from
				operands.start
			until
				operands.after
			loop
				operands.item.replace_delayed_input_domain (a_domain)
				operands.forth
			end
		end

invariant
	operands_attached: operands /= Void

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
