indexing
	description:
			"Abstract description of a elsif clause of a condition %
			%instruction. Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class ELSIF_AS

inherit
	AST_EIFFEL
		redefine
			number_of_breakpoint_slots, 
			is_equivalent, 
			line_number,
			type_check, 
			byte_node
		end

feature {AST_FACTORY} -- Initialization

	initialize (e: like expr; c: like compound; l: INTEGER) is
			-- Create a new ELSIF AST node.
		require
			e_not_void: e /= Void
		do
			expr := e
			compound := c
			line_number := l
		ensure
			expr_set: expr = e
			compound_set: compound = c
			line_number_set: line_number = l
		end

feature -- Attributes

	expr: EXPR_AS
			-- Conditional expression

	compound: EIFFEL_LIST [INSTRUCTION_AS]
			-- Compound

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (expr, other.expr) and
				equivalent (compound, other.compound)
		end

feature -- Access

	line_number: INTEGER

	number_of_breakpoint_slots: INTEGER is
			-- Number of stop points for AST
		do
			Result := 1 -- condition test
			if compound /= Void then
				Result := Result + compound.number_of_breakpoint_slots
			end
		end

feature -- Type check, byte code and dead code removal

	type_check is
			-- Type check an alternative of a conditional instruction
		local
			current_context: TYPE_A
			vwbe2: VWBE2
		do
				-- Type check test first
			expr.type_check

				-- Check conformance to boolean
			current_context := context.item
			if 	not current_context.is_boolean then
				!!vwbe2
				context.init_error (vwbe2)
				vwbe2.set_type (current_context)
				Error_handler.insert_error (vwbe2)
			end

				-- Update the type stack
			context.pop (1)
		
				-- Type check on compound
			if compound /= Void then
				compound.type_check
			end

		end

	byte_node: ELSIF_B is
			-- Associated byte code
		do
			create Result
			Result.set_expr (expr.byte_node)
			if compound /= Void then
				Result.set_compound (compound.byte_node)
			end
			Result.set_line_number (line_number)
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.put_breakable
			ctxt.put_text_item (ti_Elseif_keyword)
			ctxt.put_space
			ctxt.new_expression
			ctxt.format_ast (expr)
			ctxt.put_space
			ctxt.put_text_item_without_tabs (ti_Then_keyword)
			ctxt.indent
			ctxt.set_separator (ti_Semi_colon)
			ctxt.set_new_line_between_tokens
			ctxt.new_line
			if compound /= Void then
				ctxt.format_ast (compound)
			end
			ctxt.new_line
		end

feature {ELSIF_AS} -- Replication

	set_expr (e: like expr) is
		require
			valid_arg: e /= Void
		do
			expr := e
		end

	set_compound (c: like compound) is
		do
			compound := c
		end
			
end -- class ELSIF_AS
