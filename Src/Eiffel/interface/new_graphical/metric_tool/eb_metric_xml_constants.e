indexing
	description: "Constants used in xml representation of metrics"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_XML_CONSTANTS

feature{NONE} -- Element constants

	t_none,
	t_description,
	t_metric,
	t_basic_metric,
	t_linear_metric,
	t_ratio_metric,
	t_scope_ratio_metric,
	t_variable_metric,
	t_criterion,
	t_normal_criterion,
	t_domain_criterion,
	t_text_criterion,
	t_path_criterion,
	t_caller_criterion,
	t_and_criterion,
	t_or_criterion,
	t_text,
	t_path,
	t_domain,
	t_domain_item,
	t_metric_archive: INTEGER is unique

feature{NONE} -- Attribute constants

	at_name,
	at_unit,
	at_numerator,
	at_denominator,
	at_denominator_scope,
	at_scope,
	at_negation,
	at_case_sensitive,
	at_regular_expression,
	at_only_current_version,
	at_id,
	at_type,
	at_coefficient,
	at_time,
	at_value: INTEGER is unique

feature{NONE} -- Text

	n_metric: STRING is "metric"
	n_description: STRING is "description"
	n_basic_metric: STRING is "basic_metric"
	n_linear_metric: STRING is "linear_metric"
	n_ratio_metric: STRING is "ratio_metric"
	n_scope_ratio_metric: STRING is "scope_ratio"
	n_variable_metric: STRING is "variable_metric"
	n_criterion: STRING is "criterion"
	n_normal_criterion: STRING is "normal_criterion"
	n_domain_criterion: STRING is "domain_criterion"
	n_text_criterion: STRING is "text_criterion"
	n_path_criterion: STRING is "path_criterion"
	n_caller_criterion: STRING is "caller_criterion"
	n_text: STRING is "text"
	n_path: STRING is "path"
	n_domain: STRING is "domain"
	n_domain_item: STRING is "domain_item"

	n_name: STRING is "name"
	n_unit: STRING is "unit"
	n_numerator: STRING is "numerator"
	n_denominator: STRING is "denominator"
	n_denominator_scope: STRING is "denominator_scope"
	n_scope: STRING is"scope"
	n_negation: STRING is "negation"
	n_case_sensitive: STRING is "case_sensitive"
	n_regular_expression: STRING is "regular_expression"
	n_id: STRING is "id"
	n_type: STRING is "type"
	n_coefficient: STRING is "coefficient"
	n_only_current_version: STRING is "only_current_version"
	n_class: STRING is "class"
	n_feature: STRING is "feature"
	n_folder: STRING is "folder"
	n_target: STRING is "target"
	n_group: STRING is "group"
	n_delayed: STRING is "delayed"
	n_and_criterion: STRING is "and_criterion"
	n_or_criterion: STRING is "or_criterion"
	n_time: STRING is "time"
	n_basic: STRING is "basic"
	n_linear: STRING is "linear"
	n_ratio: STRING is "ratio"
	n_value: STRING is "value"
	n_metric_archive: STRING is "metric_archive";

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
