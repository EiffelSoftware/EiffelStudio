indexing
	description: "Abstract description of a call as an instruction, %
				%Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class
	INSTR_CALL_AS

inherit
	INSTRUCTION_AS
		redefine
			byte_node, starts_with_parenthesis
		end

	SHARED_TYPES

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

feature -- Type check, byte code and dead code removal

	perform_type_check is
			-- Type check a call as an instruction
		local
			vkcn1: VKCN1
		do
				-- Init type stack
			context.begin_expression
			call.type_check
				-- Check it is a procedure call
			if not context.item.conform_to (Void_type) then
					-- Error
				create vkcn1
				context.init_error (vkcn1)
				Error_handler.insert_error (vkcn1)
			end
				-- Update the type stack
			context.pop (1)
		end

	byte_node: INSTR_CALL_B is
			-- Associated byte code
		do
			create Result
			Result.set_call (call.byte_node)
			Result.set_line_number (line_number)
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.put_breakable
			ctxt.format_ast (call)
		end

feature {INSTR_CALL_AS, CMD, USER_CMD, ROUTINE_AS} -- Replication

	set_call (c: like call) is
			-- Set `call' to `c'.
		require
			valid_arg: c /= Void
		do
			call := c
		end

feature {INTERNAL_AS} -- Status report

	starts_with_parenthesis: BOOLEAN is
			-- Is the first format item a "(".
			-- See: INTERNAL_AS.format_compound.
		local
			nested: NESTED_EXPR_AS
		do
			nested ?= call
			Result := nested /= Void
		end

end -- class INSTR_CALL_AS
