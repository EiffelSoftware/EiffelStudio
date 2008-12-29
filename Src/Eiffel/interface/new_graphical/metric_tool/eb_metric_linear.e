note
	description: "[
					Linear metric
					Linear metric is metric defined in linear form, for example:
						metric_A ::= 1.0 * metric_B + 5.0 * metric_C - 4.0 * metric_D
					
					in the above definition, 1.0, 5.0 and -4.0 are coefficient, and
					and metric_B, metric_C and  metric_D are called variable metrics.
				]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_LINEAR

inherit
	EB_METRIC
		redefine
			is_linear
		end

create
	make

feature -- Status report

	is_result_domain_available: BOOLEAN
			-- After metric calculation, can we get the last generated domain
			-- for detail display?
		do
			Result := False
		end

	is_linear: BOOLEAN = True
			-- Is current a linear metric?

feature -- Metric calculation

	value (a_scope: EB_METRIC_DOMAIN): QL_QUANTITY_DOMAIN
			-- Value of current metric calculated over `a_scope'
		local
			l_value: DOUBLE
		do
			last_result_domain := Void
			from
				variable_metric.start
				coefficient.start
			until
				variable_metric.after
			loop
				l_value := l_value + term_value (manager.metric_with_name (variable_metric.item), coefficient.item, a_scope)
				variable_metric.forth
				coefficient.forth
			end
			create Result.make
			Result.extend (create{QL_QUANTITY}.make_with_value (l_value))
		end

feature -- Access

	coefficient: LIST [DOUBLE]
			-- Coefficient of `variable_metric'
		do
			if coefficient_internal = Void then
				create {LINKED_LIST [DOUBLE]} coefficient_internal.make
			end
			Result := coefficient_internal
		ensure
			result_attached: Result /= Void
		end

	variable_metric: LIST [STRING]
			-- Variable metrics in current linear metric
		do
			if variable_metric_internal = Void then
				create {LINKED_LIST [STRING]} variable_metric_internal.make
			end
			Result := variable_metric_internal
		ensure
			result_attached: Result /= Void
		end

feature -- Process

	process (a_visitor: EB_METRIC_VISITOR)
			-- Process current using `a_visitor'.
		do
			a_visitor.process_linear_metric (Current)
		end

feature{NONE} -- Implementation

	coefficient_internal: like coefficient
			-- Implementation of `coefficient'

	variable_metric_internal: like variable_metric
			-- Implementation of `variable_metric'

	term_value (a_metric: EB_METRIC; a_coefficient: DOUBLE; a_scope: EB_METRIC_DOMAIN): DOUBLE
			-- Value of `a_metric' * a_coefficient with `a_scope' as input
		require
			a_metric_attached: a_metric /= Void
			a_scope_attached: a_scope /= Void
			manager_attached: manager /= Void
		do
			a_metric.disable_fill_domain
			if should_result_be_filtered then
				a_metric.enable_filter_result
			else
				a_metric.disable_filter_result
			end
			Result := a_metric.value_item (a_scope) * a_coefficient
		end

invariant
	coefficient_attached: coefficient /= Void
	variable_metri_attached: variable_metric /= Void

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
