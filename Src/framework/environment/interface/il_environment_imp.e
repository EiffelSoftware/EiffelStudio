note
	description: "[
			Information about current .NET environment

			Common implementation of IL_ENVIRONMENT for Windows, and others
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	IL_ENVIRONMENT_IMP

inherit
	IL_ENVIRONMENT_I
		redefine
			default_create
		end

feature {NONE} -- Initialization

	make (a_version: detachable READABLE_STRING_GENERAL)
			-- Create an instance of IL_ENVIRONMENT targeting a specific .NET version `a_version'.
			-- If `a_version' is not specified we currently take `default_version'.
			-- Set `version' with `a_version'.
		local
			i: INTEGER
		do
			if a_version /= Void then
				create version.make_from_string_general (a_version)
			else
				version := default_version
			end
				-- TODO: find alternative solution, without parsing the version here.
			tfm := Void
			runtime_version := Void
			if attached version as v then
				i := v.index_of ('/', 1)
				if i > 0 then
					tfm := v.substring (1, i - 1)
					runtime_version := v.substring (i + 1, v.count)
				end
			end
		ensure
			version_set: attached version and (attached a_version implies version.same_string_general (a_version))
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
			-- If runtime is found, we set the ISE_DOTNET_FRAMEWORK environment variable.
		local
			l_exec: EXECUTION_ENVIRONMENT
			l_empty_string, s_packs, s_shared, s_tfm, s_runtime_version: READABLE_STRING_GENERAL
		do
			if is_dotnet_installed then
				l_empty_string := ""
				s_packs := l_empty_string
				s_shared := l_empty_string

				create l_exec
				if attached dotnet_framework_path as l_path then
					l_exec.put (l_path.name, ise_dotnet_framework_env)
				else
					l_exec.put (l_empty_string, ise_dotnet_framework_env)
				end
				l_exec.put (dotnet_platform, ise_dotnet_platform_env)

				if is_il_netcore then
					if attached dotnet_packs_path as p_packs then
						s_packs := p_packs.name
					end
					if attached dotnet_shared_path as p_shared then
						s_shared := p_shared.name
					end
					s_tfm := tfm
					s_runtime_version := runtime_version
				end
				l_exec.put (s_packs, ise_dotnet_packs_env)
				l_exec.put (s_shared, ise_dotnet_shared_env)
				if s_tfm = Void then
					s_tfm := l_empty_string
				end
				l_exec.put (s_tfm, ise_dotnet_tfm_env)
				if s_runtime_version = Void then
					s_runtime_version := l_empty_string
				end
				l_exec.put (s_runtime_version, ise_dotnet_version_env)
			end
		end

feature -- Access			

	version: IMMUTABLE_STRING_32
			-- Currently selected version, if none `default_version'.

	tfm: detachable IMMUTABLE_STRING_32
			-- Target Framework Moniker
			--| ex: net6.0, net7.0, ...

	runtime_version: detachable IMMUTABLE_STRING_32
			-- NETCore runtime version, such as 6.0.15, 7.0.10, ...

feature -- Query	

	default_version: IMMUTABLE_STRING_32
			-- Default runtime version if `version' was not specified.
			-- Semantic is to take the most recent version of the run-time.
		local
			l_runtimes: like installed_runtimes
			k: READABLE_STRING_GENERAL
			v: READABLE_STRING_GENERAL
			result_key, result_version: IMMUTABLE_STRING_32
			i: INTEGER
			inf, result_info: IL_RUNTIME_INFO
		once
			l_runtimes := installed_runtimes
			if not l_runtimes.is_empty then
					-- Take the most recent version from `installed_runtimes'.
				across
					l_runtimes as r
				loop
					inf := r
					k := @ r.key
					if result_key = Void then
						result_key := k
						result_info := inf
					elseif result_info = Void or else result_info <= inf then
						result_key := k
						result_info := inf
					end
				end
				Result := result_key
			end
			if Result = Void then
					-- No .NET runtime found, we simply return a fake version
					-- number.
				create Result.make_from_string_general (v4_0)
			end
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

	dotnet_framework_path: detachable PATH
			-- Path to .NET Framework of version `version'.
		do
			if attached installed_runtimes [version] as inf then
				Result := inf.location
			end
		end

	dotnet_packs_path: detachable PATH
			-- Path to .NET packs of version `version'.
		local
			dn: PATH
			l_dir: DIRECTORY
		once
			across
				dotnet_runtime_paths as p
			until
				Result /= Void
			loop
				dn := p.extended ("packs")
				create l_dir.make_with_path (dn)
				if l_dir.exists then
					Result := dn
				end
			end
		end

	dotnet_shared_path: detachable PATH
			-- Path to .NET shared of version `version'.
		local
			dn: PATH
			l_dir: DIRECTORY
		once
			across
				dotnet_runtime_paths as p
			until
				Result /= Void
			loop
				dn := p.extended ("shared")
				create l_dir.make_with_path (dn)
				if l_dir.exists then
					Result := dn
				end
			end
		end

	dotnet_executable_path: PATH
			-- Location of the netcore dotnet executable tool.
		deferred
		end

feature -- Dotnet platform

	dotnet_platform_netcore: IMMUTABLE_STRING_32 = "netcore"

	dotnet_platform_netframework: IMMUTABLE_STRING_32 = "netframework"

	is_il_netcore: BOOLEAN
			-- Is IL netcore ?
			-- as opposed to .Net framework (v4.0, v2.0, ...)
		local
			v: like version
		do
			v := version
			if v = Void then
				v := default_version
			end
			Result := (create {IL_NETCORE_DETECTOR}).is_il_netcore (v)
		end

	dotnet_platform: STRING_32
			-- Identifier for the dotnet platform (netcore vs netframework).
		do
			if is_il_netcore then
				Result := dotnet_platform_netcore
			else
				Result := dotnet_platform_netframework
			end
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
