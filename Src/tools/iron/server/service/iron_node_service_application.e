note
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	IRON_NODE_SERVICE_APPLICATION

create
	make,
	make_and_launch,
	make_from_iron_and_arguments

feature {NONE} -- Initialization

	make_and_launch
		do
			make
			launch
		end

	make
		do
			make_from_iron_and_arguments ((create {IRON_NODE_FACTORY}).iron_node, (create {ARGUMENTS_32}).argument_array)
		end

	make_from_iron_and_arguments (a_iron: IRON_NODE; args: ARRAY [READABLE_STRING_32])
		require
			args_has_index_0: args.lower = 0 and not args.is_empty
		do
			iron := a_iron
--			connector := server_connector_from_command (args[0])
		end

feature {NONE} -- Access		

	iron: IRON_NODE

	connector: detachable READABLE_STRING_8

feature -- Execution

	launch
		local
			server: detachable IRON_NODE_SERVER
		do
--			if attached connector as conn then
--				if conn.is_case_insensitive_equal ("cgi") then
--					create server.make_and_launch_cgi (iron)
--				elseif conn.is_case_insensitive_equal ("libfcgi") then
--					create server.make_and_launch_libfcgi (iron)
--				end
--			end
--			if server = Void then
--					-- Default
				create server.make_and_launch (iron)
--			end
		end

feature {NONE} -- Implementation

--	server_connector_from_command (cmd: READABLE_STRING_32): detachable READABLE_STRING_8
--		local
--			p: PATH
--			s: STRING_32
--			ext: detachable READABLE_STRING_32
--		do
--			create p.make_from_string (cmd)
--			if attached p.entry as l_entry then
--				s := l_entry.name
--				ext := l_entry.extension
--				if ext /= Void then
--					s.remove_tail (ext.count + 1)
--				else
--					ext := ""
--				end
--				if s.ends_with ("--cgi") or ext.is_case_insensitive_equal_general ("cgi") then
--					Result := "cgi"
--				elseif s.ends_with ("--libfcgi") or ext.is_case_insensitive_equal_general ("fcgi") then
--					Result := "libfcgi"
--				end
--			end
--		end

note
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
