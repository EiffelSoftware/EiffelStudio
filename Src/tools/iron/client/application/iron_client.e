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
			localized_print as print,
			localized_print_error as print_error
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		local
			task: detachable IRON_TASK
			iron: IRON
			cmd_task: IRON_COMMAND_TASK
		do
			create iron.make (iron_layout)
			initialize_iron (iron)

			if argument_count > 0 then
				create cmd_task.make (command_task_arguments (argument_array))
				if cmd_task.is_available (iron) then
					task := cmd_task
				else
					task := task_by_name (argument (1), task_arguments (argument_array))
				end
			end

			if task /= Void then
				task.process (iron)
			else
				print_error (iron_executable_name)
				print_error (" - Version: ")
				print_error (iron_version)
				print_error ("%N")
				print_error ("Copyright ")
				print_error (iron_copyright)
				print_error ("%N%N")
				print_error ("Usage: command ...%N")
				across
					tasks as c
				loop
					print_error ("%T " + c.key.to_string_8 + " : " + c.item.description.to_string_8 + "%N")
				end
				print_error ("note: command {action} --help: gives specific help usage on action {action}.%N")
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

	tasks: STRING_TABLE [TUPLE [factory_function: FUNCTION [ARRAY [IMMUTABLE_STRING_32], IRON_TASK]; description: READABLE_STRING_GENERAL]]
		once
			create Result.make_caseless (7 + 1)

			Result.force ([agent (args: like task_arguments): IRON_UPDATE_TASK   do create Result.make (args) end, "Update package information.."], {IRON_UPDATE_TASK}.name)
			Result.force ([agent (args: like task_arguments): IRON_LIST_TASK    do create Result.make (args) end, "list packages.."], {IRON_LIST_TASK}.name)
			Result.force ([agent (args: like task_arguments): IRON_SEARCH_TASK  do create Result.make (args) end, "search package"], {IRON_SEARCH_TASK}.name)
			Result.force ([agent (args: like task_arguments): IRON_INFO_TASK    do create Result.make (args) end, "information about a package"], {IRON_INFO_TASK}.name)
			Result.force ([agent (args: like task_arguments): IRON_PATH_TASK    do create Result.make (args) end, "output the installation folder for a package (if installed)"], {IRON_PATH_TASK}.name)
			Result.force ([agent (args: like task_arguments): IRON_INSTALL_TASK do create Result.make (args) end, "install package"], {IRON_INSTALL_TASK}.name)
			Result.force ([agent (args: like task_arguments): IRON_REMOVE_TASK  do create Result.make (args) end, "remove a package"], {IRON_REMOVE_TASK}.name)

			Result.force ([agent (args: like task_arguments): IRON_REPOSITORY_TASK  do create Result.make (args) end, "manage repository list"], {IRON_REPOSITORY_TASK}.name)
			Result.force ([agent (args: like task_arguments): IRON_SHARE_TASK  do create Result.make (args) end, "share and manage your package (auth required)"], {IRON_SHARE_TASK}.name)

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

feature -- Constants access

	iron_executable_name: IMMUTABLE_STRING_32
			-- Associated executable name.
		once
			create Result.make_from_string_general ((create {IRON_CONSTANTS}).executable_name)
		end

	iron_copyright: IMMUTABLE_STRING_32
			-- Associated copyright.
		once
			create Result.make_from_string_general ((create {IRON_CONSTANTS}).copyright)
		end

	iron_version: IMMUTABLE_STRING_32
			-- Associated version.
		once
			create Result.make_from_string_general ((create {IRON_CONSTANTS}).version)
		end

note
	copyright: "Copyright (c) 1984-2016, Eiffel Software"
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
