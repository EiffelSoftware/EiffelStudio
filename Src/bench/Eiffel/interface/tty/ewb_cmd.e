indexing

	description: 
		"General notion of command line command%
		%corresponding to an option of `ec'."
	date: "$Date$"
	revision: "$Revision $"

deferred class EWB_CMD 

inherit
	SHARED_EIFFEL_PROJECT

	SHARED_EWB_HELP

	SHARED_EWB_CMD_NAMES

	SHARED_EWB_ABBREV

	COMPARABLE
		undefine
			is_equal
		end

	SHARED_BENCH_LICENSES
		rename
			class_name as except_class_name
		end

feature -- Properties

	name: STRING is
		deferred
		end

	help_message: STRING is
		deferred
		end

	abbreviation: CHARACTER is
		deferred
		end

	output_window: OUTPUT_WINDOW is
			-- Output for current menu selection
		do
			Result := command_line_io.output_window
		ensure
			Result = command_line_io.output_window
		end

feature {NONE} -- Error messages

	Warning_messages: WARNING_MESSAGES is
			-- Placeholder to access all warning messages.
		once
			create Result
		end
		
feature -- Comparison

	infix "<" (other: EWB_CMD): BOOLEAN is
			-- The sort criteria is the command name
		do
			Result := name < other.name
		end

feature {ES, EWB_BASIC_LOOP} -- Setting

	set_output_window (display: OUTPUT_WINDOW) is
			-- Set the output window to `display'
		do
			command_line_io.set_output_window (display)
		ensure
			command_line_io.output_window = display
		end

feature {ES} -- Execution

	execute is
			-- Action performed when invoked from the
			-- command line.
		require
			system_compiled: Workbench.is_already_compiled
		deferred
		end

feature {EWB_LOOP} -- Execution

	loop_action is
			-- Action performed when invoked from the
			-- command loop (ie after ec -loop).
		do
			check_arguments_and_execute
		end

feature {NONE} -- Implementation

	command_line_io: COMMAND_LINE_IO is
		once
			create Result
		end

	arguments: STRING is
			-- Arguments passed to the application
		once
			create Result.make (0)
		end

	check_arguments_and_execute is
			-- Check the arguments and then perform then
			-- command line action.
		do
			if command_line_io.more_arguments then
				command_line_io.print_too_many_arguments
			end
			if not command_line_io.abort then
				if Workbench.is_already_compiled then
					execute
				else
					output_window.put_string (Warning_messages.w_Must_compile_first)
					output_window.new_line
				end
			else
				command_line_io.reset_abort
			end
		end

end -- class EWB_CMD
