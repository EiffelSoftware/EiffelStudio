-- Abstract description of a tagged expression

class TAGGED_AS

inherit

	EXPR_AS
		redefine
			type_check, byte_node, format,
			fill_calls_list, replicate
		end

feature -- Attributes

	tag: ID_AS;
			-- Expression tag

	expr: EXPR_AS;
			-- Expression

feature -- Initialization

	set is
			-- Yacc initialization
		do
			tag ?= yacc_arg (0);
			expr ?= yacc_arg (1);
		ensure then
			expr_exists: expr /= Void;
		end;

feature -- Type check, byte code and dead code removal

	type_check is
			-- Type check on the expression
		local
			current_context: TYPE_A;
		do
			expr.type_check;
				-- Check if the type of the expression is boolean
			current_context := context.item;
			if not current_context.conform_to (expression_type) then
				make_error (current_context);
			end;
				
				-- Update the type stack
			context.pop (1);
		end;

	byte_node: ASSERT_B is
			-- Associated byte code
		do
			!!Result;
			Result.set_tag (tag);
			Result.set_expr (expr.byte_node);
		end;

	expression_type: TYPE_A is
			-- Type expression
		do
			Result := Boolean_type;
		end;
	
	make_error (t: TYPE_A) is
			-- Raise error
		local
			vwbe3: VWBE3;
		do
			!!vwbe3;
			context.init_error (vwbe3);
			vwbe3.set_type (t);
			Error_handler.insert_error (vwbe3);
		end;

	format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.begin;
			if tag /= void then
				ctxt.put_string(tag);
				ctxt.put_special(": ");
			end;
			ctxt.new_expression;
			expr.format (ctxt);
			if ctxt.last_was_printed then
				ctxt.commit;
			else
				ctxt.rollback;
			end;
		end;

feature	-- Replication

	fill_calls_list (l: CALLS_LIST) is
			-- find calls to Current
		local
			new_list: like l;
		do
			!!new_list.make;
			expr.fill_calls_list (new_list);
			l.merge (new_list)
		end;

	replicate (ctxt: REP_CONTEXT): like Current is
			-- adapt to replication
		do
			Result := twin;
			Result.set_expr (expr.replicate (ctxt))
		end;

feature {TAGGED_AS}	-- Replication

	set_expr (e: like expr) is
		do
			expr := e;
		end
	
end
