
-- To be filled from parser with start, end position and reference to AST,
-- AST being STONABLE

class CLICK_AST 

inherit

	AST_YACC

feature -- Properties

    start_position: INTEGER;

    end_position: INTEGER;

    node: STONABLE;
        	-- An AST that is stonable

feature -- Setting

	set_node (n: like node) is
			-- Set `node' to `n'.
		do
			node := n
		end;

	pass_click_set is
			-- Pass address of `click_set' and `node_function' to yacc.
		do
			click_indir_getclick_getset ($click_set, $node_function, $start_function)
		end;

	set is
			-- Get positions from yacc.
		do
			start_position := click_indir_yacc_int_arg (0);
			end_position := click_indir_yacc_int_arg (1)
		end;
	
	click_set is
			-- Get `node' from yacc arg.
		do
			node := click_indir_yacc_arg (0)
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

	click_indir_yacc_arg (i: INTEGER): STONABLE is
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
