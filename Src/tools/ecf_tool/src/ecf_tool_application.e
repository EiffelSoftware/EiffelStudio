note
	description: "Set of ecf related tools"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	ECF_TOOL_APPLICATION

inherit
	LOCALIZED_PRINTER

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		local
			args: ARGUMENTS_32
			arr: ARRAY [IMMUTABLE_STRING_32]
			subarr: ARRAY [IMMUTABLE_STRING_32]
			args_src: ARGUMENT_STRING_SOURCE
			app_name: detachable READABLE_STRING_32
			i,j,n: INTEGER
			cmds: like commands
		do
			initialize
			cmds := commands
			create args
			if args.argument_count > 0 then
				arr := args.argument_array
					-- Remove first argument
				create subarr.make_filled (arr[arr.lower], 1, arr.count - 2)
				from
					i := arr.lower + 2
					j := 1
					n := subarr.upper
				until
					j > n
				loop
					subarr[j] := arr[i + j - 1]
					j := j + 1
				end
					-- create argument source
				create args_src.make_from_array (subarr)
				app_name := args.argument (1)
				if attached cmds.item (app_name) as l_cmd then
					l_cmd.process (args_src)
				elseif app_name.is_case_insensitive_equal_general ("help") then
					process_help (args_src)
				end
			else
				process_help (Void)
			end
		end

	initialize
		local
			cmd: APPLICATION_COMMAND
			cmds: like commands
		do
			create cmds.make_caseless (5)

			create {ECF_UPDATER_COMMAND} cmd.make ("updater")
			cmds.force (cmd, cmd.name)

			create {ECF_INTEGRATION_BUILDER_COMMAND} cmd.make ("integration")
			cmds.force (cmd, cmd.name)

			create {ECF_RESAVE_COMMAND} cmd.make ("resave")
			cmds.force (cmd, cmd.name)

			create {ECF_VOIDSAFE_COMMAND} cmd.make ("voidsafe")
			cmds.force (cmd, cmd.name)

			create {ECF_CREATE_COMMAND} cmd.make ("create")
			cmds.force (cmd, cmd.name)

			create {ECF_REDIRECTION_BUILDER_COMMAND} cmd.make ("redirection")
			cmds.force (cmd, cmd.name)


				-- Assign `commands'
			commands := cmds
		end

	commands: STRING_TABLE [APPLICATION_COMMAND]

feature -- Execution

	process_help (args_src: detachable ARGUMENT_SOURCE)
		local
			l_name: READABLE_STRING_GENERAL
		do
			if args_src = Void or else args_src.is_empty then
				print ("Help:%N")
				across
					commands as ic
				loop
					print (" - ")
					print (ic.item.name)
					print (": ")
					print (ic.item.synopsis)
					print ("%N")
				end
			else
				l_name := args_src.arguments.first
				if attached commands.item (l_name) as cmd then
					print ("Help about %"")
					print (l_name)
					print ("%"%N")
					print (" - ")
					print (cmd.name)
					print (": ")
					print (cmd.synopsis)
					print ("%N")
				else
					print ("Unknown command %"")
					print (l_name)
					print ("%"%N")
				end
			end
		end

note
	copyright: "Copyright (c) 1984-2016, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
