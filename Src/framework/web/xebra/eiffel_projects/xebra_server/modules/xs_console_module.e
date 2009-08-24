note
	description: "[
		A server module that reads commands from the console.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XS_CONSOLE_MODULE

inherit
	XC_SERVER_MODULE
		rename
			make as base_make
		end
	THREAD
	XS_SHARED_SERVER_CONFIG
	XS_SHARED_SERVER_OUTPUTTER


create
	make

feature -- Initialization

	make (a_main_server: like main_server; a_name: STRING)
			-- Initializes current
		require
			a_main_server_attached: a_main_server /= Void
			a_name_attached: a_name /= Void
		do
			base_make (a_name)
			main_server := a_main_server

			create command_groups.make(1)
			command_groups.force (create {HASH_TABLE [XC_SERVER_COMMAND, STRING]}.make (1), "Server Control")
			command_groups.force (create {HASH_TABLE [XC_SERVER_COMMAND, STRING]}.make (1), "Modules")
			command_groups.force (create {HASH_TABLE [XC_SERVER_COMMAND, STRING]}.make (1), "Webapps")

			if attached command_groups ["Server Control"] as l_group_sc then
				l_group_sc.force  (create {XCC_SHUTDOWN_SERVER}.make, "exit")
				l_group_sc.force  (create {XCC_LOAD_CONFIG}.make, "reload")
				l_group_sc.force  (create {XCC_SHUTDOWN_WEBAPPS}.make, "shutdown_webapps")
				l_group_sc.force  (create {XCC_SET_DEBUG}.make, "debug_level")
			end

			if attached command_groups ["Modules"] as l_group_m then
				l_group_m.force (create {XCC_RELAUNCH_MOD}.make, "mlaunch")
				l_group_m.force (create {XCC_SHUTDOWN_MOD}.make, "mshutdown")
				l_group_m.force (create {XCC_GET_MODULES}.make, "modules")
			end

			if attached command_groups ["Webapps"] as l_group_w then
				l_group_w.force (create {XCC_CLEAN_WEBAPP}.make, "clean")
				l_group_w.force (create {XCC_SHUTDOWN_WEBAPP}.make, "shutdown")
				l_group_w.force (create {XCC_ENABLE_WEBAPP}.make, "enable")
				l_group_w.force (create {XCC_DISABLE_WEBAPP}.make, "disable")
				l_group_w.force (create {XCC_GET_WEBAPPS}.make, "webapps")
				l_group_w.force (create {XCC_DEV_ON_WEBAPP}.make, "dev_on")
				l_group_w.force (create {XCC_DEV_OFF_WEBAPP}.make, "dev_off")
				l_group_w.force (create {XCC_DEV_ON_WEBAPP}.make, "dev")
				l_group_w.force (create {XCC_DEV_OFF_GLOBAL}.make, "dev_off_all")
				l_group_w.force (create {XCC_DEV_ON_GLOBAL}.make, "dev_all")
				l_group_w.force (create {XCC_FIREOFF_WEBAPP}.make, "fire")
				l_group_w.force (create {XCC_TRANSLATE_WEBAPP}.make, "translate")
			end
			-- help command is hardcoded
        ensure
        	main_server_set: equal (a_main_server, main_server)
        	command_groups_attached: command_groups /= Void
        	name_set: equal (name, a_name)
		end

feature -- Acces

	command_groups: HASH_TABLE [HASH_TABLE [XC_SERVER_COMMAND, STRING], STRING]
			-- Groups of commands

feature {NONE} -- Access

	main_server: XC_SERVER_INTERFACE

feature -- Inherited Features

	execute
			-- <Precursor>	
		do
			o.set_add_input_line (True)
			launched := True
			running := True
			o.iprint (print_help)
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
			o.dprint("Input Server ends.", o.Debug_start_stop_app)
			running := False
			o.set_add_input_line (False)
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
			l_response: detachable XC_COMMAND_RESPONSE
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

				if  attached {XC_SERVER_COMMAND} command (l_command) as cmd then
						if  attached {XC_PARAMETER_CONTAINER} cmd as param_cmd then
							if l_parameter.is_empty then
								o.iprint ("No parameter specified for command '" + l_command + "'. Type 'help' for a list of commands.")
							else
								param_cmd.set_parameter (l_parameter)
								l_response := cmd.execute (main_server)
							end
						else
							l_response := cmd.execute (main_server)
						end

						if attached {XCC_SHUTDOWN_SERVER} cmd then
							stop := True
						end
				else
					o.iprint ("Invalid command '" + l_command + "'. Type 'help' for a list of commands.")
				end

				if attached l_response then
					handle_response (l_response)
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

			if attached {XCCR_GET_MODULES} a_response as l_response then
				o.iprint (print_modules (l_response))
			end

			if attached {XCCR_GET_WEBAPPS} a_response as l_response then
				o.iprint (print_webapps (l_response))
			end

		end



feature -- Status Report

	command (a_name: STRING): detachable XC_SERVER_COMMAND
			-- Searches all groups for the command
		require
			a_name_attached: a_name /= Void
		do
			from
				command_groups.start
			until
				command_groups.after
			loop
				if attached {XC_SERVER_COMMAND} command_groups.item_for_iteration[a_name] as l_cmd then
					Result := l_cmd.twin
				end
				command_groups.forth
			end
		end

	print_modules (a_response: XCCR_GET_MODULES): STRING
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
				Result.append (" - name: '" + a_response.modules.item_for_iteration.name +
				"',%Tlaunched: '" + a_response.modules.item_for_iteration.launched.out +
				"',%Trunning: '" + a_response.modules.item_for_iteration.running.out +
				"'%N")
				a_response.modules.forth
			end
			Result.append   ("-----------------------------------------------------------%N")
		end

	print_webapps (a_response: XCCR_GET_WEBAPPS): STRING
			-- Display them.
		require
			a_response_attached: a_response /= Void
		local
			l_status: STRING
		do
			Result :=      "%N------------------------ Webapps --------------------------"
			from
				a_response.webapps.start
			until
				a_response.webapps.after
			loop

				Result.append ("%N- " + a_response.webapps.item_for_iteration.app_config.name.out +
				"%N%THost: '" + a_response.webapps.item_for_iteration.app_config.webapp_host.out + "'" +
				"%N%TPort: '" + a_response.webapps.item_for_iteration.app_config.port.out + "'" +
				"%N%TStatus: '" + a_response.webapps.item_for_iteration.status + "'" +
				"%N%TSessions: '" + a_response.webapps.item_for_iteration.sessions.out + "'" +
				"%N%TDisabled: '" + a_response.webapps.item_for_iteration.is_disabled.out + "'" +
--				"%N%TTranslating: '" + a_response.webapps.item_for_iteration.is_translating.out + "'" +
--				"%N%TCompiling: '" + a_response.webapps.item_for_iteration.is_compiling_webapp.out + "'" +
--				"%N%TRunning: '" + a_response.webapps.item_for_iteration.is_running.out + "'" +
				"%N%TDev_mode: '" + a_response.webapps.item_for_iteration.dev_mode.out + "'" +
				"")
				a_response.webapps.forth
			end
			Result.append   ("%N-----------------------------------------------------------%N")
		end


	print_help: STRING
			-- Prints the help command
		do
			Result := "Type 'help' for a list of commands."
		ensure
			result_attached: Result /= Void
		end


	print_command_list: STRING
			-- Prints a list of the listed commands
		do
			Result :=      "%N------------------------ Commands -------------------------%N"
				-- help is hardcoded
			Result.append (" - 'help':%T%TDisplays a list of commands%N")
			from
				command_groups.start
			until
				command_groups.after
			loop
				Result.append (print_command_group (command_groups.item_for_iteration, command_groups.key_for_iteration.out))
				command_groups.forth
			end

			Result.append   ("-----------------------------------------------------------%N")
		ensure
			result_attached: Result /= Void
		end


	print_command_group (a_cmds: HASH_TABLE [XC_SERVER_COMMAND, STRING]; a_name: STRING): STRING
			-- Prints all commands of a group
		local
			l_par: STRING
			l_count: INTEGER
			l_sorted_keys: SORTED_TWO_WAY_LIST [STRING]
		do
			create l_sorted_keys.make
			l_sorted_keys.append (create {ARRAYED_LIST[STRING]}.make_from_array (a_cmds.current_keys))
			l_sorted_keys.sort

			l_count := count_nice_space_commands (a_cmds)
			Result :=      "%N----- " + a_name + " -----%N"
			from
				l_sorted_keys.start
			until
				l_sorted_keys.after
			loop
				if attached {XC_SERVER_COMMAND} a_cmds [l_sorted_keys.item_for_iteration] as l_cmd then

					if attached {XC_PARAMETER_CONTAINER} l_cmd as p_c then
						l_par := " <" + p_c.parameter_description + ">"
					else
						l_par := ""
					end
					Result.append (" - '" + l_sorted_keys.item_for_iteration.out +  l_par + "':" + nice_space (l_count - l_sorted_keys.item_for_iteration.count - l_par.count ) + l_cmd.description + "%N")
				end
				l_sorted_keys.forth
			end

		end

	count_nice_space_commands (a_cmds: HASH_TABLE [XC_SERVER_COMMAND, STRING]): INTEGER
			-- Counts how many spaces are needed to format nicely
		local
			l_current: INTEGER
		do
			from
				a_cmds.start
				Result := 0
			until
				a_cmds.after
			loop
				l_current := a_cmds.key_for_iteration.count + 3
				if attached {XC_PARAMETER_CONTAINER} a_cmds.item_for_iteration as p_c then
					l_current := l_current +  p_c.parameter_description.count + 4
				end

				if Result < l_current then
					Result := l_current
				end
				a_cmds.forth
			end
		end


	nice_space (a_count: INTEGER): STRING
			-- Returns count many spaces in a string
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

feature -- Status setting

	shutdown
			-- <Precursor>
		do
			stop := True
		end

invariant
		command_groups_attached: command_groups /= Void
		main_server_attached: main_server /= Void
end
