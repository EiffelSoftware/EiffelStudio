indexing
	description:
		"Abstract description of a call as an expression. %
		%Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class EXPR_CALL_AS

inherit
	EXPR_AS
		redefine
			type_check, byte_node
		end

feature {AST_FACTORY} -- Initialization

	initialize (c: like call) is
			-- Create a new EXPR_CALL AST node.
		require
			c_not_void: c /= Void
		do
			call := c
		ensure
			call_set: call = c
		end

feature -- Attributes

	call: CALL_AS
			-- Expression call

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (call, other.call)
		end

feature -- Type check, byte code and dead code removal

	type_check is
			-- Type check of a call as an expression.
		local
			expr_type: TYPE_A
			vkcn3: VKCN3
		do
				-- Put an actual type of the current analyzed class
			context.begin_expression

				-- Type check the call
			call.type_check
			expr_type := context.last_constrained_type
			if expr_type.is_void then
				create vkcn3
				context.init_error (vkcn3)
				error_handler.insert_error (vkcn3)
				error_handler.raise_error	
			end
		end

	byte_node: CALL_B is
			-- Associated byte code.
		do
			Result := call.byte_node
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.format_ast (call)
		end

feature {EXPR_CALL_AS, OPERAND_AS}

	set_call (c: like call) is
		require
			valid_arg: c /= Void
		do
			call := c
		end

end -- class EXPR_CALL_AS

