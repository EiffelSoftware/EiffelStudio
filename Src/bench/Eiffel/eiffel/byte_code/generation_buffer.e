indexing
	description: "Temporization buffer used during the C generation"
	author: "Emmanuel Stapf"
	date: "$Date$"
	revision: "$Revision$"

class
	GENERATION_BUFFER

inherit
	STRING
		redefine
			clear_all
		end

creation
	make

feature -- Status report

	tabs: INTEGER
			-- Value of indentation, in tabs

	old_tabs: INTEGER
			-- Saved indentation value

	emitted: BOOLEAN
			-- Have leading tabs already been emitted?

feature -- Open, close buffer operations

	clear_all is
			-- Reset the cache for a new generation
		do
			count := 0
			tabs := 0
			old_tabs := 0
			emitted := False
		end

	open_write_c is
			-- Write at beginning of buffer that it will be a C file with the
			-- extern C declaration in case a C++ compiler is used.
		do
			append ("#ifdef __cplusplus%Nextern %"C%" {%N#endif%N%N")
		end

	close_c is
			-- Write at end of buffer that it will be a C file with the
			-- extern C declaration in case a C++ compiler is used.
		do
			append ("%N#ifdef __cplusplus%N}%N#endif%N")
		end

feature -- Element change

	indent is
			-- Indent next output line by one tab.
		do
			tabs := tabs + 1
		end
	
	exdent is
			-- Remove one leading tab for next line.
		require
			valid_tabs: tabs > 0
		do
			tabs := tabs - 1
		end

	left_margin is
			-- Temporary reset to left margin
		do
			old_tabs := tabs
			tabs := 0
		end
	
	restore_margin is
			-- Restore margin value as of the one which was in
			-- use when a `left_margin' call was issued.
		do
			tabs := old_tabs
		end

	emit_tabs is
			-- Emit the `tabs' leading tabs
		local
			i: INTEGER
		do
			if not emitted then
				from
					i := 1
				until
					i > tabs
				loop
					append_character ('%T')
					i := i + 1
				end
				emitted := true
			end
		end

	new_line is
			-- Write a '\n'.
			-- Do not allow two ore more consecutive blank lines.
		do
			append_character ('%N')
			emitted := false
		end

	putchar (c: CHARACTER) is
			-- Write char `c'.
		do
			emit_tabs
			append_character (c)
		end
	
	putint (i: INTEGER) is
			-- Write int `i'.
		do
			emit_tabs
			append_integer (i)
		end
	
	putreal (r: REAL) is
			-- Writes float `r'.
		do
			emit_tabs
			append_real (r)
		end
	
	putdouble (d: DOUBLE) is
			-- Write double `d'.
		do
			emit_tabs
			append_double (d)
		end
	
	putstring (s: STRING) is
			-- Write string `s'.
		do
			emit_tabs
			append (s)
		end

	putoctal (i: INTEGER) is
			-- Print octal representation of `i'
			--| always generate 3 digits
		local
			val, remain: INTEGER
			s, t: STRING
		do
			if i = 0 then
				append ("000")
			elseif i < 8 then
				append ("00")
				append_integer (i)
			else
				if i < 64 then
					append_character ('0')
				end
				
				!! s.make (3)
				from
					val := i
				variant
					val + 1
				until
					val = 0
				loop
					remain := val \\ 8
					val := val // 8
					t := remain.out
					s.prepend (t)
				end
				append (s)
			end
		end

	escape_char (c: CHARACTER) is
			-- Write char `c' with C escape sequences
		do
				-- Assume ASCII set, sorry--RAM.
			if c < ' ' or c > '%/127/' then
				append_character ('\')
				putoctal (c.code)
			elseif c = '\' then
				append ("\\")
			elseif c = '%'' then
				append ("\'")
			else
				append_character (c)
			end
		end

	escape_string (s: STRING) is
			-- Write string `s' with escape quotes
		require
			good_argument: s /= Void
		local
			i, nb: INTEGER
			c: CHARACTER
		do
			from
				i := 1
				nb := s.count
			until
				i > nb
			loop
				c := s.item (i)
				if c = '"' then
					append ("\%"")
				elseif c = '\' then
					append ("\\")
				elseif c < ' ' or c > '%/127/' then
						-- Assume ASCII set, sorry--RAM.
					append_character ('\')
					putoctal (c.code)
				else
					append_character (c)
				end
				i := i + 1
			end
		end

feature {GENERATION_BUFFER} -- prototype code generation

	generate_function_declaration (type: STRING; f_name: STRING;
			extern: BOOLEAN; arg_types: ARRAY [STRING]) is
				-- Generate funtion declaration using macros
		local
			i, nb: INTEGER
		do
			if extern then
				append ("extern ")
			else
				append ("static ")
			end

			append (type)
			append_character (' ')
			append (f_name)
			append_character ('(')
			from
				i := 1
				nb := arg_types.count
			until
				i > nb
			loop
				if i /= 1 then
					append (", ")
				end
				append (arg_types @ i)
				i := i + 1
			end
			append (");%N")
		end

feature -- prototype code generation

	generate_extern_declaration (type: STRING; f_name: STRING;
					arg_types: ARRAY [STRING]) is
			-- Generate the external declaration for a C function
		require
			non_void_args: type /= Void and f_name /= Void and arg_types /= Void
			valid_lower:arg_types.lower = 1
		do
			generate_function_declaration (type, f_name, True, arg_types)
		end

	generate_static_declaration (type: STRING; f_name: STRING;
					arg_types: ARRAY [STRING]) is
			-- Generate the external declaration for a C function
		require
			non_void_args: type /= Void and f_name /= Void and arg_types /= Void
			valid_lower:arg_types.lower = 1
		do
			generate_function_declaration (type, f_name, False, arg_types)
		end

	generate_function_signature (type: STRING; f_name: STRING;
					extern: BOOLEAN; extern_header: like Current
					arg_names: ARRAY [STRING]; arg_types: ARRAY [STRING]) is
			-- Generate the function signature for ANSI C
			-- including the starting '{'
		require
			non_void_args: type /= Void and f_name /= Void and
				arg_names /= Void and arg_types /= Void
			same_count: arg_names.count = arg_types.count
			valid_lower: arg_names.lower = 1 and arg_types.lower = 1
		local
			i, nb: INTEGER
		do
			extern_header.generate_function_declaration (type, f_name, extern, arg_types)
			if not extern then
				append ("static ")
			end
			append (type)
			append_character (' ')
			append (f_name)
			append (" (")

			from
				i := 1
				nb := arg_names.count
			until
				i > nb
			loop
				append (arg_types @ i)
				append_character (' ')
				append (arg_names @ i)
				if i /= nb then
					append (", ")
				end
				i := i + 1
			end

			append (")%N{%N%TGTCX") -- ss MT: GET CONTEXT
			new_line
		end

end -- class GENERATION_BUFFER
