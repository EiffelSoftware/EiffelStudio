indexing
	description: "Abstract description of an Eiffel operand of a routine object"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	OPERAND_AS

inherit
	EXPR_AS

create
	initialize

feature {NONE} -- Initialization

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

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_operand_as (Current)
		end

feature -- Attributes

	class_type: TYPE_AS
			-- Type from which the feature comes if specified

	target : ACCESS_AS
			-- Name of target of delayed call

	expression: EXPR_AS
			-- Object expression given at routine object evaluation

feature -- Location

	start_location: LOCATION_AS is
			-- Starting point for current construct.
		do
			if class_type /= Void then
				Result := class_type.start_location
			elseif target /= Void then
				Result := target.start_location
			elseif expression /= Void then
				Result := expression.start_location
			else
				Result := null_location
			end
		end
		
	end_location: LOCATION_AS is
			-- Ending point for current construct.
		do
			if class_type /= Void then
				Result := class_type.end_location
			elseif target /= Void then
				Result := target.end_location
			elseif expression /= Void then
				Result := expression.end_location
			else
				Result := null_location
			end
		end

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
			Result := (expression = Void) and then (target = Void)
		ensure
			Result = (expression = Void) and then (target = Void)
		end

end -- class OPERAND_AS

