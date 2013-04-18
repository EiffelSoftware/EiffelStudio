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

	SHARED_EXECUTION_ENVIRONMENT

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		local
			cmd: READABLE_STRING_32
			task: detachable IRON_TASK
			iron: IRON
			lay: IRON_LAYOUT
		do
			if argument_count > 0 then
				cmd := argument (1)
				task := task_by_name (cmd, task_arguments (argument_array))
			end
			if task /= Void then
				create lay.make_default
				create iron.make (lay)
				task.process (iron)
			else
				io.error.put_string ("Usage: command ...%N")
				across
					tasks as c
				loop
					io.error.put_string ("%T " + c.key.to_string_8 + " : " + c.item.description.to_string_8 + "%N")
				end
			end
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

	task_by_name (a_name: READABLE_STRING_GENERAL; args: like task_arguments): detachable IRON_TASK
		do
			if attached tasks.item (a_name) as t then
				Result := t.factory_function.item ([args])
			end
		end

	tasks: STRING_TABLE [TUPLE [factory_function: FUNCTION [ANY, TUPLE [ARRAY [IMMUTABLE_STRING_32]], IRON_TASK]; description: READABLE_STRING_GENERAL]]
		once
			create Result.make_caseless (7 + 1)

			Result.force ([agent (args: like task_arguments): IRON_UPDATE_TASK    do create Result.make (args) end, "Update package information.."], "update")
			Result.force ([agent (args: like task_arguments): IRON_LIST_TASK    do create Result.make (args) end, "list packages.."], "list")
			Result.force ([agent (args: like task_arguments): IRON_INSTALL_TASK do create Result.make (args) end, "install package"], "install")
			Result.force ([agent (args: like task_arguments): IRON_INFO_TASK    do create Result.make (args) end, "information about a package"], "info")
			Result.force ([agent (args: like task_arguments): IRON_SEARCH_TASK  do create Result.make (args) end, "search package"], "search")
			Result.force ([agent (args: like task_arguments): IRON_REMOVE_TASK  do create Result.make (args) end, "remove a package"], "remove")
			Result.force ([agent (args: like task_arguments): IRON_REPOSITORY_TASK  do create Result.make (args) end, "manage repository"], "repository")

			Result.force ([agent (args: like task_arguments): IRON_TESTING_TASK    do create Result.make (args) end, "Testing.."], "testing")
		end

feature -- Status

feature -- Access

feature -- Change

feature {NONE} -- Implementation

invariant
	--	invariant_clause: True

end
