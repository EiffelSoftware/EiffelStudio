indexing

	description:
			"Abstract description of a elsif clause of a condition %
			%instruction. Version for Bench.";
	date: "$Date$";
	revision: "$Revision$"

class ELSIF_AS_B

inherit

	ELSIF_AS
		redefine
			expr, compound
		end;

	AST_EIFFEL_B
		undefine
			line_number
		redefine
			type_check, byte_node,
			find_breakable, 
			fill_calls_list, replicate
		end

feature -- Attributes

	expr: EXPR_AS_B;
			-- Conditional expression

	compound: EIFFEL_LIST_B [INSTRUCTION_AS_B];
			-- Compound

feature -- Type check, byte code and dead code removal

	type_check is
			-- Type check an alternative of a conditional instruction
		local
			current_context: TYPE_A;
			vwbe2: VWBE2;
		do
				-- Type check test first
			expr.type_check;

				-- Check conformance to boolean
			current_context := context.item;
			if 	not current_context.is_boolean then
				!!vwbe2;
				context.init_error (vwbe2);
				vwbe2.set_type (current_context);
				Error_handler.insert_error (vwbe2);
			end;

				-- Update the type stack
			context.pop (1);
		
				-- Type check on compound
			if compound /= Void then
				compound.type_check;
			end;

		end;

	byte_node: ELSIF_B is
			-- Associated byte code
		do
			!!Result;
			Result.set_expr (expr.byte_node);
			if compound /= Void then
				Result.set_compound (compound.byte_node)
			end
			Result.set_line_number (line_number)
		end;

feature -- Debugging

	find_breakable is
		do
			if compound /= Void then
				compound.find_breakable
			end;
			record_break_node
		end

feature	-- Replication

	fill_calls_list (l: CALLS_LIST) is
			-- Find calls to Current
		do
			expr.fill_calls_list (l);
			if compound /= void then
				compound.fill_calls_list (l)
			end
		end;

	replicate (ctxt: REP_CONTEXT): like Current is
		do
			Result :=  clone (Current);
			Result.set_expr (expr.replicate (ctxt));
			if compound /= void then
				Result.set_compound (
					compound.replicate (ctxt))
			end;
		end;
			
end -- class ELSIF_AS_B
