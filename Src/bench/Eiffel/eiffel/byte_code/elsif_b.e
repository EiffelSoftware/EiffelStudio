-- Byte code for conditional alternative

class ELSIF_B 

inherit

	BYTE_NODE
		redefine
			analyze, generate, enlarge_tree,
			find_assign_result, last_all_in_result,
			has_loop, assigns_to, is_unsafe,
			optimized_byte_node, calls_special_features,
			size, pre_inlined_code, inlined_byte_code,
			line_number, set_line_number
		end;
	VOID_REGISTER
		export
			{NONE} all
		end;
	
feature -- Access

	line_number : INTEGER;

feature -- Line number setting

	set_line_number (lnr : INTEGER) is

		do
			line_number := lnr
		ensure then
			line_number_set : line_number = lnr
		end

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
		local
			f: INDENT_FILE
		do
			f := generated_file
			generate_line_info;
			f.putstring (" else {");
			f.new_line;
			f.indent;
			expr.generate;
			f.exdent;
			f.putstring (gc_if_l_paran);
			expr.print_register;
			f.putstring (") {");
			f.new_line;
			if compound /= Void then
				f.indent;
				compound.generate;
				f.exdent;
			end;
			f.putchar ('}');
		end;

feature -- Array optimization

	has_loop: BOOLEAN is
		do
			Result := compound /= Void and then compound.has_loop
		end

	assigns_to (i: INTEGER): BOOLEAN is
		do
			Result := compound /= Void and then compound.assigns_to (i)
		end;

	calls_special_features (array_desc: INTEGER): BOOLEAN is
		do
			Result := (compound /= Void and then
							compound.calls_special_features (array_desc))
				or else expr.calls_special_features (array_desc)
		end

	is_unsafe: BOOLEAN is
		do
			Result := (compound /= Void and then compound.is_unsafe)
				or else expr.is_unsafe
		end

	optimized_byte_node: like Current is
		do
			Result := Current;
			if compound /= Void then
				compound := compound.optimized_byte_node
			end
			expr := expr.optimized_byte_node
		end

feature -- Inlining

	size: INTEGER is
		do
			Result := expr.size + 1;
			if compound /= Void then
				Result := Result + compound.size
			end
		end

	pre_inlined_code: like Current is
		do
			Result := Current
			expr := expr.pre_inlined_code
			if compound /= Void then
				compound := compound.pre_inlined_code
			end
		end

	inlined_byte_code: like Current is
		do
			Result := Current
			expr := expr.inlined_byte_code
			if compound /= Void then
				compound := compound.inlined_byte_code
			end
		end

end
