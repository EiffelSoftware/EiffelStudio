indexing
	description: "Abstract class for unary expression, Bench version"
	date: "$Date$"
	revision: "$Revision$"

deferred class UNARY_AS
	
inherit
	EXPR_AS
		redefine
			type_check, byte_node, format, 
			fill_calls_list, replicate
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

feature {NONE} -- Initialization

	set is
			-- Yacc initialization
		do
			expr ?= yacc_arg (0)
		ensure then
			expr_exists: expr /= Void
		end

feature -- Attributes

	expr: EXPR_AS
			-- Expression

feature -- Properties

	prefix_feature_name: STRING is
			-- Internal name of the prefixed feature
		deferred
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
			feature_b: FEATURE_B
			feature_bs: FEATURE_BS
			depend_unit: DEPEND_UNIT
			vwoe: VWOE
			vkcn3: VKCN3
			vhne: VHNE
			vuex: VUEX
		do
				-- Check operand
			expr.type_check

			last_constrained := context.last_constrained_type
			if last_constrained.is_void then
					-- No call when target is a procedure
				!!vkcn3
				context.init_error (vkcn3)
				Error_handler.insert_error (vkcn3)
					-- Cannot go on here
				Error_handler.raise_error
			elseif last_constrained.is_none then
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
			!!depend_unit.make (last_class.id, prefix_feature)
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
								(context.item, last_class.id).actual_type
			end

			context.replace (prefix_feature_type)

			if last_constrained /= Void and then last_constrained.is_separate then
debug io.putstring ("Now,  In UNARY_AS we perform try-assign on class ")
io.putstring (context.a_class.name_in_upper)
io.putstring (" at feature ")
io.putstring (context.feature_name)
io.new_line
io.putstring ("    ** UNARY_AS We created FEATURE_SB here: <")
io.putstring (feature_b.feature_name)
io.putstring (">%N"); end
				!!feature_bs
				feature_bs.init (prefix_feature)
				feature_bs.set_type (context.item.type_i)
				context.access_line.insert (feature_bs)
			else
				!!feature_b
				feature_b.init (prefix_feature)
				feature_b.set_type (context.item.type_i)
				context.access_line.insert (feature_b)
			end

		end

	byte_node: UNARY_B is
			-- Associated byte code
		do
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
				ctxt.prepare_for_prefix (prefix_feature_name)
				ctxt.put_current_feature
				if ctxt.last_was_printed then
					ctxt.commit
				else
					ctxt.rollback
				end
			end
		end

feature -- Replication

	fill_calls_list (l: CALLS_LIST) is
			-- Find calls to Current.
		local
			new_list: like l
		do
			!!new_list.make
			expr.fill_calls_list (new_list)
			l.merge (new_list)
		end

	replicate (ctxt: REP_CONTEXT): UNARY_AS is
			-- Adapt to replication
		local
			new_expression: like expr
			u: UN_FREE_AS
		do
			new_expression := expr.replicate (ctxt)
			ctxt.adapt_name (prefix_feature_name)
			if prefix_feature_name.is_equal (ctxt.adapted_name) then
				Result := clone (Current)
			else
				!!u
				u.set_prefix_feature_name (ctxt.adapted_name)
				Result := u
			end
			Result.set_expr (new_expression)
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.prepare_for_prefix (prefix_feature_name)
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

end -- class UNARY_AS
