
-- Element one can click on to select `node': an indirect
-- clicking.

class CLICK_STONE 

creation

	make

feature 

	node: STONE;

	make (a_node: like node; s, e: INTEGER) is
			-- Initialize all attributes with arguments.
		do
			node := a_node;
			start_position := s;
			end_position := e
		end;

	start_position: INTEGER;

	end_position: INTEGER;

	start_focus: INTEGER is
		do
			Result := start_position
		end;

	end_focus: INTEGER is
		do
			Result := end_position
		end

end
