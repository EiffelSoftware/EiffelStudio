indexing
	description: "Abstract class for binary expression nodes, Bench version"
	date: "$Date$"
	revision: "$Revision$"

deferred class BINARY_AS

inherit
	EXPR_AS
		redefine
			type_check, byte_node, format,
			fill_calls_list, replicate
		end

	SHARED_ARG_TYPES

feature {NONE} -- Initialization

	set is
			-- Yacc initialization
		do
			left ?= yacc_arg (0)
			right ?= yacc_arg (1)
		ensure then
			left_exists: left /= Void
			right_exists: right /= Void
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

	balanced_result: BOOLEAN is
			-- is the result of the infix operation subject to the
			-- balancing rule ?
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

	operator_is_keyword: BOOLEAN is
		do
			Result := true
		end

	operator_is_special: BOOLEAN is 
		do
			Result := false
		end

	operator_name: STRING is
		do
			Result := infix_function_name;	
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
			bit_balance_in_effect, balance_in_effect: BOOLEAN
			infix_function: FEATURE_I
			infix_arg_type, infix_type, left_balance: TYPE_A
			left_type, current_context: TYPE_A
			last_constrained, left_constrained: TYPE_A
			left_id: CLASS_ID
			feature_b: FEATURE_B
			feature_bs: FEATURE_BS
			last_class: CLASS_C
			depend_unit: DEPEND_UNIT
			vwoe: VWOE
			vwoe1: VWOE1
			vhne: VHNE
			vkcn3: VKCN3
			vuex: VUEX
		do
				-- First type check the left operand
			left.type_check

				-- Check if target is not of type NONE
			left_constrained := context.last_constrained_type
			if left_constrained.is_void then
					-- No call when target is a procedure
				!!vkcn3
				context.init_error (vkcn3)
				Error_handler.insert_error (vkcn3)
					-- Cannot go on here
				Error_handler.raise_error
			elseif left_constrained.is_none then
				!!vhne
				context.init_error (vhne)
				Error_handler.insert_error (vhne)
					-- Cannot go on here
				Error_handler.raise_error
			end

				-- Check if we have then an infixed function
			last_class := left_constrained.associated_class
			infix_function := last_class.feature_table.item
														(infix_function_name)
			if infix_function = Void then
					-- Error
				!!vwoe
				context.init_error (vwoe)
				vwoe.set_other_class (last_class)
				vwoe.set_op_name (infix_function_name)
				Error_handler.insert_error (vwoe)
					-- Cannot go on here.
				Error_handler.raise_error
			end

				-- Export validity
			if not infix_function.is_exported_for (last_class) then
				!!vuex
				context.init_error (vuex)
				vuex.set_static_class (last_class)
				vuex.set_exported_feature (infix_function)
				Error_handler.insert_error (vuex)
				Error_handler.raise_error
			end

			left_type := context.item
			left_id := last_class.id

				-- Suppliers update
			!!depend_unit.make (left_id, infix_function.feature_id)
			context.supplier_ids.extend (depend_unit)

				-- Then type check the right operand
			right.type_check

				-- Conformance initialization
			Argument_types.init2 (infix_function)
				-- Argument conformance: infix feature must have one argument
			infix_arg_type ?= infix_function.arguments.i_th (1)
			infix_arg_type := infix_arg_type.conformance_type
				-- Instantiation
			infix_arg_type := infix_arg_type.instantiation_in
										(left_type, left_id).actual_type
				-- Conformance: take care of constrained genericity and
				-- of the balancing rule for the simple numeric types
			current_context := context.item
			last_constrained := context.last_constrained_type

				-- Process of the balancing rule
			balance_in_effect := numeric_balance
									(left_constrained, last_constrained)
			bit_balance_in_effect := bit_balance
									(left_constrained, last_constrained)

			if not (
				balance_in_effect
				or else
				bit_balance_in_effect
				or else
				current_context.conform_to (infix_arg_type)
			) then
					-- No conformance on argument of infix 
				!!vwoe1
				context.init_error (vwoe1)
				vwoe1.set_other_class (last_class)
				vwoe1.set_op_name (infix_function_name)
				vwoe1.set_formal_type (infix_arg_type)
				vwoe1.set_actual_type (current_context)
				Error_handler.insert_error (vwoe1)
			end

				-- Update the type stack: instantiate result type of the
				-- infixed feature
			infix_type ?= infix_function.type
			if	last_constrained.is_bits
				and then
				infix_type.is_like_current
			then
					-- For non-balanced features of symbolic class BIT_REF
					-- like infix "^" or infix "#"
				infix_type := left_type
			else
					-- Usual case
				infix_type := infix_type.conformance_type
				infix_type := infix_type.instantiation_in
										(left_type, left_id).actual_type
			end

			context.pop (2)
			if 	(balance_in_effect and then balanced_result)
				or else
				bit_balance_in_effect
			then
				if
					left_constrained.heaviest (last_constrained)
					=
					left_constrained
				then
					infix_type := left_type
				else
					infix_type := current_context
				end
			end
			context.put (infix_type)

			if last_constrained /= Void and then last_constrained.is_separate then
debug io.putstring ("Now,  In BINARY_AS we perform try-assign on class ")
io.putstring (context.a_class.name_in_upper)
io.putstring (" at feature ")
io.putstring (context.feature_name)
io.new_line
io.putstring ("    ** BINARY_AS We created FEATURE_BS here: <")
io.putstring (feature_b.feature_name)
io.putstring (">%N"); end
				!!feature_bs
				feature_bs.init (infix_function)
				feature_bs.set_type (infix_type.type_i)
				context.access_line.insert (feature_bs)
			else
				!!feature_b
				feature_b.init (infix_function)
				feature_b.set_type (infix_type.type_i)
				context.access_line.insert (feature_b)
			end

		end

	byte_node: BINARY_B is
			-- Associated byte node
		local
			access_line: ACCESS_LINE
			feature_b: FEATURE_B
		do
			Result := byte_anchor
			Result.set_left (left.byte_node)
			Result.set_right (right.byte_node)

			access_line := context.access_line
			feature_b ?= access_line.access
			Result.init (feature_b)
			access_line.forth
		end

	byte_anchor: BINARY_B is
		deferred
		end

	bit_balance (left_type, current_context: TYPE_A): BOOLEAN is
			-- Is the bit balance in effect ?
		require
			good_argument: not (	left_type = Void
									or else
									current_context = Void)
			consistency: not (	left_type.is_formal
								or else
								current_context.is_formal)
		do
			Result :=	bit_balanced
						and then
						left_type.is_bits
						and then
						current_context.is_bits
		end

	numeric_balance (left_type, current_context: TYPE_A): BOOLEAN is
			-- Is the numeric balancing rule in effect ?
		require
			good_argument: not (	left_type = Void
									or else
									current_context = Void)
			consistency: not (  left_type.is_formal
								or else
								current_context.is_formal)
		do
			Result :=   balanced
						and then
						left_type.is_numeric
						and then
						current_context.is_numeric
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
				ctxt.prepare_for_infix (operator_name, right)
				ctxt.put_current_feature
				if not ctxt.last_was_printed then
					ctxt.rollback
				else
					ctxt.commit
				end
			end
		end

feature -- Replication

	fill_calls_list (l: CALLS_LIST)  is
			
		local
			new_list: like l
		do
			!!new_list.make
			left.fill_calls_list (new_list)
			l.merge (new_list)
			new_list.make
			right.fill_calls_list (new_list)
			l.merge (new_list)
		end


	replicate (ctxt: REP_CONTEXT): BINARY_AS is
			-- Adapt to replication.
		local
			new_left: like left
			b: BIN_FREE_AS
		do
			new_left := left.replicate (ctxt)
			ctxt.adapt_name (infix_function_name)
			if infix_function_name.is_equal (ctxt.adapted_name) then
				Result := clone (Current)
			else
				!!b
				b.set_infix_function_name (ctxt.adapted_name)
				Result := b
			end
			Result.set_left (new_left)
			Result.set_right (right.replicate (ctxt.new_ctxt))
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			left.simple_format (ctxt)
			ctxt.case_prepare_for_infix (operator_name, right)
			ctxt.case_put_infix_feature
		end

feature {BINARY_AS}	-- Replication

	set_left (l: like left) is
		require
			valid_arg: l /= Void
		do
			left := l
		end

	set_right (l: like right) is
		require
			valid_arg: l /= Void
		do
			right := l
		end

end -- class BINARY_AS
