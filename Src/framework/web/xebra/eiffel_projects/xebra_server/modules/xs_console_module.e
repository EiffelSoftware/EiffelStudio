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
	XC_SERVER_MODULE
		redefine
			make
		end
	THREAD
	XS_SHARED_SERVER_CONFIG
	XS_SHARED_SERVER_OUTPUTTER


create
	make

feature -- Initialization

	make (a_main_server: like main_server)
			-- Initializes current
		do
			Precursor (a_main_server)
            create commands.make (1)
			commands.force (create {XCC_SHUTDOWN_SERVER}.make, "exit")
			commands.force (create {XCC_LOAD_CONFIG}.make, "reload")
			commands.force (create {XCC_SHUTDOWN_WEBAPPS}.make, "shutdown_webapps")
			commands.force (create {XCC_RELAUNCH_MOD}.make, "mlaunch")
			commands.force (create {XCC_SHUTDOWN_MOD}.make, "mshutdown")
			commands.force (create {XCC_GET_MODULES}.make, "modules")
			commands.force (create {XCC_CLEAN_WEBAPP}.make, "clean")
			commands.force (create {XCC_SHUTDOWN_WEBAPP}.make, "shutdown")
			commands.force (create {XCC_ENABLE_WEBAPP}.make, "enable")
			commands.force (create {XCC_DISABLE_WEBAPP}.make, "disable")
			commands.force (create {XCC_GET_WEBAPPS}.make, "webapps")
			-- help command is hardcoded
        ensure then
        	commands_attached: commands /= Void
		end

feature -- Acces

	commands: HASH_TABLE [XC_COMMAND, STRING]

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
			l_response: XC_COMMAND_RESPONSE
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

				if  attached {XC_COMMAND} commands[l_command] as cmd then
						if  attached {XS_PARAMETER_COMMAND} cmd as param_cmd then
							param_cmd.set_parameter (l_parameter)
							l_response := param_cmd.execute (main_server)
						else
							l_response := cmd.execute (main_server)
						end

						if attached {XCC_SHUTDOWN_SERVER} cmd then
							stop := True
						end

						handle_response (l_response)
				else
					o.iprint ("Invalid command '" + l_command + "'")
				end
			end
		end

	handle_response (a_response: XC_COMMAND_RESPONSE)
			-- Handles it.
		require
			a_response_attached: a_response /= Void
		do
			if attached {XCCR_ERROR} a_response as l_error then
				o.iprint (l_error.description)
			end

			if attached {XCCR_GET_MODULES} a_response as get_mod_response then
				o.iprint (display_modules (get_mod_response))
			end


		end



feature -- Status Report

	display_modules (a_response: XCCR_GET_MODULES): STRING
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
				Result.append (" - name: '" + a_response.modules.key_for_iteration +
				"',%Tlaunched: '" + a_response.modules.item_for_iteration.launched.out +
				"',%Trunning: '" + a_response.modules.item_for_iteration.running.out +
				"'%N")
				a_response.modules.forth
			end
			Result.append   ("-----------------------------------------------------------%N")
		end


	print_command_list: STRING
			-- Prints a list of the listed commands
		local
			l_par: STRING
			l_count: INTEGER
		do
			l_count := count_nice_space
			Result :=      "%N------------------------ Commands -------------------------%N"
				-- help is hardcoded
			Result.append (" - 'help':" + nice_space (l_count - 4 ) + "Displays a list of commands%N")
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
				Result.append (" - '" + commands.key_for_iteration.out +  l_par + "':" + nice_space (l_count - commands.key_for_iteration.out.count - l_par.count ) + commands.item_for_iteration.description + "%N")
				commands.forth
			end
			Result.append   ("-----------------------------------------------------------%N")
		end

	count_nice_space: INTEGER
			--
		local
			l_current: INTEGER
		do
			from
				commands.start
				Result := 0
			until
				commands.after
			loop
				l_current := commands.key_for_iteration.count + 3
				if attached {XS_PARAMETER_COMMAND} commands.item_for_iteration as p_c then
					l_current := l_current +  p_c.parameter_description.count + 4
				end

				if Result < l_current then
					Result := l_current
				end
				commands.forth
			end
		end


	nice_space (a_count: INTEGER): STRING
			--
		local
			l_i: INTEGER
		do
			from
				l_i := 0
				Result := ""
			until
				l_i >= a_count
			loop
				Result := Result + " "
				l_i := l_i + 1
			end

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
