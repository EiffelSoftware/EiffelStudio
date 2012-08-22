%{
note

	description:

		"Infix notation calculator"

	copyright: "Copyright (c) 1999-2003, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class CALC

inherit

	YY_PARSER_SKELETON

	KL_IMPORTED_STRING_ROUTINES

create

	make, execute

%}

	-- geyacc declarations.
%token <DOUBLE> NUM
%left '-' '+'
%left '*' '/'
%left NEG  -- negation--unary minus
%right '^' -- exponentiation

%type <DOUBLE> exp

%%

input: -- Empty
	| input line
	;

line: '\n'
	| exp '\n'		{ print ($1.out); print ("%N") }
	| error '\n'	{ recover }
	;

exp: NUM				{ $$ := $1 }
	| exp '+' exp		{ $$ := $1 + $3 }
	| exp '-' exp		{ $$ := $1 - $3 }
	| exp '*' exp		{ $$ := $1 * $3 }
	| exp '/' exp		{ $$ := $1 / $3 }
	| '-' exp %prec NEG	{ $$ := -$2 }
	| '(' exp ')'		{ $$ := $2 }
	;

%%

feature {NONE} -- Initialization

	execute
			-- Run calculator.
		do
			make
			parse
		end

feature {NONE} -- Scanner

	read_token
			-- Lexical analyzer returns a double floating point
			-- number on the stack and the token NUM, or the ASCII
			-- character read if not a number. Skips all blanks
			-- and tabs, returns 0 for EOF.
		local
			c: CHARACTER
			buffer: STRING
		do
				-- Skip white space
			from
				if has_pending_character then
					c := pending_character
					has_pending_character := False
				elseif not std.input.end_of_file then
					std.input.read_character
					c := std.input.last_character
				end
			until
				std.input.end_of_file or else
				(c /= ' ' and c /= '%T')
			loop
				std.input.read_character
				c := std.input.last_character
			end
			if std.input.end_of_file then
					-- Return end-of-file
				last_token := 0
			elseif (c >= '0' and c <= '9') then
					-- Process numbers
				last_token := NUM
				from
					create buffer.make (10)
					buffer.append_character (c)
					std.input.read_character
					c := std.input.last_character
				until
					std.input.end_of_file or else
					(c < '0' or c > '9')
				loop
					buffer.append_character (c)
					std.input.read_character
					c := std.input.last_character
				end
				if not std.input.end_of_file and then c = '.' then
					from
						buffer.append_character ('.')
						std.input.read_character
						c := std.input.last_character
					until
						std.input.end_of_file or else
						(c < '0' or c > '9')
					loop
						buffer.append_character (c)
						std.input.read_character
						c := std.input.last_character
					end
				end
				if not std.input.end_of_file then
					pending_character := c
					has_pending_character := True
				end
				last_double_value := buffer.to_double
			else
					-- Return single character
				last_token := c.code
			end
		end

	last_token: INTEGER
			-- Last token read

feature {NONE} -- Implementation

	pending_character: CHARACTER
	has_pending_character: BOOLEAN

end
