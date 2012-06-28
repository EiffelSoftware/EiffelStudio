note
	description: ""
	author: "jvelilla"
	date: "2008/08/24"
	revision: "0.1"

class
	JSON_TOKENS

feature -- Access

	j_OBJECT_OPEN: CHARACTER = '{'
	j_ARRAY_OPEN: CHARACTER = '['
	j_OBJECT_CLOSE: CHARACTER = '}'
	j_ARRAY_CLOSE: CHARACTER = ']'

	j_STRING: CHARACTER = '"'
	j_PLUS: CHARACTER = '+'
	j_MINUS: CHARACTER = '-'
	j_DOT: CHARACTER = '.'

feature -- Status report

	is_open_token (c: CHARACTER): BOOLEAN
			-- Characters which open a type	
		do
			inspect c
			when j_OBJECT_OPEN, j_ARRAY_OPEN, j_STRING, j_PLUS, j_MINUS, j_DOT then
				Result := True
			else

			end
		end

	is_close_token (c: CHARACTER): BOOLEAN
			-- Characters which close a type	
		do
			inspect c
			when j_OBJECT_CLOSE, j_ARRAY_CLOSE, j_STRING then
				Result := True
			else

			end
		end

	is_special_character (c: CHARACTER): BOOLEAN
			-- Control Characters
			-- 	%F  	Form feed
			-- 	%H  	backslasH
			--  %N  	Newline
			--  %R  	carriage Return
			--  %T  	horizontal Tab
			--  %B  	Backspace
		    --  /       Solidus
		    --  "       Quotation	
		do
			inspect c
			when '%F', '%H', '%N', '%R', '%T', '%B', '/', '"' then
				Result := True
			else

			end
		end

   is_special_control (c: CHARACTER): BOOLEAN
           --Control Characters
           -- \b\f\n\r\t
		do
			inspect c
			when 'b', 'f', 'n', 'r', 't' then
				Result := True
			else

			end
		end

end
