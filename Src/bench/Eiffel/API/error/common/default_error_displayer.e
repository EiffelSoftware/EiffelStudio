indexing

	description: 
		"Displays warnings and errors of compilation for ebench.";
	date: "$Date$";
	revision: "$Revision $"

class DEFAULT_ERROR_DISPLAYER

inherit

	ERROR_DISPLAYER;
	SHARED_CONFIGURE_RESOURCES;
	SHARED_EIFFEL_PROJECT

creation

	make

feature -- Initialization

	make (ow: like output_window) is
			-- Initialize current with `output_window' to `ow'
		do
			output_window := ow
		ensure
			set: ow = output_window
		end;

feature -- Property

	output_window: OUTPUT_WINDOW

feature -- Output

	trace_warnings (handler: ERROR_HANDLER) is
			-- Display warnings messages from `handler'.
		local
			warning_list: SORTED_TWO_WAY_LIST [WARNING];
			st: STRUCTURED_TEXT
		do
			if not retried then
				warning_list := handler.warning_list
				!! st.make;
				from
					warning_list.start
				until
					warning_list.after
				loop
					display_separation_line (st);
					st.add_new_line;
					warning_list.item.trace (st);
					st.add_new_line;
					warning_list.forth;
				end;
				if handler.error_list.empty then
						-- There is no error in the list
						-- put a separation before the next message
					display_separation_line (st)
				end;
				warning_list.wipe_out;
			else
				retried := False;
				display_error_error (st)
			end;
			output_window.process_text (st);
			output_window.display
		rescue
			if not fail_on_rescue then
				retried := True;
				retry;
			end;
		end;

	trace_errors (handler: ERROR_HANDLER) is
			-- Display error messages from `handler'.
		local
			error_list: SORTED_TWO_WAY_LIST [ERROR];
			st: STRUCTURED_TEXT;
			degree_nbr: INTEGER;
			to_go: INTEGER
		do
			if not retried then
				!! st.make;
				error_list := handler.error_list;
				from
					error_list.start
				until
					error_list.after
				loop
					display_separation_line (st);
					st.add_new_line;
					error_list.item.trace (st);
					st.add_new_line;
					error_list.forth;
				end;
				--if not error_list.empty then
					--display_separation_line (st)
				--end;
				display_separation_line (st);	
				degree_nbr := Degree_output.current_degree;
				st.add_string ("Degree: ");
				st.add_string (degree_nbr.out);
				st.add_string (" Processed: ")
				st.add_string (Degree_output.processed.out);
				st.add_string (" To go: ")
				to_go := Degree_output.total_number - Degree_output.processed;
				st.add_string (to_go.out);
				st.add_string (" Total: ")
				st.add_string (Degree_output.total_number.out);
				st.add_new_line;
			else
				retried := False;
				display_error_error (st)
			end;
			output_window.process_text (st);
		rescue
			if not fail_on_rescue then
				retried := True;
				retry;
			end;
		end;

feature {NONE} -- Implementation

	retried: BOOLEAN;

	display_error_error (st: STRUCTURED_TEXT) is
		do
			st.add_string ("Exception occurred while displaying error message.");
			st.add_new_line;
			st.add_string ("Please contact ISE to report this bug.");
			st.add_new_line
		end;

	display_separation_line (st: STRUCTURED_TEXT) is
		do
			st.add_string
("-------------------------------------------------------------------------------");
			st.add_new_line
		end;

invariant

	non_void_output_window: output_window /= Void

end -- class DEFAULT_ERROR_DISPLAYER
