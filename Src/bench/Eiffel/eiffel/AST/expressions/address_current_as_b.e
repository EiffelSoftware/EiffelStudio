class ADDRESS_CURRENT_AS

inherit

	EXPR_AS
		redefine
			type_check, byte_node, format
		end

feature

	set is
			-- Yacc initialization
		do
			-- Do nothing
		end;

feature -- Type check, byte code and dead code removal

	type_check is
			-- Type check an adress access on Current
		do
			context.begin_expression;
		end;

	byte_node: HECTOR_B is
			-- Byte code for current node
		local
			current_access: CURRENT_B;
		do
			!!current_access;
			!!Result.make (current_access);
		end;

	format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.put_special("$");
			ctxt.put_string("Current");
			ctxt.always_succeed;
		end;	

end
