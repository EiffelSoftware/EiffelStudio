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

feature -- Access / Environment names

	ise_dotnet_framework_env: STRING = "ISE_DOTNET_FRAMEWORK"
			-- .NET framework environment variable

	ise_dotnet_platform_env: STRING = "ISE_DOTNET_PLATFORM"
			-- .net platform environment variable

	ise_dotnet_packs_env: STRING = "ISE_DOTNET_PACKS"
			-- .NETCore "packs" location environment variable
			-- (Only for NETCore)

	ise_dotnet_shared_env: STRING = "ISE_DOTNET_SHARED"
			-- .NETCore "shared" location environment variable
			-- (Only for NETCore)

	ise_dotnet_tfm_env: STRING = "ISE_DOTNET_TFM"
			-- .NETCore TFM (Target Framework Moniker) environment variable
			-- (Only for NETCore)

	ise_dotnet_version_env: STRING = "ISE_DOTNET_VERSION"
			-- .NETCore runtime precise version environment variable
			-- (Only for NETCore)		

feature -- Access

	dotnet_runtime_paths: ITERABLE [PATH]
			-- Paths to where .NET runtimes are installed.
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

	installed_runtime_info (a_version: READABLE_STRING_GENERAL): detachable IL_RUNTIME_INFO
			-- Exact installed version adapted from `a_version`.
			-- note: `a_version` could have only the major and minor, but not the rest
			--		 the installed_version will be a full defined version compatible with `a_version`
			--|		 for instance, for ".../6.0", it could return ".../6.0.15" if that one is installed.
		local
			k, loc: READABLE_STRING_GENERAL
			v: STRING_32
			i,n: INTEGER
		do
			if
				is_version_installed (a_version) and then
				attached installed_runtimes [a_version] as inf
			then
				Result := inf
			else
				across
					installed_runtimes as tb
				loop
					k := @ tb.key
						-- FIXME: be more acurate working with versioning and not just "starts_with"
					if k.starts_with (a_version) then
							-- From 6.0, accept latest installed version 6.0.16
						Result := tb
					end
				end
				if Result = Void and a_version.has ('/') then
						-- Check old CLR version formatting:  Microsoft.NETCore.App.Ref/6.0...
					create v.make_from_string_general ({STRING_32} "/" + a_version)
					if {PLATFORM}.is_windows then
						from
							i := 1
							n := v.count
						until
							i > n
						loop
							if v [i] = '/' then
								v [i] := {OPERATING_ENVIRONMENT}.directory_separator
							end
							i := i + 1
						end
					end

					across
						installed_runtimes as tb
					loop
						loc := tb.location.name
							-- FIXME: be more acurate working with versioning and not just "starts_with"
						if loc.has_substring (v) then
								-- From 6.0, accept latest installed version 6.0.16
							Result := tb
						end
					end
				end
			end
		end

	is_version_installed (a_version: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `a_version' installed?
		deferred
		end

	installed_runtimes: STRING_TABLE [IL_RUNTIME_INFO]
			-- All paths of sorted installed versions of .NET runtime indexed by their version names.
			-- note: the table is also sorted.
		deferred
		ensure
			installed_runtimes_not_void: Result /= Void
		end

	dotnet_framework_path: detachable PATH
			-- Path to .NET Framework/Runtime of version `version'.
		require
			is_dotnet_installed: is_dotnet_installed
		deferred
		end

	dotnet_packs_path: detachable PATH
			-- Path to .NET packs directory.
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

	is_using_reference_assemblies: BOOLEAN = True
			-- Use reference assemblies instead of implementation assemblies.

feature -- Query

	resource_compiler: detachable PATH
			-- Path to `resgen' tool from .NET Framework SDK.
		deferred
		end

feature -- Helpers		

	dotnet_target_framework_moniker (v: READABLE_STRING_32): STRING_32
			-- .Net Target Framework Moniker (TFM) for .Net version `v`.
		local
			i,j: INTEGER
			shv: STRING_32
		do
				-- TODO: check if similar code does not exist elsewhere.
			i := v.index_of ('.', 1)
			if i > 1 then
				j := v.index_of ('.', i + 1)
				if j > 0 then
					shv := v.substring (1, j - 1)
				else
					shv := v.substring (1, v.count)
				end
			else
				shv := v + {STRING_32} ".0"
			end
			if shv.is_case_insensitive_equal_general ("3.1") then
				Result := {STRING_32} "netcoreapp" + shv
			elseif shv.is_case_insensitive_equal_general ("2.1") then
				Result := {STRING_32} "netstandard" + shv
			elseif shv.is_case_insensitive_equal_general ("4.8") then
				Result := {STRING_32} "net48"
			else
				Result := {STRING_32} "net" + shv
			end
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
