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
			byte_node, fill_calls_list, replicate,
			starts_with_parenthesis
		end

	SHARED_TYPES

feature {AST_FACTORY} -- Initialization

	initialize (c: like call; s, l: INTEGER) is
			-- Create a new INSTR_CALL AST node.
		require
			c_not_void: c /= Void
		do
			call := c
			start_position := s
			line_number := l
		ensure
			call_set: call = c
			start_position_set: start_position = s
			line_number_set: line_number = l
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
				!!vkcn1
				context.init_error (vkcn1)
				Error_handler.insert_error (vkcn1)
			end
				-- Update the type stack
			context.pop (1)
		end

	byte_node: INSTR_CALL_B is
			-- Associated byte code
		do
			!!Result
			Result.set_call (call.byte_node)
			Result.set_line_number (line_number)
		end

feature	-- Replication

	fill_calls_list (l: CALLS_LIST) is
			-- find calls to Current
		do
			call.fill_calls_list (l)
		end

	replicate (ctxt: REP_CONTEXT): like Current is
			-- Adapt to replication
		do
			Result := clone (Current)
			Result.set_call (call.replicate (ctxt))
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
