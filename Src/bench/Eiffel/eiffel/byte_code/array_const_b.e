-- Byte code for manifest arrays

class ARRAY_CONST_B 

inherit

	EXPR_B
		redefine
			make_byte_code, enlarged, enlarge_tree, is_unsafe,
			optimized_byte_node, calls_special_features, size,
			pre_inlined_code, inlined_byte_code
		end
	
feature 

	expressions: BYTE_LIST [BYTE_NODE];
			-- Expressions in the array

	type: GEN_TYPE_I;
			-- Generic array type

	need_metamorphosis (source_type: TYPE_I): BOOLEAN is
			-- Do we need to issue a metamorphosis on the `source_type'?
		local
			target_type: TYPE_I;
			real_ty: GEN_TYPE_I
		do
			real_ty ?= context.real_type (type);
			target_type := real_ty.meta_generic.item (1); 
			if (not target_type.is_basic) and (source_type.is_basic) then
				Result := True;
			end;
		end;

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

	used (r: REGISTRABLE): BOOLEAN is
		do
		end;

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
			!!Result;
			Result.set_expressions (expressions);
			Result.set_type (type);
			Result.enlarge_tree;
		end;

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a manifest array
		local
			real_ty: GEN_TYPE_I;
			actual_type: CL_TYPE_I;
			f_table: FEATURE_TABLE;
			feat_i: FEATURE_I;
			feat_id: INTEGER;
			expr: EXPR_B;
			target_type: TYPE_I;
			basic_i: BASIC_I;
			base_class: CLASS_C;
			r_id: ROUTINE_ID;
			rout_info: ROUT_INFO
		do
			real_ty ?= context.real_type (type);
			target_type := real_ty.meta_generic.item (1);
			base_class := real_ty.base_class;
			f_table := base_class.feature_table;
			feat_i := f_table.item ("make");
				-- Need to insert expression into
				-- the stack back to front in order
				-- to be inserted into the area correctly
			from
				expressions.finish;
			until
				expressions.before
			loop
				expr ?= expressions.item;
				actual_type ?= context.real_type (expr.type);
				expr.make_byte_code (ba);
				if actual_type = Void then
					ba.append (Bc_void);
				elseif need_metamorphosis (actual_type) then
						-- Simple type objects are metamorphosed
					basic_i ?= actual_type;	
					ba.append (Bc_metamorphose);
				elseif not actual_type.same_as (target_type) then
						-- A conversion integer => real, integer => double
						-- or real => double is needed
					if target_type.is_double then
						if actual_type.is_long or else
							actual_type.is_float
						then
							ba.append (Bc_cast_double)
						end
					elseif target_type.is_float and then
						(actual_type.is_long or else actual_type.is_double)
					then
						ba.append (Bc_cast_float)
					end
				end;
				expressions.back;
			end;
			if base_class.is_precompiled then
				ba.append (Bc_parray);
				r_id := feat_i.rout_id_set.first;
				rout_info := System.rout_info_table.item (r_id);
				ba.append_integer (rout_info.origin.id);
				ba.append_integer (rout_info.offset);	
				ba.append_short_integer (real_ty.associated_class_type.type_id - 1);
				real_ty.make_gen_type_byte_code (ba, true)
				ba.append_short_integer (-1);
			else
				ba.append (Bc_array);
				ba.append_short_integer (real_ty.associated_class_type.id.id - 1);
				ba.append_short_integer (real_ty.associated_class_type.type_id - 1);
				real_ty.make_gen_type_byte_code (ba, true)
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

end
