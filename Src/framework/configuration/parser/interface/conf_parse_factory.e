note
	description: "Factory for configuration objects needed to parse a config file."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_PARSE_FACTORY

inherit
	CONF_FILE_CONSTANTS

feature -- Factory: system and redirection

	new_redirection_with_file_name (a_file_name: READABLE_STRING_GENERAL; a_location: READABLE_STRING_GENERAL; a_uuid: detachable UUID): CONF_REDIRECTION
			-- Create a {CONF_REDIRECTION} object with `a_location' and optional `a_uuid'.
		require
			a_file_name_valid: a_file_name /= Void and then not a_file_name.is_empty
			a_location_ok: a_location /= Void and then not a_location.is_empty
		do
			create Result.make (a_file_name, a_location, a_uuid)
		end

	new_system_generate_uuid_with_file_name (a_file_name: READABLE_STRING_GENERAL; a_name: STRING_32; a_namespace: READABLE_STRING_32): CONF_SYSTEM
			-- Create a {CONF_SYSTEM} object with an automatically generated UUID.
		require
			a_file_name_valid: a_file_name /= Void and then not a_file_name.is_empty
			a_name_ok: a_name /= Void and then not a_name.is_empty
			a_namespace_valid: is_namespace_known (a_namespace)
		do
			create Result.make_with_uuid (a_file_name, a_name, uuid_generator.generate_uuid, a_namespace)
			Result.set_is_generated_uuid (True)
		ensure
			Result_not_void: Result /= Void
		end

	new_system_with_file_name (a_file_name: READABLE_STRING_GENERAL; a_name: STRING_32; an_uuid: UUID; a_namespace: READABLE_STRING_32): CONF_SYSTEM
			-- Create a `CONF_SYSTEM' object.
		require
			a_file_name_valid: a_file_name /= Void and then not a_file_name.is_empty
			a_name_ok: a_name /= Void and then not a_name.is_empty
			an_uuid_not_void: an_uuid /= Void
			a_namespace_valid: is_namespace_known (a_namespace)
		do
			create Result.make_with_uuid (a_file_name, a_name, an_uuid, a_namespace)
		ensure
			Result_not_void: Result /= Void
		end

feature -- Factory			

	new_target (a_name: STRING_32; a_system: CONF_SYSTEM): CONF_TARGET
			-- Create a `CONF_TARGET' object.
		require
			a_name_ok: a_name /= Void and then not a_name.is_empty
			a_system_not_void: a_system /= Void
		do
			create Result.make (a_name, a_system)
		ensure
			Result_not_void: Result /= Void
		end

	new_location_from_path (a_path: like {CONF_LOCATION}.original_path; a_target: CONF_TARGET): CONF_DIRECTORY_LOCATION
			-- Create a `CONF_LOCATION' object.
			-- Create with `a_path' (without a filename).
			-- e.g. aa/bb/cc =>
			-- directory = aa/bb/cc
			-- file =
		require
			a_path_not_void: a_path /= Void
			a_target_not_void: a_target /= Void
		do
			create Result.make (a_path, a_target)
		ensure
			Result_not_void: Result /= Void
		end

	new_file_location_from_path (a_path: like {CONF_LOCATION}.original_path; a_target: CONF_TARGET): CONF_FILE_LOCATION
			-- Create a `CONF_FILE_LOCATION' object.
			-- Create with `a_path' (without a filename).
			-- e.g. aa/bb/cc =>
			-- directory = aa/bb/cc
			-- file =
		require
			a_path_not_void: a_path /= Void
			a_target_not_void: a_target /= Void
		do
			create Result.make (a_path, a_target)
		ensure
			Result_not_void: Result /= Void
		end

	new_location_from_full_path (a_full_path: like {CONF_LOCATION}.original_path; a_target: CONF_TARGET): CONF_FILE_LOCATION
			-- Create a `CONF_LOCATION' object.
			-- Create with `a_full_path' (with a filename).
			-- e.g. aa/bb/cc =>
			-- directory = aa/bb
			-- file = cc
		require
			a_full_path_not_void: a_full_path /= Void
			a_target_not_void: a_target /= Void
		do
			create Result.make (a_full_path, a_target)
		ensure
			Result_not_void: Result /= Void
		end

	new_root (a_cluster, a_class, a_feature: detachable STRING_32; a_all_root: BOOLEAN): CONF_ROOT
			-- Create a `CONF_ROOT' object.
		require
			a_cluster_ok: a_cluster /= Void implies not a_cluster.is_empty
			a_class_ok: not a_all_root implies a_class /= Void and then not a_class.is_empty
			a_feature_ok: a_feature /= Void implies not a_feature.is_empty
		do
			create Result.make (a_cluster, a_class, a_feature, a_all_root)
		ensure
			Result_not_void: Result /= Void
		end

	new_version (a_major, a_minor, a_release, a_build: NATURAL_16): CONF_VERSION
			-- Create a `CONF_VERSION' object.
		do
			create Result.make_version (a_major, a_minor, a_release, a_build)
		ensure
			Result_not_void: Result /= Void
		end

	new_option (n: like namespace_1_0_0): CONF_OPTION
			-- Create a `CONF_OPTION' object for the namespace `n`.
		do
			Result := {CONF_OPTION}.create_from_namespace_or_latest (n)
		ensure
			Result_not_void: Result /= Void
		end

	new_target_option (n: like namespace_1_0_0): CONF_TARGET_OPTION
			-- Create a `CONF_TARGET_OPTION' object for the namespace `n`.
		do
			Result := {CONF_TARGET_OPTION}.create_from_namespace_or_latest (n)
		ensure
			Result_not_void: Result /= Void
		end

	new_file_rule: CONF_FILE_RULE
			-- Create a `CONF_FILE_RULE' object.
		do
			create Result.make
		ensure
			Result_not_void: Result /= Void
		end

	new_external_include (a_location: READABLE_STRING_GENERAL; a_target: CONF_TARGET): CONF_EXTERNAL_INCLUDE
			-- Create a `CONF_EXTERNAL_INCLUDE' object.
		require
			a_location_not_void: a_location /= Void
			a_target_not_void: a_target /= Void
		do
			create Result.make (a_location.as_string_32, a_target)
		ensure
			Result_not_void: Result /= Void
		end

	new_external_cflag (a_value: READABLE_STRING_GENERAL; a_target: CONF_TARGET): CONF_EXTERNAL_CFLAG
			-- Create a `CONF_EXTERNAL_CFLAG' object.
		require
			a_value_not_void: a_value /= Void
			a_target_not_void: a_target /= Void
		do
			create Result.make (a_value.as_string_32, a_target)
		ensure
			Result_not_void: Result /= Void
		end

	new_external_object (a_location: READABLE_STRING_GENERAL; a_target: CONF_TARGET): CONF_EXTERNAL_OBJECT
			-- Create a `CONF_EXTERNAL_OBJECT' object.
		require
			a_location_not_void: a_location /= Void
			a_target_not_void: a_target /= Void
		do
			create Result.make (a_location.as_string_32, a_target)
		ensure
			Result_not_void: Result /= Void
		end

	new_external_library (a_location: READABLE_STRING_GENERAL; a_target: CONF_TARGET): CONF_EXTERNAL_LIBRARY
			-- Create a `CONF_EXTERNAL_LIBRARY' object.
		require
			a_location_not_void: a_location /= Void
			a_target_not_void: a_target /= Void
		do
			create Result.make (a_location.as_string_32, a_target)
		ensure
			Result_not_void: Result /= Void
		end

	new_external_resource (a_location: READABLE_STRING_GENERAL; a_target: CONF_TARGET): CONF_EXTERNAL_RESOURCE
			-- Create a `CONF_EXTERNAL_RESOURCE' object.
		require
			a_location_not_void: a_location /= Void
			a_target_not_void: a_target /= Void
		do
			create Result.make (a_location.as_string_32, a_target)
		ensure
			Result_not_void: Result /= Void
		end

	new_external_linker_flag (a_value: READABLE_STRING_GENERAL; a_target: CONF_TARGET): CONF_EXTERNAL_LINKER_FLAG
			-- Create a `CONF_EXTERNAL_LINKER_FLAG' object.
		require
			a_value_not_void: a_value /= Void
			a_target_not_void: a_target /= Void
		do
			create Result.make (a_value.as_string_32, a_target)
		ensure
			Result_not_void: Result /= Void
		end

	new_external_make (a_location: READABLE_STRING_GENERAL; a_target: CONF_TARGET): CONF_EXTERNAL_MAKE
			-- Create a `CONF_EXTERNAL_MAKE' object.
		require
			a_location_not_void: a_location /= Void
			a_target_not_void: a_target /= Void
		do
			create Result.make (a_location.as_string_32, a_target)
		ensure
			Result_not_void: Result /= Void
		end

	new_action (a_command: READABLE_STRING_GENERAL; a_must_succeed: BOOLEAN; a_working_directory: detachable CONF_DIRECTORY_LOCATION): CONF_ACTION
			-- Create a `CONF_ACTION' object.
		require
			a_command_ok: a_command /= Void and then not a_command.is_empty
		do
			create Result.make (a_command.as_string_32, a_must_succeed, a_working_directory)
		ensure
			Result_not_void: Result /= Void
		end

	new_assertions: CONF_ASSERTIONS
			-- Create a `CONF_ASSERTIONS' object.
		do
			create Result
		ensure
			Result_not_void: Result /= Void
		end

	new_assembly (a_name: STRING_32; a_file: READABLE_STRING_GENERAL; a_target: CONF_TARGET): CONF_ASSEMBLY
			-- Create a `CONF_ASSEMBLY' object.
		require
			a_name_ok: a_name /= Void and then not a_name.is_empty
			a_directory_not_void: a_file /= Void
			a_target_not_void: a_target /= Void
		local
			l_location: CONF_FILE_LOCATION
		do
			l_location := new_location_from_full_path (a_file.as_string_32, a_target)
			create Result.make (a_name, l_location, a_target)
		ensure
			Result_not_void: Result /= Void
		end

	new_assembly_from_gac (a_name: STRING_32; an_assembly_name, an_assembly_version, an_assembly_culture, an_assembly_key: READABLE_STRING_32; a_target: CONF_TARGET): CONF_ASSEMBLY
			-- Create a `CONF_ASSEMBLY' object from gac.
		require
			a_name_not_void: a_name /= Void
			an_assembly_name_not_void: an_assembly_name /= Void
			an_assembly_version_not_void: an_assembly_version /= Void
			an_assembly_culture_not_void: an_assembly_culture /= Void
			an_assembly_key_not_void: an_assembly_key /= Void
			a_target_not_void: a_target /= Void
		do
			create Result.make_from_gac (a_name, an_assembly_name, an_assembly_version, an_assembly_culture, an_assembly_key, a_target)
		ensure
			Result_not_void: Result /= Void
		end

	new_library (a_name: STRING_32; a_location: READABLE_STRING_GENERAL; a_target: CONF_TARGET): CONF_LIBRARY
			-- Create a `CONF_LIBRARY' object.
		require
			a_name_ok: a_name /= Void and then not a_name.is_empty
			a_location_not_void: a_location /= Void
			a_target_not_void: a_target /= Void
		do
			create Result.make (a_name, new_location_from_full_path (a_location.as_string_32, a_target), a_target)
		ensure
			Result_not_void: Result /= Void
		end

	new_precompile (a_name: STRING_32; a_file: READABLE_STRING_GENERAL; a_target: CONF_TARGET): CONF_PRECOMPILE
			-- Create a `CONF_PRECOMPILE' object.
		require
			a_name_ok: a_name /= Void and then not a_name.is_empty
			a_file_not_void: a_file /= Void
			a_target_not_void: a_target /= Void
		do
			create Result.make (a_name, new_location_from_full_path (a_file.as_string_32, a_target), a_target)
		ensure
			Result_not_void: Result /= Void
		end

	new_cluster (a_name: STRING_32; a_directory: CONF_DIRECTORY_LOCATION; a_target: CONF_TARGET): CONF_CLUSTER
			-- Create a `CONF_CLUSTER' object.
		require
			a_name_ok: a_name /= Void and then not a_name.is_empty
			a_directory_not_void: a_directory /= Void
			a_target_not_void: a_target /= Void
		do
			create Result.make (a_name, a_directory, a_target)
		ensure
			Result_not_void: Result /= Void
		end

	new_test_cluster (a_name: STRING_32; a_directory: CONF_DIRECTORY_LOCATION; a_target: CONF_TARGET): CONF_TEST_CLUSTER
			-- Create a `CONF_TEST_CLUSTER' object.
		require
			a_name_ok: a_name /= Void and then not a_name.is_empty
			a_directory_not_void: a_directory /= Void
			a_target_not_void: a_target /= Void
		do
			create Result.make (a_name, a_directory, a_target)
		ensure
			Result_not_void: Result /= Void
		end

	new_override (a_name: STRING_32; a_directory: CONF_DIRECTORY_LOCATION; a_target: CONF_TARGET): CONF_OVERRIDE
			-- Create a `CONF_OVERRIDE' object.
		require
			a_name_ok: a_name /= Void and then not a_name.is_empty
			a_directory_not_void: a_directory /= Void
			a_target_not_void: a_target /= Void
		do
			create Result.make (a_name, a_directory, a_target)
		ensure
			Result_not_void: Result /= Void
		end

	uuid_generator: UUID_GENERATOR
			-- UUID generator.
		once
			create Result
		ensure
			Result_not_void: Result /= Void
		end

note
	ca_ignore: "CA011", "CA011: too many arguments"
	copyright:	"Copyright (c) 1984-2021, Eiffel Software"
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
