-- Class syntax stone

class CL_SYNTAX_STONE

inherit

	SYNTAX_STONE
		redefine
			stone_type, stone_name
		end

creation

	make

feature

	stone_type: INTEGER is do Result := Class_type end;

	stone_name: STRING is do Result := l_Class end;

end
