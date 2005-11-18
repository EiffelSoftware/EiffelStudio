indexing
	description: "Byte code for manifest tuples"
	date: "$Date$"
	revision: "$Revision$"

class TUPLE_CONST_B

inherit
	EXPR_B
		redefine
			enlarged, enlarge_tree, is_unsafe,
			optimized_byte_node, calls_special_features, size,
			pre_inlined_code, inlined_byte_code, generate_il,
			allocates_memory, has_call, is_constant_expression
		end

	PREDEFINED_NAMES
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (e: like expressions; t: like type) is
			-- New instance of TUPLE_CONST_B
		require
			e_not_void: e /= Void
			t_not_void: t /= Void
		do
			expressions := e
			type := t
		ensure
			expressions_set: expressions = e
			type_set: type = t
		end

feature -- Visitor

	process (v: BYTE_NODE_VISITOR) is
			-- Process current element.
		do
			v.process_tuple_const_b (Current)
		end

feature -- Access

	expressions: BYTE_LIST [BYTE_NODE];
			-- Expressions in the tuple

	type: TUPLE_TYPE_I;

feature -- Settings

	set_expressions (e: like expressions) is
			-- Assign `e' to `expressions'.
		do
			expressions := e;
		end;

	set_type (t: like type) is
			-- Assign `t' to `type'.
		do
			type := t;
		end;

feature -- Status report

	used (r: REGISTRABLE): BOOLEAN is
			-- Is register `r' used in local access ?
		local
			expr: EXPR_B
			i, nb: INTEGER
			l_area: SPECIAL [BYTE_NODE]
			l_expressions: like expressions
		do
			l_expressions := expressions
			from
				l_area := l_expressions.area
				nb := l_expressions.count
			until
				i = nb or Result
			loop
				expr ?= l_area.item (i)
				check
					expr_not_void: expr /= Void
				end
				Result := expr.used (r)
				i := i + 1
			end
		end

	allocates_memory: BOOLEAN is True;
			-- Current allocates memory.

	has_call: BOOLEAN is
			-- Does current contain a call?
		local
			expr: EXPR_B
			l_expressions: like expressions
		do
			from
				l_expressions := expressions
				l_expressions.start
			until
				l_expressions.after or Result
			loop
				expr ?= l_expressions.item
				check expr_not_void: expr /= Void end
				Result := expr.has_call
				l_expressions.forth
			end
		end

	is_constant_expression: BOOLEAN is
			-- Is current array only made of constant expressions?
		local
			expr: EXPR_B
			l_expressions: like expressions
		do
			from
				l_expressions := expressions
				Result := True
				l_expressions.start
			until
				l_expressions.after or not Result
			loop
				expr ?= l_expressions.item
				check expr_not_void: expr /= Void end
				Result := expr.is_constant_expression
				l_expressions.forth
			end
		end

feature -- Code generation

	enlarge_tree is
			-- Enlarge the expressions.
		do
			expressions.enlarge_tree
		end

	enlarged: TUPLE_CONST_BL is
			-- Enlarge node
		do
			create Result.make (expressions, type)
			Result.enlarge_tree
		end;

feature -- IL generation

	generate_il is
			-- Generate IL code for manifest tuple.
		local
			real_ty: GEN_TYPE_I
			l_decl_type: CL_TYPE_I
			actual_type: CL_TYPE_I
			expr: EXPR_B
			base_class: CLASS_C
			local_tuple: INTEGER
			i: INTEGER
			feat_tbl: FEATURE_TABLE
			make_feat, put_feat: FEATURE_I
		do
			real_ty ?= context.real_type (type)
			base_class := real_ty.base_class
			feat_tbl := base_class.feature_table
			make_feat := feat_tbl.item_id (Default_create_name_id)
			l_decl_type := il_generator.implemented_type (make_feat.origin_class_id, real_ty)

				-- Creation of Array
 			context.add_local (real_ty)
 			local_tuple := context.local_list.count
 			il_generator.put_dummy_local_info (real_ty, local_tuple)
			(create {CREATE_TYPE}.make (real_ty)).generate_il
 			il_generator.generate_local_assignment (local_tuple)

				-- Call creation procedure of TUPLE
			il_generator.generate_local (local_tuple)
 			il_generator.generate_feature_access (l_decl_type, make_feat.origin_feature_id,
 				make_feat.argument_count, make_feat.has_return_value, True)

				-- Find `put' from TUPLE
			put_feat := feat_tbl.item_id (put_name_id)
			l_decl_type := il_generator.implemented_type (put_feat.origin_class_id, real_ty)

 			from
 				expressions.start
 				i := 1
 			until
 				expressions.after
 			loop
 				expr ?= expressions.item
 				actual_type ?= context.real_type (expr.type)

 					-- Prepare call to `put'.
 				il_generator.generate_local (local_tuple)

 					-- Generate expression
 				expr.generate_il
 				if actual_type /= Void and then actual_type.is_expanded then
 						-- We generate a metamorphosed version of type.
 					expr.generate_il_metamorphose (actual_type, Void, True)
 				end

 				il_generator.put_integer_32_constant (i)

 				il_generator.generate_feature_access (l_decl_type, put_feat.origin_feature_id,
 					put_feat.argument_count, put_feat.has_return_value, True)
 				i := i + 1
 				expressions.forth
 			end

 			il_generator.generate_local (local_tuple)
		end

feature -- Array optimization

	calls_special_features (array_desc: INTEGER): BOOLEAN is
		do
			Result := expressions.calls_special_features (array_desc)
		end

	is_unsafe: BOOLEAN is
		do
			Result := expressions.is_unsafe
		end

	optimized_byte_node: like Current is
		do
			Result := Current
			expressions := expressions.optimized_byte_node
		end

feature -- Inlining

	size: INTEGER is
		do
			Result := expressions.size + 1
		end

	pre_inlined_code: like Current is
		do
			Result := Current
			expressions := expressions.pre_inlined_code
		end

	inlined_byte_code: like Current is
		do
			Result := Current
			expressions := expressions.inlined_byte_code
		end

invariant
	expressions_not_void: expressions /= Void
	type_not_void: type /= Void

end
