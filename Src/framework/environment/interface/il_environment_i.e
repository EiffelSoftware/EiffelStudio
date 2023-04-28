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

	installed_version (a_version: READABLE_STRING_GENERAL): detachable READABLE_STRING_GENERAL
			-- Exact installed version adapted from `a_version`.
			-- note: `a_version` could have only the major and minor, but not the rest
			--		 the installed_version will be a full defined version compatible with `a_version`
			--|		 for instance, for ".../6.0", it could return ".../6.0.15" if that one is installed.
		local
			k: READABLE_STRING_GENERAL
		do
			if is_version_installed (a_version) then
				Result := a_version
			else
					-- FIXME: try to sort the `installed_runtimes` before using it
					-- sort with versioning M.m.build in mind, and not just alphabetical order.
				across
					installed_runtimes as tb
				loop
					k := @ tb.key
						-- FIXME: be more acurate working with versioning and not just "starts_with"
					if k.starts_with (a_version) then
							-- From 6.0, accept latest installed version 6.0.16
						Result := k
					end
				end
			end
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

	dotnet_framework_path: detachable PATH
			-- Path to .NET Framework of version `version'.
		require
			is_dotnet_installed: is_dotnet_installed
		deferred
		end

	installed_sdks: STRING_TABLE [PATH]
			-- All paths of installed versions of .NET SDKs indexed by their version names.
		deferred
		end

feature -- Status report

	is_valid_version (v: detachable READABLE_STRING_GENERAL): BOOLEAN
			-- Is `v` a valid runtime version?
			-- cases: v4.0, Microsoft.NETCore.App/6.0.15
		local
			i: INTEGER
			s: READABLE_STRING_GENERAL
		do
			if v /= Void and then v.count >= 4 then
				if v [1] = 'v' then
					s := v.substring (2, v.count)
				else
					i := v.last_index_of ('/', v.count)
					if i > 0 then
						s := v.substring (i + 1, v.count)
					else
						s := v
					end
				end
				i := s.index_of ('.', 1)
				if i > 0 then
					Result := s.substring (1, i - 1).is_integer and then
						(s[i+1]).is_digit
				else
					Result := s.is_integer
				end
			end
		end


feature -- Query

	resource_compiler: detachable PATH
			-- Path to `resgen' tool from .NET Framework SDK.
		deferred
		end

feature -- Constants

	v1_0: STRING = "v1.0"
			-- Version number of v1.0 of Microsoft .NET

	v1_1: STRING = "v1.1"
			-- Version number of v1.1 of Microsoft .NET

	v2_0: STRING = "v2.0"
			-- Version number of v2.0 of Microsoft .NET

	v4_0: STRING = "v4.0"
			-- Version number of v4.0 of Microsoft .NET		

invariant
	version_not_void: attached version
	version_valid: is_valid_version (version)

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
