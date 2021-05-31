note
	description: "Contants used in CONF_LOAD_PARSE_CALLBACKS"
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_LOAD_PARSE_CALLBACKS_CONSTANTS

feature {NONE} -- Access

	non_client_option_ids: ARRAY [INTEGER]
			-- Non client options ids
			-- It should be made a hashtable if the number of values grows too large.
		once
			Result :=
				<<
					at_catcall_detection,
					at_full_class_checking,
					at_is_attached_by_default,
					at_is_obsolete_iteration,
					at_is_void_safe,
					at_manifest_array_type,
					at_namespace,
					at_syntax,
					at_syntax_level,
					at_void_safety
				>>
		end

feature {NONE} -- Helper

	is_non_client_option (an_option: INTEGER): BOOLEAN
			-- Is `an_option' non client option?
		do
			Result := non_client_option_ids.has (an_option)
		end

feature {NONE} -- Implementation constants

		-- Tag states
	t_unknown: INTEGER = 0
	t_none: INTEGER = 1
	t_system: INTEGER = 2
	t_description: INTEGER = 3
	t_target: INTEGER = 4
	t_root: INTEGER = 5
	t_version: INTEGER = 6
	t_file_rule: INTEGER = 7
	t_option: INTEGER = 8
	t_setting: INTEGER = 9
	t_external_include: INTEGER = 10
	t_external_cflag: INTEGER = 11
	t_external_object: INTEGER = 12
	t_external_library: INTEGER = 13
	t_external_resource: INTEGER = 14
	t_external_linker_flag: INTEGER = 15
	t_external_make: INTEGER = 16
	t_pre_compile_action: INTEGER = 17
	t_post_compile_action: INTEGER = 18
	t_variable: INTEGER = 19
	t_precompile: INTEGER = 20
	t_library: INTEGER = 21
	t_assembly: INTEGER = 22
	t_cluster: INTEGER = 23
	t_override: INTEGER = 24
	t_exclude: INTEGER = 25
	t_include: INTEGER = 26
	t_debug: INTEGER = 27
	t_assertions: INTEGER = 28
	t_warning: INTEGER = 29
	t_condition: INTEGER = 30
	t_platform: INTEGER = 31
	t_build: INTEGER = 32
	t_multithreaded: INTEGER = 33
	t_dotnet: INTEGER = 34
	t_dynamic_runtime: INTEGER = 35
	t_version_condition: INTEGER = 36
	t_custom: INTEGER = 37
	t_renaming: INTEGER = 38
	t_class_option: INTEGER = 39
	t_uses: INTEGER = 40
	t_visible: INTEGER = 41
	t_overrides: INTEGER = 42
	t_mapping: INTEGER = 43
	t_note: INTEGER = 44
	t_test_cluster: INTEGER = 45
	t_concurrency: INTEGER = 46
	t_redirection: INTEGER = 47
	t_void_safety: INTEGER = 48
	t_capability: INTEGER = 49
	t_capability_catcall_detection: INTEGER = 50
	t_capability_code: INTEGER = 51
	t_capability_concurrency: INTEGER = 52
	t_capability_platform: INTEGER = 53
	t_capability_void_safety: INTEGER = 54


		-- Attribute states
	at_abstract: INTEGER = 1000
	at_name: INTEGER = 1001
	at_uuid: INTEGER = 1002
	at_library_target: INTEGER = 1003
	at_extends_location: INTEGER = 1004
	at_extends: INTEGER = 1005
	at_cluster: INTEGER = 1006
	at_class: INTEGER = 1007
	at_all_classes: INTEGER = 1008
	at_feature: INTEGER = 1009
	at_class_rename: INTEGER = 1010
	at_feature_rename: INTEGER = 1011
	at_major: INTEGER = 1012
	at_minor: INTEGER = 1013
	at_release: INTEGER = 1014
	at_build: INTEGER = 1015
	at_product: INTEGER = 1016
	at_company: INTEGER = 1017
	at_copyright: INTEGER = 1018
	at_trademark: INTEGER = 1019
	at_trace: INTEGER = 1020
	at_profile: INTEGER = 1021
	at_optimize: INTEGER = 1022
	at_debug: INTEGER = 1023
	at_namespace: INTEGER = 1024
	at_location: INTEGER = 1025
	at_command: INTEGER = 1026
	at_value: INTEGER = 1027
	at_excluded_value: INTEGER = 1028
	at_readonly: INTEGER = 1029
	at_prefix: INTEGER = 1030
	at_target: INTEGER = 1031
	at_assembly_name: INTEGER = 1032
	at_assembly_version: INTEGER = 1033
	at_assembly_culture: INTEGER = 1034
	at_assembly_key: INTEGER = 1035
	at_recursive: INTEGER = 1036
	at_enabled: INTEGER = 1037
	at_precondition: INTEGER = 1038
	at_postcondition: INTEGER = 1039
	at_check: INTEGER = 1040
	at_invariant: INTEGER = 1041
	at_loop: INTEGER = 1042
	at_supplier_precondition: INTEGER = 1043
	at_platform: INTEGER = 1044
	at_min: INTEGER = 1045
	at_max: INTEGER = 1046
	at_old_name: INTEGER = 1047
	at_new_name: INTEGER = 1048
	at_group: INTEGER = 1049
	at_succeed: INTEGER = 1050
	at_working_directory: INTEGER = 1051
	at_type: INTEGER = 1052
	at_eifgens_location: INTEGER = 1053
	at_warning: INTEGER = 1054
	at_hidden: INTEGER = 1055
	at_msil_application_optimize: INTEGER = 1056
	at_use_application_options: INTEGER = 1057
	at_full_class_checking: INTEGER = 1058
	at_catcall_detection: INTEGER = 1059
	at_is_attached_by_default: INTEGER = 1060
	at_is_obsolete_routine_type: INTEGER = 1061
	at_is_void_safe: INTEGER = 1062
	at_void_safety: INTEGER = 1063
	at_syntax_level: INTEGER = 1064
	at_syntax: INTEGER = 1065
	at_message: INTEGER = 1066
	at_support: INTEGER = 1067
	at_use: INTEGER = 1068
	at_match: INTEGER = 1069
	at_manifest_array_type: INTEGER = 1070
	at_is_obsolete_iteration: INTEGER = 1071

		-- Undefined tag starting number
	undefined_tag_start: INTEGER = 100000

	at_enabled_string: STRING = "enabled"
			-- Name of the attribute "enabled".

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
