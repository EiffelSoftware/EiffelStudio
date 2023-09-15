note
	description: "Summary description for {CIL_PROJECT_INFO}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CIL_PROJECT_INFO

create
	make_from_system

feature {NONE} -- Initialization

	make_from_system (a_system: SYSTEM_I)
		local
			s, maj, min, sub: STRING
			i,j: INTEGER
			l_fmwk_name, l_fmwk_version: STRING
			l_il_env: IL_ENVIRONMENT
		do
			system_name := a_system.name
			if
				attached a_system.msil_version as l_msil_version and then
				not l_msil_version.is_empty
			then
				system_version := l_msil_version.to_string_8 -- FIXME: Unicode version?
			else
				system_version := "1.0.0.0" -- Default?
			end

			system_type := a_system.msil_generation_type.to_string_8 -- dll | exe

			s := a_system.clr_runtime_version.to_string_8 -- FIXME: Unicode CLR version?
			create l_il_env.make (s)
			if attached l_il_env.installed_runtime_info (s) as l_info then
				l_fmwk_name := l_info.runtime_name
				l_fmwk_version := l_info.runtime_version
			else
				i := s.index_of ('/', 1)
				if i > 0 then
					l_fmwk_name := s.head (i - 1)
					l_fmwk_version := s.substring (i + 1, s.count)
				else
					l_fmwk_name := s
					l_fmwk_version := ""
				end
			end
			if l_fmwk_name.as_lower.ends_with_general (".ref") then
				l_fmwk_name.remove_tail (4) -- removing the .ref
			end
			framework_name := l_fmwk_name
			framework_version := l_fmwk_version

				-- FRAMEWORK_TARGET
				-- tfm: net6.0, net7.0, .... netstandard2.1
				--  (see: https://learn.microsoft.com/en-us/dotnet/standard/frameworks)
			i := l_fmwk_version.index_of ('.', 1)
			if i > 0 then
				maj := l_fmwk_version.head (i - 1)
				if maj.is_integer then
					j := l_fmwk_version.index_of ('.', i + 1)
					if j > 0 then
						min := l_fmwk_version.substring (i + 1, j - 1)
						sub := l_fmwk_version.substring (j + 1, l_fmwk_version.count)
					else
						min := "0"
						sub := "0"
					end
					if maj.to_integer >= 5 then
						s := "net" + maj + "." + min
					else
						s := "netcoreapp" + maj + "." + min
					end
--					if sub.to_integer > 0 then
--						s := s + "." + sub
--					end
					framework_moniker := s
					-- TODO: support
					-- tfm: net6.0, net7.0, .... netstandard2.1  (see: https://learn.microsoft.com/en-us/dotnet/standard/frameworks)
				end
			end

			if l_fmwk_name.has_substring ("NETCore.App") then
				s := ".NETCoreApp,Version=v" + maj + "." + min
				clr_runtime := s
			else
				clr_runtime := ".NETCoreApp,Version=v6.0" -- Default?
			end
		end

feature -- Access

	system_name: STRING
	system_version: STRING
	system_type: STRING
	framework_name: STRING
	framework_version: STRING
	framework_moniker: STRING
	clr_runtime: STRING

invariant

note
	copyright: "Copyright (c) 1984-2023, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
