indexing

	description:
		"Displays warnings and errors of compilation."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class DEFAULT_ERROR_DISPLAYER

inherit
	ERROR_DISPLAYER

	SHARED_CONFIGURE_RESOURCES

	SHARED_ERROR_TRACER
		export
			{NONE} all
		end

create
	make

feature -- Initialization

	make (ow: like output_window) is
			-- Initialize current with `output_window' to `ow'
		do
			output_window := ow
		ensure
			set: ow = output_window
		end

feature -- Property

	output_window: OUTPUT_WINDOW

feature -- Output

	force_display is
			-- Make sure the user can see the messages we send.
		do
		end

	trace_warnings (handler: ERROR_HANDLER) is
			-- Display warnings messages from `handler'.
		local
			warning_list: LINKED_LIST [ERROR];
			a_text_formatter: TEXT_FORMATTER
			l_cursor: CURSOR
		do
			a_text_formatter := output_window
			if not retried then
				from
					warning_list := handler.warning_list
					l_cursor := warning_list.cursor
					warning_list.start
				until
					warning_list.after
				loop
					display_separation_line (a_text_formatter);
					a_text_formatter.add_new_line;
					tracer.trace (a_text_formatter, warning_list.item, {ERROR_TRACER}.normal)
					a_text_formatter.add_new_line;
					warning_list.forth;
				end;
				warning_list.go_to (l_cursor)
				if handler.error_list.is_empty then
						-- There is no error in the list
						-- put a separation before the next message
					display_separation_line (a_text_formatter)
				end;
			else
				retried := False;
				display_error_error (a_text_formatter)
			end;
		rescue
			if not fail_on_rescue then
				retried := True;
				retry;
			end;
		end;

	trace_errors (handler: ERROR_HANDLER) is
			-- Display error messages from `handler'.
		local
			error_list: LINKED_LIST [ERROR]
			a_text_formatter: TEXT_FORMATTER
			l_cursor: CURSOR
		do
			a_text_formatter := output_window
			if not retried then
				from
					error_list := handler.error_list
					l_cursor := error_list.cursor
					error_list.start
				until
					error_list.after
				loop
					display_separation_line (a_text_formatter)
					a_text_formatter.add_new_line
					tracer.trace (a_text_formatter, error_list.item, {ERROR_TRACER}.normal)
					a_text_formatter.add_new_line
					error_list.forth
				end
				error_list.go_to (l_cursor)
				display_separation_line (a_text_formatter)
				display_additional_info (a_text_formatter)
			else
				retried := False
				display_error_error (a_text_formatter)
			end
		rescue
			if not fail_on_rescue then
				retried := True
				retry
			end
		end

feature {NONE} -- Implementation

	retried: BOOLEAN;

	display_error_error (a_text_formatter: TEXT_FORMATTER) is
		do
			a_text_formatter.add ("Exception occurred while displaying error message.");
			a_text_formatter.add_new_line;
			a_text_formatter.add ("Please contact ISE to report this bug.");
			a_text_formatter.add_new_line
		end;

	display_separation_line (a_text_formatter: TEXT_FORMATTER) is
		do
			a_text_formatter.add ("--------------------------------------------%
							%-----------------------------------");
			a_text_formatter.add_new_line
		end

	display_additional_info (a_text_formatter: TEXT_FORMATTER) is
		do
		end

invariant

	non_void_output_window: output_window /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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

end -- class DEFAULT_ERROR_DISPLAYER
