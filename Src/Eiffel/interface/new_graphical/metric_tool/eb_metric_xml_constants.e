note
	description: "Constants used in xml representation of metrics"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_XML_CONSTANTS

feature{NONE} -- Element constants

	t_none: INTEGER = 1
	t_description: INTEGER = 2
	t_metric: INTEGER = 3
	t_basic_metric: INTEGER = 4
	t_linear_metric: INTEGER = 5
	t_ratio_metric: INTEGER = 6
	t_variable_metric: INTEGER = 7
	t_criterion: INTEGER = 8
	t_normal_criterion: INTEGER = 9
	t_domain_criterion: INTEGER = 10
	t_text_criterion: INTEGER = 11
	t_path_criterion: INTEGER = 12
	t_caller_criterion: INTEGER = 13
	t_client_criterion: INTEGER = 14
	t_and_criterion: INTEGER = 15
	t_or_criterion: INTEGER = 16
	t_value_criterion: INTEGER = 17
	t_text: INTEGER = 18
	t_path: INTEGER = 19
	t_domain: INTEGER = 20
	t_domain_item: INTEGER = 21
	t_metric_archive: INTEGER = 22
	t_tester: INTEGER = 23
	t_tester_item: INTEGER = 24
	t_constant_value: INTEGER = 25
	t_metric_value: INTEGER = 26
	t_pixmap: INTEGER = 27
	t_input: INTEGER = 28
	t_output: INTEGER = 29
	t_error: INTEGER = 30
	t_command: INTEGER = 31
	t_command_criterion: INTEGER = 32
	t_exit_code: INTEGER = 33
	t_working_directory: INTEGER = 34

feature{NONE} -- Attribute constants

	at_name: INTEGER = 1000
	at_unit: INTEGER = 1001
	at_numerator: INTEGER = 1002
	at_denominator: INTEGER = 1003
	at_negation: INTEGER = 1005
	at_case_sensitive: INTEGER = 1006
	at_regular_expression: INTEGER = 1007
	at_only_current_version: INTEGER = 1008
	at_id: INTEGER = 1009
	at_type: INTEGER = 1010
	at_coefficient: INTEGER = 1011
	at_time: INTEGER = 1012
	at_value: INTEGER = 1013
	at_uuid: INTEGER = 1014
	at_numerator_uuid: INTEGER = 1015
	at_denominator_uuid: INTEGER = 1016
	at_library_target_uuid: INTEGER = 1017
	at_filter: INTEGER = 1018
	at_numerator_coefficient: INTEGER = 1019
	at_denominator_coefficient: INTEGER = 1020
	at_normal: INTEGER = 1021
	at_only_syntactical: INTEGER = 1022
	at_indirect: INTEGER = 1023
	at_metric_name: INTEGER = 1024
	at_relation: INTEGER = 1025
	at_use_external_delayed: INTEGER = 1026
	at_location: INTEGER = 1027
	at_matching_strategy: INTEGER = 1028
	at_enabled: INTEGER = 1029
	at_redirected_to_output: INTEGER = 1030
	at_as_file_name: INTEGER = 1031

feature{NONE} -- Text

	n_metric: STRING = "metric"
	n_description: STRING = "description"
	n_basic_metric: STRING = "basic_metric"
	n_linear_metric: STRING = "linear_metric"
	n_ratio_metric: STRING = "ratio_metric"
	n_variable_metric: STRING = "variable_metric"
	n_criterion: STRING = "criterion"
	n_normal_criterion: STRING = "normal_criterion"
	n_domain_criterion: STRING = "domain_criterion"
	n_text_criterion: STRING = "text_criterion"
	n_path_criterion: STRING = "path_criterion"
	n_caller_criterion: STRING = "caller_criterion"
	n_client_criterion: STRING = "client_criterion"
	n_text: STRING = "text"
	n_path: STRING = "path"
	n_domain: STRING = "domain"
	n_domain_item: STRING = "domain_item"
	n_metric_value: STRING = "metric_value"
	n_name: STRING = "name"
	n_unit: STRING = "unit"
	n_numerator: STRING = "numerator"
	n_denominator: STRING = "denominator"
	n_negation: STRING = "negation"
	n_case_sensitive: STRING = "case_sensitive"
	n_regular_expression: STRING = "regular_expression"
	n_id: STRING = "id"
	n_type: STRING = "type"
	n_coefficient: STRING = "coefficient"
	n_only_current_version: STRING = "only_current_version"
	n_class: STRING = "class"
	n_feature: STRING = "feature"
	n_folder: STRING = "folder"
	n_target: STRING = "target"
	n_group: STRING = "group"
	n_delayed: STRING = "delayed"
	n_and_criterion: STRING = "and_criterion"
	n_or_criterion: STRING = "or_criterion"
	n_time: STRING = "time"
	n_basic: STRING = "basic"
	n_linear: STRING = "linear"
	n_ratio: STRING = "ratio"
	n_value: STRING = "value"
	n_metric_archive: STRING = "metric_archive"
	n_uuid: STRING = "uuid"
	n_numerator_uuid: STRING = "numerator_uuid"
	n_denominator_uuid: STRING = "denominator_uuid"
	n_library_target_uuid: STRING = "library_target_uuid"
	n_filter: STRING = "filter"
	n_numerator_coefficient: STRING = "numerator_coefficient"
	n_denominator_coefficient: STRING = "denominator_coefficient"
	n_normal: STRING = "normal"
	n_only_syntactical: STRING = "only_syntactical"
	n_indirect: STRING = "indirect"
	n_delayed_domain_id: STRING = "delayed"
	n_value_criterion: STRING = "value_criterion"
	n_tester: STRING = "tester";
	n_tester_item: STRING = "tester_item"
	n_constant_value: STRING = "constant_value"
	n_relation: STRING = "relation"
	n_metric_name: STRING = "metric_name"
	n_use_external_delayed: STRING = "use_external_delayed"
	n_location: STRING = "location"
	n_matching_strategy: STRING = "matching_strategy"
	n_input: STRING = "input"
	n_output: STRING = "output"
	n_error: STRING = "error"
	n_enabled: STRING = "enabled"
	n_command: STRING = "command"
	n_command_criterion: STRING = "command_criterion"
	n_exit_code: STRING = "exit_code"
	n_redirected_to_output: STRING = "redirected_to_output"
	n_as_file_name: STRING = "as_file_name"
	n_working_directory: STRING = "working_directory"

feature -- Names of matching strategies

	identity_matching_strategy_name: STRING = "identity"
	containing_matching_strategy_name: STRING = "containing"
	wildcard_matching_strategy_name: STRING = "wildcard"
	regexp_matching_strategy_name: STRING = "regular expression";

	matching_strategy_table: HASH_TABLE [INTEGER, STRING]
			-- Table of matching strategies.
			-- [strategy id, strategy name]
			-- strategy name is in lower case.
		once
			create Result.make (4)
			Result.put ({QL_NAME_CRITERION}.identity_matching_strategy, identity_matching_strategy_name)
			Result.put ({QL_NAME_CRITERION}.containing_matching_strategy, containing_matching_strategy_name)
			Result.put ({QL_NAME_CRITERION}.wildcard_matching_strategy, wildcard_matching_strategy_name)
			Result.put ({QL_NAME_CRITERION}.regular_expression_matching_strategy, regexp_matching_strategy_name)
		ensure
			result_attached: Result /= Void
		end

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
