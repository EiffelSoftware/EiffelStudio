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
			type_check, byte_node,
			fill_calls_list, replicate
		end

	SHARED_TYPES
	SHARED_EVALUATOR

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

feature -- Attributes

	class_type: TYPE
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
					!!open_type
					context.put (open_type)
				end
			end
		end

	byte_node: EXPR_B is
			-- Associated byte code.
		do
			if class_type /= Void then
				!OPERAND_B!Result
			else
				if expression /= Void then
					Result := expression.byte_node
				else
					!OPERAND_B!Result
				end
			end
		end

feature -- Replication

	fill_calls_list (l: CALLS_LIST) is
			-- find calls to Current
		do
			if target /= Void then
				l.add (target)
			else
				if expression /= Void then
					expression.fill_calls_list (l)
				end
			end
		end

	replicate (ctxt: REP_CONTEXT): like Current is
			-- Adapt to replication
		do
			Result := Clone (Current)

			if target /= Void then
				ctxt.adapt_name (target)
				Result.set_target (ctxt.adapted_name)
			end

			if expression /= Void then
				Result.set_expression (expression.replicate (ctxt.new_ctxt))
			end
		end

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
			if class_type /= Void then
					-- We print an open operand on `class_type'
				ctxt.put_text_item (Ti_L_curly)
				ctxt.format_ast (class_type)
				ctxt.put_text_item (Ti_R_curly)
			else
				if expression /= Void then
						-- Closed operand on an expression
					expression.format (ctxt)
				else
					if target /= Void then
							-- Closed operand on a target
						ctxt.format_ast (target)
					else
							-- This is an open operand without
							-- any `class_type'
						ctxt.put_text_item (Ti_question)
					end
				end
			end
		end

feature {OPERAND_AS, ROUTINE_CREATION_AS} -- Type

	type_a : CL_TYPE_A is
			-- Type of operand
		do
			if computed_type = Void then
				compute_type
			end

			Result := computed_type
		end

feature {NONE}  -- Type

	computed_type : CL_TYPE_A
			-- Type of operand

	compute_type is
			-- Compute `computed_type'.
		require
			class_type_exists: class_type /= Void
		local
			a_class: CLASS_C
			a_feature: FEATURE_I
			a_table: FEATURE_TABLE
			any_type: CL_TYPE_A
			ttype: TYPE_A
			gen_type: GEN_TYPE_A
			formal_type: FORMAL_A
			formal_dec: FORMAL_DEC_AS
			formal_position: INTEGER
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
				!!not_supported
				context.init_error (not_supported)
				not_supported.set_message ("Type qualifiers in delayed calls may not involve anchors.")
				Error_handler.insert_error (not_supported)
				Error_handler.raise_error
			end

			-- If it is a formal generic use its
			-- constraint if it has one or ANY otherwise.
			
			if ttype.is_formal then
				formal_type ?= ttype
				formal_position := formal_type.position
				-- Get the corresponding constraint type 
				-- of the current class
				formal_dec := a_class.generics.i_th (formal_position)
				if formal_dec.has_constraint then
					ttype := formal_dec.constraint_type
				else
					!!any_type
					any_type.set_base_class_id (System.any_id)
					ttype := any_type
				end
			end

			if ttype.is_basic then
				-- Not supported. May change in the future - M.S.
				-- Reason: We cannot call a feature with basic
				-- call target!
				!!not_supported
				context.init_error (not_supported)
				not_supported.set_message ("Type qualifiers in delayed calls may not be a basic type.")
				Error_handler.insert_error (not_supported)
				Error_handler.raise_error
			end

			gen_type ?= ttype
			if gen_type /= Void then
				System.instantiator.dispatch (gen_type, context.current_class)
			end

			ttype.reset_constraint_error_list
			ttype.check_constraints (context.current_class)
			if not ttype.constraint_error_list.is_empty then
				create vtcg3
				vtcg3.set_class (context.current_class)
				vtcg3.set_feature (context.current_feature)
				vtcg3.set_entity_name (target)
				vtcg3.set_error_list (ttype.constraint_error_list)
				Error_handler.insert_error (vtcg3)
			end

			-- Assignment attempt cannot fail
			computed_type ?= ttype
			Error_handler.checksum
		end

end -- class OPERAND_AS

