-- Error object sent by the compiler to the workbench

deferred class ERROR

inherit

	SHARED_WORKBENCH;
	EIFFEL_ENV;
	COMPARABLE;
	WINDOWS;
	STONABLE

feature -- Error code 

	code: STRING is
			-- Code error
		deferred
		end;

	subcode: INTEGER is
		do
		end;

feature

	infix "<" (other: like Current): BOOLEAN is
		do
			Result := code < other.code or else
						(code.is_equal (other.code) and then
							subcode < other.subcode)
		end;

feature -- Debug pupose

	print_error_message is
		local
			dummy_reference: CLASS_C
		do
			put_string (Error_string);
			put_string (" code: ");
			put_clickable_string (stone (dummy_reference), code);
			if subcode /= 0 then
				put_char ('(');
				put_int (subcode);
				put_string (")%N");
			else
				new_line;
			end;
			print_short_help;
		end;

	trace is
		do
			print_error_message;
			build_explain;
		end;

	help_file_name: STRING is
		do
			Result := code
		end;

	print_short_help is
		local
			file_name: STRING;
			file: PLAIN_TEXT_FILE;
		do
			file_name := clone (help_path)
			file_name.append ("short");
			file_name.extend (Directory_separator);
			file_name.append (help_file_name);
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
					put_string (file.laststring);
					new_line;
				end;
				file.close;
			else
				put_string ("%NNo help available for this error%N%
							%(cannot read file: ");
				put_string (file_name);
				put_string (")%N%
							%%NAn error message should always be available.%N%
							%Please contact ISE.%N%N");
			end;
		end;

	build_explain is
			-- Build specific explanation image for current error
			-- in `error_window'.
		deferred
		end;

	Error_string: STRING is
		do
			Result := "Error";
		end;

feature -- Clicking

	put_string (s: STRING) is
		do
			error_window.put_string (s)
		end;

	put_clickable_string (a: ANY; s: STRING) is
		do
			error_window.put_clickable_string (a, s)
		end;

	new_line is
		do
			error_window.new_line
		end;

	put_char (c: CHARACTER) is
		do
			error_window.put_char (c)
		end;

	put_int (i: INTEGER) is
		do
			error_window.put_int (i);
		end;

	putstring (s: STRING) is obsolete "Use put_string"
		do
			put_string (s)
		end;

feature -- stoning

	stone (reference_class: CLASS_C): ERROR_STONE is
			-- Reference class is useless here
		do
			!!Result.make (Current)
		end

end
