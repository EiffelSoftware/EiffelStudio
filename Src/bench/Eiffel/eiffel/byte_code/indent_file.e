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
		end;

	putchar (c: CHARACTER) is
			-- Write char `c'.
		do
			emit_tabs;
			nl := 0;
			file_putchar (c);
		end;
	
	putint (i: INTEGER) is
			-- Write int `i'.
		do
			emit_tabs;
			nl := 0;
			file_putint (i);
		end;
	
	putreal (r: REAL) is
			-- Writes float `r'.
		do
			emit_tabs;
			nl := 0;
			file_putreal (r);
		end;
	
	putdouble (d: DOUBLE) is
			-- Write double `d'.
		do
			emit_tabs;
			nl := 0;
			file_putdouble (d);
		end;
	
	putstring (s: STRING) is
			-- Write string `s'.
		do
			emit_tabs;
			nl := 0;
			file_putstring (s);
		end;

	putoctal (i: INTEGER) is
			-- Print octal representation of `i'
		local
			val, remain: INTEGER;
			s, t: STRING;
		do
			if i = 0 then
				file_putstring ("0")
			else
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
		end;

end
