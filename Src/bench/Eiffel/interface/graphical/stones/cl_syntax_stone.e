indexing

	description: 
		"Class syntax stone.";
	date: "$Date$";
	revision: "$Revision $"

class CL_SYNTAX_STONE

inherit

	SYNTAX_STONE
		rename
			make as old_make
		redefine
			stone_type, stone_name
		end;
	INTERFACE_W

creation

	make

feature -- Initialization

	make (a_syntax_errori: SYNTAX_ERROR; c: E_CLASS) is
		do
			syntax_error_i := a_syntax_errori;
			associated_class := c
		end;

feature -- Properties

	associated_class: E_CLASS;
		-- Associated class for error

	stone_type: INTEGER is do Result := Class_type end;

	stone_name: STRING is do Result := l_Class end;

end -- class CL_SYNTAX_STONE
