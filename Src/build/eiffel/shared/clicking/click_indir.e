
-- Element one can click on to select `node': an indirect
-- clicking.

class CLICK_INDIR 

inherit

	CLICK_ELEM

creation

	make

feature 

	make (a_node: like node; s, e: INTEGER) is
			-- Initialize all attributes with arguments.
		do
			node := a_node;
			start_position := s;
			end_position := e
		end;

	set_node (a_node: like node) is
			-- Assign `a_node' to `node'.
		do
			node := a_node
		ensure
			assigned: node = a_node
		end;

	node: ANY;
		-- A node is indirectly referenced
		-- A STONABLE in CLICK_AST
		-- A STONE in CLICK_STONE after processing of the click_list (after further compilation
		-- and on demand).

feature {NONE}

	node_function: like node is do Result := node end;

	start_function: INTEGER is do Result := start_position end

end
