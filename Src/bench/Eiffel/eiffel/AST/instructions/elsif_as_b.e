-- Abstract description of a elsif clause of a condition instruction

class ELSIF_AS

inherit

	AST_EIFFEL
		redefine
			type_check, byte_node,
			find_breakable
		end

feature -- Attributes

	expr: EXPR_AS;
			-- Conditional expression

	compound: EIFFEL_LIST [INSTRUCTION_AS];
			-- Compound

feature -- Initialization

	set is
			-- Yacc initialization
		do
			expr ?= yacc_arg (0);
			compound ?= yacc_arg (1);
		ensure then
			expr_exists: expr /= Void
		end;

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
			if 	not context.item.conform_to (Boolean_type) then
				!!vwbe2;
				context.init_error (vwbe2);
				vwbe2.set_clause (Current);
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
		end;

feature -- Debugging

	find_breakable is
		do
			if compound /= Void then
				compound.find_breakable
			end
		end

end
