indexing
	description: "AST represenation of a unary `old' operation."
	date: "$Date$"
	revision: "$Revision$"

class UN_OLD_AS

inherit
	UNARY_AS
		redefine
			simple_format,
			type_check, byte_node, format,
			prefix_feature_name
		end

	SHARED_TYPES

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			--v.process_un_old_as (Current)
		end

feature -- Properties

	prefix_feature_name: STRING is
			-- Internal name of the prefixed feature
		do
		end

	operator_name: STRING is "old"

feature -- Type check, byte code and dead code removal

	type_check is
			-- Type check
		local
			vaol1: VAOL1
			vaol2: VAOL2
			saved_vaol_check: BOOLEAN
		do
			if not context.level1 then
					-- Old expression found somewhere else that in a
					-- postcondition
				create vaol1
				context.init_error (vaol1)
				Error_handler.insert_error (vaol1)
				Error_handler.raise_error
			end

			saved_vaol_check := context.check_for_vaol
			if not saved_vaol_check then
					-- Set flag for vaol check.
					-- Check for an old expression within
					-- an old expression.
				context.set_check_for_vaol (True)
			end
				-- Expression type check
			expr.type_check

			if not saved_vaol_check then
					-- Reset flag for vaol check
				context.set_check_for_vaol (False)
			end
			if 
				context.item.conform_to (Void_type) or else
				context.check_for_vaol
			then
					-- Not an expression
				create vaol2
				context.init_error (vaol2)
				Error_handler.insert_error (vaol2)
			end
		end

	byte_node: UN_OLD_B is
			-- Associated byte code
		local
			old_expr: EXPR_B
		do
			create Result
			old_expr := expr.byte_node
			Result.set_expr (old_expr)
			Result.add_old_expression
		end

	format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text
		do
			ctxt.begin
			ctxt.put_text_item (ti_Old_keyword)
			ctxt.put_space
			expr.format (ctxt)
			if ctxt.last_was_printed then
				ctxt.commit
			else
				ctxt.rollback
			end
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text
		do
			ctxt.put_text_item (ti_Old_keyword)
			ctxt.put_space
			expr.simple_format (ctxt)
		end

feature {NONE} -- Implementation

	internal_byte_node: UN_OLD_B is
			-- Do nothing
		do
			check
				False
			end
		end

end -- class UN_OLD_AS
