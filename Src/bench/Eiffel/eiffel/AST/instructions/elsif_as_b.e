-- Abstract description of a elsif clause of a condition instruction

class ELSIF_AS

inherit

	AST_EIFFEL
		redefine
			type_check, byte_node,
			find_breakable, format,
			fill_calls_list, replicate
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
		end;

feature -- Debugging

	find_breakable is
		do
			if compound /= Void then
				compound.find_breakable
			end;
			record_break_node
		end


feature -- Formatter
	
	format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.begin;
			ctxt.put_text_item (ti_Elseif_keyword);
			ctxt.put_space;
		   	ctxt.new_expression;
			expr.format (ctxt);
			ctxt.put_space;
			ctxt.put_text_item (ti_Then_keyword);
			ctxt.indent_one_more;
			ctxt.set_separator (ti_Semi_colon);
			ctxt.new_line_between_tokens;
			ctxt.next_line;
			if compound /= Void then
				compound.format (ctxt);
			end;
			ctxt.put_breakable;
			ctxt.commit;
		end;

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
			
feature {ELSIF_AS} -- Replication

	set_expr (e: like expr) is
		require
			valid_arg: e /= Void
		do
			expr := e
		end;

	set_compound (c: like compound) is
		do
			compound := c
		end;
end
