indexing

	description: 
		"Array of click stone computed from CLICK_LIST.";
	date: "$Date$";
	revision: "$Revision $"

class CLICK_STONE_ARRAY

inherit

	ARRAY [CLICK_STONE]
		rename
			make as array_make
		end;

creation

	make
	
feature {NONE} -- Initialization

	make (list: CLICK_LIST; 
			ref_class: E_CLASS) is
			-- Create a click_stone array from `list' 
			-- with reference class `ref_class'.
		local
			pos: INTEGER;
			a_click_ast: CLICK_AST;
			clickable: CLICKABLE_AST;
			new_click_stone: CLICK_STONE;
			list_area: SPECIAL [CLICK_AST];
			c: INTEGER;
			stone: STONE;
		do
			if list = Void then
				array_make (1, 0);
			else
				list_area := list.area;
				c := list.count;
				array_make (1, c);
				from
					pos := 1
				until
					pos > c
				loop
					a_click_ast := list_area.item (pos - 1);
					clickable := a_click_ast.node;
					if clickable.is_class then
						!CLASSC_STONE! stone.make 
							(clickable.associated_eiffel_class (ref_class))
					else
						!FEATURE_NAME_STONE! stone.make 
							(clickable.associated_feature_name,
								ref_class)
					end;
					!! new_click_stone.make
						(stone,
						a_click_ast.start_position,
						a_click_ast.end_position);
					put (new_click_stone, pos);
					pos := pos + 1;
				end
			end
		end;

end -- class CLICK_STONE_ARRAY
