-- Abstract description of a tagged expression

class TAGGED_AS

inherit

	EXPR_AS
		redefine
			type_check, byte_node
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
			if not context.item.conform_to (expression_type) then
				make_error;
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
	
	make_error is
			-- Raise error
		local
			vwbe3: VWBE3;
		do
			!!vwbe3;
			context.init_error (vwbe3);
			vwbe3.set_assertion (Current);
			Error_handler.insert_error (vwbe3);
		end;
	
end
