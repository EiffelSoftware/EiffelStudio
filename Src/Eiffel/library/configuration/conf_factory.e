indexing
	description: "Factory for configuration objects."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_FACTORY

feature

	new_system (a_name: STRING an_uuid: UUID): CONF_SYSTEM is
			-- Create a `CONF_SYSTEM' object.
		require
			a_name_ok: a_name /= Void and then not a_name.is_empty
			an_uuid_not_void: an_uuid /= Void
		do
			create Result.make_with_uuid (a_name, an_uuid)
		ensure
			Result_not_void: Result /= Void
		end

	new_target (a_name: STRING; a_system: CONF_SYSTEM): CONF_TARGET is
			-- Create a `CONF_TARGET' object.
		require
			a_name_ok: a_name /= Void and then not a_name.is_empty
			a_system_not_void: a_system /= Void
		do
			create Result.make (a_name, a_system)
		ensure
			Result_not_void: Result /= Void
		end

	new_location_from_path (a_path: STRING; a_target: CONF_TARGET): CONF_LOCATION is
			-- Create a `CONF_LOCATION' object.
			-- Create with `a_path' (without a filename).
			-- e.g. aa/bb/cc =>
			-- directory = aa/bb/cc
			-- file =
		require
			a_path_not_void: a_path /= Void
			a_target_not_void: a_target /= Void
		do
			create Result.make_from_path (a_path, a_target)
		ensure
			Result_not_void: Result /= Void
		end

	new_location_from_full_path (a_full_path: STRING; a_target: CONF_TARGET): CONF_LOCATION is
			-- Create a `CONF_LOCATION' object.
			-- Create with `a_full_path' (with a filename).
			-- e.g. aa/bb/cc =>
			-- directory = aa/bb
			-- file = cc
		require
			a_full_path_not_void: a_full_path /= Void
			a_target_not_void: a_target /= Void
		do
			create Result.make_from_full_path (a_full_path, a_target)
		ensure
			Result_not_void: Result /= Void
		end

	new_root (a_cluster, a_class, a_feature: STRING; a_all_root: BOOLEAN): CONF_ROOT is
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

	new_version (a_major, a_minor, a_release, a_build: NATURAL_16): CONF_VERSION is
			-- Create a `CONF_VERSION' object.
		do
			create Result.make_version (a_major, a_minor, a_release, a_build)
		ensure
			Result_not_void: Result /= Void
		end

	new_option: CONF_OPTION is
			-- Create a `CONF_OPTION' object.
		do
			create Result
		ensure
			Result_not_void: Result /= Void
		end

	new_file_rule: CONF_FILE_RULE is
			-- Create a `CONF_FILE_RULE' object.
		do
			create Result.make
		ensure
			Result_not_void: Result /= Void
		end


	new_external_include (a_location: STRING): CONF_EXTERNAL_INCLUDE is
			-- Create a `CONF_EXTERNAL_INCLUDE' object.
		do
			create Result.make (a_location)
		ensure
			Result_not_void: Result /= Void
		end

	new_external_object (a_location: STRING): CONF_EXTERNAL_OBJECT is
			-- Create a `CONF_EXTERNAL_OBJECT' object.
		do
			create Result.make (a_location)
		ensure
			Result_not_void: Result /= Void
		end

	new_external_ressource (a_location: STRING): CONF_EXTERNAL_RESSOURCE is
			-- Create a `CONF_EXTERNAL_RESSOURCE' object.
		do
			create Result.make (a_location)
		ensure
			Result_not_void: Result /= Void
		end

	new_external_make (a_location: STRING): CONF_EXTERNAL_MAKE is
			-- Create a `CONF_EXTERNAL_MAKE' object.
		do
			create Result.make (a_location)
		ensure
			Result_not_void: Result /= Void
		end

	new_action (a_command: STRING; a_must_succeed: BOOLEAN; a_working_directory: CONF_LOCATION): CONF_ACTION is
			-- Create a `CONF_ACTION' object.
		do
			create Result.make (a_command, a_must_succeed, a_working_directory)
		ensure
			Result_not_void: Result /= Void
		end

	new_assertions: CONF_ASSERTIONS is
			-- Create a `CONF_ASSERTIONS' object.
		do
			create Result
		ensure
			Result_not_void: Result /= Void
		end


	new_class (a_file_name: STRING; a_group: CONF_CLUSTER; a_path: STRING): CONF_CLASS is
			-- Create a `CONF_CLASS' object.
		require
			a_file_name_ok: a_file_name /= Void and then not a_file_name.is_empty
			a_group_not_void: a_group /= Void
			a_path_not_void: a_path /= Void
		do
			create Result.make (a_file_name, a_group, a_path)
		ensure
			Result_not_void: Result /= Void
		end

	new_class_assembly (a_name, a_dotnet_name: STRING; an_assembly: CONF_ASSEMBLY; a_position: INTEGER): CONF_CLASS_ASSEMBLY is
			-- Create a `CONF_CLASS_ASSEMBLY' object.
		require
			a_name_ok: a_name /= Void and then not a_name.is_empty
			a_name_upper: a_name.is_equal (a_name.as_upper)
			a_dotnet_name_ok: a_dotnet_name /= Void and then not a_dotnet_name.is_empty
			an_assembly_not_void: an_assembly /= Void
			a_position_ok: a_position >= 0
		do
			create Result.make_assembly_class (a_name, a_dotnet_name, an_assembly, a_position)
		ensure
			Result_not_void: Result /= Void
		end

	new_class_partial (a_partial_classes: ARRAYED_LIST [STRING]; a_group: CONF_CLUSTER; a_base_location: CONF_LOCATION): CONF_CLASS_PARTIAL is
			-- Create a `CONF_CLASS_PARTIAL' object.
		require
			a_partial_classes_not_void: a_partial_classes /= Void
			a_group_not_void: a_group /= Void
			a_base_location_not_void: a_base_location /= Void
		do
			create Result.make_from_partial (a_partial_classes, a_group, a_base_location)
		ensure
			Result_not_void: Result /= Void
		end

	new_assembly (a_name: STRING; a_directory: STRING; a_target: CONF_TARGET): CONF_ASSEMBLY is
			-- Create a `CONF_ASSEMBLY' object.
		require
			a_name_ok: a_name /= Void and then not a_name.is_empty
			a_directory_not_void: a_directory /= Void
			a_target_not_void: a_target /= Void
		local
			l_location: CONF_LOCATION
		do
			l_location := new_location_from_full_path (a_directory, a_target)
			create Result.make (a_name, l_location, a_target)
		ensure
			Result_not_void: Result /= Void
		end

	new_assembly_from_gac (a_name, an_assembly_name, an_assembly_version, an_assembly_culture, an_assembly_key: STRING; a_target: CONF_TARGET): CONF_ASSEMBLY is
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

	new_library (a_name: STRING; a_directory: CONF_LOCATION; a_target: CONF_TARGET): CONF_LIBRARY is
			-- Create a `CONF_LIBRARY' object.
		require
			a_name_ok: a_name /= Void and then not a_name.is_empty
			a_directory_not_void: a_directory /= Void
			a_target_not_void: a_target /= Void
		do
			create Result.make (a_name, a_directory, a_target)
		ensure
			Result_not_void: Result /= Void
		end

	new_precompile (a_name: STRING; a_directory: STRING; a_target: CONF_TARGET): CONF_PRECOMPILE is
			-- Create a `CONF_PRECOMPILE' object.
		require
			a_name_ok: a_name /= Void and then not a_name.is_empty
			a_directory_not_void: a_directory /= Void
			a_target_not_void: a_target /= Void
		do
			create Result.make (a_name, new_location_from_full_path (a_directory, a_target), a_target)
		ensure
			Result_not_void: Result /= Void
		end

	new_cluster (a_name: STRING; a_directory: CONF_LOCATION; a_target: CONF_TARGET): CONF_CLUSTER is
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

	new_override (a_name: STRING; a_directory: CONF_LOCATION; a_target: CONF_TARGET): CONF_OVERRIDE is
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
