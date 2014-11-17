note
	description: "Token used by the JSON_PARSER"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_TOKENS

feature -- Access

	token_object_open: CHARACTER = '{'
	token_object_close: CHARACTER = '}'

	token_array_open: CHARACTER = '['
	token_array_close: CHARACTER = ']'

	token_double_quote: CHARACTER = '"'
	token_plus: CHARACTER = '+'
	token_minus: CHARACTER = '-'
	token_dot: CHARACTER = '.'
	token_exp: CHARACTER = 'e'
	token_comma: CHARACTER = ','
	token_colon: CHARACTER = ':'

feature -- Status report

	is_open_token (c: CHARACTER): BOOLEAN
			-- Characters which open a type	
		do
			inspect c
			when token_object_open, token_array_open, token_double_quote, token_plus, token_minus, token_dot then
				Result := True
			else

			end
		end

	is_close_token (c: CHARACTER): BOOLEAN
			-- Characters which close a type	
		do
			inspect c
			when token_object_close, token_array_close, token_double_quote then
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
			when '"', '%H' , '/', '%B', '%F', '%N', '%R', '%T' then -- '%H' = '\' =  reverse solidus
				Result := True
			else

			end
		end

   is_special_control (c: CHARACTER): BOOLEAN
           -- Control Characters
           -- \b\f\n\r\t
		do
			inspect c
			when 'b', 'f', 'n', 'r', 't' then
				Result := True
			else

			end
		end

	is_exp_token (c: CHARACTER): BOOLEAN
			-- Is number exposant token?
		do
			Result := c = token_exp or else c.as_lower = token_exp
		end

note
	copyright: "2010-2014, Javier Velilla and others https://github.com/eiffelhub/json."
	license: "https://github.com/eiffelhub/json/blob/master/License.txt"
end
