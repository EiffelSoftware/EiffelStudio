indexing

	description:
		"Abstract description of an Eiffel expression pointer. %
		%Version for Bench";
	date: "$Date$";
	revision: "$Revision$"

class EXPR_ADDRESS_AS_B

inherit
	EXPR_ADDRESS_AS
		redefine
			is_allowed, expr
		end

	EXPR_AS_B
		redefine
			type_check, byte_node, format,
			fill_calls_list, replicate
		end

	SHARED_TYPES

feature {NONE} -- Implementation

	is_allowed: BOOLEAN is
			-- Is this construct allowed?
		do
			Result := System.address_expression_allowed
		end

feature -- Properties

	expr: EXPR_AS_B
			-- Expression to address

feature -- Type check, byte code and dead code removal

	type_check is
			-- Type check an address access.
		do
			expr.type_check
				-- Replace type of expression by pointer type
			context.replace (pointer_type)
		end

	byte_node: EXPR_ADDRESS_B is
			-- Associated byte code.
		do
			!! Result
			Result.set_expr (expr.byte_node)
		end

	format (ctxt: FORMAT_CONTEXT_B) is
			-- Reconstitute text.
		do
			ctxt.begin
			simple_format (ctxt)
			if ctxt.last_was_printed then
				ctxt.commit
			else
				ctxt.rollback
			end
		end

feature	-- Replication

	set_expr (e: like expr) is
		require
			valid_arg: e /= Void
		do
			expr := e
		end

	fill_calls_list (l: CALLS_LIST) is
		do
			expr.fill_calls_list (l)
		end

	replicate (ctxt: REP_CONTEXT): like Current is
		do
			Result := clone (Current)
			Result.set_expr (expr.replicate (ctxt))
		end

end -- class EXPR_ADDRESS_AS_B
