
-- To be filled from parser with start, end position and reference to AST,
-- AST being STONABLE

class CLICK_AST 

inherit

	AST_YACC

feature -- Properties

	start_position: INTEGER;
			-- Start position of clickable

	end_position: INTEGER;
			-- End position of clickable

	node: CLICKABLE_AST;
			-- Node AST that has a position

feature {CLASS_AS} 

	set_node (n: like node) is
			-- Set `node' to `n'.
		do
			node := n
		end;

feature {CLICK_AST} 

	click_set is
			-- Get `node' from yacc arg.
		do
			node := click_indir_yacc_arg (0)
		end;

feature {YACC_LACE, COMPILER_EXPORTER}
	
	set is
			-- Get positions from yacc.
		do
			start_position := click_indir_yacc_int_arg (0);
			end_position := click_indir_yacc_int_arg (1)
		end;

	pass_click_set is
			-- Pass address of `click_set' and `node_function' to yacc.
		do
			click_indir_getclick_getset ($click_set, $node_function, $start_function)
		end;

feature {NONE} -- Implementation

	node_function: like node is 
		do 
			Result := node 
		end;

	start_function: INTEGER is 
		do 
			Result := start_position 
		end


feature {NONE}

	click_indir_getclick_getset (f1, f2, f3: POINTER) is
		external
			"C"
		alias
			"getclick_getset"
		end;

	click_indir_yacc_arg (i: INTEGER): CLICKABLE_AST is
		external
			"C"
		alias
			"yacc_arg"
		end;

	click_indir_yacc_int_arg (i: INTEGER): INTEGER is
		external
			"C"
		alias
			"yacc_int_arg"
		end

end
