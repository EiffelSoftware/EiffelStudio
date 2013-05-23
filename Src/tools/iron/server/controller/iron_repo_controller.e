note
	description: "Summary description for {IRON_REPO_CONTROLLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_REPO_CONTROLLER

inherit
	ARGUMENTS_32

	IRON_REPO_CONSTANTS

	SHARED_EXECUTION_ENVIRONMENT

create
	make

feature {NONE} -- Initialization

	make
		local
			i,n: INTEGER
			op: detachable IRON_REPO_CONTROLLER_TASK
		do
			if argument_count = 0 and attached server_from_command (argument (0)) as conn then
				create {IRON_REPO_CONTROLLER_SERVER_TASK} op.make_with_connector (conn)
			else
				from
					i := 1
					n := argument_count
				until
					i > n
				loop
					if attached argument (i) as arg then
						if arg.starts_with ("-") then
							-- options
						elseif op = Void then
							if arg.is_case_insensitive_equal ("server") then
								i := n -- exit loop
								create {IRON_REPO_CONTROLLER_SERVER_TASK} op
							elseif arg.is_case_insensitive_equal ("system") then
								create {IRON_REPO_CONTROLLER_SYSTEM_TASK} op.make (argument_array.subarray (i + 1, n))
							elseif arg.is_case_insensitive_equal ("user") then
								create {IRON_REPO_CONTROLLER_USER_TASK} op.make (argument_array.subarray (i + 1, n))
							end
						end
					end
					i := i + 1
				end
			end
			initialize_iron
			if op /= Void then
				if op.is_available (iron) then
					op.execute (iron)
				end
			else
				print ("Command: " + argument (0) + "%N")
				print ("IRON version: " + version)
				print ("%N")
				print ("usage: ironctl {server|system|user}%N")
				print ("%Tserver: launch the server.%N")
				print ("%Tsystem: various configuration operations (database, ...) .%N")
				print ("%Tuser: user management.%N")
			end
		end

feature -- Database

	server_from_command (cmd: IMMUTABLE_STRING_32): detachable READABLE_STRING_8
		local
			p: PATH
			s: STRING_32
		do
			create p.make_from_string (cmd)
			if attached p.entry as l_entry then
				s := l_entry.name
				if attached l_entry.extension as ext then
					s.remove_tail (ext.count + 1)
				end
				if s.ends_with ("--cgi") then
					Result := "cgi"
				elseif s.ends_with ("--libfcgi") then
					Result := "libfcgi"
				end
			end
		end

	initialize_iron
		local
			p: PATH
		do
			if attached execution_environment.item ({IRON_REPO_CONSTANTS}.IRON_REPO_variable_name) as s then
				create p.make_from_string (s)
			else
				create p.make_from_string ("iron")
			end
			p := p.absolute_path.canonical_path
			create iron.make (create {IRON_REPO_FS_DATABASE}.make_with_path (p.extended ("repo")), p)
		end

	iron: IRON_REPO

;note
	copyright: "Copyright (c) 1984-2013, Eiffel Software"
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
