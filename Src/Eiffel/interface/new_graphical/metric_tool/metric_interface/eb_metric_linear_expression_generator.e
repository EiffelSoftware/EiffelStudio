indexing
	description: "Linear metric expression generator"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_LINEAR_EXPRESSION_GENERATOR

inherit
	EB_METRIC_EXPRESSION_GENERATOR

	EB_METRIC_SHARED

create
	make

feature -- Access

	metric: EB_METRIC_LINEAR
			-- Metric whose expression is to be generated

feature -- Basic operation

	set_metric (a_metric: like metric) is
			-- Set `metric' with `a_metric'.
		do
			metric := a_metric
		ensure
			metric_set: metric = a_metric
		end

	generate_expression is
			-- Generate expression in `text_list' and `format_list'.
		local
			l_metrics: LIST [STRING]
			l_coefficients: LIST [DOUBLE]
			l_is_first: BOOLEAN
			l_coefficient: DOUBLE
		do
			reset
			if metric /= Void then
				l_metrics := metric.variable_metric
				l_coefficients := metric.coefficient
				from
					l_is_first := True
					l_metrics.start
					l_coefficients.start
				until
					l_metrics.after or l_coefficients.after
				loop
					l_coefficient := l_coefficients.item
					if l_coefficient >= 0 then
						if not l_is_first then
							text_list.extend (once " + ")
							format_list.extend (operator_format)
						end
					else
						if not l_is_first then
							text_list.extend (once " - ")
						else
							text_list.extend (once "- ")
						end
						format_list.extend (operator_format)
					end
					text_list.extend (l_coefficient.abs.out)
					format_list.extend (number_format)

					text_list.extend (once " * ")
					format_list.extend (operator_format)

					text_list.extend (once "(")
					format_list.extend (normal_format)

					text_list.extend (l_metrics.item)
					if metric_manager.has_metric (l_metrics.item) and then metric_manager.is_metric_valid (l_metrics.item) then
						format_list.extend (normal_format)
					else
						format_list.extend (error_format)
					end

					text_list.extend (once ")")
					format_list.extend (normal_format)

					l_is_first := False
					l_metrics.forth
					l_coefficients.forth
				end
			end
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
