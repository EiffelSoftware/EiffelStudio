indexing

	description: 
		"Error object sent by the compiler to the workbench.";
	date: "$Date$";
	revision: "$Revision $"

deferred class ERROR

inherit
	EIFFEL_ENV
		export
			{NONE} all
		end

feature -- Properties 

	code: STRING is
			-- Code error
		deferred
		end;

	subcode: INTEGER is
		do
		end;

	help_file_name: STRING is
		do
			Result := code
		end;

	Error_string: STRING is
		do
			Result := "Error";
		end;

feature -- Access

	is_defined: BOOLEAN is
			-- Is the error fully defined?
		do
			Result := True
		end

feature -- Output

	trace (st: STRUCTURED_TEXT) is
		require
			valid_st: st /= Void;
			is_defined: is_defined
		do
			print_error_message (st);
			build_explain (st);
		end;

	print_error_message (st: STRUCTURED_TEXT) is
		require
			valid_st: st /= Void
		do
			st.add_string (Error_string);
			st.add_string (" code: ");
			st.add_error (Current, code);
			if subcode /= 0 then
				st.add_char ('(');
				st.add_int (subcode);
				st.add_string (")");
				st.add_new_line
			else
				st.add_new_line;
			end;
			print_short_help (st);
		end;

	print_short_help (st: STRUCTURED_TEXT) is
		require
			valid_st: st /= Void
		local
			file_name: STRING;
			f_name: FILE_NAME;
			file: PLAIN_TEXT_FILE;
		do
			!!f_name.make_from_string (help_path);
			f_name.extend ("short");
			f_name.set_file_name (help_file_name);
			file_name := f_name
			if subcode /= 0 then
				file_name.append_integer (subcode)
			end;
			!!file.make (file_name);
			if file.exists then
				from
					file.open_read;
				until
					file.end_of_file
				loop
					file.readline;
					st.add_string (clone (file.laststring));
					st.add_new_line;
				end;
				file.close;
			else
				st.add_new_line;
				st.add_string ("No help available for this error");
				st.add_new_line;
				st.add_string ("(cannot read file: ");
				st.add_string (file_name);
				st.add_string (")");
				st.add_new_line;
				st.add_new_line;
				st.add_string ("An error message should always be available.");
				st.add_new_line;
				st.add_string ("Please contact ISE.");
				st.add_new_line;
				st.add_new_line
			end;
		end;

	build_explain (st: STRUCTURED_TEXT) is
			-- Build specific explanation image for current error
			-- in `error_window'.
		require
			valid_st: st /= Void
		deferred
		end;

invariant

	non_void_code: code /= Void;
	non_void_error_message: error_string /= Void;
	non_void_help_file_name: help_file_name /= Void
	
end -- class ERROR
