indexing
	description: "Abstract description of an Eiffel operand of a routine object"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	OPERAND_AS

inherit
	EXPR_AS

feature {AST_FACTORY} -- Initialization

	initialize (c: like class_type; t: like target; e: like expression) is
			-- Create a new OPERAND AST node.
		do
			class_type := c
			target := t
			expression := e
		ensure
			class_type_set: class_type = c
			target_set: target = t
			expression_set: expression = e
		end

	initialize_result is
			-- Create a new OPERAND_AST node on `Result'
		require
			not_is_result: not is_result
		do
			is_result := True
		ensure
			is_resul_set: is_result
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_operand_as (Current)
		end

feature -- Attributes

	class_type: EIFFEL_TYPE
			-- Type from which the feature comes if specified

	target : ID_AS
			-- Name of target of delayed call

	is_result: BOOLEAN
			-- Is operand `Result'

	expression: EXPR_AS
			-- Object expression given at routine object evaluation

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (class_type, other.class_type) and then
					  equivalent (target, other.target) and then
					  equivalent (expression, other.expression)
		end

feature

	is_open : BOOLEAN is
			-- Is it an open operand?
		do
			--| FIXME ... and "not Result" ?
			Result := (expression = Void) and then (target = Void)
		ensure
			Result = (expression = Void) and then (target = Void)
		end

feature {OPERAND_AS} -- Duplication

	set_target (t : like target) is
			-- Set `target' to `t'.
		do
			target := t
		end

	set_expression (e : like expression) is
			-- Set `expression' to `e'.
		do
			expression := e
		end

--feature {AST_EIFFEL} -- Output
--
--	simple_format (ctxt: FORMAT_CONTEXT) is
--			-- Reconstitute text.
--		do
--			-- FIXME
--		end

end -- class OPERAND_AS

