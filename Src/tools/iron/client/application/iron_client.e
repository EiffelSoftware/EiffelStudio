note
	description: "[
		
		iron list 						: List of available packages, i.e. packages that have been installed
										: as well as packages available from the Iron server.
		iron list --installed 			: List of installed packages.
		iron install package_name 		: Install a package.
		iron install -f package_file 	: Install a package from a file.
		iron remove package_name 		: Remove a package.
		iron search package_name 		: Search for a package.
		iron info package_name 			: Information about a package.
		iron update						: Update repositories information.
	]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_CLIENT

inherit
	ARGUMENTS_32
		rename
			print as print_any
		end

	SHARED_EXECUTION_ENVIRONMENT
		rename
			print as print_any
		end

	LOCALIZED_PRINTER
		rename
			print as print_any,
			localized_print as print
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		local
			cmd: READABLE_STRING_32
			task: detachable IRON_TASK
			iron: IRON
			cmd_task: IRON_COMMAND_TASK
		do
			create iron.make (iron_layout)
			initialize_iron (iron)

			if argument_count > 0 then
				cmd := argument (1)
				task := task_by_name (cmd, task_arguments (argument_array))
				if task = Void then
					create cmd_task.make (command_task_arguments (argument_array))
					if cmd_task.is_available (iron) then
						task := cmd_task
					end
				end
			end

			if task /= Void then
				task.process (iron)
			else
				io.error.put_string ("Usage: command ...%N")
				across
					tasks as c
				loop
					io.error.put_string ("%T " + c.key.to_string_8 + " : " + c.item.description.to_string_8 + "%N")
				end
				io.error.put_string ("note: command {action} --help: gives specific help usage on action {action}.%N")
			end
		end

	initialize_iron (a_iron: IRON)
			-- Initialize `a_iron' if needed
		do
		end

	task_arguments (args: ARRAY [IMMUTABLE_STRING_32]): ARRAY [IMMUTABLE_STRING_32]
		local
			i,n: INTEGER
		do
			from
				i := args.lower + 2
				n := args.upper
				if args.valid_index (i) then
					create Result.make_filled (args[i], i, n)
				else
					create Result.make_empty
				end
			until
				i > n
			loop
				Result[i] := args[i]
				i := i + 1
			end
			Result.rebase (1)
		ensure
			Result.lower = 1
			Result.count = args.count - 2
		end

	command_task_arguments (args: ARRAY [IMMUTABLE_STRING_32]): ARRAY [IMMUTABLE_STRING_32]
		local
			i,n: INTEGER
		do
			from
				i := args.lower + 1
				n := args.upper
				if args.valid_index (i) then
					create Result.make_filled (args[i], i, n)
				else
					create Result.make_empty
				end
			until
				i > n
			loop
				Result[i] := args[i]
				i := i + 1
			end
			Result.rebase (1)
		ensure
			Result.lower = 1
			Result.count = args.count - 1
		end

	task_by_name (a_name: READABLE_STRING_GENERAL; args: like task_arguments): detachable IRON_TASK
		do
			if attached tasks.item (a_name) as t then
				Result := t.factory_function.item ([args])
			end
		ensure
			Result /= Void implies a_name.same_string (Result.name)
		end

	tasks: STRING_TABLE [TUPLE [factory_function: FUNCTION [ANY, TUPLE [ARRAY [IMMUTABLE_STRING_32]], IRON_TASK]; description: READABLE_STRING_GENERAL]]
		once
			create Result.make_caseless (7 + 1)

			Result.force ([agent (args: like task_arguments): IRON_UPDATE_TASK   do create Result.make (args) end, "Update package information.."], "update")
			Result.force ([agent (args: like task_arguments): IRON_LIST_TASK    do create Result.make (args) end, "list packages.."], "list")
			Result.force ([agent (args: like task_arguments): IRON_SEARCH_TASK  do create Result.make (args) end, "search package"], "search")
			Result.force ([agent (args: like task_arguments): IRON_INFO_TASK    do create Result.make (args) end, "information about a package"], "info")
			Result.force ([agent (args: like task_arguments): IRON_WHERE_TASK    do create Result.make (args) end, "output the installation folder for a package (if installed)"], "where")
			Result.force ([agent (args: like task_arguments): IRON_INSTALL_TASK do create Result.make (args) end, "install package"], "install")
			Result.force ([agent (args: like task_arguments): IRON_REMOVE_TASK  do create Result.make (args) end, "remove a package"], "remove")

			Result.force ([agent (args: like task_arguments): IRON_REPOSITORY_TASK  do create Result.make (args) end, "manage repository list"], "repository")
			Result.force ([agent (args: like task_arguments): IRON_SHARE_TASK  do create Result.make (args) end, "share and manage your package (auth required)"], "share")
			Result.force ([agent (args: like task_arguments): IRON_COMMAND_TASK  do create Result.make (args) end, "extension command for iron"], "command")

			debug ("iron")
				Result.force ([agent (args: like task_arguments): IRON_TESTING_TASK    do create Result.make (args) end, "Testing.."], "testing")
			end
		end

feature -- Access

	iron_layout: IRON_LAYOUT
		do
			create Result.make_default
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
