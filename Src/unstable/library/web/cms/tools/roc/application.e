note
	description: "[
			roc tool: install modules into an existing CMS Application.
			
			roc install [--module|-m <MODULE_PATH>] [(--dir|-d <CMS_PATH>) | <MODULE_NAME>]

			install:  Install a given module to the corresponding cms application
			--module|-m: module path or current directory if is not defined.
			--dir|-d cms application path or current directory if is not defined

			Running the command will copy to the CMS Application site/modules the following artifacts if the current module provide them.

				config
				scripts
				themes
			running
			roc install blog
			will look for a module blog in the modules directory starting at the current directory.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

inherit

	SHARED_EXECUTION_ENVIRONMENT
		rename
			print as ascii_print
		end

	ARGUMENTS_32
		rename
			print as ascii_print
		end

	LOCALIZED_PRINTER
		rename
			print as ascii_print,
			localized_print as print
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize tool.
		local
			cmd_args: like command_arguments
		do
				-- TODO add support to other commands.
			if argument_count = 0 then
				print_usage
			elseif attached commands.item (argument (1)) as cmd then
				cmd_args := command_arguments
				if cmd.is_valid (cmd_args) then
					cmd.execute (cmd_args)
				else
					print_command_usage (cmd)
				end
			else
				print ("Wrong command %"" + argument (1) + "%".%N")
				print_usage
			end
		end

	commands: STRING_TABLE [ROC_COMMAND]
		local
			cmd: ROC_COMMAND
		once
			create Result.make (1)
			create {ROC_INSTALL_COMMAND} cmd.make ("install")
			Result.force (cmd, cmd.name)
		end

	command_arguments: ARRAY [READABLE_STRING_32]
		local
			i,n: INTEGER
		do
			create Result.make_empty
			Result.rebase (0)
			Result.force (argument (0), 0)
			from
				i := 2 -- skip first arg which is command name
				n := argument_count
			until
				i > n
			loop
				Result.force (argument (i), i - 1)
				i := i + 1
			end
		end

feature -- Usage

	print_usage
		do
			print ("Usage:%N")
			across
				commands as ic
			loop
				print_command_usage (ic.item)
			end
		end

	print_command_usage (cmd: ROC_COMMAND)
		do
			print ("roc ")
			print (cmd.name)
			print (" ")
			print (cmd.help)
			print ("%N")
		end


note
	copyright: "2011-2015, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
