indexing
	description: 
		"AST representation of a call as an instruction"
	date: "$Date$"
	revision: "$Revision$"

class
	INSTR_CALL_AS

inherit
	INSTRUCTION_AS

feature {AST_FACTORY} -- Initialization

	initialize (c: like call; l: like location) is
			-- Create a new INSTR_CALL AST node.
		require
			c_not_void: c /= Void
			l_not_void: l /= Void
		do
			call := c
			location := clone (l)
		ensure
			call_set: call = c
			location_set: location.is_equal (l)
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_instr_call_as (Current)
		end

feature -- Attributes

	call: CALL_AS
			-- Call instruction

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
--			ctxt.put_breakable;
--			ctxt.format_ast (call)
--		end

feature {INSTR_CALL_AS, ROUTINE_AS} -- Replication

	set_call (c: like call) is
			-- Set `call' to `c'.
		require
			valid_arg: c /= Void
		do
			call := c;
		end

end -- class INSTR_CALL_AS
