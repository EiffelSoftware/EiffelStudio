indexing
	description: 
		"AST representation of a call as an expression."
	date: "$Date$"
	revision: "$Revision$"

class
	EXPR_CALL_AS

inherit
	EXPR_AS

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

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_expr_call_as (Current)
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

--feature {AST_EIFFEL} -- Output
--
--	simple_format (ctxt: FORMAT_CONTEXT) is
--			-- Reconstitute text.
--		do
--			ctxt.format_ast (call)
--		end

feature {EXPR_CALL_AS}

	set_call (c: like call) is
		require
			valid_arg: c /= Void
		do
			call := c
		end

end -- class EXPR_CALL_AS
