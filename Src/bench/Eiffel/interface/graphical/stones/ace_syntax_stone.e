-- Ace syntax stone

class ACE_SYNTAX_STONE

inherit

	SYNTAX_STONE
		redefine
			stone_type, stone_name
		end

creation

	make

feature

	stone_type: INTEGER is do Result := System_type end;

	stone_name: STRING is do Result := l_System end;

end
