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

	make (list: CLICK_LIST; ref_class: E_CLASS) is
			-- Create a click_stone array from `list' 
			-- with reference class `ref_class'.
		local
			pos: INTEGER;
			a_click_ast: CLICK_AST;
			clickable: CLICKABLE_AST;
			new_click_stone: CLICK_STONE;
			c: INTEGER;
			stone: STONE;
			local_copy: like Current
		do
			if list = Void then
				array_make (1, 0);
			else
				local_copy := Current
				c := list.count;
				array_make (1, c);
				from
					pos := 1
				until
					pos > c
				loop
					a_click_ast := list.i_th (pos);
					clickable := a_click_ast.node;
					if clickable.is_class or else clickable.is_precursor then
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
					local_copy.put (new_click_stone, pos);
					pos := pos + 1;
				end
			end
		end;

end -- class CLICK_STONE_ARRAY
