note
	description: "[
		Provides logging features that gradually format the message.
	]"
	legal: "See notice at end of class."
	status: "Community Preview 1.0"
	date: "$Date$"
	revision: "$Revision$"

class
	XU_OUTPUTTER

inherit
	ANY

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			create i_name.make_empty
			create i_debug_level.make_empty
			add_input_line := False
		ensure
			i_name_attached: i_name /= Void
			i_debug_level_attached: i_debug_level /= Void
		end

feature -- Access

	add_input_line: BOOLEAN assign set_add_input_line

feature -- Status Report

	configured: BOOLEAN
			-- Checks if the outputter has been configured and all neccesary attributes have been set
		do
			Result := (i_name /= Void and then i_name.is_set) and (i_debug_level /= Void and then i_debug_level.is_set)
		end

	name: STRING
			-- The name of the application
		do
			if i_name.is_set then
				Result := i_name.value.out
			else
				Result := "NO NAME SET"
			end
		end

	debug_level: INTEGER
			-- The current debug level
		do
			if i_debug_level.is_set then
				Result := i_debug_level.value
			else
				Result := 0
			end
		end

feature {NONE} -- Internal Access

	i_name: SETTABLE_STRING
		-- The name of the application

	i_debug_level: SETTABLE_INTEGER
		-- The current debug level


feature -- Status Change

	set_name (a_name: STRING)
			-- Sets name.
		require
			a_name_attached: a_name /= Void
		do
			i_name := a_name
		ensure
			name_set: i_name.value ~ a_name
		end

	set_add_input_line (a_add_input_line: BOOLEAN)
			-- Sets add_input_line.
		do
			add_input_line := a_add_input_line
		ensure
			add_input_line_set: add_input_line ~ a_add_input_line
		end

	set_debug_level (a_debug_level: INTEGER)
			-- Sets name.
		do
			i_debug_level := a_debug_level
		ensure
			debug_level_set: i_debug_level.value ~ a_debug_level
		end

feature -- Print

	dprint_noformat (a_msg: STRING; a_debug_level: INTEGER)
			--Prints a debug message without formatting	and without logging
			--
			-- `a_msg': The message to be printed
			-- `a_debug_level': Prints message only if `debug_level' is >= `a_debug_level'
		require
			a_msg_attached: a_msg /= Void
			outputter_configured: configured
		do
			if a_debug_level <= debug_level then
				print (a_msg)
			end
		end

	dprint (a_msg: STRING; a_debug_level: INTEGER)
			-- Prints a debug message
			--
			-- `a_msg': The message to be printed
			-- `a_debug_level': Prints message only if current `i_debug_level' is >= `a_debug_level'
		require
			a_msg_attached: a_msg /= Void
			outputter_configured: configured
		do
			if a_debug_level <= debug_level then
				print_with_name ("[DEBUG" + a_debug_level.out + "] " + a_msg, False)
			end
		end

	wprint (a_msg: STRING)
			-- Prints a warning message
			--
			-- `a_msg': The message to be printed
		require
			a_msg_attached: a_msg /= Void
			outputter_configured: configured
		do
			print_with_name ("[WARNING] " + a_msg, False)
		end

	eprint (a_msg: STRING; a_generating_type: TYPE [detachable ANY])
			-- Prints an error message
			--
			-- `a_msg': The message to be printed
			-- `a_generating_type': The type that generated this errror
		require
			outputter_configured: configured
			a_generating_type_attached: a_generating_type /= Void
		do
			print_with_name ("[ERROR] " + a_generating_type.debug_output + ": " + a_msg, True)
		end

	iprint (a_msg: STRING)
			-- Prints an info message
			--
			-- `a_msg': The message to be printed
		require
			outputter_configured: configured
			a_msg_attached: a_msg /= Void
		do
			print_with_name ("[INFO] " + a_msg, False)
		end

feature {NONE}  -- Implementation

	print_with_name (a_msg: STRING; a_is_error_output: BOOLEAN)
			-- Adds the name
			--
			-- `a_msg': The message to be printed
			-- `a_is_error_output': True, if message should be print to error output
		require
			outputter_configured: configured
			a_msg_attached: a_msg /= Void
		do
			print_with_cmdnl ("[" + name + "]" + a_msg, a_is_error_output)
		end

	print_with_cmdnl (a_msg: STRING; a_is_error_output: BOOLEAN)
			-- Adds a new line at the start and the end and the command symbol(s)
			--
			-- `a_msg': The message to be printed
			-- `a_is_error_output': True, if message should be print to error output
		require
			outputter_configured: configured
			a_msg_attached: a_msg /= Void
 		local
			l_f_utils: XU_FILE_UTILITIES
			l_msg: STRING
		do
			l_msg := "%N" + a_msg

			create l_f_utils
			if attached l_f_utils.plain_text_file_append_create (name + ".log") as l_file then
				l_file.put_string (l_msg)
				l_f_utils.close
			end

			if add_input_line then
				l_msg.append ("%N$> ")
			end

			if a_is_error_output then
				io.error.put_string (l_msg)
			else
				io.put_string (l_msg)
			end
		end

feature -- Debug levels

	Debug_start_stop_app: INTEGER = 1
			-- Start and stop of overall application

	Debug_configuration: INTEGER = 2
			-- Debug of configuration file reading

	Debug_start_stop_components: INTEGER = 3
			-- Start and stop of main components

	Debug_tasks: INTEGER = 4
			-- Information about tasks that are performed

	Debug_subtasks: INTEGER = 5
			--  Information about subtasks that are performed

	Debug_verbose_subtasks: INTEGER = 6
			-- Very verbose information about subtasks that are performed

invariant
		i_name_attached: i_name /= Void
		i_debug_level_attached: i_debug_level /= Void
		name_attached: name /= Void
		debug_level_attached: debug_level /= Void
note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
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
