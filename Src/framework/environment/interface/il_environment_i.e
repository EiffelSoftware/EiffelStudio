note
	description: "Information about current .NET environment"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	IL_ENVIRONMENT_I

feature -- Initialization

	register_environment_variable
			-- If runtime is found, we set the ISE_DOTNET_FRAMEWORK environement variable.
		deferred
		end

feature -- Access

	ise_dotnet_framework_env: STRING --| = "ISE_DOTNET_FRAMEWORK"
			-- .NET framework environment variable
		deferred
		end

	version: IMMUTABLE_STRING_32
			-- Currently selected version, if none `default_version'.
		deferred
		end

	default_version: IMMUTABLE_STRING_32
			-- Default runtime version if `version' was not specified.
			-- Semantic is to take the most recent version of the run-time.
		deferred
		ensure
			default_version_not_void: Result /= Void
		end

	is_dotnet_installed: BOOLEAN
			-- Is dotnet version `version' installed?
		deferred
		end

	is_version_installed (a_version: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `a_version' installed?
		deferred
		end

	installed_runtimes: STRING_TABLE [PATH]
			-- All paths of installed versions of .NET runtime indexed by their version names.
		deferred
		ensure
			installed_runtimes_not_void: Result /= Void
		end

	installed_sdks: STRING_TABLE [PATH]
			-- All paths of installed versions of .NET SDKs indexed by their version names.
		deferred
		end

feature -- Query

	resource_compiler: detachable PATH
			-- Path to `resgen' tool from .NET Framework SDK.
		deferred
		end

invariant
	version_not_void: version /= Void
	version_valid: version.count >= 4 and then (version.item (1) = 'v' and version.item (2).is_digit and
		version.item (3) = '.' and version.item (4).is_digit)

note
	copyright: "Copyright (c) 1984-2023, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
