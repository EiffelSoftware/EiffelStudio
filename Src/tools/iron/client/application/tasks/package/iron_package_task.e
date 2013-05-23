note
	description: "Summary description for {IRON_PACKAGE_TASK}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_PACKAGE_TASK

inherit
	IRON_TASK

	IRON_EXPORTER
		rename
			print as print_any
		end

create
	make

feature -- Access

	name: STRING = "package"
			-- Iron client task

feature -- Execute

	process (a_iron: IRON)
		local
			args: IRON_PACKAGE_ARGUMENT_PARSER
		do
			create args.make (Current)
			args.execute (agent execute (args, a_iron))
		end

	execute (args: IRON_PACKAGE_ARGUMENTS; a_iron: IRON)
		local
			d: detachable PATH
		do
			if
				attached args.username as u and
				attached args.password as p and
				attached args.repository as repo_url and
				attached args.operation as op
			then
				if args.is_create then
					localized_print_error ({STRING_32} "[" + op + {STRING_32} "] Not yet supported!")
				elseif args.is_modify then
					localized_print_error ({STRING_32} "[" + op + {STRING_32} "] Not yet supported!")
				else
					localized_print_error ({STRING_32} "[" + op + {STRING_32} "] Not yet supported!")
				end
			else
				localized_print_error ({STRING_32} "[ERROR] Missing required arguments!")
			end
		end


	data_object (p: PATH): detachable JSON_OBJECT
		local
			jp: JSON_PARSER
			f: PLAIN_TEXT_FILE
			s: STRING
		do
			create f.make_with_path (p)
			if f.exists and then f.is_access_readable then
				f.open_read
				from
					create s.make_empty
				until
					f.exhausted
				loop
					f.read_stream (1_024)
					s.append (f.last_string)
				end
				f.close

				create jp.make_parser (s)
				if attached {JSON_OBJECT} jp.parse as jo and then jp.is_parsed then

				end

			end

		end


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
