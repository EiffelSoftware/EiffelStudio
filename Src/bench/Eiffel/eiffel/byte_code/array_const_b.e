-- Byte code for manifest arrays

class ARRAY_CONST_B 

inherit

	EXPR_B
		redefine
			make_byte_code, enlarged, enlarge_tree
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
		do
			real_ty ?= context.real_type (type);
			target_type := real_ty.meta_generic.item (1);
			f_table := real_ty.base_class.feature_table;
			feat_i := f_table.item ("make");
			feat_id := feat_i.feature_id;
			ba.append (Bc_array);
			ba.append_short_integer (real_ty.associated_class_type.id - 1);
			ba.append_short_integer (feat_id);
			ba.append_integer (expressions.count);
			from
				expressions.start;
			until
				expressions.after
			loop
				expr ?= expressions.item;
				actual_type ?= context.real_type (expr.type);
				expr.make_byte_code (ba);
				if need_metamorphosis (actual_type) then
						-- Simple type objects are metamorphosed
					basic_i ?= actual_type;	
					ba.append (Bc_metamorphose);
				end;
				ba.append (Bc_insert);
				if actual_type.is_expanded then
						-- Require position in array for expandeds
					ba.append_integer (expressions.index - 1);
				end;
				expressions.forth;
			end;
			ba.append (Bc_end_insert)
		end;

end
