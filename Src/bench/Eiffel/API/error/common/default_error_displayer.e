indexing

	description: 
		"Displays warnings and errors of compilation for ebench.";
	date: "$Date$";
	revision: "$Revision $"

class DEFAULT_ERROR_DISPLAYER

inherit

	ERROR_DISPLAYER;
	SHARED_RESOURCES

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
		do
			if not retried then
				warning_list := handler.warning_list
				from
					warning_list.start
				until
					warning_list.after
				loop
					display_separation_line (output_window);
					output_window.new_line;
					warning_list.item.trace (output_window);
					output_window.new_line;
					warning_list.forth;
				end;
				if handler.error_list.empty then
						-- There is no error in the list
						-- put a separation before the next message
					display_separation_line (output_window)
				end;
				warning_list.wipe_out;
			else
				retried := False;
				display_error_error (output_window)
			end;
		rescue
			if not resources.get_boolean (r_Fail_on_rescue, False) then
				retried := True;
				retry;
			end;
		end;

	trace_errors (handler: ERROR_HANDLER) is
			-- Display error messages from `handler'.
		local
			error_list: SORTED_TWO_WAY_LIST [ERROR]
		do
			if not retried then
				error_list := handler.error_list;
				from
					error_list.start
				until
					error_list.after
				loop
					display_separation_line (output_window);
					output_window.new_line;
					error_list.item.trace (output_window);
					output_window.new_line;
					error_list.forth;
				end;
				if not error_list.empty then
					display_separation_line (output_window)
				end;
			else
				retried := False;
				display_error_error (output_window)
			end;
		rescue
			if not resources.get_boolean (r_Fail_on_rescue, False) then
				retried := True;
				retry;
			end;
		end;

feature {NONE} -- Implementation

	retried: BOOLEAN;

	display_error_error (ow: OUTPUT_WINDOW) is
		do
			ow.put_string ("Exception occurred while displaying error message.%N%
						%Please contact ISE to report this bug.%N");
		end;

	display_separation_line (ow: OUTPUT_WINDOW) is
		do
			ow.put_string
("-------------------------------------------------------------------------------%N");
		end;

invariant

	non_void_output_window: output_window /= Void

end -- class DEFAULT_ERROR_DISPLAYER
