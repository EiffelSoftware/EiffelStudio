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
			type_check, byte_node,
			number_of_breakpoint_slots
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (t: like tag; e: like expr) is
			-- Create a new TAGGED AST node.
		require
			e_not_void: e /= Void
		do
			tag := t
			expr := e
		ensure
			tag_set: tag = t
			expr_set: expr = e
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_tagged_as (Current)
		end

feature -- Access

	number_of_breakpoint_slots: INTEGER is 1
			-- Number of stop points for AST

feature -- Attributes

	tag: ID_AS
			-- Expression tag

	expr: EXPR_AS
			-- Expression

feature -- Location

	start_location: LOCATION_AS is
			-- Start location of Current
		do
			if tag /= Void then
				Result := tag.start_location
			else
				Result := expr.start_location
			end
		end

	end_location: LOCATION_AS is
			-- End location of Current
		do
			Result := expr.end_location
		end
		
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
			expr.type_check
				-- Check if the type of the expression is boolean
			current_context := context.item
			if not current_context.is_boolean then
				create vwbe3
				context.init_error (vwbe3)
				vwbe3.set_type (current_context)
				vwbe3.set_location (expr.end_location)
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
			Result.set_line_number (expr.start_location.line)
		end

invariant
	expr_not_void: expr /= Void

end -- class TAGGED_AS
