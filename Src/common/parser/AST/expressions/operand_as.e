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

feature {NONE} -- Initialization

	set is
			-- Yacc initialization
		do
			class_type ?= yacc_arg (0)
			target ?= yacc_arg (0)
			expression ?= yacc_arg (0)
		end

feature -- Attributes

	class_type: TYPE
			-- Type from which the feature comes if specified

	target : ID_AS
			-- Name of target of delayed call

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

feature -- Status

	is_open : BOOLEAN is
			-- Is it an open operand?
		do
			Result := (expression = Void) and then (target = Void)
		ensure
			Result = (expression = Void) and then (target = Void)
		end

feature {OPERAND_AS}

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

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			-- FIXME
		end

end -- class OPERAND_AS

