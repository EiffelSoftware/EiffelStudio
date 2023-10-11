note
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

	REFACTORING_HELPER
		undefine
			default_create
		end

create
	make, default_create

feature -- Access

	dotnet_runtime_paths: ITERABLE [PATH]
			-- Paths to where .NET runtimes are installed.
		local
			paths: ARRAYED_LIST [PATH]
			p: PATH
		once
			create paths.make (0)
			if attached installed_runtimes as l_runtimes then
				across
					l_runtimes as rt
				loop
					if is_using_reference_assemblies then
							-- Case: /usr/lib/dotnet/packs/Microsoft.NETCore.App.Ref/6.0.22/ref/net6.0
						p := rt.location.extended ("..").extended ("..").extended ("..").extended ("..").extended ("..")
					else
							-- Case: usr/lib/dotnet/shared/Microsoft.NETCore.App/6.0.22/
						p := rt.location.extended ("..").extended ("..").extended ("..")
					end
					p := p.canonical_path
					if not paths.has (p) then
						paths.force (p)
					end
				end
			end
			Result := paths
		end

	installed_runtimes: STRING_TABLE [IL_RUNTIME_INFO]
			-- All paths of installed versions of .NET runtime indexed by their version names.
		local
			v: READABLE_STRING_32
			inf: IL_RUNTIME_INFO
			netcore_list: ARRAYED_LIST [IL_RUNTIME_INFO]
			l_full_version: READABLE_STRING_GENERAL
			l_sorter: QUICK_SORTER [IL_RUNTIME_INFO]
			i,n: INTEGER
			l_info: IL_RUNTIME_INFO
		once
			if attached available_runtimes (is_using_reference_assemblies) as l_runtimes then
				create Result.make (l_runtimes.count)
				create netcore_list.make (l_runtimes.count)
				across
					l_runtimes as rt
				loop
						-- Keep only .NETCore. runtime
					if rt.runtime_name.as_lower.has_substring (".netcore.") then
						v := rt.runtime_version.to_string_32
						if attached dotnet_target_framework_moniker (v) as l_moniker then
							create inf.make_with_version_and_tfm (rt.path, v, l_moniker, rt.runtime_name)
						else
							create inf.make (rt.path, v)
						end
						netcore_list.force (inf)
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
			else
				create Result.make (0)
			end
		end

	installed_sdks: STRING_TABLE [PATH]
			-- All paths of installed versions of .NET SDKs indexed by their version names.
		local
			v: READABLE_STRING_GENERAL
		once
			if attached available_sdks as l_sdks then
				create Result.make (l_sdks.count)
				across
					l_sdks as e
				loop
					v := e.version
					Result.force (e.path.extended (v), v)
				end
			else
				create Result.make (0)
			end
		end

feature -- .Net framework specific

	dotnet_framework_sdk_path: like dotnet_framework_path
			-- Path to .NET Framework SDK directory of version `version'.
			-- Void if not installed.
		do
			--create Result.make_empty
			Result := installed_sdks [version]
			debug ("refactor_fixme")
				to_implement ("TODO: to implement")
			end
		end

	dotnet_framework_sdk_bin_path: like dotnet_framework_path
			-- Path to bin directory of .NET Framework SDK of version `version'.
		do
			create Result.make_empty
			debug ("refactor_fixme")
				to_implement ("TODO: to implement")
			end
		end

feature -- NETCore specific

	dotnet_executable_path: PATH
			-- Location of the netcore dotnet executable tool.
		local
			fut: FILE_UTILITIES
			p: PATH
		once
			across
				dotnet_potential_root_locations as loc
			until
				Result /= Void
			loop
				p := loc.extended ("dotnet")
				if fut.file_path_exists (p) then
					Result := p
				end
			end
			if Result = Void then
				create Result.make_from_string ("dotnet")
			end
		end

	dotnet_potential_root_locations: ARRAYED_LIST [PATH]
			-- Potential locations of the netcore root directory
		local
			p: PATH
		once
			create Result.make (1)
			if
				attached execution_environment.item ("DOTNET_ROOT") as s_dotnet_root
			then
				create p.make_from_string (s_dotnet_root)
				Result.force (p)
			end
			if {PLATFORM}.is_mac then
				create p.make_from_string ("/usr/local/share/dotnet")
			else
				create p.make_from_string ("/usr/share/dotnet")
				Result.force (p)
				create p.make_from_string ("/usr/lib/dotnet")
				Result.force (p)
			end
		end

feature -- Query

	dotnet_debugger_path (a_debug: READABLE_STRING_GENERAL): detachable PATH
			-- The path to the .NET debugger associated with 'a_debug'.
		require
			a_debug_not_void: a_debug /= Void
		do
			create Result.make_empty
			debug ("refactor_fixme")
				to_implement ("TODO: to implement")
			end
		end

	resource_compiler: detachable PATH
			-- Path to `resgen' tool from .NET Framework SDK.
		do
			debug ("refactor_fixme")
				to_implement ("TODO: to implement")
			end
		end

feature -- Helpers

	available_sdks: ARRAYED_LIST [TUPLE [version: READABLE_STRING_8; path: PATH]]
		local
			fac: BASE_PROCESS_FACTORY
			p: BASE_PROCESS
			buffer: SPECIAL [NATURAL_8]
			s, line, v, d: STRING_8
			i: INTEGER
			loc: PATH
		once
			create fac
			p := fac.process_launcher_with_command_line (dotnet_executable_path.name + " --list-sdks", Void)
			p.redirect_output_to_stream

			p.launch
			if p.launched then
				create s.make_empty
				from
				until
					p.has_exited
				loop
					from
						if buffer = Void then
							create buffer.make_filled (0, 1024)
						end
					until
						p.has_exited or p.has_output_stream_closed
					loop
						p.read_output_to_special (buffer)
						append_special_of_natural_8_to_string_8 (buffer, s)
					end
					p.wait_for_exit_with_timeout (50)
				end
			end
			p.close
			create Result.make (0)
			if s /= Void then
				across
					s.split ('%N') as ic
				loop
					line := ic
					i := line.index_of (' ', 1)
					if i > 0 then
						v := line.substring (1, i - 1)
						d := line.substring (i + 1, line.count)
						if d.count > 1 and d [1] = '[' and d [d.count] = ']' then
							d := d.substring (2, d.count - 1)
							create loc.make_from_string ({UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (d))
							Result.force ([v, loc.extended (v)])
						end
					end
				end
			end
		end

	available_runtimes (a_using_reference: BOOLEAN): ARRAYED_LIST [TUPLE [runtime_name: READABLE_STRING_GENERAL; runtime_version: READABLE_STRING_8; path: PATH]]
			-- Available dotnet runtime, if `a_using_reference` is True, detect reference assemblies.
		local
			fac: BASE_PROCESS_FACTORY
			p: BASE_PROCESS
			buffer: SPECIAL [NATURAL_8]
			l_rt_name: STRING_32
			s, line, v, d: STRING_8
			dn: STRING_32
			i,j: INTEGER
			loc: PATH
			fut: FILE_UTILITIES
		do
			create fac
			p := fac.process_launcher_with_command_line (dotnet_executable_path.name + " --list-runtimes", Void)
			p.redirect_output_to_stream

			p.launch
			if p.launched then
				create s.make_empty
				from
				until
					p.has_exited
				loop
					from
						if buffer = Void then
							create buffer.make_filled (0, 1024)
						end
					until
						p.has_exited or p.has_output_stream_closed
					loop
						p.read_output_to_special (buffer)
						append_special_of_natural_8_to_string_8 (buffer, s)
					end
					p.wait_for_exit_with_timeout (50)
				end
			end
			p.close
			create Result.make (0)
			if s /= Void then
				across
					s.split ('%N') as ic
				loop
					line := ic
					i := line.index_of (' ', 1)
					if i > 0 then
						s := line.substring (1, i - 1)
						j := line.index_of (' ', i + 1)
						if j > 0 then
							d := line.substring (j + 1, line.count)
							if d.count > 1 and d [1] = '[' and d [d.count] = ']' then
								d := d.substring (2, d.count - 1)
								dn := {UTF_CONVERTER}.utf_8_string_8_to_string_32 (d)
								create loc.make_from_string (dn)

								v := line.substring (i + 1, j - 1)
								if a_using_reference then
									dn := loc.name
									s.append (".Ref")
									dn.replace_substring_all ("/dotnet/shared/", "/dotnet/packs/")
									dn.append (".Ref")
									create l_rt_name.make_from_string_general (s)
									create loc.make_from_string (dn)
									loc := loc.extended (v).extended ("ref").extended (dotnet_target_framework_moniker (v))
								else
									create l_rt_name.make_from_string_general (s)
									loc := loc.extended (v)
								end
								if fut.directory_path_exists (loc) then
									Result.force ([l_rt_name, v, loc])
								end
							else
								loc := Void
							end
						end
					end
				end
			end
		end

feature {NONE} -- Implementation

	append_special_of_natural_8_to_string_8 (spec: SPECIAL [NATURAL_8]; a_output: STRING)
		local
			i,n: INTEGER
		do
			from
				i := spec.lower
				n := spec.upper
			until
				i > n
			loop
				a_output.append_code (spec[i])
				i := i + 1
			end
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
