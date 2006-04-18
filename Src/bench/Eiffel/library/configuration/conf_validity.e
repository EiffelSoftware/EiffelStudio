indexing
	description: "Specifies constants and validity check against the constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_VALIDITY

feature -- Basic validity queries

	valid_platform (a_platform: INTEGER): BOOLEAN is
			-- Is `a_platform' a valid platform?
		do
			Result := a_platform = Pf_windows or a_platform = Pf_unix or a_platform = Pf_dotnet or a_platform = Pf_mac or a_platform = Pf_all
		end

	valid_build (a_build: INTEGER): BOOLEAN is
			-- Is `a_build' a valid build?
		do
			Result := a_build = Build_workbench or a_build = Build_finalize or a_build = Build_all
		end

	valid_warning (a_warning: STRING): BOOLEAN is
			-- Is `a_warning' a valid warning?
		require
			a_warning_not_void: a_warning /= Void
			a_warning_lower: a_warning.is_equal (a_warning.as_lower)
		do
			if not a_warning.is_empty then
				Result := valid_warnings.has (a_warning)
			end
		end

	valid_setting (a_setting: STRING): BOOLEAN is
			-- Is `a_setting' a valid setting?
		require
			a_setting_not_void: a_setting /= Void
			a_setting_lower: a_setting.is_equal (a_setting.as_lower)
		do
			if not a_setting.is_empty then
				Result := valid_settings.has (a_setting)
			end
		end


feature {NONE} -- Basic operation

	get_platform_name (a_platform: INTEGER): STRING is
			-- Get the name of `a_platform'.
		require
			valid_platform: valid_platform (a_platform)
		do
			Result := platform_names.item (a_platform)
		ensure
			result_not_void: Result /= Void
		end

	get_build_name (a_build: INTEGER): STRING is
			-- Get the name of `a_build'.
		require
			valid_build: valid_build (a_build)
		do
			Result := build_names.item (a_build)
		ensure
			result_not_void: Result /= Void
		end

	get_platform (a_name: STRING): INTEGER is
			-- Get the platform with `a_name', otherwise return 0.
		do
			if a_name = Void then
				Result := 0
			end
			from
				platform_names.start
			until
				Result /= 0 or platform_names.after
			loop
				if platform_names.item_for_iteration.is_case_insensitive_equal (a_name) then
					Result := platform_names.key_for_iteration
				end
				platform_names.forth
			end
		end

	get_build (a_name: STRING): INTEGER is
			-- Get the build with `a_name', otherwise return 0.
		do
			if a_name = Void then
				Result := 0
			end
			from
				build_names.start
			until
				Result /= 0 or build_names.after
			loop
				if build_names.item_for_iteration.is_case_insensitive_equal (a_name) then
					Result := build_names.key_for_iteration
				end
				build_names.forth
			end
		end

feature -- Constants

		-- Platforms
	Pf_windows: INTEGER is 0x0001
			-- Windows
	Pf_unix: INTEGER is 0x0002
			-- Unix/Linux
	Pf_dotnet: INTEGER is 0x0004
			-- .NET
	Pf_mac: INTEGER is 0x0008
			-- Macintosh
	Pf_vxworks: INTEGER is 0x000F
			-- vxWorks
	Pf_all: INTEGER is 0x00FF
			-- All platforms

		-- Builds
	Build_workbench: INTEGER is 0x0100
			-- Workbench
	Build_finalize: INTEGER is 0x0200
			-- Finalize
	Build_all: INTEGER is 0xFF00
			-- All builds

feature {NONE} -- Onces

	platform_names: HASH_TABLE [STRING, INTEGER] is
			-- The platform names mapped to their integer.
		once
			create Result.make (6)
			Result.force ("Windows", Pf_windows)
			Result.force ("Unix", Pf_unix)
			Result.force ("Dotnet", Pf_dotnet)
			Result.force ("Macintosh", Pf_mac)
			Result.force ("vxWorks", Pf_vxworks)
			Result.force ("All", Pf_all)
		ensure
			Result_not_void: Result /= Void
		end

	build_names: HASH_TABLE [STRING, INTEGER] is
			-- The build names mapped to their integer.
		once
			create Result.make (3)
			Result.force ("Workbench", build_workbench)
			Result.force ("Finalize", build_finalize)
			Result.force ("All", build_all)
		ensure
			Result_not_void: Result /= Void
		end

feature {NONE} -- Implementation

	valid_warnings: SEARCH_TABLE [STRING] is
			-- The codes of valid warnings.
		once
			create Result.make (4)
			Result.force ("unused_local")
			Result.force ("obsolete_class")
			Result.force ("obsolete_feature")
			Result.force ("once_in_generic")
		ensure
			Result_not_void: Result /= Void
		end

	valid_settings: SEARCH_TABLE [STRING] is
			-- The codes of valid settings.
		once
			create Result.make (50)
			Result.force ("address_expression")
			Result.force ("array_optimization")
			Result.force ("check_generic_creation_constraint")
			Result.force ("check_vape")
			Result.force ("console_application")
			Result.force ("cls_compliant")
			Result.force ("dead_code_removal")
			Result.force ("dotnet_naming_convention")
			Result.force ("dynamic_runtime")
			Result.force ("exception_trace")
			Result.force ("executable_name")
			Result.force ("full_type_checking")
			Result.force ("il_verifiable")
			Result.force ("inlining")
			Result.force ("inlining_size")
			Result.force ("java_generation")
			Result.force ("line_generation")
			Result.force ("metadata_cache_path")
			Result.force ("msil_assembly_compatibility")
			Result.force ("msil_classes_per_module")
			Result.force ("msil_clr_version")
			Result.force ("msil_culture")
			Result.force ("msil_generation")
			Result.force ("msil_generation_type")
			Result.force ("msil_key_file_name")
			Result.force ("msil_use_optimized_precompile")
			Result.force ("multithreaded")
			Result.force ("old_verbatim_strings")
			Result.force ("old_verbatim_strings_warning")
			Result.force ("platform")
			Result.force ("external_runtime")
			Result.force ("shared_library_definition")
			Result.force ("syntax_warning")
			Result.force ("use_cluster_name_as_namespace")
			Result.force ("use_all_cluster_name_as_namespace")
		ensure
			Result_not_void: Result /= Void
		end

	boolean_settings: SEARCH_TABLE [STRING] is
			-- Settings that have a boolean value.
		once
			create Result.make (25)
			Result.force ("dead_code_removal")
			Result.force ("array_optimization")
			Result.force ("inlining")
			Result.force ("check_generic_creation_constraint")
			Result.force ("check_vape")
			Result.force ("exception_trace")
			Result.force ("address_expression")
			Result.force ("java_generation")
			Result.force ("msil_generation")
			Result.force ("msil_use_optimized_precompile")
			Result.force ("line_generation")
			Result.force ("cls_compliant")
			Result.force ("dotnet_naming_convention")
			Result.force ("dynamic_runtime")
			Result.force ("syntax_warning")
			Result.force ("old_verbatim_strings")
			Result.force ("old_verbatim_strings_warning")
			Result.force ("console_application")
			Result.force ("multithreaded")
			Result.force ("il_verifiable")
			Result.force ("full_type_checking")
			Result.force ("use_cluster_name_as_namespace")
			Result.force ("use_all_cluster_name_as_namespace")
			Result.force ("force_recompile")
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
