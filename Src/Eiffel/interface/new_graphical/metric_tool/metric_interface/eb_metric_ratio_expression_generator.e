indexing
	description: "Ratio metric expression generator"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_RATIO_EXPRESSION_GENERATOR

inherit
	EB_METRIC_EXPRESSION_GENERATOR

	EB_METRIC_SHARED

create
	make

feature -- Access

	metric: EB_METRIC_RATIO
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
		do
			reset
			if metric /= Void then
				append_metric (metric.numerator_metric_name)
				text_list.extend (once " / ")
				format_list.extend (operator_format)
				append_metric (metric.denominator_metric_name)
			end
		end

feature{NONE} -- Implementation

	append_metric (a_metric_name: STRING) is
			-- Append `a_metric_name'
		require
			a_metric_name_attached: a_metric_name /= Void
		do
			text_list.extend (once "(")
			format_list.extend (normal_format)
			if a_metric_name.is_empty then
				text_list.extend ("No metric")
			else
				text_list.extend (a_metric_name)
			end
			if
				metric_manager.has_metric (a_metric_name) and then
				metric_manager.is_metric_valid (a_metric_name)
			then
				format_list.extend (normal_format)
			else
				format_list.extend (error_format)
			end
			text_list.extend (once ")")
			format_list.extend (normal_format)
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
