indexing

	description: 
		"Stone representing a syntax error.";
	date: "$Date$";
	revision: "$Revision $"


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

feature {NONE} -- Initialization

	make (a_syntax_errori: SYNTAX_ERROR) is
 		do
			syntax_error_i := a_syntax_errori
		end;

feature -- Properties
 
	syntax_error_i: SYNTAX_ERROR;

feature -- Access

	file_name: STRING is
			-- The one from SYNTAX_ERROR: where it happened
		do
			Result := syntax_error_i.file_name
		end;

	help_text: LINKED_LIST [STRING] is
		do
			!! Result.make;
			Result.put_front (Interface_names.h_No_help_available)
		end;

	start_position: INTEGER is do Result := syntax_error_i.start_position end;
			-- Stating position of the token involved in the syntax error

	end_position: INTEGER is do Result := syntax_error_i.end_position end;
			-- Ending position of the of the token involved in the syntax
			-- error

	code: STRING is "Syntax error";
			-- Error code

end -- class SYNTAX_STONE
