indexing
	description: "Byte code for manifest arrays"
	date: "$Date$"
	revision: "$Revision$"

class ARRAY_CONST_B 

inherit
	EXPR_B
		redefine
			make_byte_code, enlarged, enlarge_tree, is_unsafe,
			optimized_byte_node, calls_special_features, size,
			pre_inlined_code, inlined_byte_code, generate_il,
			allocates_memory, has_call
		end

	PREDEFINED_NAMES
		export
			{NONE} all
		end

	REFACTORING_HELPER
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialize

	make (e: like expressions; t: like type; i: like info) is
			-- New instance of ARRAY_CONST_B initialized with `e' and `t'.
		require
			e_not_void: e /= Void
			t_not_void: t /= Void
			i_not_void: i /= Void
		do
			expressions := e
			type := t
			info := i
		ensure
			expressions_set: expressions = e
			type_set: type = t
			info_set: info = i
		end
		
feature -- Access

	expressions: BYTE_LIST [BYTE_NODE];
			-- Expressions in the array

	type: GEN_TYPE_I;
			-- Generic array type

	info: CREATE_INFO
			-- Info to create manifest array instance

feature -- Status report

	used (r: REGISTRABLE): BOOLEAN is
			-- Is register `r' used in local access ?
		local
			expr: EXPR_B
			i, nb: INTEGER
			l_area: SPECIAL [BYTE_NODE]
			l_expressions: BYTE_LIST [BYTE_NODE]
		do
			l_expressions := expressions
			if l_expressions /= Void then
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
		end

	allocates_memory: BOOLEAN is True;
			-- Current allocates memory.

	has_call: BOOLEAN is
			-- Does current contain a call?
		local
			expr: EXPR_B
		do
			from
				expressions.start
			until
				expressions.after or Result
			loop
				expr ?= expressions.item
				Result := expr.has_call;
				expressions.forth
			end;
		end;

feature -- Code generation

	enlarge_tree is
			-- Enlarge the expressions.
		do
			if expressions /= Void then
				expressions.enlarge_tree;
			end;
		end;

	enlarged: ARRAY_CONST_BL is
			-- Enlarge node
		do
			create Result.make (expressions, type, info)
			Result.enlarge_tree;
		end;

feature -- IL generation

	generate_il is
			-- Generate IL code for manifest arrays.
		local
			real_ty: GEN_TYPE_I
			l_decl_type: CL_TYPE_I
			actual_type, target_type: CL_TYPE_I
			expr: EXPR_B
			base_class: CLASS_C
			local_array: INTEGER
			i: INTEGER
			feat_tbl: FEATURE_TABLE
			make_feat, put_feat: FEATURE_I
		do
			real_ty ?= context.real_type (type)
			target_type ?= real_ty.true_generics.item (1)
			base_class := real_ty.base_class
			feat_tbl := base_class.feature_table
			make_feat := feat_tbl.item_id (make_name_id)
			l_decl_type := il_generator.implemented_type (make_feat.origin_class_id, real_ty)
			
				-- Creation of Array
 			context.add_local (real_ty)
 			local_array := context.local_list.count
 			il_generator.put_dummy_local_info (real_ty, local_array)
			info.generate_il
 			il_generator.generate_local_assignment (local_array)

				-- Call creation procedure of ARRAY
			il_generator.generate_local (local_array)
			il_generator.put_integer_32_constant (1)
 			il_generator.put_integer_32_constant (expressions.count)
 			il_generator.generate_feature_access (l_decl_type, make_feat.origin_feature_id,
 				make_feat.argument_count, make_feat.has_return_value, True)

				-- Find `put' from ARRAY
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
 				il_generator.generate_local (local_array)

 					-- Generate expression
 				expr.generate_il

 				il_generator.put_integer_32_constant (i)
 
 				il_generator.generate_feature_access (l_decl_type, put_feat.origin_feature_id,
 					put_feat.argument_count, put_feat.has_return_value, True)
 				i := i + 1
 				expressions.forth
 			end
 
 			il_generator.generate_local (local_array)
		end

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a manifest array
		local
			real_ty: GEN_TYPE_I;
			f_table: FEATURE_TABLE;
			feat_i: FEATURE_I;
			feat_id: INTEGER;
			expr: EXPR_B;
			target_type: TYPE_I;
			base_class: CLASS_C;
			r_id: INTEGER;
			rout_info: ROUT_INFO
		do
			fixme ("We should use `info' to create byte code")
			real_ty ?= context.real_type (type);
			target_type := real_ty.meta_generic.item (1);
			base_class := real_ty.base_class;
			f_table := base_class.feature_table;
			feat_i := f_table.item_id (make_name_id);
				-- Need to insert expression into
				-- the stack back to front in order
				-- to be inserted into the area correctly
			from
				expressions.finish;
			until
				expressions.before
			loop
				expr ?= expressions.item;
				expr.make_byte_code (ba);
				expressions.back;
			end;
			if base_class.is_precompiled then
				ba.append (Bc_parray);
				r_id := feat_i.rout_id_set.first;
				rout_info := System.rout_info_table.item (r_id);
				ba.append_integer (rout_info.origin);
				ba.append_integer (rout_info.offset);	
				ba.append_short_integer (real_ty.associated_class_type.type_id - 1);
				ba.append_short_integer (context.class_type.static_type_id - 1)
				real_ty.make_gen_type_byte_code (ba, True)
				ba.append_short_integer (-1);
			else
				ba.append (Bc_array);
				ba.append_short_integer (real_ty.associated_class_type.static_type_id - 1);
				ba.append_short_integer (real_ty.associated_class_type.type_id - 1);
				ba.append_short_integer (context.class_type.static_type_id - 1)
				real_ty.make_gen_type_byte_code (ba, True)
				ba.append_short_integer (-1);
				feat_id := feat_i.feature_id;
				ba.append_short_integer (feat_id);
			end;
			ba.append_integer (expressions.count);
		end;

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
	info_not_void: info /= Void

end
