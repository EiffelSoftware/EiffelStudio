-- Byte code for manifest tuples

class TUPLE_CONST_B 

inherit

	EXPR_B
		redefine
			make_byte_code, enlarged, enlarge_tree, is_unsafe,
			optimized_byte_node, calls_special_features, size,
			pre_inlined_code, inlined_byte_code, generate_il
		end
	
feature 

	expressions: BYTE_LIST [BYTE_NODE];
			-- Expressions in the tuple

	type: TUPLE_TYPE_I;

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

	enlarged: TUPLE_CONST_BL is
			-- Enlarge node
		do
			!!Result;
			Result.set_expressions (expressions);
			Result.set_type (type);
			Result.enlarge_tree;
		end;

feature -- IL generation

	generate_il is
			-- Generate IL code for manifest tuple.
		local
			real_ty: TUPLE_TYPE_I
			actual_type: CL_TYPE_I
			tuple_make: FEATURE_I
			expr: EXPR_B
			array_class: CLASS_C
			class_type, array_any, array_char: SPECIAL_CLASS_TYPE
			local_array_any, local_array_char: INTEGER
			i: INTEGER
		do
			real_ty ?= context.real_type (type)

				-- Retrieve info on `make' of TUPLE.
			tuple_make := real_ty.base_class.feature_table.item ("make")

				-- Retrieve info on ARRAY [ANY] and ARRAY [CHARACTER]
				-- in order to create them.
			array_class := System.special_class.compiled_class
			from
				array_class.types.start
			until
				array_class.types.after
			loop
				class_type ?= array_class.types.item
				if class_type.is_character_array then
					array_char := class_type
				elseif class_type.is_any_array then
					array_any := class_type
				end
				array_class.types.forth
			end

				-- Creation of an ARRAY [CHARACTER]
			context.add_local (array_char.type)
			local_array_char := context.local_list.count
			il_generator.put_local_info (array_char.type, "dummy_" + local_array_char.out)
			il_generator.put_integer_32_constant (expressions.count)
			array_char.generate_il ("make")
			il_generator.generate_local_assignment (local_array_char)

				-- Creation of an ARRAY [ANY]
			context.add_local (array_any.type)
			local_array_any := context.local_list.count
			il_generator.put_local_info (array_any.type, "dummy_" + local_array_any.out)
			il_generator.put_integer_32_constant (expressions.count)
			array_any.generate_il ("make")
			il_generator.generate_local_assignment (local_array_any)

			from
				expressions.start
			until
				expressions.after
			loop
				expr ?= expressions.item
				actual_type ?= context.real_type (expr.type)

					-- Prepare call to `put'.
				il_generator.generate_local (local_array_any)
				il_generator.put_integer_32_constant (i)

					-- Generate expression
				expr.generate_il
				if
					actual_type /= Void and then
					actual_type.is_expanded
				then 
						-- We generate a boxed version of type.
					expr.generate_il_metamorphose (actual_type, True)
				end
				array_any.generate_il ("put")
				i := i + 1
				expressions.forth
			end

			il_generator.create_object (real_ty)
			il_generator.duplicate_top
			il_generator.generate_local (local_array_any)
			il_generator.generate_local (local_array_char)
			il_generator.generate_feature_access (real_ty, tuple_make.feature_id, True)
		end

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a manifest tuple
		local
			real_ty: TUPLE_TYPE_I;
			actual_type: CL_TYPE_I;
			f_table: FEATURE_TABLE;
			feat_i: FEATURE_I;
			feat_id: INTEGER;
			expr: EXPR_B;
			base_class: CLASS_C;
			r_id: INTEGER;
			rout_info: ROUT_INFO
		do
			real_ty ?= context.real_type (type);
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
					ba.append (Bc_Void)
				elseif actual_type.is_basic then 
						-- Simple type objects are metamorphosed
					ba.append (Bc_metamorphose);
				end;
				expressions.back;
			end;
			if base_class.is_precompiled then
				ba.append (Bc_parray);
				r_id := feat_i.rout_id_set.first;
				rout_info := System.rout_info_table.item (r_id);
				ba.append_integer (rout_info.origin);
				ba.append_integer (rout_info.offset);	
				ba.append_short_integer (real_ty.associated_class_type.type_id - 1);
				ba.append_short_integer (context.class_type.static_type_id-1)
				real_ty.make_gen_type_byte_code (ba, true)
				ba.append_short_integer (-1);
			else
				ba.append (Bc_array);
				ba.append_short_integer (real_ty.associated_class_type.static_type_id - 1);
				ba.append_short_integer (real_ty.associated_class_type.type_id - 1);
				ba.append_short_integer
					(context.current_type.associated_class_type.static_type_id - 1)
				real_ty.make_gen_type_byte_code (ba, true)
				ba.append_short_integer (-1);
				feat_id := feat_i.feature_id;
				ba.append_short_integer (feat_id);
			end;
			ba.append_integer (expressions.count);
			-- Tell interpreter that this is a TUPLE.
			ba.append_short_integer (1)
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
