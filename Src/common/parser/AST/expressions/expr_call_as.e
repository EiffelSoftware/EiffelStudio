-- Abstract description of a call as an expression

class EXPR_CALL_AS

inherit

	EXPR_AS
		redefine
			type_check, byte_node, format,
			 fill_calls_list, replicate
		end

feature -- Attributes

	call: CALL_AS;
			-- Expression call

feature -- Inialization

	set is
			-- Yacc initialization
		do
			call ?= yacc_arg (0);
		ensure then
			call_exists: call /= Void;
		end;

feature -- Type check, byte code and dead code removal

	type_check is
			-- Type check of a call as an expression
		do
				-- Put an actual type of the current analyzed class
			context.begin_expression;
				-- Type check the call
			call.type_check;
		end;

	byte_node: CALL_B is
			-- Associated byte code
		do
			Result := call.byte_node;
		end;

	format(ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			call.format (ctxt);
		end;


feature	-- Replication

	fill_calls_list (l: CALLS_LIST) is
			-- find calls to Current
		do
			call.fill_calls_list (l);
		end;

	replicate (ctxt: REP_CONTEXT): like Current is
			-- Adapt to replication
		do
			Result := twin;
			Result.set_call (call.replicate (ctxt));
		end;

feature {EXPR_CALL_AS}

	set_call (c: like call) is
		require
			valid_arg: c /= Void
		do
			call := c;
		end
end
