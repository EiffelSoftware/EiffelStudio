
class SYNTAX_STONE

inherit

	ERROR_STONE
		rename
			make as make_simple_error
		redefine
			code, file_name, help_text
		end

creation

	make

feature

	make (a_syntax_errori: SYNTAX_ERROR) is
 		do
			syntax_error_i := a_syntax_errori
		end;
 
	syntax_error_i: SYNTAX_ERROR;

feature

	file_name: STRING is
            -- The one from SYNTAX_ERROR: where it happened
        do
			Result := syntax_error_i.file_name
        end;

	help_text: STRING is
		do
			Result := l_No_help_available
		end;

	start_position: INTEGER is do Result := syntax_error_i.start_position end;
			-- Stating position of the token involved in the syntax error

	end_position: INTEGER is do Result := syntax_error_i.end_position end;
			-- Ending position of the of the token involved in the syntax
			-- error

	code: STRING is "Syntax error";
			-- Error code

end
