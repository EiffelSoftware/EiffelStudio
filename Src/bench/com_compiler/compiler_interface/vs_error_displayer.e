indexing
	description: "Visual Studio Error Displayer."
	date: "$Date$"
	revision: "$Revision$"

class
	VS_ERROR_DISPLAYER

inherit
	DEFAULT_ERROR_DISPLAYER
		redefine
			trace_warnings,
			trace_errors
		end

create
	make_with_coclass

feature -- Initialization

	make_with_coclass (ow: like output_window; compiler: like compiler_coclass) is
			-- Initialize current with `output_window' to `ow'
		do
			output_window := ow
			compiler_coclass := compiler
		ensure
			set: ow = output_window
			compiler_set: compiler = compiler_coclass
		end

feature -- Property

	compiler_coclass: CEIFFEL_COMPILER_COCLASS
			-- Compiler coclass, where events are defined.

feature -- Output

	trace_warnings (handler: ERROR_HANDLER) is
			-- Display warnings messages from `handler'.
		local
			warning_list: LINKED_LIST [WARNING];
			st: STRUCTURED_TEXT
		do
			if not retried then
				from
					create st.make;
					warning_list := handler.warning_list
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
				if handler.error_list.is_empty then
						-- There is no error in the list
						-- put a separation before the next message
					display_separation_line (st)
				end;
			else
				retried := False;
				display_error_error (st)
			end;
			output_window.process_text (st)
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
			st, st2: STRUCTURED_TEXT
			syntax_error: SYNTAX_ERROR
		do
			if not retried then
				from
					create st.make
					error_list := handler.error_list
					error_list.start
				until
					error_list.after
				loop
					display_separation_line (st)
					st.add_new_line
					error_list.item.trace (st)
					st.add_new_line
					error_list.forth
					create st2.make
					error_list.item.trace (st2)
					syntax_error ?= error_list.item
					if syntax_error /= Void then
						compiler_coclass.event_last_error (st2.image,
									syntax_error.file_name,
									line_number (syntax_error.file_name, syntax_error.start_position))
					else
						compiler_coclass.event_last_error (st2.image, Void, 0)
					end
				end
				display_separation_line (st)
				display_additional_info (st)
			else
				retried := False
				display_error_error (st)
			end
			output_window.process_text (st)
		rescue
			if not fail_on_rescue then
				retried := True
				retry
			end
		end

feature {NONE} -- Implementation
	
	line_number (file_name: STRING; start_position: INTEGER): INTEGER is
			-- Calculate line number of the character in `start_position'.
		require
			non_void_file_name: file_name /= Void
			non_empty_file_name: not file_name.is_empty
		local
			file: RAW_FILE
			string: STRING
			i: INTEGER
		do
			create file.make (file_name)
			if file.exists then
				file.open_read
				file.start
				file.read_stream (start_position)
				string := file.last_string
				from
					i := 1
				until
					i > start_position
				loop
					if string.item (i) = '%N' then
						Result := Result + 1
					end
					i := i + 1
				end
			end
		end
		
end -- class VS_ERROR_DISPLAYER
