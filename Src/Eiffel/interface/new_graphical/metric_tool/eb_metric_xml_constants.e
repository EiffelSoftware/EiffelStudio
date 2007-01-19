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

	t_none: INTEGER is 1
	t_description: INTEGER is 2
	t_metric: INTEGER is 3
	t_basic_metric: INTEGER is 4
	t_linear_metric: INTEGER is 5
	t_ratio_metric: INTEGER is 6
	t_variable_metric: INTEGER is 7
	t_criterion: INTEGER is 8
	t_normal_criterion: INTEGER is 9
	t_domain_criterion: INTEGER is 10
	t_text_criterion: INTEGER is 11
	t_path_criterion: INTEGER is 12
	t_caller_criterion: INTEGER is 13
	t_client_criterion: INTEGER is 14
	t_and_criterion: INTEGER is 15
	t_or_criterion: INTEGER is 16
	t_value_criterion: INTEGER is 17
	t_text: INTEGER is 18
	t_path: INTEGER is 19
	t_domain: INTEGER is 20
	t_domain_item: INTEGER is 21
	t_metric_archive: INTEGER is 22
	t_tester: INTEGER is 23
	t_tester_item: INTEGER is 24
	t_constant_value: INTEGER is 25
	t_metric_value: INTEGER is 26

feature{NONE} -- Attribute constants

	at_name: INTEGER is 1000
	at_unit: INTEGER is 1001
	at_numerator: INTEGER is 1002
	at_denominator: INTEGER is 1003
	at_denominator_scope: INTEGER is 1004
	at_negation: INTEGER is 1005
	at_case_sensitive: INTEGER is 1006
	at_regular_expression: INTEGER is 1007
	at_only_current_version: INTEGER is 1008
	at_id: INTEGER is 1009
	at_type: INTEGER is 1010
	at_coefficient: INTEGER is 1011
	at_time: INTEGER is 1012
	at_value: INTEGER is 1013
	at_uuid: INTEGER is 1014
	at_numerator_uuid: INTEGER is 1015
	at_denominator_uuid: INTEGER is 1016
	at_library_target_uuid: INTEGER is 1017
	at_filter: INTEGER is 1018
	at_numerator_coefficient: INTEGER is 1019
	at_denominator_coefficient: INTEGER is 1020
	at_normal: INTEGER is 1021
	at_only_syntactical: INTEGER is 1022
	at_indirect: INTEGER is 1023
	at_metric_name: INTEGER is 1024
	at_relation: INTEGER is 1025
	at_use_external_delayed: INTEGER is 1026

feature{NONE} -- Text

	n_metric: STRING is "metric"
	n_description: STRING is "description"
	n_basic_metric: STRING is "basic_metric"
	n_linear_metric: STRING is "linear_metric"
	n_ratio_metric: STRING is "ratio_metric"
	n_variable_metric: STRING is "variable_metric"
	n_criterion: STRING is "criterion"
	n_normal_criterion: STRING is "normal_criterion"
	n_domain_criterion: STRING is "domain_criterion"
	n_text_criterion: STRING is "text_criterion"
	n_path_criterion: STRING is "path_criterion"
	n_caller_criterion: STRING is "caller_criterion"
	n_client_criterion: STRING is "client_criterion"
	n_text: STRING is "text"
	n_path: STRING is "path"
	n_domain: STRING is "domain"
	n_domain_item: STRING is "domain_item"
	n_metric_value: STRING is "metric_value"
	n_name: STRING is "name"
	n_unit: STRING is "unit"
	n_numerator: STRING is "numerator"
	n_denominator: STRING is "denominator"
	n_denominator_scope: STRING is "denominator_scope"
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
	n_metric_archive: STRING is "metric_archive"
	n_uuid: STRING is "uuid"
	n_numerator_uuid: STRING is "numerator_uuid"
	n_denominator_uuid: STRING is "denominator_uuid"
	n_library_target_uuid: STRING is "library_target_uuid"
	n_filter: STRING is "filter"
	n_numerator_coefficient: STRING is "numerator_coefficient"
	n_denominator_coefficient: STRING is "denominator_coefficient"
	n_normal: STRING is "normal"
	n_only_syntactical: STRING is "only_syntactical"
	n_indirect: STRING is "indirect"
	n_delayed_domain_id: STRING is "delayed"
	n_value_criterion: STRING is "value_criterion"
	n_tester: STRING is "tester";
	n_tester_item: STRING is "tester_item"
	n_constant_value: STRING is "constant_value"
	n_relation: STRING is "relation"
	n_metric_name: STRING is "metric_name"
	n_use_external_delayed: STRING is "use_external_delayed";

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
