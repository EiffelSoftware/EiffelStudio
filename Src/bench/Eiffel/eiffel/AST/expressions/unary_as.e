indexing
	description: "Abstract class for unary expression, Bench version"
	date: "$Date$"
	revision: "$Revision$"

deferred class UNARY_AS
	
inherit
	EXPR_AS
		redefine
			type_check, byte_node
		end

	SYNTAX_STRINGS
		export
			{NONE} all
		undefine
			is_equal
		end

feature {NONE} -- Initialization

	initialize (e: like expr) is
			-- Create a new UNARY AST node.
		require
			e_not_void: e /= Void
		do
			expr := e
		ensure
			expr_set: expr = e
		end

feature -- Attributes

	expr: EXPR_AS
			-- Expression

feature -- Location

	start_location: LOCATION_AS is
			-- Start location of Current
		do
			Result := expr.start_location
		end
		
	end_location: LOCATION_AS is
			-- End location of Current
		do
			Result := expr.end_location
		end
		
	operator_location: LOCATION_AS is
			-- Location of operator
		do
			fixme ("Need to store operator location")
			Result := start_location
		end

feature -- Properties

	prefix_feature_name: STRING is
			-- Internal name of the prefixed feature
		do
			Result := Prefix_str + operator_name + Quote_str
		end

	operator_name: STRING is
		deferred
		end
		
	is_minus: BOOLEAN is
			-- Is Current prefix "-"?
		do
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (expr, other.expr)
		end

feature -- Type check, byte code and dead code removal

	type_check is
			-- Check the unary instruction
		local
			prefix_feature: FEATURE_I
			prefix_feature_type, last_constrained: TYPE_A
			last_class: CLASS_C
			depend_unit: DEPEND_UNIT
			vwoe: VWOE
			vuex: VUEX
			vape: VAPE
			l_manifest: MANIFEST_INTEGER_A
			l_value: ATOMIC_AS
		do
				-- Check operand
			expr.type_check
			
			last_constrained := context.last_constrained_type
			if last_constrained.is_none then
				create vuex.make_for_none (prefix_feature_name)
				context.init_error (vuex)
				vuex.set_location (expr.end_location)
				Error_handler.insert_error (vuex)
					-- Cannot go on here
				Error_handler.raise_error
			end

			last_class := last_constrained.associated_class
			prefix_feature := last_class.feature_table.item (prefix_feature_name)

			if prefix_feature = Void then
					-- Error: not prefixed function found
				create vwoe
				context.init_error (vwoe)
				vwoe.set_other_class (last_class)
				vwoe.set_op_name (prefix_feature_name)
				vwoe.set_location (operator_location)
				Error_handler.insert_error (vwoe)
					-- Cannot go on here.
				Error_handler.raise_error
			end

				-- Export validity
			if not (context.is_ignoring_export or prefix_feature.is_exported_for (last_class)) then
				create vuex
				context.init_error (vuex)
				vuex.set_static_class (last_class)
				vuex.set_exported_feature (prefix_feature)
				vuex.set_location (operator_location)
				Error_handler.insert_error (vuex)
				Error_handler.raise_error
			end

			if
				not System.do_not_check_vape and then
				context.is_checking_precondition and then context.check_for_vape and then
				not context.current_feature.export_status.is_subset (prefix_feature.export_status) 
			then
					-- In precondition and checking for vape
				create vape
				context.init_error (vape)
				vape.set_exported_feature (context.current_feature)
				vape.set_location (operator_location)
				Error_handler.insert_error (vape)
				Error_handler.raise_error
			end

				-- Suppliers update
			create depend_unit.make_with_level (last_class.class_id, prefix_feature,
				context.depend_unit_level)
			context.supplier_ids.extend (depend_unit)

				-- Assumes here that a prefix feature has no argument
				-- Update the type stack; instantiate the result of the
				-- refixed feature
			prefix_feature_type ?= prefix_feature.type
			if last_constrained.is_bits and then prefix_feature_type.is_like_current then
					-- For feature prefix "not" of symbolic class BIT_REF.
				prefix_feature_type := last_constrained
			else
				if is_minus then
						-- Let's say if it is a special case the negation of a positive
						-- value in which case we maintain the type of the expression.
						-- E.g. -127 is of type INTEGER_8, not of type INTEGER
						--      -128 is of type INTEGER_16, since 128 is an INTEGER_16
						--      -511 is of type INTEGER_16, not of type INTEGER
						--
						-- FIXME: Manu 02/06/2004: we do not attempt here to ensure
						-- that `-128' is of type INTEGER_8. We will have to wait for ETL3
						-- to tell us what we need to do. The current behavior preserve
						-- compatibility with older version of Eiffel (5.4 and earlier).
					l_manifest ?= last_constrained
					l_value ?= expr
					if l_value /= Void and l_manifest /= Void then
						prefix_feature_type := last_constrained
					else
							-- Usual case
						prefix_feature_type := prefix_feature_type.conformance_type
						prefix_feature_type := prefix_feature_type.instantiation_in
										(context.item, last_class.class_id).actual_type
					end
				else
						-- Usual case
					prefix_feature_type := prefix_feature_type.conformance_type
					prefix_feature_type := prefix_feature_type.instantiation_in
									(context.item, last_class.class_id).actual_type
				end
			end

			context.replace (prefix_feature_type)

			context.access_line.insert (prefix_feature.access (context.item.type_i))
		end

	byte_node: EXPR_B is
			-- Associated byte code
		local
			access_line: ACCESS_LINE
			access_b: ACCESS_B
			unary_b: UNARY_B
			expr_b: EXPR_B
		do
			expr_b := expr.byte_node
			access_line := context.access_line
			access_b := access_line.access

				-- If we have something like `a.f' where `a' is predefined
				-- and `f' is a constant then we simply generate a byte
				-- node that will be the constant only. Otherwise if `a' is
				-- not predefined and `f' is a constant, we generate the
				-- complete evaluation `a.f'. However during generation,
				-- we will do an optimization by hardwiring value of constant.
			if not (access_b.is_constant and expr_b.is_predefined) then
				unary_b := internal_byte_node
				unary_b.set_expr (expr_b)
				unary_b.init (access_b)
				Result := unary_b
			else
				Result := access_b
			end
			access_line.forth
		end

feature {UNARY_AS} -- Replication

	set_expr (e: like expr) is
			-- Set `expr' with `e'.
		require
			valid_arg: e /= Void
		do
			expr := e
		ensure
			expr_set: expr = e
		end

feature {NONE} -- Implementation

	internal_byte_node: UNARY_B is
			-- Create typed byte code depending on Current.
		deferred
		end
		
invariant
	expr_not_void: expr /= Void

end

