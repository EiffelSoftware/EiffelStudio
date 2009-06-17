note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XS_CONSOLE_MODULE

inherit
	XS_SERVER_MODULE
		redefine
			make
		end

create
	make

feature -- Initialization

	make (a_main_server: XS_MAIN_SERVER)
			-- Initializes current
		do
			Precursor (a_main_server)
            create commands.make (1)
			commands.force (create {XSC_SHUTDOWN_SERVER}.make, "exit")
			commands.force (create {XSC_LOAD_CONFIG}.make, "reload_config")
			commands.force (create {XSC_SHUTDOWN_WEBAPPS}.make, "shutdown_webapps")
			commands.force (create {XSC_RELAUNCH_MOD}.make, "relaunch_mod")
			commands.force (create {XSC_SHUTDOWN_MOD}.make, "shutdown_mod")
			commands.force (create {XSC_GET_MODULES}.make, "get_modules")
			-- help command is hardcoded
        ensure then
        	commands_attached: commands /= Void
		end

feature -- Acces

	commands: HASH_TABLE [XS_COMMAND, STRING]

feature -- Inherited Features

	execute
			-- <Precursor>	
		local

		do
			launched := True
			running := True
			o.iprint (print_command_list)
			from
				stop := False
			until
				stop
			loop
				io.read_line
				if not stop then
					parse_input (io.last_string)
				end
			end
			o.dprint("Input Server ends.",2)
			running := False
		end

feature {NONE} -- Access

	stop: BOOLEAN

feature {NONE} -- Operations

	parse_input (a_string: STRING)
			-- Parses an input and executes a command if possible
		require
			a_string_attached: a_string /= Void
		local
			l_command: STRING
			l_parameter: STRING
			l_response: XS_COMMAND_RESPONSE
		do
				-- help command is hardcoded
			if a_string.is_equal ("help") then
				o.iprint (print_command_list)
			else
				if a_string.has_substring (" ") then
					l_command := a_string.split (' ')[1]
					l_parameter := a_string.split (' ')[2]
				else
					l_command := a_string
					l_parameter  := ""
				end

				if  attached {XS_COMMAND} commands[l_command] as cmd then
						if  attached {XS_PARAMETER_COMMAND} cmd as param_cmd then
							param_cmd.set_parameter (l_parameter)
							l_response := param_cmd.execute (main_server)
						else
							l_response := cmd.execute (main_server)
						end

						if attached {XSC_SHUTDOWN_SERVER} cmd then
							stop := True
						end

						handle_response (l_response)
				else
					o.iprint ("Invalid command '" + l_command + "'")
				end
			end
		end

	handle_response (a_response: XS_COMMAND_RESPONSE)
			-- Handles it.
		require
			a_response_attached: a_response /= Void
		do
			if attached {XSCR_GET_MODULES} a_response as get_mod_response then
				o.iprint (display_modules (get_mod_response))
			end


		end



feature -- Status Report

	display_modules (a_response: XSCR_GET_MODULES): STRING
			-- Display them.
		require
			a_response_attached: a_response /= Void
		do
			Result :=      "%N------------------------ Modules --------------------------%N"
			from
				a_response.modules.start
			until
				a_response.modules.after
			loop
				if attached {STRING} a_response.modules.item_for_iteration.item (1) as l_name and then
					attached {BOOLEAN} a_response.modules.item_for_iteration.item (2) as l_launched and then
					attached {BOOLEAN} a_response.modules.item_for_iteration.item (3) as l_running then
						Result.append (" - name: '" + l_name + "', launched: '"+l_launched.out+"', running: '"+l_running.out+"'%N")
				end

				a_response.modules.forth
			end
			Result.append   ("-----------------------------------------------------------%N")
		end


	print_command_list: STRING
			-- Prints a list of the listed commands
		local
			l_par: STRING
		do
			Result :=      "%N------------------------ Commands -------------------------%N"
				-- help is hardcoded
			Result.append (" - 'help': Displays a list of commands%N")
			from
				commands.start
			until
				commands.after
			loop
				if attached {XS_PARAMETER_COMMAND} commands.item_for_iteration as p_c then
					l_par := " <" + p_c.parameter_description + ">"
				else
					l_par := ""
				end
				Result.append (" - '" + commands.key_for_iteration.out +  l_par + "': " + commands.item_for_iteration.description + "%N")
				commands.forth
			end
			Result.append   ("-----------------------------------------------------------%N")
		end



feature -- Constants

feature -- Status setting

	shutdown
			-- <Precursor>
		do
			stop := True
		end

invariant
		commands_attached: commands /= Void
end
