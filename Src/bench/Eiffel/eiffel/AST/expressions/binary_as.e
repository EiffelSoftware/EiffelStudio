indexing
	description: "Abstract class for binary expression nodes, Bench version"
	date: "$Date$"
	revision: "$Revision$"

deferred class BINARY_AS

inherit
	EXPR_AS
		redefine
			type_check, byte_node,
			start_location, end_location
		end

	SHARED_ARG_TYPES

feature {NONE} -- Initialization

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

feature -- Location

	start_location: LOCATION_AS is
			-- Start location of Current
		do
			Result := left.start_location
		end

	end_location: LOCATION_AS is
			-- End location of Current
		do
			Result := right.end_location
		end
		
	operator_location: LOCATION_AS is
			-- Location of operator
		do
			fixme ("This is not precise enough, we ought to have the precise location.")
			Result := left.end_location
		end

feature -- Properties

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
	
	is_infix_valid (a_left_type, a_right_type: TYPE_A; a_name: STRING): BOOLEAN is
			-- Does infix routine `a_name' exists in `a_left_type' and if so is
			-- it valid for `a_right_type'?
		require
			a_left_type_not_void: a_left_type /= Void
			a_right_type_not_void: a_right_type /= Void
			a_name_not_void: a_name /= Void
		local
			l_infix: FEATURE_I
			l_class: CLASS_C
			l_vwoe: VWOE
			l_vwoe1: VWOE1
			l_vuex: VUEX
			l_vape: VAPE
			l_arg_type: TYPE_A
			l_formal: FORMAL_A
			l_left_constrained: TYPE_A
		do
			last_error := Void
			if a_left_type.is_formal then
				l_formal ?= a_left_type
				l_left_constrained := context.current_class.constraint (l_formal.position)
				l_class := l_left_constrained.associated_class
			else
				l_class := a_left_type.associated_class
			end
			l_infix := l_class.feature_table.item (a_name)
			if l_infix = Void then
				create l_vwoe
				context.init_error (l_vwoe)
				l_vwoe.set_other_class (l_class)
				l_vwoe.set_op_name (a_name)
				last_error := l_vwoe
			else
					-- Export validity
				last_infix := l_infix
				if not (context.is_ignoring_export or l_infix.is_exported_for (l_class)) then
					create l_vuex
					context.init_error (l_vuex)
					l_vuex.set_static_class (l_class)
					l_vuex.set_exported_feature (l_infix)
					last_error := l_vuex
				else
					if
						not System.do_not_check_vape and then
						context.is_checking_precondition and then context.check_for_vape and then
						not context.current_feature.export_status.is_subset (l_infix.export_status) 
					then
							-- In precondition and checking for vape
						create l_vape
						context.init_error (l_vape)
						l_vape.set_exported_feature (context.current_feature)
						last_error := l_vape
					else
							-- Conformance initialization
						Argument_types.init2 (l_infix)
							-- Argument conformance: infix feature must have one argument
						l_arg_type ?= l_infix.arguments.i_th (1)
						l_arg_type := l_arg_type.conformance_type
							-- Instantiation
						l_arg_type := l_arg_type.instantiation_in (a_left_type,
							l_class.class_id).actual_type

						if not a_right_type.conform_to (l_arg_type) then
							if a_right_type.convert_to (context.current_class, l_arg_type) then
								last_argument_conversion_info := context.last_conversion_info
								last_arg_type := l_arg_type
							else
									-- No conformance on argument of infix 
								create l_vwoe1
								context.init_error (l_vwoe1)
								l_vwoe1.set_other_class (l_class)
								l_vwoe1.set_op_name (a_name)
								l_vwoe1.set_formal_type (l_arg_type)
								l_vwoe1.set_actual_type (a_right_type)
								last_error := l_vwoe1
							end
						else
							last_arg_type := l_arg_type
						end
					end
				end
			end
			if last_error /= Void then
				last_infix := Void
				last_argument_conversion_info := Void
			else
				Result := True
			end
		end

	last_error: ERROR
	last_infix: FEATURE_I
	last_arg_type: TYPE_A
	last_argument_conversion_info: CONVERSION_INFO
	last_target_conversion_info: CONVERSION_INFO
			-- Helpers to perform type check and byte_node generation.
			-- FIXME: Manu: 03/04/2004: we should remove them from BINARY_AS
			-- and put them in another abstraction.

	type_check is
			-- Type check a binary expression
		local
			infix_type: TYPE_A
			left_type, right_type: TYPE_A
			right_constrained, left_constrained: TYPE_A
			l_target_type: TYPE_A
			left_id: INTEGER
			depend_unit: DEPEND_UNIT
			vuex: VUEX
			l_error: ERROR
		do
				-- First type check the left operand
			left.type_check

				-- Check if target is not of type NONE
			left_type := context.item
			left_constrained := context.last_constrained_type
			if left_constrained.is_none then
				create vuex.make_for_none (infix_function_name)
				context.init_error (vuex)
				vuex.set_location (operator_location)
				Error_handler.insert_error (vuex)
				Error_handler.raise_error
			end

				-- Then type check the right operand
			right.type_check

				-- Conformance: take care of constrained genericity and
				-- of the balancing rule for the simple numeric types
			right_type := context.item
			right_constrained := context.last_constrained_type

			if is_infix_valid (left_type, right_type, infix_function_name) then
			else
				l_error := last_error
				if left_type.convert_to (context.current_class, right_type) then
					last_target_conversion_info := context.last_conversion_info
					if not is_infix_valid (right_type, right_type, infix_function_name) then
						last_target_conversion_info := Void
					end
				end
			end

			if last_infix = Void then
					-- Raise error here
				l_error.set_location (operator_location)
				Error_handler.insert_error (l_error)
				Error_handler.raise_error
			else
					-- Process conversion if any.
				if last_target_conversion_info /= Void then
					left_id := right_constrained.associated_class.class_id
					if parameters_convert_info = Void then
						create parameters_convert_info.make (0, 1)
					end
					parameters_convert_info.put (last_target_conversion_info, 0)
					if last_target_conversion_info.has_depend_unit then
						context.supplier_ids.extend (last_target_conversion_info.depend_unit)
					end
					l_target_type := last_target_conversion_info.target_type
				else
					left_id := left_constrained.associated_class.class_id
					l_target_type := left_type
				end

				if last_argument_conversion_info /= Void then
					if parameters_convert_info = Void then
						create parameters_convert_info.make (0, 1)
					end
					parameters_convert_info.put (last_argument_conversion_info, 1)
					if last_argument_conversion_info.has_depend_unit then
						context.supplier_ids.extend (last_argument_conversion_info.depend_unit)
					end
				end

					-- Suppliers update
				create depend_unit.make_with_level (left_id, last_infix, context.depend_unit_level)
				context.supplier_ids.extend (depend_unit)


					-- Add type to `parameters' in case we will need it later.
				attachment := last_arg_type

					-- Update the type stack: instantiate result type of the
					-- infixed feature
				infix_type ?= last_infix.type
				if
					l_target_type.is_bits and then right_constrained.is_bits and then
					infix_type.is_like_current
				then
						-- For non-balanced features of symbolic class BIT_REF
						-- like infix "^" or infix "#"
					infix_type := l_target_type
				else
						-- Usual case
					infix_type := infix_type.conformance_type
					infix_type := infix_type.instantiation_in (l_target_type, left_id).actual_type
				end

				context.pop (2)
				context.put (infix_type)
				context.access_line.insert (last_infix.access (infix_type.type_i))
			end
		end

	byte_node: EXPR_B is
			-- Associated byte node
		local
			access_line: ACCESS_LINE
			call_access_b: CALL_ACCESS_B
			l_info: CONVERSION_INFO
			l_byte_node: BINARY_B
		do
			l_byte_node := byte_anchor

			if parameters_convert_info /= Void then
				l_info := parameters_convert_info.item (0)
			end
			if l_info /= Void then
				l_byte_node.set_left (l_info.byte_node (left.byte_node))
			else
				l_byte_node.set_left (left.byte_node)
			end

			if parameters_convert_info /= Void then
				l_info := parameters_convert_info.item (1)
			end
			if l_info /= Void then
				l_byte_node.set_right (l_info.byte_node (right.byte_node))
			else
				l_byte_node.set_right (right.byte_node)
			end

			access_line := context.access_line
			call_access_b ?= access_line.access
			l_byte_node.init (call_access_b)
			l_byte_node.set_attachment (attachment.type_i)
			access_line.forth
			
			Result := l_byte_node
		end

	byte_anchor: BINARY_B is
		deferred
		end

feature {BINARY_AS}	-- Replication

	attachment: TYPE_A
			-- Type of right expression as defined in Eiffel source.

feature {NONE} -- Implementation: convertibility

	parameters_convert_info: ARRAY [CONVERSION_INFO]
			-- For each parameters that need a conversion call, we store info used in `byte_node'
			-- to generate conversion call.

invariant
	left_not_void: left /= Void
	right_not_void: right /= Void

end -- class BINARY_AS

