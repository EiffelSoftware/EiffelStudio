indexing
	description: "Abstract class for binary expression nodes, Bench version"
	date: "$Date$"
	revision: "$Revision$"

deferred class BINARY_AS

inherit
	EXPR_AS
		redefine
			type_check, byte_node, format
		end

	SHARED_ARG_TYPES

feature {AST_FACTORY} -- Initialization

	initialize (l: like left; r: like right) is
			-- Create a new BINARY AST node.
		require
			l_not_void: l /= Void
			r_not_void: r /= Void
		do
			left := l
			right := r
		ensure
			left_set: left = l
			right_set: right = r
		end

feature -- Attributes

	left: EXPR_AS
			-- Left operand

	right: EXPR_AS
			-- Right opernad

feature -- Properties

	balanced: BOOLEAN is
			-- Is the current binary operation subject to the balancing
			-- rule proper to simple numeric types ?
		do
			-- Do nothing
		end

	bit_balanced: BOOLEAN is
			-- Is the current binary operation subject to the
			-- balancing rule proper to bit types ?
		do
			-- Do nothing
		end

	infix_function_name: STRING is
			-- Internal name of the infix feature associated to the
			-- binary expression
		deferred
		end

	operator_name: STRING is
		do
			Result := infix_function_name;	
		end

	op_name: STRING is
			-- Symbol representing the operator (without the infix).
		deferred
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (left, other.left) and then
				equivalent (right, other.right)
		end

feature -- Type check, byte code and dead code removal

	type_check is
			-- Type check a binary expression
		local
			bit_balance_in_effect: BOOLEAN
			balance_in_effect: BOOLEAN
			infix_function: FEATURE_I
			infix_arg_type: TYPE_A
			infix_type: TYPE_A
			left_type, right_type: TYPE_A
			right_constrained, left_constrained: TYPE_A
			infix_constrained: TYPE_A
			left_id: INTEGER
			last_class: CLASS_C
			depend_unit: DEPEND_UNIT
			vwoe: VWOE
			vwoe1: VWOE1
			vuex: VUEX
			vape: VAPE
		do
				-- First type check the left operand
			left.type_check

				-- Check if target is not of type NONE
			left_type := context.item
			left_constrained := context.last_constrained_type
			if left_constrained.is_none then
				create vuex.make_for_none (infix_function_name)
				context.init_error (vuex)
				Error_handler.insert_error (vuex)
				Error_handler.raise_error
			end

				-- Then type check the right operand
			right.type_check

				-- Conformance: take care of constrained genericity and
				-- of the balancing rule for the simple numeric types
			right_type := context.item
			right_constrained := context.last_constrained_type

				-- Process of the balancing rule
			balance_in_effect := numeric_balance (left_constrained, right_constrained)
			bit_balance_in_effect := bit_balance (left_constrained, right_constrained)

			if balance_in_effect or bit_balance_in_effect then
				infix_constrained := left_constrained.heaviest (right_constrained)
				if infix_constrained = right_constrained then
						-- Make sure that if right hand side is heavier then default_type
						-- is the one from expression.
					left_type := right_type
				end
			else
				infix_constrained := left_constrained
			end

				-- Check if we have then an infixed function
			last_class := infix_constrained.associated_class
			left_id := last_class.class_id
			infix_function := last_class.feature_table.item (infix_function_name)
			if infix_function = Void then
					-- Error
				create vwoe
				context.init_error (vwoe)
				vwoe.set_other_class (last_class)
				vwoe.set_op_name (infix_function_name)
				Error_handler.insert_error (vwoe)
				Error_handler.raise_error
			end

				-- Export validity
			if not infix_function.is_exported_for (last_class) then
				create vuex
				context.init_error (vuex)
				vuex.set_static_class (last_class)
				vuex.set_exported_feature (infix_function)
				Error_handler.insert_error (vuex)
				Error_handler.raise_error
			end

			if
				not System.do_not_check_vape and then
				context.level4 and then context.check_for_vape and then
				not context.current_feature.export_status.is_subset (infix_function.export_status) 
			then
					-- In precondition and checking for vape
				create vape
				context.init_error (vape)
				vape.set_exported_feature (context.current_feature)
				Error_handler.insert_error (vape)
				Error_handler.raise_error
			end

				-- Suppliers update
			create depend_unit.make (left_id, infix_function)
			context.supplier_ids.extend (depend_unit)

				-- Conformance initialization
			Argument_types.init2 (infix_function)
				-- Argument conformance: infix feature must have one argument
			infix_arg_type ?= infix_function.arguments.i_th (1)
			infix_arg_type := infix_arg_type.conformance_type
				-- Instantiation
			infix_arg_type := infix_arg_type.instantiation_in (left_type, left_id).actual_type

			if not right_type.conform_to (infix_arg_type) then
					-- No conformance on argument of infix 
				create vwoe1
				context.init_error (vwoe1)
				vwoe1.set_other_class (last_class)
				vwoe1.set_op_name (infix_function_name)
				vwoe1.set_formal_type (infix_arg_type)
				vwoe1.set_actual_type (right_type)
				Error_handler.insert_error (vwoe1)
			end

				-- Add type to `parameters' in case we will need it later.
			attachment := infix_arg_type

				-- Update the type stack: instantiate result type of the
				-- infixed feature
			infix_type ?= infix_function.type
			if right_constrained.is_bits and then infix_type.is_like_current then
					-- For non-balanced features of symbolic class BIT_REF
					-- like infix "^" or infix "#"
				infix_type := left_type
			else
					-- Usual case
				infix_type := infix_type.conformance_type
				infix_type := infix_type.instantiation_in (left_type, left_id).actual_type
			end

			context.pop (2)
			context.put (infix_type)
			context.access_line.insert (infix_function.access (infix_type.type_i))
		end

	byte_node: BINARY_B is
			-- Associated byte node
		local
			access_line: ACCESS_LINE
			call_access_b: CALL_ACCESS_B
		do
			Result := byte_anchor
			Result.set_left (left.byte_node)
			Result.set_right (right.byte_node)

			access_line := context.access_line
			call_access_b ?= access_line.access
			Result.init (call_access_b)
			Result.set_attachment (attachment.type_i)
			access_line.forth
		end

	byte_anchor: BINARY_B is
		deferred
		end

	bit_balance (left_type, current_context: TYPE_A): BOOLEAN is
			-- Is the bit balance in effect ?
		require
			good_argument: not (left_type = Void or else current_context = Void)
			consistency: not (left_type.is_formal or else current_context.is_formal)
		do
			Result := bit_balanced and then left_type.is_bits and then current_context.is_bits
		end

	numeric_balance (left_type, current_context: TYPE_A): BOOLEAN is
			-- Is the numeric balancing rule in effect ?
		require
			good_argument: not (left_type = Void or else current_context = Void)
			consistency: not (left_type.is_formal or else current_context.is_formal)
		do
			Result := balanced and then left_type.is_numeric and then current_context.is_numeric
		end
	
	format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.begin
			left.format (ctxt)
			if not ctxt.last_was_printed then
				ctxt.rollback
			else
				ctxt.need_dot
				ctxt.prepare_for_infix (operator_name, op_name, right)
				ctxt.put_current_feature
				if not ctxt.last_was_printed then
					ctxt.rollback
				else
					ctxt.commit
				end
			end
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			left.simple_format (ctxt)
			ctxt.prepare_for_infix (operator_name, op_name, right)
			ctxt.put_infix_feature
		end

feature {BINARY_AS}	-- Replication

	attachment: TYPE_A
			-- Type of right expression as defined in Eiffel source.

end -- class BINARY_AS

