
-- Abstract class for unary expression

deferred class UNARY_AS
	
inherit

	EXPR_AS
		redefine
			type_check, byte_node
		end

feature -- Attributes

	expr: EXPR_AS;
			-- Expression

feature -- Initialization

	set is
			-- Yacc initialization
		do
			expr ?= yacc_arg (0);
		ensure then
			expr_exists: expr /= Void;
		end;

feature -- Type check

	prefix_feature_name: STRING is
			-- Internal name of the prefixed feature
		deferred
		end;

feature -- Type check, byte code and dead code removal

	type_check is
			-- Check the unary instruction
		local
			prefix_feature: FEATURE_I;
			prefix_feature_type, last_constrained: TYPE_A;
			last_class: CLASS_C;
			feature_b: FEATURE_B;
			depend_unit: DEPEND_UNIT;
			vwoe: VWOE;
			vkcn: VKCN;
			vhne: VHNE;
		do
				-- Check operand
			expr.type_check;

			last_constrained := context.last_constrained_type;
			if last_constrained.is_void then
					-- No call when target is a procedure
				!!vkcn;
				context.init_error (vkcn);
				vkcn.set_node (Current);
				Error_handler.insert_error (vkcn);
					-- Cannot go on here
				Error_handler.raise_error;
			elseif last_constrained.is_none then
				!!vhne;
				context.init_error (vhne);
				Error_handler.insert_error (vhne);
					-- Cannot go on here
				Error_handler.raise_error;
			end;

			last_class := last_constrained.associated_class;
			prefix_feature := last_class.feature_table.item
														(prefix_feature_name);

			if prefix_feature = Void then
					-- Error: not prefixed function found
				!!vwoe;
				context.init_error (vwoe);
				vwoe.set_other_class (last_class);
				vwoe.set_op_name (prefix_feature_name);
				vwoe.set_node (Current);
				Error_handler.insert_error (vwoe);
					-- Cannot go on here.
				Error_handler.raise_error;
			end;

				-- Suppliers update
			!!depend_unit.make (last_class.id, prefix_feature.feature_id);
			context.supplier_ids.add (depend_unit);

				-- Assumes here that a prefix feature has no argument
				-- Update the type stack; instantiate the result of the
				-- refixed feature
			prefix_feature_type ?= prefix_feature.type;
			if 	last_constrained.is_bits
				and then
				prefix_feature_type.is_like_current
			then
					-- For feature prefix "not" of symbolic class BIT_REF.
				prefix_feature_type := last_constrained;
			else
				-- Usual case
				prefix_feature_type := prefix_feature_type.conformance_type;
				prefix_feature_type := prefix_feature_type.instantiation_in
								(context.item, last_class.id).actual_type;
			end;

			context.change_item (prefix_feature_type);

			!!feature_b;
			feature_b.init (prefix_feature);
			feature_b.set_type (context.item.type_i);
			context.access_line.insert (feature_b);

		end;

	byte_node: UNARY_B is
			-- Associated byte code
		do
		ensure then
			False
		end;

end
