
-- To be filled from parser with start, end position and reference to AST,
-- AST being STONABLE

class CLICK_AST 

inherit

	CLICK_INDIR
		redefine
			node
		end;
	AST_YACC

feature 

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

	node: STONABLE;
		-- An AST is indirectly referenced

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
