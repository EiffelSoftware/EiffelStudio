note
	description: "[
				Extension to iron via commands
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_COMMAND_TASK

inherit
	IRON_TASK

	SHARED_EXECUTION_ENVIRONMENT
		rename
			print as print_any
		end

create
	make

feature -- Access

	name: STRING = "command"
			-- Iron client task

feature -- Status report			

	is_available (a_iron: IRON): BOOLEAN
			-- Is associated command available?
		local
			args: LIST [READABLE_STRING_32]
			op: READABLE_STRING_32
			f: RAW_FILE
			p: PATH
		do
			args := argument_source.arguments
			if args.is_empty then
					-- Help ?
			else
				op := args.first
				if attached a_iron.layout.binaries_path as l_bin_path then
					p := l_bin_path.extended ("commands").extended (op)
					create f.make_with_path (p)
					if not f.exists and {PLATFORM}.is_windows then
						p := p.appended_with_extension ("exe")
						create f.make_with_path (p)
					end
					Result := f.exists and then f.is_executable
				end
			end
		end

feature -- Execute

	process (a_iron: IRON)
		local
			args: LIST [READABLE_STRING_32]
			op: READABLE_STRING_32
			p: PATH
			cmd: STRING_32
			ut: FILE_UTILITIES
		do
			args := argument_source.arguments
			args.start
			if not args.off then
				op := args.item
				args.forth
				if attached a_iron.layout.binaries_path as l_bin_path then
					p := l_bin_path.extended ("commands").extended (op)
					if not ut.file_path_exists (p) then
						p := p.appended_with_extension ("exe")
					end
					if ut.file_path_exists (p) then
						create cmd.make_from_string (p.absolute_path.canonical_path.name)
						cmd.prepend_character ('"')
						cmd.append_character ('"')
						from
						until
							args.after
						loop
							cmd.append_character (' ')
							if args.item.has (' ') then
								cmd.append_character ('"')
								cmd.append (args.item)
								cmd.append_character ('"')
							else
								cmd.append (args.item)
							end
							args.forth
						end
						print ("Command=")
						print (cmd)
						print ("%N")
						execution_environment.system (cmd)
					else
						print ("unknown command: ")
						print (p.name)
						print ("%N")
					end
				else
					print ("unknown command: ")
					print (op)
					print ("%N")
				end
			elseif attached available_commands (a_iron) as cmds and then cmds.count > 0 then
				if cmds.count > 1 then
					print (cmds.count.out + " commands available: ")
				else
					print ("One command available: ")
				end
				print_new_line
				across
					cmds as ic
				loop
					print (" - ")
					print (ic.item)
					print_new_line
				end
			else
				print ("unknown command")
				print ("%N")
			end
		end

feature -- Helpers		

	available_commands (a_iron: IRON): detachable ARRAYED_LIST [READABLE_STRING_32]
		local
			d: DIRECTORY
			f: RAW_FILE
			p: PATH
		do
			if attached a_iron.layout.binaries_path as l_bin_path then
				p := l_bin_path.extended ("commands")

				create Result.make (0)

				create d.make_with_path (p)
				across
					d.entries as ic
				loop
					if ic.item.is_current_symbol or ic.item.is_parent_symbol then
							-- ignored
					else
						create f.make_with_path (p.extended_path (ic.item))
						if f.exists and then f.is_executable then
							Result.force (ic.item.name)
						end
					end
				end
			end
		end

note
	copyright: "Copyright (c) 1984-2014, Eiffel Software"
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
