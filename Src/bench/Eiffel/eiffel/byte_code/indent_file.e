-- A file with primitives for indenting

class INDENT_FILE 

inherit

	PLAIN_TEXT_FILE
		rename
			putchar as file_putchar,
			new_line as file_new_line,
			putint as file_putint,
			putstring as file_putstring,
			putreal as file_putreal,
			putdouble as file_putdouble
		end;
	PLAIN_TEXT_FILE
		redefine
			putdouble, putreal, putstring, putint, new_line, putchar	
		select
			putdouble, putreal, putstring, putint, new_line, putchar
		end;

creation

	make

feature

	tabs: INTEGER;
			-- Value of indentation, in tabs

	old_tabs: INTEGER;
			-- Saved indentation value

	emitted: BOOLEAN;
			-- Have leading tabs already been emitted ?

	nl: INTEGER;
			-- Number of consecutive new line generated

feature 

	indent is
			-- Indent next output line by one tab.
		do
			tabs := tabs + 1;
		end;
	
	exdent is
			-- Remove one leading tab for next line.
		require
			valid_tabs: tabs > 0;
		do
			tabs := tabs - 1;
		end;

	left_margin is
			-- Temporary reset to left margin
		do
			old_tabs := tabs;
			tabs := 0;
		end;
	
	restore_margin is
			-- Restore margin value as of the one which was in
			-- use when a `left_margin' call was issued.
		do
			tabs := old_tabs;
		end;

	emit_tabs is
			-- Emit the `tabs' leading tabs
		local
			i: INTEGER
		do
			if not emitted then
				from
					i := 1;
				until
					i > tabs
				loop
					file_putchar ('%T');
					i := i + 1;
				end;
				emitted := true;
			end;
			debug ("FLUSH_FILE")
				flush
			end
		end;

	new_line is
			-- Write a '\n'.
			-- Do not allow two ore more consecutive blank lines.
		do
			if nl < 2 then
				file_new_line;
				emitted := false;
				nl := nl + 1;
			end;
			debug ("FLUSH_FILE")
				flush
			end
		end;

	putchar (c: CHARACTER) is
			-- Write char `c'.
		do
			emit_tabs;
			nl := 0;
			file_putchar (c);
			debug ("FLUSH_FILE")
				flush
			end
		end;
	
	putint (i: INTEGER) is
			-- Write int `i'.
		do
			emit_tabs;
			nl := 0;
			file_putint (i);
			debug ("FLUSH_FILE")
				flush
			end
		end;
	
	putreal (r: REAL) is
			-- Writes float `r'.
		do
			emit_tabs;
			nl := 0;
			file_putreal (r);
			debug ("FLUSH_FILE")
				flush
			end
		end;
	
	putdouble (d: DOUBLE) is
			-- Write double `d'.
		do
			emit_tabs;
			nl := 0;
			file_putdouble (d);
			debug ("FLUSH_FILE")
				flush
			end
		end;
	
	putstring (s: STRING) is
			-- Write string `s'.
		do
			emit_tabs;
			nl := 0;
			file_putstring (s);
			debug ("FLUSH_FILE")
				flush
			end
		end;

	putoctal (i: INTEGER) is
			-- Print octal representation of `i'
			--| always generate 3 digits
		local
			val, remain: INTEGER;
			s, t: STRING;
		do
			if i = 0 then
				file_putstring ("000")
			elseif i < 8 then
				file_putstring ("00")
				file_putint (i)
			else
				if i < 64 then
					file_putstring ("0")
				end
				
				!!s.make (3);
				from
					val := i;
				variant
					val + 1
				until
					val = 0
				loop
					remain := val \\ 8;
					val := val // 8;
					t := remain.out;
					s.prepend (t);
				end;
				file_putstring (s);
			end;
			debug ("FLUSH_FILE")
				flush
			end
		end;

	escape_char (c: CHARACTER) is
			-- Write char `c' with C escape sequences
		do
				-- Assume ASCII set, sorry--RAM.
			if c < ' ' or c > '%/127/' then
				file_putstring ("\");
				putoctal (c.code);
			elseif c = '\' then
				file_putstring ("\\");
			elseif c = '%'' then
				file_putstring ("\'");
			else
				file_putchar (c);
			end;
			debug ("FLUSH_FILE")
				flush
			end
		end;

	escape_string (s: STRING) is
			-- Write string `s' with escape quotes
		require
			good_argument: s /= Void
		local
			i, nb: INTEGER;
			c: CHARACTER;
		do
			from
				i := 1;
				nb := s.count;
			until
				i > nb
			loop
				c := s.item (i);
				if c = '"' then
					file_putstring ("\%"");
				elseif c = '\' then
					file_putstring ("\\");
				elseif c < ' ' or c > '%/127/' then
						-- Assume ASCII set, sorry--RAM.
					file_putstring ("\");
					putoctal (c.code);
				else
					file_putchar (c);
				end;
				i := i + 1;
			end;
			debug ("FLUSH_FILE")
				flush
			end
		end;

feature -- prototype code generation

	generate_cpp_wrapper_start is
			-- Generate the C++ wrapper start for C functions
		do
			putstring ("CPP_WRAPPER_START%N")
		end

	generate_cpp_wrapper_end is
			-- Generate the C++ wrapper end for C functions
		do
			putstring ("CPP_WRAPPER_END%N")
		end

	generate_extern_declaration (type: STRING; f_name, args: STRING) is
			-- Generate the external declaration for a C function
		do
			putstring ("EXTERN_DECL(")
			putstring (type)
			putstring (", ")
			putstring (f_name)
			putstring (", (")
			putstring (args)
			putstring ("));%N")
		end

	generate_protected_extern_declaration (type: STRING; f_name: STRING;
					arg_types: ARRAY [STRING]) is
			-- Generate the external declaration for a C function
			-- with the C++ wrapper
		require
			non_void_args: type /= Void and f_name /= Void and
				arg_types /= Void
			valid_lower:arg_types.lower = 1
		local
			i, nb: INTEGER
		do
			putstring ("CPP_WRAPPER_START%N%
				%EXTERN_DECL(")
			putstring (type)
			putstring (", ")
			putstring (f_name)
			putstring (", (")
			from
				i := 1
				nb := arg_types.count
			until
				i > nb
			loop
				if i /= 1 then
					putstring (", ")
				end
				putstring (arg_types @ i)
				i := i + 1
			end
			putstring ("));%N%
				%CPP_WRAPPER_END%N%N")
		end

	generate_function_signature (type: STRING; f_name: STRING;
					scope: STRING; extern_dec_file: like Current;
					arg_names: ARRAY [STRING]; arg_types: ARRAY [STRING]) is
			--- Generate the function signature for both ANSI and K&R
		require
			non_void_args: type /= Void and f_name /= Void and
				scope /= Void and arg_names /= Void and arg_types /= Void
			same_count: arg_names.count = arg_types.count
			valid_lower: arg_names.lower = 1 and arg_types.lower = 1
		local
			i, nb: INTEGER
		do
			extern_dec_file.generate_protected_extern_declaration
				(type, f_name, arg_types)
			putstring (scope)
			putstring ("%N#ifdef __STDC__%N")
			putstring (type)
			putchar (' ')
			putstring (f_name)
			putstring (" (")
			from
				i := 1
				nb := arg_names.count
			until
				i > nb
			loop
				putstring (arg_types @ i)
				putchar (' ')
				putstring (arg_names @ i)
				if i /= nb then
					putstring (", ")
				end
				i := i + 1
			end
			putstring (")%N%
					%#else%N")
			putstring (type)
			putchar (' ')
			putstring (f_name)
			putstring (" (")
			from
				i := 1 
			until
				i > nb
			loop
				putstring (arg_names @ i)
				if i /= nb then
					putstring (", ")
				end
				i := i + 1
			end 
			putstring (")%N")
			from
				i := 1 
			until
				i > nb
			loop
				putstring (arg_types @ i)
				putchar (' ')
				putstring (arg_names @ i)
				putstring (";%N")
				i := i + 1
			end 
			putstring ("#endif%N")
		end

end
