-- Class syntax stone

class CL_SYNTAX_STONE

inherit

	SYNTAX_STONE
		rename
			make as old_make
		redefine
			stone_type, stone_name
		end

creation

	make

feature

	make (a_syntax_errori: SYNTAX_ERROR; c: CLASS_C) is
		do
			syntax_error_i := a_syntax_errori;
			associated_class := c
		end;

	associated_class: CLASS_C;
		-- Associated class for error

	stone_type: INTEGER is do Result := Class_type end;

	stone_name: STRING is do Result := l_Class end;

end
