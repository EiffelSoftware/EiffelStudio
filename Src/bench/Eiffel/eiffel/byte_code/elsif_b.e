-- Byte code for conditional alternative

class ELSIF_B 

inherit

	BYTE_NODE
		redefine
			analyze, generate, enlarge_tree,
			find_assign_result, last_all_in_result
		end;
	VOID_REGISTER
		export
			{NONE} all
		end;
	
feature 

	expr: EXPR_B;
			-- Conditional expression

	compound: BYTE_LIST [BYTE_NODE];
			-- Compound {list of INSTR_B}

	set_expr (e: EXPR_B) is
			-- Assign `e' to `expr'.
		do
			expr := e;
		end;

	set_compound (c: like compound) is
			-- Assign `c' to `compound'.
		do
			compound := c;
		end;

	enlarge_tree is
			-- Enlarge the elsif construct
		do
			expr := expr.enlarged;
			if compound /= Void then
				compound.enlarge_tree;
			end;
		end;

	find_assign_result is
			-- Find all terminal assignments made to Result
		do
			if compound /= Void then
				compound.finish;
				compound.item.find_assign_result;
			end;
		end;

	last_all_in_result: BOOLEAN is
			-- Are all the exit points in the function assignments
			-- in a Result entity ?
		do
			if compound /= Void then
				compound.finish;
				Result := compound.item.last_all_in_result;
			end;
		end;

	analyze is
			-- Builds a proper context (for C code).
		do
			context.init_propagation;
			expr.propagate (No_register);
			expr.analyze;
			expr.free_register;
			if compound /= Void then
				compound.analyze;
			end;
		end;

	generate is
			-- Generate C code in `generated_file'.
		do
			generated_file.putstring (" else {");
			generated_file.new_line;
			generated_file.indent;
			expr.generate;
			generated_file.exdent;
			generated_file.putstring ("if (");
			expr.print_register;
			generated_file.putstring (") {");
			generated_file.new_line;
			if compound /= Void then
				generated_file.indent;
				compound.generate;
				generated_file.exdent;
			end;
			generated_file.putchar ('}');
		end;

end
