note
	description: "Information about current .NET environment"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	IL_ENVIRONMENT

inherit
	IL_ENVIRONMENT_I
		redefine
			default_create
		end

	OPERATING_ENVIRONMENT
		redefine
			default_create
		end

create
	make, default_create

feature {NONE} -- Initialization

	make (a_version: READABLE_STRING_GENERAL)
			-- Create an instance of IL_ENVIRONMENT targeting a specific .NET version `a_version'.
			-- If `a_version' is not specified we currently take `default_version'.
			-- Set `version' with `a_version'.
		do
			if a_version /= Void then
				create version.make_from_string_general (a_version)
			else
				version := default_version
			end
		ensure
			version_set: version /= Void and (a_version /= Void implies version.same_string_general (a_version))
		end

	default_create
			-- Create an instance of IL_ENVIRONMENT targetting `default_version' of .NET runtime.
		do
			version := default_version
		ensure then
			version_set: version /= Void and then version.same_string (default_version)
		end

feature -- Initialization

	register_environment_variable
			-- If runtime is found, we set the ISE_DOTNET_FRAMEWORK environement variable.
		local
			l_exec: EXECUTION_ENVIRONMENT
		do
			if is_dotnet_installed and then attached dotnet_framework_path as l_path then
				create l_exec
				l_exec.put (l_path.name, ise_dotnet_framework_env)
			end
		end

feature -- Access

	ise_dotnet_framework_env: STRING = "ISE_DOTNET_FRAMEWORK"
			-- .NET framework environment variable

	version: IMMUTABLE_STRING_32
			-- Currently selected version, if none `default_version'.

	default_version: IMMUTABLE_STRING_32
			-- Default runtime version if `version' was not specified.
			-- Semantic is to take the most recent version of the run-time.
		do
			Result := "v1.0"
		end

	is_dotnet_installed: BOOLEAN
			-- Is dotnet version `version' installed?
		do
			Result := installed_runtimes.has (version)
		end

	is_version_installed (a_version: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `a_version' installed?
		do
			Result := installed_runtimes.has (a_version)
		end

	installed_runtimes: STRING_TABLE [PATH]
			-- All paths of installed versions of .NET runtime indexed by their version names.
		do
			create Result.make (0)
		end

	dotnet_framework_path: detachable PATH
			-- Path to .NET Framework of version `version'.
		require
			is_dotnet_installed: is_dotnet_installed
		do
			create Result.make_empty
		end

	installed_sdks: STRING_TABLE [PATH]
			-- All paths of installed versions of .NET SDKs indexed by their version names.
		require
			is_dotnet_installed: is_dotnet_installed
		do
			create Result.make (0)
		end

	dotnet_framework_sdk_path: like dotnet_framework_path
			-- Path to .NET Framework SDK directory of version `version'.
			-- Void if not installed.
		do
			create Result.make_empty
		end

	dotnet_framework_sdk_bin_path: like dotnet_framework_path
			-- Path to bin directory of .NET Framework SDK of version `version'.
		do
			create Result.make_empty
		end

feature -- Query

	use_cordbg (a_string: READABLE_STRING_GENERAL): BOOLEAN
			-- Should Current use cordbg.exe?
		do
			Result := a_string /= Void and then a_string.same_string ("cordbg")
		end

	use_dbgclr (a_string: READABLE_STRING_GENERAL): BOOLEAN
			-- Should Current use DbgCLR.exe?
		do
			Result := a_string /= Void and then a_string.same_string ("DbgCLR")
		end

	use_mdbg (a_string: READABLE_STRING_GENERAL): BOOLEAN
			-- Should current use MDbg.exe?
		do
			Result := a_string /= Void and then a_string.same_string ("MDbg")
		end

	dotnet_debugger_path (a_debug: READABLE_STRING_GENERAL): detachable PATH
			-- The path to the .NET debugger associated with 'a_debug'.
		require
			a_debug_not_void: a_debug /= Void
		do
			create Result.make_empty
		end

invariant
	version_not_void: version /= Void

note
	copyright:	"Copyright (c) 1984-2022, Eiffel Software"
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

end -- class IL_ENVIRONMENT
