indexing
	description: "Abstract class for unary expression, Bench version"
	date: "$Date$"
	revision: "$Revision$"

deferred class UNARY_AS
	
inherit
	EXPR_AS
		redefine
			type_check, byte_node, format
		end

	SYNTAX_STRINGS
		export
			{NONE} all
		undefine
			is_equal
		end

feature {AST_FACTORY} -- Initialization

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

feature -- Properties

	prefix_feature_name: STRING is
			-- Internal name of the prefixed feature
		do
			Result := Prefix_str + operator_name + Quote_str
		end

	operator_name: STRING is
		deferred
		end
	
	operator_is_special: BOOLEAN is
		do
			Result := true
		end
	
	operator_is_keyword: BOOLEAN is 
		do
			Result := false
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
			vhne: VHNE
			vuex: VUEX
		do
				-- Check operand
			expr.type_check
			
			last_constrained := context.last_constrained_type
			if last_constrained.is_none then
				!!vhne
				context.init_error (vhne)
				Error_handler.insert_error (vhne)
					-- Cannot go on here
				Error_handler.raise_error
			end

			last_class := last_constrained.associated_class
			prefix_feature := last_class.feature_table.item
														(prefix_feature_name)

			if prefix_feature = Void then
					-- Error: not prefixed function found
				!!vwoe
				context.init_error (vwoe)
				vwoe.set_other_class (last_class)
				vwoe.set_op_name (prefix_feature_name)
				Error_handler.insert_error (vwoe)
					-- Cannot go on here.
				Error_handler.raise_error
			end

				-- Export validity
			if not prefix_feature.is_exported_for (last_class) then
				!!vuex
				context.init_error (vuex)
				vuex.set_static_class (last_class)
				vuex.set_exported_feature (prefix_feature)
				Error_handler.insert_error (vuex)
				Error_handler.raise_error
			end
 
				-- Suppliers update
			!!depend_unit.make (last_class.class_id, prefix_feature)
			context.supplier_ids.extend (depend_unit)

				-- Assumes here that a prefix feature has no argument
				-- Update the type stack; instantiate the result of the
				-- refixed feature
			prefix_feature_type ?= prefix_feature.type
			if 	last_constrained.is_bits
				and then
				prefix_feature_type.is_like_current
			then
					-- For feature prefix "not" of symbolic class BIT_REF.
				prefix_feature_type := last_constrained
			else
				-- Usual case
				prefix_feature_type := prefix_feature_type.conformance_type
				prefix_feature_type := prefix_feature_type.instantiation_in
								(context.item, last_class.class_id).actual_type
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

	format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.begin
			ctxt.set_insertion_point
			expr.format (ctxt)
			if not ctxt.last_was_printed then
				ctxt.rollback
			else
				ctxt.need_dot
				ctxt.prepare_for_prefix (prefix_feature_name, operator_name)
				ctxt.put_current_feature
				ctxt.put_prefix_space
				if ctxt.last_was_printed then
					ctxt.commit
				else
					ctxt.rollback
				end
			end
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.prepare_for_prefix (prefix_feature_name, operator_name)
			ctxt.put_prefix_feature
			ctxt.put_space
			expr.simple_format (ctxt)
		end

feature {UNARY_AS} -- Replication

	set_expr (e: like expr) is
		require
			valid_arg: e /= Void
		do
			expr := e
		end

feature {NONE} -- Implementation

	internal_byte_node: UNARY_B is
			-- Create typed byte code depending on Current.
		deferred
		end


end -- class UNARY_AS

