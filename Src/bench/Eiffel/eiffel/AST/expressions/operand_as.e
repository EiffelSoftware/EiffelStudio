indexing
	description: "Abstract description of an Eiffel operand of a routine object"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	OPERAND_AS

inherit
	EXPR_AS
		redefine
			type_check, byte_node
		end

	SHARED_TYPES
	SHARED_EVALUATOR

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

feature -- Type check, byte code and dead code removal

	type_check is
			-- Only called if operand is a routine argument.
		local
			open_type : OPEN_TYPE_A
		do
			if class_type /= Void then
				context.put (type_a)
			else
				if expression /= Void then
					expression.type_check
				else
					create open_type
					context.put (open_type)
				end
			end
		end

	byte_node: EXPR_B is
			-- Associated byte code.
		do
			if class_type /= Void then
				create {OPERAND_B} Result
			else
				if expression /= Void then
					Result := expression.byte_node
				else
					create {OPERAND_B} Result
				end
			end
		end

feature {OPERAND_AS, ROUTINE_CREATION_AS} -- Type

	type_a : TYPE_A is
			-- Type of operand
		do
			if computed_type = Void then
				compute_type
			end

			Result := computed_type
		end

feature {NONE}  -- Type

	computed_type : TYPE_A
			-- Type of operand

	compute_type is
			-- Compute `computed_type'.
		require
			class_type_exists: class_type /= Void
		local
			a_class: CLASS_C
			a_feature: FEATURE_I
			a_table: FEATURE_TABLE
			ttype: TYPE_A
			not_supported: NOT_SUPPORTED
			vtug: VTUG
			vtcg3: VTCG3
		do
			a_class := context.current_class
			a_table := a_class.feature_table
			a_feature := context.current_feature

			-- First check generic parameters

			ttype ?= class_type.actual_type

			if not ttype.good_generics then
				vtug := ttype.error_generics
				vtug.set_class (a_class)
				vtug.set_feature (context.current_feature)
				vtug.set_location (class_type.start_location)
				Error_handler.insert_error (vtug)
				Error_handler.raise_error
			end

			-- Now solve the type

			ttype := Creation_evaluator.evaluated_type (
										 class_type, a_table, a_feature
													   )
			ttype := ttype.actual_type

			if ttype.has_like then
				-- Not supported - doesn't make sense
				-- anyway.
				create not_supported
				context.init_error (not_supported)
				not_supported.set_message ("Type qualifiers in delayed calls may not involve anchors.")
				not_supported.set_location (class_type.start_location)
				Error_handler.insert_error (not_supported)
				Error_handler.raise_error
			end

			if ttype.is_basic then
				-- Not supported. May change in the future - M.S.
				-- Reason: We cannot call a feature with basic
				-- call target!
				create not_supported
				context.init_error (not_supported)
				not_supported.set_message ("Type qualifiers in delayed calls may not be a basic type.")
				not_supported.set_location (class_type.start_location)
				Error_handler.insert_error (not_supported)
				Error_handler.raise_error
			end

			System.instantiator.dispatch (ttype, context.current_class)

			ttype.reset_constraint_error_list
			ttype.check_constraints (context.current_class)
			if not ttype.constraint_error_list.is_empty then
				create vtcg3
				vtcg3.set_class (context.current_class)
				vtcg3.set_feature (context.current_feature)
				if target /= Void then
					vtcg3.set_entity_name (target.access_name)
				end
				vtcg3.set_error_list (ttype.constraint_error_list)
				vtcg3.set_location (class_type.start_location)
				Error_handler.insert_error (vtcg3)
			end

			-- Assignment attempt cannot fail
			computed_type := ttype
			Error_handler.checksum
		end

end -- class OPERAND_AS

