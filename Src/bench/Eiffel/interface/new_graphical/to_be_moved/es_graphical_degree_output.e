indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_GRAPHICAL_DEGREE_OUTPUT

inherit
	DEGREE_OUTPUT
		redefine
			put_new_compilation,
			display_message,
			display_new_line,
			display_degree,
			put_start_degree,
			put_end_degree,
			finish_degree_output,
			flush_output
		end

	EB_SHARED_WINDOW_MANAGER
		undefine
			default_create
		end

	EB_SHARED_GRAPHICAL_COMMANDS
		undefine
			default_create
		end

	EV_SHARED_APPLICATION
		undefine
			default_create
		end

create
	make_with_output_manager

feature {NONE} -- Initialization

	make_with_output_manager (a_output_manager: EB_OUTPUT_MANAGER) is
			-- Initialize degree output with `a_output_manager'.
		require
			a_output_manager_not_void: a_output_manager /= Void
		do
			output_manager := a_output_manager
			is_output_quiet := True
		end

feature {NONE} -- Implementation

	output_manager: EB_OUTPUT_MANAGER
			-- Output manager used to display messages of `Current'.

	flush_output is
			-- Flush any pending messages to the display.
		do
			process_events_and_idle
		end

	put_new_compilation is
			-- A new compilation has begun.
		do
			window_manager.display_percentage (0)
		end

	display_degree (deg_nbr: STRING; to_go: INTEGER; a_name: STRING) is
			-- Display degree `deg_nbr' with entity `a_class'.
		do
			Precursor (deg_nbr, to_go, a_name)
			window_manager.display_message (degree_description (current_degree) + " " + a_name)
			window_manager.display_percentage (percentage_calculation (to_go))
		end

	put_start_degree (degree_nbr: INTEGER; total_nbr: INTEGER) is
			-- Put message indicating the start of a degree
			-- with `total_nbr' passes to be done.
		do
			Precursor (degree_nbr, total_nbr)
			window_manager.display_percentage (0)
			if is_compilation_cancellable then
				project_cancel_cmd.enable_sensitive
			else
				project_cancel_cmd.disable_sensitive
			end
		end

	put_end_degree is
			-- Put message indicating the end of a degree.
		do
			window_manager.display_percentage (100)
		end

	finish_degree_output is
			-- Procedd end degree output.
		do
			Precursor
			window_manager.display_percentage (0)
		end

	display_message (a_message: STRING) is
			-- Display `a_message' to output.
		local
			stt: STRUCTURED_TEXT
		do
			create stt.make
			stt.add_string (a_message)
			output_manager.process_text (stt)
		end

	display_new_line is
			-- Display a new line on output.
		local
			stt: STRUCTURED_TEXT
		do
			create stt.make
			stt.add_new_line
			output_manager.process_text (stt)
		end
end
