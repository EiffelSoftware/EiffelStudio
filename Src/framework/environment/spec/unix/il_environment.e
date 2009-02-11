note
	description: "Information about current .NET environment"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	IL_ENVIRONMENT

inherit
	ANY
		redefine
			default_create
		end

create
	make,
	default_create

feature {NONE} -- Initialization

	make (a_version: STRING)
			-- Create an instance of IL_ENVIRONMENT targeting a specific .NET version `a_version'.
			-- If `a_version' is not specified we currently take `default_version'.
			-- Set `version' with `a_version'.
		do
			if a_version /= Void then
				version := a_version
			else
				version := default_version
			end
		ensure
			version_set: version /= Void and (a_version /= Void implies version = a_version)
		end

	default_create
			-- Create an instance of IL_ENVIRONMENT targetting `default_version' of .NET runtime.
		do
			version := default_version
		ensure then
			version_set: version /= Void and then version.is_equal (default_version)
		end

feature -- Initialization

	register_environment_variable
			-- If runtime is found, we set the ISE_DOTNET_FRAMEWORK environement variable.
		local
			l_exec: EXECUTION_ENVIRONMENT
		do
			if is_dotnet_installed then
				create l_exec
				l_exec.put (dotnet_framework_path.string, "ISE_DOTNET_FRAMEWORK")
			end
		end

feature -- Access

	default_version: STRING
			-- Default runtime version if `version' was not specified.
			-- Semantic is to take `v1_0' if present, `v1_1' otherwise.
		do
			Result := "v1.0"
		ensure
			default_version_not_void: Result /= Void
		end

	dotnet_framework_path: STRING
			-- Path to .NET Framework of version `version'.
		require
			is_dotnet_installed: is_dotnet_installed
		do
		end

	dotnet_framework_sdk_bin_path: STRING
			-- Path to bin directory of .NET Framework SDK of version `version'.
		do
		end

	dotnet_framework_sdk_path: STRING
			-- Path to .NET Framework SDK directory of version `version'.
			-- Void if not installed.
		do
		end

	installed_runtimes: ARRAYED_LIST [STRING]
			-- List all installed version of the runtime.
		do
			create {ARRAYED_LIST [STRING]} Result.make (1)
		ensure
			installed_runtimes_not_void: Result /= Void
		end

	is_dotnet_installed: BOOLEAN
			-- Is dotnet version `version' installed?
		do
		end

	ise_dotnet_framework_env: STRING = "ISE_DOTNET_FRAMEWORK"
		-- .NET framework environment variable

	version: STRING
			-- Currently selected version, if none `default_version'.

feature -- Query

	use_cordbg (a_string: STRING): BOOLEAN
			-- Should Current use cordbg.exe?
		require
			a_string_not_void: a_string /= Void
		do
		end

	use_dbgclr (a_string: STRING): BOOLEAN
			-- Should Current use DbgCLR.exe?
		require
			a_string_not_void: a_string /= Void
		do
		end

	Dotnet_debugger_path (a_debug: STRING): STRING
			-- The path to the .NET debugger associated with 'a_debug'.
		require
			a_debug_not_void: a_debug /= Void
		do
		end

invariant
	version_not_void: version /= Void

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

end -- class IL_ENVIRONMENT
