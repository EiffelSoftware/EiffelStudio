--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

indexing

	date: "$Date$";
	revision: "$Revision$"

class STD_FILES

feature {GENERAL}

	input: UNIX_FILE is
			-- Standard input file
		once
			!UNIX_STD! Result.make_open_stdin ("stdin");
		end;

	output: UNIX_FILE is
			-- Standard output file
		once
			!UNIX_STD! Result.make_open_stdout ("stdout");
		end;

	error: UNIX_FILE is
			-- Standard error file
		once
			!UNIX_STD! Result.make_open_stderr ("stderr");
		end;

	default_output: UNIX_FILE;
			-- Default output.

	standard_default: UNIX_FILE is
			-- Return the `default_output' or `output'
			-- if `default_output' is Void.
			--| Usefull if a class inherits from STD_FILES and
			--| and a `putint' is applied without standard setting.
		do
			if default_output = Void then
				Result := output;
			else
				Result := default_output;
			end;
		end;

	set_output_default is
			-- Use standard output as default output.
		do
			default_output := output; 
		end;

	set_error_default is
			-- Use standard error as default output.
		do
			default_output := error;
		end;

	putchar (c: CHARACTER) is
			-- Write `c' at end of default output.
		do
			file_pc (standard_default.file_pointer, $c)
		end;

	putstring (s: STRING) is
			-- Write `s' at end of default output.
		local
			external_s: ANY;
		do
			external_s := s.to_c;
			file_ps (standard_default.file_pointer, $external_s, s.count)
		end;

	putreal (r: REAL) is
			-- Write `r' at end of default output.
		do
			file_pr (standard_default.file_pointer, r)
		end;

	putdouble (d: DOUBLE) is
			-- Write `d' at end of default output.
		do
			file_pd (standard_default.file_pointer, d)
		end;

	putint (i: INTEGER) is
			-- Write `i' at end of default output.
		do
			file_pi (standard_default.file_pointer, i)
		end;

	putbool (b: BOOLEAN) is
			-- Write `b' at end of default output.
		do
			if b then
				putstring ("true")
			else
				putstring ("false")
			end -- if
		end; 

	new_line is
			-- Write line feed at end of default output.
		do
			file_tnwl (standard_default.file_pointer)
		end;

	readint is
			-- Read a new integer from standard input.
		do
			input.readint
		end;

	readreal is
			-- Read a new real from standard input.
		do
			input.readreal
		end;

	readdouble is
			-- Read a new double from standard input.
		do
			input.readdouble
		end;

	readline is
			-- Read a line from standard input.
		do
			input.readline
		end;

	readstream (nb_char: INTEGER) is
 			-- Read a string of at most `nb_char' bound characters
			-- from standard input.
		do
			input.readstream (nb_char)
		end;

	readword is
			-- Read a new word from standard input.
		do
			input.readword
		end;

	readchar is
			-- Read a new character from standard input.
		do
			input.readchar
		end;

	next_line is
			-- Move to next input line on standard input.
		do
			input.next_line
		end;

	lastchar: CHARACTER is
			-- Last character read by readchar
		do
			Result := input.lastchar
		end;

	lastint: INTEGER is
			-- Last integer read by readint
		do
			Result := input.lastint
		end;

	lastreal: REAL is
			-- Last real read by readreal
		do
			Result := input.lastreal
		end;

	laststring: STRING is
			-- Last string read by readstring
		do
			Result := input.laststring
		end;

	lastdouble: DOUBLE is
		do
			Result := input.lastdouble
		end;

feature {NONE}
			-- Externals

	file_pc (file: POINTER; c: CHARACTER) is
		-- Write character `c' at end of `file'
		external
			"C"
		end;

	file_ps (file: POINTER; s_name: ANY; lenght: INTEGER) is
			-- Write string `s' at end of `file'
		external
			"C"
		end;

	file_pr (file: POINTER; r: REAL) is
			-- Write real `r' at end of `file'
		external
			"C"
		end;

	file_pd (file: POINTER; d: DOUBLE) is
			-- Write double `d' at end of `file'
		external
			"C"
		end;

	file_pi (file: POINTER; i: INTEGER) is
			-- Write integer `i' at end of `file'
		external
			"C"
		end;

	file_tnwl (file: POINTER) is
			-- Print a new_line to `file'
		external
			"C"
		end;
	
end -- class STD_FILES
