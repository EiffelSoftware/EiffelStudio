indexing
	description:
		"Abstract description of a tagged expression. %
		%Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class
	TAGGED_AS

inherit
	EXPR_AS
		redefine
			type_check, byte_node, format,
			fill_calls_list, replicate
		end

feature {AST_FACTORY} -- Initialization

	initialize (t: like tag; e: like expr; s: INTEGER) is
			-- Create a new TAGGED AST node.
		require
			e_not_void: e /= Void
		do
			tag := t
			expr := e
			start_position := s
		ensure
			tag_set: tag = t
			expr_set: expr = e
			start_position_set: start_position = s
		end

feature {NONE} -- Initialization

	set is
			-- Yacc initialization
		do
			tag ?= yacc_arg (0)
			expr ?= yacc_arg (1)
			start_position := yacc_position
		ensure then
			expr_exists: expr /= Void
		end

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
			!!Result
			Result.set_tag (tag)
			Result.set_expr (expr.byte_node)
		end

	format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.new_expression
			ctxt.begin
			simple_format (ctxt)
			if ctxt.last_was_printed then
				ctxt.commit
			else
				ctxt.rollback
			end
		end

feature	-- Replication

	fill_calls_list (l: CALLS_LIST) is
			-- find calls to Current
		local
			new_list: like l
		do
			!!new_list.make
			expr.fill_calls_list (new_list)
			l.merge (new_list)
		end

	replicate (ctxt: REP_CONTEXT): like Current is
			-- adapt to replication
		do
			Result := clone (Current)
			Result.set_expr (expr.replicate (ctxt))
		end

feature -- Case Storage

	storage_info (ctxt: FORMAT_CONTEXT): S_TAG_DATA is
		require
			valid_context: ctxt /= Void
			empty_text: ctxt.text.empty
		local
			txt: STRING
		do
			expr.simple_format (ctxt)
			if tag = Void then
				!! Result.make (Void, ctxt.text.image)
			else
				!! Result.make (tag.string_value, ctxt.text.image)
			end
			ctxt.text.wipe_out
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			if tag /= Void then
				ctxt.put_string (tag)
				ctxt.put_text_item_without_tabs (ti_Colon)
				ctxt.put_space
			end
			ctxt.new_expression
			ctxt.format_ast (expr)
		end

feature {TAGGED_AS}	-- Replication

	set_expr (e: like expr) is
		require
			valid_arg: e /= Void
		do
			expr := e
		end
	
end -- class TAGGED_AS
