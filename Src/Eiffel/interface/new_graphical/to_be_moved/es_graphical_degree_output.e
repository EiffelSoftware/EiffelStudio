note
	description: "EiffelStudio graphical degree output to send output to the outputs tool ({ES_OUTPUTS_TOOL})."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_GRAPHICAL_DEGREE_OUTPUT

inherit
	DEGREE_OUTPUT
		redefine
			translate,
			put_start_output,
			put_end_output,
			put_message,
			put_new_line,
			put_degree,
			put_degree_output,
			put_dead_code_removal_message,
			put_start_degree,
			put_end_degree,
			flush_output
		end

	ES_SHARED_OUTPUTS
		export
			{NONE} all
		undefine
			default_create
		end

	ES_SHARED_LOCALE_FORMATTER
		export
			{NONE} all
		undefine
			default_create
		end

	EB_SHARED_WINDOW_MANAGER
		export
			{NONE} all
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

feature {NONE} -- Query: Internationalization

	translate (a_string: STRING; a_args: detachable TUPLE): STRING_32
			-- <Precursor>
		do
			if a_args /= Void then
				Result := locale_formatter.formatted_translation (a_string, a_args)
			else
				Result := locale_formatter.translation (a_string)
			end
		end

feature -- Basic operation

	put_start_output
			-- <Precursor>
		do
			Precursor
			if attached compiler_output as l_output then
				l_output.lock
				l_output.clear
			end
		end

	put_end_output
			-- <Precursor>
		do
			Precursor
			if attached compiler_output as l_output then
				l_output.unlock
			end
			window_manager.display_percentage (0)
		end

feature {NONE} -- Basic operations

	put_start_degree (a_degree: INTEGER; a_total: INTEGER)
			-- <Precursor>
		local
			l_degree_str: STRING_32
		do
			total_number := a_total
			degree := a_degree
			last_degree := a_degree
			processed := 0
			compiler_formatter.start_processing (True)
			l_degree_str := degree_short_description (a_degree)
			if a_degree /= 0 then
				compiler_formatter.process_string_text (translate (lb_degree, Void), Void)
				compiler_formatter.process_basic_text (" ")
				compiler_formatter.process_string_text (a_degree.out, Void)
				compiler_formatter.process_basic_text (": ")
			end
			compiler_formatter.process_basic_text (l_degree_str)
			compiler_formatter.process_new_line
			compiler_formatter.end_processing

			window_manager.display_percentage (0)
			if is_compilation_cancellable then
				project_cancel_cmd.enable_sensitive
			else
				project_cancel_cmd.disable_sensitive
			end
		end

	put_end_degree
			-- <Precursor>
		do
			window_manager.display_percentage (100)
		end

	put_degree (a_degree: STRING; a_to_go: INTEGER; a_name: STRING)
			-- <Precursor>
		local
			l_desc: STRING_32
		do
			Precursor (a_degree, a_to_go, a_name)
			if degree = 0 then
				l_desc := a_degree
			else
				l_desc := degree_description (degree)
			end

			if total_number > 1 then
				window_manager.display_message_and_percentage (
					l_desc  + " (" + (total_number - a_to_go + 1).out + "/" + total_number.out + "): " + a_name,
					calculate_percentage (a_to_go))
			else
				window_manager.display_message_and_percentage (
					l_desc + ": " + a_name, calculate_percentage (a_to_go))
			end

			flush_output
		end


	put_dead_code_removal_message (a_processed: INTEGER; a_to_go: INTEGER)
			-- <Precursor>
		local
			l_processed: INTEGER
		do
			Precursor (a_processed, a_to_go)
			l_processed := processed
			total_number := l_processed + a_to_go

			window_manager.display_message_and_percentage (locale_formatter.formatted_translation (lb_removing_dead_features_2, [l_processed, total_number]),  calculate_percentage (a_to_go))
		end

feature {NONE} -- Implementation

	flush_output
			-- Flush any pending messages to the display.
		do
			if not ev_application.is_destroyed and then ev_application.is_launched then
				ev_application.process_events
			end
		end

	put_degree_output (a_degree: STRING; a_to_go: INTEGER; a_total: INTEGER)
			-- <Precursor>
		do
			Precursor (a_degree, a_to_go, a_total)
			window_manager.display_message_and_percentage (a_degree, calculate_percentage (a_to_go))
			flush_output
		end

feature -- Basic operations

	put_message (a_message: STRING)
			-- <Precursor>
		do
			compiler_formatter.start_processing (True)
			compiler_formatter.add (a_message.as_string_32)
			compiler_formatter.end_processing
		end

	put_new_line
			-- <Precursor>
		do
			compiler_formatter.add_new_line
		end

feature {NONE} -- Internationalization

	lb_compilation_failed: STRING = "Compilation failed"
	lb_removing_dead_features_2: STRING = "Removing unused (dead) code ($1/$2)"

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
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
