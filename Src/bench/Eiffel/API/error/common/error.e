indexing

	description: 
		"Error object sent by the compiler to the workbench.";
	date: "$Date$";
	revision: "$Revision $"

deferred class ERROR

inherit

	EIFFEL_ENV;
	COMPARABLE
		undefine
			is_equal
		end;

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
        end;

feature -- Comparison

	infix "<" (other: like Current): BOOLEAN is
		do
			Result := code < other.code or else
						(code.is_equal (other.code) and then
							subcode < other.subcode)
		end;

feature -- Output

	trace (ow: OUTPUT_WINDOW) is
		require
			valid_ow: ow /= Void;
			is_defined: is_defined
		do
			print_error_message (ow);
			build_explain (ow);
		end;

	print_error_message (ow: OUTPUT_WINDOW) is
		require
			valid_ow: ow /= Void
		do
			ow.put_string (Error_string);
			ow.put_string (" code: ");
			ow.put_error (Current, code);
			if subcode /= 0 then
				ow.put_char ('(');
				ow.put_int (subcode);
				ow.put_string (")%N");
			else
				ow.new_line;
			end;
			print_short_help (ow);
		end;

	print_short_help (ow: OUTPUT_WINDOW) is
		require
			valid_ow: ow /= Void
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
					ow.put_string (file.laststring);
					ow.new_line;
				end;
				file.close;
			else
				ow.put_string ("%NNo help available for this error%N%
							%(cannot read file: ");
				ow.put_string (file_name);
				ow.put_string (")%N%
							%%NAn error message should always be available.%N%
							%Please contact ISE.%N%N");
			end;
		end;

	build_explain (ow: OUTPUT_WINDOW) is
			-- Build specific explanation image for current error
			-- in `error_window'.
		require
			valid_ow: ow /= Void
		deferred
		end;

invariant

	non_void_code: code /= Void;
	non_void_error_message: error_string /= Void;
	non_void_help_file_name: help_file_name /= Void
	
end -- class ERROR
