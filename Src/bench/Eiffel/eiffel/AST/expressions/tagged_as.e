indexing
	description	: "Abstract description of a tagged expression. %
				  %Version for Bench."
	date		: "$Date$"
	revision	: "$Revision$"

class
	TAGGED_AS

inherit
	EXPR_AS
		redefine
			type_check, byte_node, format,
			number_of_breakpoint_slots, line_number
		end

feature {AST_FACTORY} -- Initialization

	initialize (t: like tag; e: like expr; s, l: INTEGER; ) is
			-- Create a new TAGGED AST node.
		require
			e_not_void: e /= Void
		do
			tag := t
			expr := e
			start_position := s
			line_number := l
		ensure
			tag_set: tag = t
			expr_set: expr = e
			start_position_set: start_position = s
		end

feature -- Access

	number_of_breakpoint_slots: INTEGER is 1
			-- Number of stop points for AST

	line_number: INTEGER
		-- Line position of assertions

feature -- Attributes

	tag: ID_AS
			-- Expression tag

	expr: EXPR_AS
			-- Expression

	start_position: INTEGER;
			-- Start position of AST

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (tag, other.tag) and then
				equivalent (expr, other.expr)
		end

	is_equiv (other: like Current): BOOLEAN is
			-- Is `other' tagged as equivalent to Current?
		do
			Result := equivalent (tag, other.tag) and then equivalent (expr, other.expr)
		end;	

feature -- Type check, byte code and dead code removal

	type_check is
			-- Type check on the expression
		local
			current_context: TYPE_A
			vwbe3: VWBE3
		do
			Error_handler.set_error_position (start_position)
			expr.type_check
				-- Check if the type of the expression is boolean
			current_context := context.item
			if not current_context.is_boolean then
				!!vwbe3
				context.init_error (vwbe3)
				vwbe3.set_type (current_context)
				Error_handler.insert_error (vwbe3)
			end
				
				-- Update the type stack
			context.pop (1)
		end

	byte_node: ASSERT_B is
			-- Associated byte code
		do
			create Result
			Result.set_tag (tag)
			Result.set_expr (expr.byte_node)
			Result.set_line_number (line_number)
		end

	format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			internal_format (ctxt, not ctxt.is_with_breakable)
		end

	format_without_breakable_marks (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text without creating the breakable marks
		do
			internal_format (ctxt, True)
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.put_breakable
			if tag /= Void then
				ctxt.put_text_item (
					create {ASSERTION_TAG_TEXT}.make (tag.string_value)
				)
				ctxt.put_text_item_without_tabs (ti_Colon)
				ctxt.put_space
			end
			ctxt.new_expression
			ctxt.format_ast (expr)
		end

	internal_format (ctxt: FORMAT_CONTEXT; hide_breakable_marks: BOOLEAN) is
		do
			ctxt.new_expression
			ctxt.begin
			if not hide_breakable_marks then
				ctxt.put_breakable
			end
			if tag /= Void then
				ctxt.put_text_item (
					create {ASSERTION_TAG_TEXT}.make (tag.string_value)
				)
				ctxt.put_text_item_without_tabs (ti_Colon)
				ctxt.put_space
			end
			ctxt.new_expression
			ctxt.format_ast (expr)
			if ctxt.last_was_printed then
				ctxt.commit
			else
				ctxt.rollback
			end
		end

feature {TAGGED_AS}	-- Replication

	set_expr (e: like expr) is
		require
			valid_arg: e /= Void
		do
			expr := e
		end
	
end -- class TAGGED_AS
