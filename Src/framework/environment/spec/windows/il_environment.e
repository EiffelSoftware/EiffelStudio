note
	description: "Information about current .NET environment"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	IL_ENVIRONMENT

inherit
	OPERATING_ENVIRONMENT
		redefine
			default_create
		end

create
	make, default_create

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
			if is_dotnet_installed and then attached dotnet_framework_path as l_path then
				create l_exec
				l_exec.put (l_path.string, ise_dotnet_framework_env)
			end
		end

feature -- Access

	ise_dotnet_framework_env: STRING = "ISE_DOTNET_FRAMEWORK"
			-- .NET framework environment variable

	version: STRING
			-- Currently selected version, if none `default_version'.

	default_version: STRING
			-- Default runtime version if `version' was not specified.
			-- Semantic is to take the most recent version of the run-time.
		local
			l_runtimes: like installed_runtimes
		do
			l_runtimes := installed_runtimes
			if not l_runtimes.is_empty then
					-- Take the most recent version from `installed_runtimes'.
				from
					Result := l_runtimes.first
					l_runtimes.start
					l_runtimes.forth
				until
					l_runtimes.after
				loop
					if Result < l_runtimes.item then
						Result := l_runtimes.item
					end
					l_runtimes.forth
				end
				Result := Result.twin
			else
					-- No .NET runtime found, we simply return a fake version
					-- number.
				Result := v1_0.twin
			end
		ensure
			default_version_not_void: Result /= Void
		end

	is_dotnet_installed: BOOLEAN
			-- Is dotnet version `version' installed?
		do
			Result := installed_runtimes.has (version)
		end

	installed_runtimes: ARRAYED_LIST [STRING]
			-- List all installed version of the runtime.
		local
			l_runtime_path: detachable STRING
			l_content: ARRAYED_LIST [STRING]
			l_dir: DIRECTORY
			l_file_name: FILE_NAME
			l_file: RAW_FILE
		do
			l_runtime_path := dotnet_runtime_path
			create Result.make (5)
			Result.compare_objects
			if l_runtime_path /= Void then
				create l_dir.make (l_runtime_path)
				if l_dir.exists then
					l_dir.open_read
					l_content := l_dir.linear_representation
					from
						l_content.start
					until
						l_content.after
					loop
							-- Insert in `Result' all files/directories
							-- starting with letter `v' as it is most likely
							-- to be an occurrence of an installed .NET runtime.
						if l_content.item.item (1) = 'v' then
								-- Now we check that in this directory there is a file called
								-- `mscorwks.dll' which is the Microsoft .NET engine. If there
								-- is no such file, then it might be a remaining of an old
								-- installed runtime.
							create l_file_name.make_from_string (l_runtime_path)
							l_file_name.extend (l_content.item)
							l_file_name.set_file_name ("mscorwks.dll")
							create l_file.make (l_file_name)
							if l_file.exists then
								Result.put_right (l_content.item)
							else
								create l_file_name.make_from_string (l_runtime_path)
								l_file_name.extend (l_content.item)
								l_file_name.set_file_name ("clr.dll")
								l_file.make (l_file_name)
								if l_file.exists then
									Result.put_right (l_content.item)
								end
							end
						end
						l_content.forth
					end
					l_dir.close
				end
			end
		ensure
			installed_runtimes_not_void: Result /= Void
		end

	dotnet_framework_path: detachable STRING
			-- Path to .NET Framework of version `version'.
		require
			is_dotnet_installed: is_dotnet_installed
		local
			l_file_name: FILE_NAME
		do
			if attached dotnet_runtime_path as l_path then
				create l_file_name.make_from_string (l_path)
				l_file_name.extend (version)
				Result := l_file_name
			end
		end

	dotnet_framework_sdk_path: detachable STRING
			-- Path to .NET Framework SDK directory of version `version'.
			-- Void if not installed.
		local
			reg: WEL_REGISTRY
			p: POINTER
			key: detachable WEL_REGISTRY_KEY_VALUE
			l_major_version: STRING
		do
			l_major_version := version.twin
			l_major_version.keep_head (4)
			if old_sdk_keys.has (l_major_version) then
					-- For version v2.0 and earlier, the path to the SDK path is simple to find.
				create reg
				p := reg.open_key_with_access ("hkey_local_machine\SOFTWARE\Microsoft\.NETFramework",
					{WEL_REGISTRY_ACCESS_MODE}.Key_read)
				if p /= default_pointer then
					if attached {STRING} old_sdk_keys.item (l_major_version) as l_key then
						key := reg.key_value (p, l_key)
						if key /= Void then
							Result := key.string_value
						end
					end
					reg.close_key (p)
				end
			else
					-- For version v4.0 and later, the path actually depends on what was installed on your machine,
					-- i.e. Visual Studio vs Windows SDK and the version of the SDK used.
					-- For the time being we take the first one that is not Void.
				across sdk_key_paths as l_path
				until
					Result /= Void
				loop
					create reg
					p := reg.open_key_with_access (l_path.item, {WEL_REGISTRY_ACCESS_MODE}.key_read)
					if p /= default_pointer then
						key := reg.key_value (p, "InstallationFolder")
						if key /= Void then
							Result := key.string_value
						end
					end
				end
			end
		end

	dotnet_framework_sdk_bin_path: detachable STRING
			-- Path to bin directory of .NET Framework SDK of version `version'.
		local
			l_path: detachable STRING
			l_major_version: STRING
		do
			l_path := Dotnet_framework_sdk_path
			if l_path /= Void then
				l_major_version := version.twin
				l_major_version.keep_head (4)
				if old_sdk_keys.has (l_major_version) then
						-- In the old SDKs, it was in a subdirectory
					Result := l_path + "bin\"
				else
					Result := l_path
				end
			end
		end

feature -- Query

	use_cordbg (a_string: STRING): BOOLEAN
			-- Should Current use cordbg.exe?
		do
			Result := a_string /= Void and then a_string.is_equal ("cordbg")
		end

	use_dbgclr (a_string: STRING): BOOLEAN
			-- Should Current use DbgCLR.exe?
		do
			Result := a_string /= Void and then a_string.is_equal ("DbgCLR")
		end

	use_mdbg (a_string: STRING): BOOLEAN
			-- Should current use MDbg.exe?
		do
			Result := a_string /= Void and then a_string.is_equal ("MDbg")
		end

	dotnet_debugger_path (a_debug: STRING): detachable STRING
			-- The path to the .NET debugger associated with 'a_debug'.
		require
			a_debug_not_void: a_debug /= Void
		local
			l_path: detachable STRING
		do
			if use_mdbg (a_debug) then
				l_path := dotnet_framework_sdk_bin_path
				if l_path /= Void then
					Result := l_path + a_debug + ".exe"
				end
			elseif use_cordbg (a_debug) then
				l_path := dotnet_framework_sdk_bin_path
				if l_path /= Void then
					Result := l_path + a_debug + ".exe"
				end
			elseif use_dbgclr (a_debug) then
				l_path := Dotnet_framework_sdk_path
				if l_path /= Void then
					Result := l_path + "GuiDebug\" + a_debug + ".exe"
				end
			end
		end

	resource_compiler: detachable STRING
			-- Path to `resgen' tool from .NET Framework SDK.
		local
			l_path: detachable STRING
		do
			l_path := dotnet_framework_sdk_bin_path
			if l_path /= Void then
				Result := l_path + "resgen.exe"
			end
		end

feature {NONE} -- Implementation

	old_sdk_keys: HASH_TABLE [STRING, STRING]
			-- List of keys associated to each known version of the .NET runtime up to version 2.0
		once
			create Result.make (2)
			Result.put ("sdkInstallRoot", v1_0)
			Result.put ("sdkInstallRootv1.1", v1_1)
			Result.put ("sdkInstallRootv2.0", v2_0)
		ensure
			sdk_keys_not_void: Result /= Void
		end

	sdk_key_paths: ARRAYED_LIST [STRING]
			-- List of keys associated to each known version of the .NET runtime from version 4.0
		require
			version_valid: version.count >= 4
		local
			l_path: STRING
		do
			create Result.make (2)

			create l_path.make_from_string ("hkey_local_machine\SOFTWARE\Microsoft\Microsoft SDKs\Windows\v7.1\WinSDK-NetFx")
				-- Major version
			l_path.append_character (version.item (2))
				-- Minor version
			l_path.append_character (version.item (4))
			l_path.append ("Tools")
			Result.extend (l_path)

			create l_path.make_from_string ("hkey_local_machine\SOFTWARE\Microsoft\Microsoft SDKs\Windows\v7.0A\WinSDK-NetFx")
				-- Major version
			l_path.append_character (version.item (2))
				-- Minor version
			l_path.append_character (version.item (4))
			l_path.append ("Tools")
			Result.extend (l_path)
		end

	dotnet_runtime_path: detachable STRING
			-- Path to where .NET runtimes are installed. It can be a once since this value is
			-- not dependent on `version'.
		local
			reg: WEL_REGISTRY
			p: POINTER
			key: detachable WEL_REGISTRY_KEY_VALUE
		once
			create reg
			p := reg.open_key_with_access ("hkey_local_machine\SOFTWARE\Microsoft\.NETFramework",
				{WEL_REGISTRY_ACCESS_MODE}.Key_read)
			if p /= default_pointer then
				key := reg.key_value (p, runtime_root_key)
				if key /= Void then
					Result := key.string_value
					if Result.item (Result.count) = Directory_separator then
						Result.remove (Result.count)
					end
				end
				reg.close_key (p)
			end
		ensure
			no_ending_separator: Result /= Void implies Result.item (Result.count) /= Directory_separator
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

feature {NONE} -- Constants

	runtime_root_key: STRING = "InstallRoot"
			-- Name of key specifiying where runtimes are installed.

invariant
	version_not_void: version /= Void

note
	copyright: "Copyright (c) 1984-2011, Eiffel Software"
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

end -- class IL_ENVIRONMENT
