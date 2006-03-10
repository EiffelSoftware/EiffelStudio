indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			window_manager.display_message_and_percentage (degree_description (current_degree) + once " " + a_name, percentage_calculation (to_go))
			flush_output
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
		do
			output_manager.start_processing (true)
			output_manager.add_string (a_message)
			output_manager.end_processing
		end

	display_new_line is
			-- Display a new line on output.
		do
			output_manager.add_new_line
		end
indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.

			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).

			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.

			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
