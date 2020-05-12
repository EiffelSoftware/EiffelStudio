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

	make (a_version: detachable READABLE_STRING_GENERAL)
			-- Create an instance of IL_ENVIRONMENT targeting a specific .NET version `a_version'.
			-- If `a_version' is not specified we currently take `default_version'.
			-- Set `version' with `a_version'.
		do
			if attached a_version then
				create version.make_from_string_general (a_version)
			else
				version := default_version
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
			else
					-- No .NET runtime found, we simply return a fake version
					-- number.
				create Result.make_from_string_general (v1_0)
			end
		ensure
			default_version_not_void: Result /= Void
		end

	is_dotnet_installed: BOOLEAN
			-- Is dotnet version `version' installed?
		do
			Result := installed_runtimes.has (version)
		end

	is_version_installed (a_version: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `a_version' installed?
		do
			Result := across installed_runtimes as l_runtime some l_runtime.item.same_string_general (a_version) end
		end

	installed_runtimes: ARRAYED_LIST [IMMUTABLE_STRING_32]
			-- List all installed version of the runtime.
		local
			l_runtime_path: detachable like dotnet_runtime_path
			l_content: ARRAYED_LIST [PATH]
			l_dir: DIRECTORY
			l_file_name: PATH
			l_entry: PATH
			l_file: RAW_FILE
		do
			l_runtime_path := dotnet_runtime_path
			create Result.make (5)
			Result.compare_objects
			if l_runtime_path /= Void then
				create l_dir.make_with_path (l_runtime_path)
				if l_dir.exists then
					l_content := l_dir.entries
					from
						l_content.start
					until
						l_content.after
					loop
							-- Insert in `Result' all files/directories
							-- starting with letter `v' as it is most likely
							-- to be an occurrence of an installed .NET runtime.
						l_entry := l_content.item
						if not l_entry.is_empty and then l_entry.name.item (1) = 'v' then
								-- Now we check that in this directory there is a file called
								-- `mscorwks.dll' which is the Microsoft .NET engine. If there
								-- is no such file, then it might be a remaining of an old
								-- installed runtime.
							l_file_name := l_runtime_path.extended_path (l_entry).extended ("mscorwks.dll")
							create l_file.make_with_path (l_file_name)
							if l_file.exists then
								Result.put_right (l_entry.name)
							else
								l_file_name := l_runtime_path.extended_path (l_entry).extended ("clr.dll")
								l_file.make_with_path (l_file_name)
								if l_file.exists then
									Result.put_right (l_entry.name)
								end
							end
						end
						l_content.forth
					end
				end
			end
		ensure
			installed_runtimes_not_void: Result /= Void
		end

	dotnet_framework_path: detachable PATH
			-- Path to .NET Framework of version `version'.
		require
			is_dotnet_installed: is_dotnet_installed
		do
			if attached dotnet_runtime_path as l_path then
				Result := l_path.extended (version)
			end
		end

	dotnet_framework_sdk_path: like dotnet_framework_path
			-- Path to .NET Framework SDK directory of version `version'.
			-- Void if not installed.
		local
			reg: WEL_REGISTRY
			p: POINTER
			key: detachable WEL_REGISTRY_KEY_VALUE
			l_major_version: like version
		do
			l_major_version := version.head (4)
			if old_sdk_keys.has (l_major_version) then
					-- For version v2.0 and earlier, the path to the SDK path is simple to find.
				create reg
				p := reg.open_key_with_access ("hkey_local_machine\SOFTWARE\Microsoft\.NETFramework",
					{WEL_REGISTRY_ACCESS_MODE}.Key_read)
				if p /= default_pointer then
					if attached old_sdk_keys.item (l_major_version) as l_key then
						key := reg.key_value (p, l_key)
						if key /= Void then
							create Result.make_from_string (key.string_value)
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
							create Result.make_from_string (key.string_value)
						end
					end
				end
			end
		end

	dotnet_framework_sdk_bin_path: like dotnet_framework_path
			-- Path to bin directory of .NET Framework SDK of version `version'.
		do
			Result := Dotnet_framework_sdk_path
			if Result /= Void then
				if old_sdk_keys.has (version.head (4)) then
						-- In the old SDKs, it was in a subdirectory
					Result := Result.extended ("bin")
				end
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

	dotnet_debugger_path (a_debug: READABLE_STRING_GENERAL): detachable PATH
			-- The path to the .NET debugger associated with 'a_debug'.
		require
			a_debug_not_void: a_debug /= Void
		do
			if use_mdbg (a_debug) then
				Result := dotnet_framework_sdk_bin_path
				if attached Result then
					Result := Result.extended (a_debug).appended_with_extension ("exe")
				end
			elseif use_cordbg (a_debug) then
				Result:= dotnet_framework_sdk_bin_path
				if attached Result then
					Result := Result.extended (a_debug).appended_with_extension ("exe")
				end
			elseif use_dbgclr (a_debug) then
				Result := Dotnet_framework_sdk_path
				if attached Result then
					Result := Result.extended ("GuiDebug").extended (a_debug).appended_with_extension ("exe")
				end
			end
		end

	resource_compiler: detachable PATH
			-- Path to `resgen' tool from .NET Framework SDK.
		do
			Result := dotnet_framework_sdk_bin_path
			if Result /= Void then
				Result := Result.extended ("resgen.exe")
			end
		end

feature {NONE} -- Implementation

	old_sdk_keys: STRING_TABLE [STRING]
			-- List of keys associated to each known version of the .NET runtime up to version 2.0
		once
			create Result.make (2)
			Result.put ("sdkInstallRoot", v1_0)
			Result.put ("sdkInstallRootv1.1", v1_1)
			Result.put ("sdkInstallRootv2.0", v2_0)
		ensure
			sdk_keys_not_void: Result /= Void
		end

	sdk_key_paths: ARRAYED_LIST [STRING_32]
			-- List of keys associated to each known version of the .NET runtime from version 4.0 or greater.
			-- See http://en.wikipedia.org/wiki/Microsoft_Windows_SDK#Versions for details on various versions.
		require
			version_valid: version.count >= 4
		local
			l_path: STRING_32
			l_major, l_minor: CHARACTER_32
			l_list: ARRAYED_LIST [STRING_32]
		do
			create Result.make (256)
				-- Extract major and minor version from `version' which follows the pattern `vM.N'.
			l_major := version.item (2)
			l_minor := version.item (4)
				-- Create list of known SDKs
			create l_list.make (8)
			l_list.extend ({STRING_32} "v8.1A")	-- VS 2013
			l_list.extend ({STRING_32} "v8.1")	-- WSDK Windows 8.1
			l_list.extend ({STRING_32} "v8.0A")	-- VS 2012
			l_list.extend ({STRING_32} "v8.0")	-- WSDK Windows 8 and .NET 4.5
			l_list.extend ({STRING_32} "v7.1A")	-- VS 2012 Update 1
			l_list.extend ({STRING_32} "v7.1")	-- WSDK Windows 7 and .NET 4.0
			l_list.extend ({STRING_32} "v7.0A")	-- VS 2010
			l_list.extend ({STRING_32} "v7.0")	-- WSDK Windows 7 and .NET 3.5 SP1

			across l_list as l_sdk loop
				create l_path.make_from_string_general ("hkey_local_machine\SOFTWARE\Microsoft\Microsoft SDKs\Windows\")
				l_path.append_string (l_sdk.item)
				l_path.append_string ("\WinSDK-NetFx")
				l_path.append_character (l_major)
				l_path.append_character (l_minor)
				l_path.append_string_general ("Tools")
					-- In recent versions we see also the "-x64" or "-x86" appearing but
					-- just using the one without the suffix picks up the right binaries for our purpose.
				Result.extend (l_path)
			end
		end

	dotnet_runtime_path: detachable PATH
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
					create Result.make_from_string (key.string_value)
				end
				reg.close_key (p)
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

feature {NONE} -- Constants

	runtime_root_key: STRING = "InstallRoot"
			-- Name of key specifiying where runtimes are installed.

invariant
	version_not_void: version /= Void
	version_valid: version.count >= 4 and then (version.item (1) = 'v' and version.item (2).is_digit and
		version.item (3) = '.' and version.item (4).is_digit)

note
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
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
