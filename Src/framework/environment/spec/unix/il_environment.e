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

	SHARED_EXECUTION_ENVIRONMENT
		redefine
			default_create
		end

	REFACTORING_HELPER
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
			if a_version /= Void then
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
			-- If runtime is found, we set the ISE_DOTNET_FRAMEWORK environment variable.
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
				across
					l_runtimes as r
				from
					Result := @ r.key
					;@ r.forth
				loop
					if Result < @ r.key then
						Result := @ r.key
					end
				end
			else
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

	installed_runtimes: STRING_TABLE [PATH]
			-- All paths of installed versions of .NET runtime indexed by their version names.
		local
			v: READABLE_STRING_GENERAL
		do
			if attached available_runtimes as l_runtimes then
				create Result.make (l_runtimes.count)
				across
					l_runtimes as rt
				loop
					v := rt.version
					Result.force (rt.path, v)
				end
			else
				create Result.make (0)
			end
		end

	dotnet_framework_path: detachable PATH
			-- Path to .NET Framework of version `version'.
		do
			Result := installed_runtimes [version]
		end

	installed_sdks: STRING_TABLE [PATH]
			-- All paths of installed versions of .NET SDKs indexed by their version names.
		local
			v: READABLE_STRING_GENERAL
		do
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
			if {PLATFORM}.is_windows then
				p := fac.process_launcher_with_command_line ("dotnet --list-sdks", Void)
			else
				p := fac.process_launcher_with_command_line ("/usr/bin/dotnet --list-sdks", Void)
			end
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

	available_runtimes: ARRAYED_LIST [TUPLE [version: READABLE_STRING_8; path: PATH]]
		local
			fac: BASE_PROCESS_FACTORY
			p: BASE_PROCESS
			buffer: SPECIAL [NATURAL_8]
			s, line, v, d: STRING_8
			i,j: INTEGER
			loc: PATH
		once
			create fac
			if {PLATFORM}.is_windows then
				p := fac.process_launcher_with_command_line ("dotnet --list-runtimes", Void)
			else
				p := fac.process_launcher_with_command_line ("/usr/bin/dotnet --list-runtimes", Void)
			end
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
							v := line.substring (i + 1, j - 1)
							s.extend ('/')
							s.append (v)
							d := line.substring (j + 1, line.count)

							if d.count > 1 and d [1] = '[' and d [d.count] = ']' then
								d := d.substring (2, d.count - 1)
								create loc.make_from_string ({UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (d))
								Result.force ([s, loc.extended (v)])
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

	resource_compiler: detachable PATH
			-- Path to `resgen' tool from .NET Framework SDK.
		do
			debug ("refactor_fixme")
				to_implement ("TODO: to implement")
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
