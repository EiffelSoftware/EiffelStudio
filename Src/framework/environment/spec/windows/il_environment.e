﻿note
	description: "Information about current .NET environment"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	IL_ENVIRONMENT

inherit
	IL_ENVIRONMENT_IMP

	OPERATING_ENVIRONMENT
		undefine
			default_create
		end

	SHARED_EXECUTION_ENVIRONMENT
		undefine
			default_create
		end

create
	make, default_create

feature -- Access

	installed_runtimes: STRING_TABLE [IL_RUNTIME_INFO]
			-- All paths of installed versions of .NET runtime indexed by their version names.
		local
			l_runtime_path: detachable like dotnet_framework_runtime_path
			l_content: ARRAYED_LIST [PATH]
			l_dir: DIRECTORY
			l_file_name: PATH
			l_entry, loc: PATH
			l_file: RAW_FILE
			netcore_list: ARRAYED_LIST [IL_RUNTIME_INFO]
			l_netcore_version: READABLE_STRING_32
			l_version: IL_VERSION
			l_full_version: READABLE_STRING_GENERAL
			l_sorter: QUICK_SORTER [IL_RUNTIME_INFO]
			i,n: INTEGER
			l_info: IL_RUNTIME_INFO
		once
				-- .Net framework
			l_runtime_path := dotnet_framework_runtime_path
			create Result.make_equal (5)
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
								Result [l_entry.name] := create {IL_RUNTIME_INFO}.make (l_file_name.parent, l_entry.name)
							else
								l_file_name := l_runtime_path.extended_path (l_entry).extended ("clr.dll")
								l_file.make_with_path (l_file_name)
								if l_file.exists then
									if Result.has (l_entry.name) then
										Result.remove (l_entry.name)
									end
									Result [l_entry.name] := create {IL_RUNTIME_INFO}.make (l_file_name.parent, l_entry.name)
								end
							end
						end
						l_content.forth
					end
				end
			end
				-- NETCore runtimes
			create netcore_list.make (3)
			across
				dotnet_runtime_paths as p
			loop
				if is_using_reference_assemblies then
					l_file_name := p.extended ("packs")
				else
					l_file_name := p.extended ("shared")
				end
				create l_dir.make_with_path (l_file_name)
				if l_dir.exists then
					across l_dir.entries as e loop
						l_entry := e
						create l_dir.make_with_path (l_file_name.extended_path (l_entry))
						if is_using_reference_assemblies then
							if
								attached l_entry.extension as ext and then ext.is_case_insensitive_equal_general ("ref") and then
								l_entry.name.as_lower.has_substring (".netcore.") and then
								l_dir.exists
							then
								across l_dir.entries as v loop
									if version_expression.matches (v.utf_8_name) then
										loc := l_file_name.extended_path (l_entry).extended_path (v).extended ("Ref")
											-- Now get the TFM
										if attached folder_tfm (loc) as l_tfm then
											l_netcore_version := l_tfm + "/" + v.name
											create l_version.make_from_string (v.name)
											loc := loc.extended (l_tfm)
											netcore_list.force (create {IL_RUNTIME_INFO}.make_with_version_and_tfm (loc, v.name, l_tfm, l_entry.name))
										end
									end
								end
							end
						else
							if
								not l_entry.is_current_symbol and then
								not l_entry.is_parent_symbol and then
								l_dir.exists
							then
								across l_dir.entries as v loop
									if version_expression.matches (v.utf_8_name) then
										loc := l_file_name.extended_path (l_entry).extended_path (v)
										netcore_list.force (create {IL_RUNTIME_INFO}.make_with_version_and_tfm (loc, v.name, dotnet_target_framework_moniker (v.name), l_entry.name))
									end
								end
							end
						end
					end
				end
			end
			if netcore_list /= Void and then not netcore_list.is_empty then
				create l_sorter.make (create {COMPARABLE_COMPARATOR [IL_RUNTIME_INFO]})
				l_sorter.sort (netcore_list)
				from
					i := 1
					n := netcore_list.count
				until
					i > n
				loop
					l_info := netcore_list [i]
					l_full_version := l_info.full_version
					Result [l_full_version] := l_info
					i := i + 1
					if attached l_info.tfm as l_tfm then
						if
							i > n
							or else (
								attached netcore_list [i].tfm as l_next_tfm and then
								not l_next_tfm.same_string (l_tfm)
							)
						then
							Result [l_tfm] := l_info
						end
					end
				end
			end
		end

	folder_tfm (p: PATH): detachable READABLE_STRING_32
			-- Target Framework Moniker directory name inside location at `p`.
			-- It is the unique (and first) node name.
		local
			dir: DIRECTORY
		do
			create dir.make_with_path (p)
			if
				dir.exists and then
				attached dir.entries as l_entries
			then
				across
					l_entries as e
				loop
					if
						Result = Void and then
						not e.is_current_symbol and then
						not e.is_parent_symbol
					then
						Result := e.name
					end
				end
			end
		end

	installed_sdks: STRING_TABLE [PATH]
			-- All paths of installed versions of .NET SDKs indexed by their version names.
		local
			reg: WEL_REGISTRY
			p: POINTER
			f: STRING_32
			d: DIRECTORY
		once
			create Result.make_equal (1)
				-- For version v2.0 and earlier, the path to the SDK path is simple to find.
			create reg
			p := reg.open_key_with_access ("hkey_local_machine\SOFTWARE\Microsoft\.NETFramework",
				{WEL_REGISTRY_ACCESS_MODE}.Key_read)
			if p /= default_pointer then
				across <<"", "v1.1", "v2.0">> as k loop
					if attached reg.key_value (p, "sdkInstallRoot" + k) as key then
						Result [(<<"net10", "net11", "net20">>) [@ k.target_index]] :=
							create {PATH}.make_from_string (key.string_value)
					end
				end
				reg.close_key (p)
			end
				-- For version v4.0 and later, the path depends on what was installed on your machine,
				-- i.e. Visual Studio vs Windows SDK and the version of the SDK used.
			across <<"v8.1A", "v8.1", "v8.0A", "v8.0", "v7.1A", "v7.1", "v7.0A", "v7.0">> as v loop
				p := reg.open_key_with_access ("hkey_local_machine\SOFTWARE\Microsoft\Microsoft SDKs\Windows\" + v,
					{WEL_REGISTRY_ACCESS_MODE}.key_read)
				if p /= default_pointer then
					across 1 |..| reg.number_of_subkeys (p) as i loop
						if
							attached reg.enumerate_key (p, i) as k and then
							k.name.starts_with ("WinSDK-NetFx") and then
							k.name.ends_with ("Tools") and then
							attached k.name.substring (12, k.name.count - 5) as sdk_version and then
							sdk_version.count >= 2 and then
							attached reg.open_key (p, k.name, {WEL_REGISTRY_ACCESS_MODE}.key_read) as s and then
							s /= default_pointer
						then
							if attached reg.key_value (s, "InstallationFolder") as key then
								Result [{STRING_32} "net" + sdk_version] := create {PATH}.make_from_string (key.string_value)
							end
							reg.close_key (s)
						end
					end
					reg.close_key (p)
				end
			end
				-- Higher versions of .NET SDKs are located in "%ProgramFiles%\dotnet" (for 64-bit .NET on 64-bit Windows).
				-- TODO: handle other cases described at
				--    https://github.com/dotnet/core-setup/blob/master/Documentation/design-docs/multilevel-sharedfx-lookup.md
			f := execution_environment.item ("ProgramFiles")
			if not attached f then
				f := {STRING_32} "C:\Program Files"
			end
			f := f + "\dotnet\sdk"
			create d.make_with_name (f)
			if d.exists then
				across
					d.entries as e
				loop
					if
						not e.is_current_symbol and then
						not e.is_parent_symbol and then
						Version_expression.matches (e.utf_8_name) and then
						attached e.name as v and then
						attached (create {PATH}.make_from_string (f + "\" + v)) as n and then
						(create {DIRECTORY}.make_with_path (n)).exists
					then
						Result ["net" + v.head (if v.occurrences ('.') >= 2 then
							v.index_of ('.', 2) - 1
						else
							v.count
						end)] := n
					end
				end
			end
		end

	dotnet_framework_sdk_path_list: ARRAYED_LIST [like dotnet_framework_path]
			-- Path to .NET Framework SDK directory of version `version'.
			-- Void if not installed.
		local
			reg: WEL_REGISTRY
			p: POINTER
			key: detachable WEL_REGISTRY_KEY_VALUE
			l_major_version: like version
		do
			create Result.make (1)
			create reg
			l_major_version := version.head (4)
			if old_sdk_keys.has (l_major_version) then
					-- For version v2.0 and earlier, the path to the SDK path is simple to find.
				p := reg.open_key_with_access ("hkey_local_machine\SOFTWARE\Microsoft\.NETFramework",
					{WEL_REGISTRY_ACCESS_MODE}.Key_read)
				if p /= default_pointer then
					if attached old_sdk_keys.item (l_major_version) as l_key then
						key := reg.key_value (p, l_key)
						if key /= Void then
							Result.force (create {PATH}.make_from_string (key.string_value))
						end
					end
					reg.close_key (p)
				end
			end

				-- For version v4.0 and later, the path actually depends on what was installed on your machine,
				-- i.e. Visual Studio vs Windows SDK and the version of the SDK used.
				-- For the time being we take the first one that is not Void.
			across
				sdk_key_paths as l_path
			loop
				p := reg.open_key_with_access (l_path, {WEL_REGISTRY_ACCESS_MODE}.key_read)
				if p /= default_pointer then
					key := reg.key_value (p, "InstallationFolder")
					if key /= Void then
						Result.force (create {PATH}.make_from_string (key.string_value))
					end
					reg.close_key (p)
				end
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
			create reg
			l_major_version := version.head (4)
			if old_sdk_keys.has (l_major_version) then
					-- For version v2.0 and earlier, the path to the SDK path is simple to find.
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
			end
			if Result = Void then
					-- For version v4.0 and later, the path actually depends on what was installed on your machine,
					-- i.e. Visual Studio vs Windows SDK and the version of the SDK used.
					-- For the time being we take the first one that is not Void.
				across
					sdk_key_paths as l_path
				until
					Result /= Void
				loop
					p := reg.open_key_with_access (l_path, {WEL_REGISTRY_ACCESS_MODE}.key_read)
					if p /= default_pointer then
						key := reg.key_value (p, "InstallationFolder")
						if key /= Void then
							create Result.make_from_string (key.string_value)
						end
						reg.close_key (p)
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

	dotnet_framework_sdk_executable (a_executable: READABLE_STRING_GENERAL; a_sub_path: detachable PATH): detachable PATH
			-- Path to the executable found in one of the available SDK.
			-- if `a_sub_path` is set, search in that sub folder.
		local
			f: RAW_FILE
			l_sdk_path: PATH
			p: PATH
		do
			if attached dotnet_framework_sdk_path_list as lst then
				create f.make_with_name (a_executable)
				across
					lst as i
				until
					Result /= Void
				loop
					if attached i as l_path then
						if a_sub_path /= Void then
							l_sdk_path := l_path.extended_path (a_sub_path)
						else
							l_sdk_path := l_path
						end
						p := l_sdk_path.extended (a_executable)
						f.make_with_path (p)
						if f.exists then
							Result := p
						else
							p := l_sdk_path.extended ("bin").extended (a_executable)
							f.make_with_path (p)
							if f.exists then
								Result := p
							end
						end
					end
				end
			end
		end

	dotnet_executable_path: PATH
			-- Location of the
		local
			fut: FILE_UTILITIES
			p: PATH
		once
			across
				dotnet_potential_root_locations as loc
			until
				Result /= Void
			loop
				p := loc.extended ("dotnet.exe")
				if fut.file_path_exists (p) then
					Result := p
				end
			end
			if Result = Void then
				create Result.make_from_string ("dotnet.exe")
			end
		end

	dotnet_potential_root_locations: ARRAYED_LIST [PATH]
			-- Potential locations of the netcore root directory
		local
			f: READABLE_STRING_32
			p: PATH
		once
			create Result.make (1)
			if
				attached execution_environment.item ("DOTNET_ROOT") as s_dotnet_root
			then
				create p.make_from_string (s_dotnet_root)
				Result.force (p)
			end
			if {PLATFORM}.is_windows then
				f := execution_environment.item ("ProgramFiles")
				if f = Void then
					f := {STRING_32} "C:\Program Files"
				end
				f := f + "\dotnet"
				create p.make_from_string (f)
				Result.force (p)
			end
		end

feature -- Query

	dotnet_debugger_path (a_debug: READABLE_STRING_GENERAL): detachable PATH
			-- The path to the .NET debugger associated with 'a_debug'.
		require
			a_debug_not_void: a_debug /= Void
		local
			n: PATH
		do
			create n.make_from_string (a_debug)
			n := n.appended_with_extension ("exe")
			if
				use_mdbg (a_debug)
				or use_cordbg (a_debug)
			then
				Result := dotnet_framework_sdk_executable (n.name, Void)
			elseif use_dbgclr (a_debug) then
				create n.make_from_string ("GuiDebug")
				Result := dotnet_framework_sdk_executable (n.name, create {PATH}.make_from_string ("GuiDebug"))
			end
		end

	resource_compiler: detachable PATH
			-- Path to `resgen' tool from .NET Framework SDK.
		do
			Result := dotnet_framework_sdk_executable ("resgen.exe", Void)
		end

feature {NONE} -- Implementation

	old_sdk_keys: STRING_TABLE [STRING]
			-- List of keys associated to each known version of the .NET runtime up to version 2.0
		once
			create Result.make (3)
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
			create l_list.make (9)
			l_list.extend ({STRING_32} "v10.0A")	-- VS 2017
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
				l_path.append_string (l_sdk)
				Result.extend (l_path)
				create l_path.make_from_string (l_path)
				l_path.append_string ("\WinSDK-NetFx")
				l_path.append_character (l_major)
				l_path.append_character (l_minor)
				l_path.append_string_general ("Tools")
					-- In recent versions we see also the "-x64" or "-x86" appearing but
					-- just using the one without the suffix picks up the right binaries for our purpose.
				Result.extend (l_path)
			end
			across l_list as l_sdk loop
				create l_path.make_from_string_general ("hkey_local_machine\SOFTWARE\WOW6432Node\Microsoft\Microsoft SDKs\Windows\")
				l_path.append_string (l_sdk)
				Result.extend (l_path)
				create l_path.make_from_string (l_path)
				l_path.append_string ("\WinSDK-NetFx")
				l_path.append_character (l_major)
				l_path.append_character (l_minor)
				l_path.append_string_general ("Tools")
					-- In recent versions we see also the "-x64" or "-x86" appearing but
					-- just using the one without the suffix picks up the right binaries for our purpose.
				Result.extend (l_path)
			end
		end

	dotnet_runtime_paths: ITERABLE [PATH]
			-- Paths to where .NET runtimes are installed.
		local
			reg: WEL_REGISTRY
			p: POINTER
			key: WEL_REGISTRY_KEY_VALUE
			paths: ARRAYED_LIST [PATH]
		do
			create paths.make (1)
			paths.compare_objects
			create reg
				-- TODO: Support different architectures.
			p := reg.open_key_with_access ("hkey_local_machine\SOFTWARE\dotnet\Setup\InstalledVersions\x64\sharedhost",
				{WEL_REGISTRY_ACCESS_MODE}.Key_read)
			if p /= default_pointer then
				key := reg.key_value (p, "Path")
				if attached key then
					paths.extend (create {PATH}.make_from_string (key.string_value))
				end
				reg.close_key (p)
			end
			p := reg.open_key_with_access ("hkey_local_machine\SOFTWARE\dotnet\Setup\InstalledVersions\x64",
				{WEL_REGISTRY_ACCESS_MODE}.Key_read)
			if p /= default_pointer then
				key := reg.key_value (p, "InstallLocation")
				if attached key then
					paths.extend (create {PATH}.make_from_string (key.string_value))
				end
				reg.close_key (p)
			end
			Result := paths
		end

	dotnet_framework_runtime_path: detachable PATH
			-- Path to where .NET Framework runtimes are installed. It can be a once since this value is
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
				key := reg.key_value (p, framework_runtime_root_key)
				if key /= Void then
					create Result.make_from_string (key.string_value)
				end
				reg.close_key (p)
			end
		end

feature {NONE} -- Constants

	framework_runtime_root_key: STRING = "InstallRoot"
			-- Name of key specifiying where runtimes are installed.

	version_expression: REGULAR_EXPRESSION
			-- The regular expression decribing a dotnet version.
		once
			create Result
				-- TODO: update the final part of the expression to match the version specification rules.
			Result.compile ("(0|([1-9][0-9]*)).(0|([1-9][0-9]*)).*")
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
