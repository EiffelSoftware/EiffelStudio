class UN_STRIP_AS

inherit

	EXPR_AS
		redefine
			type_check, byte_node, format
		end

feature -- Attributes

	id_list: EIFFEL_LIST [ID_AS];
			-- Attribute list

feature -- Initialization

	set is
			-- Yacc initialization
		do
			id_list ?= yacc_arg (0);
		ensure then
			id_list /= Void;
		end;

feature -- Type check, byte code and dead code removal

	type_check is
			-- Type check a strip expression
		local
			an_id: ID_AS;
			pos: INTEGER;
			feature_table: FEATURE_TABLE;
			attribute_i: ATTRIBUTE_I;
			vwst1: VWST1;
			vwst2: VWST2;
		do
			from
				feature_table := context.a_class.feature_table;
				id_list.start
			until
				id_list.after
			loop
				an_id := id_list.item;
				pos := id_list.position;
				id_list.forth;
				id_list.search_equal (an_id);
				if not id_list.after then
						-- Id appears more than once in attribute list
					!!vwst2;
					context.init_error (vwst2);
					vwst2.set_attribute_name (an_id);
					vwst2.set_strip_expr (Current);
					Error_handler.insert_error (vwst2);
				end;
				id_list.go (pos);
				attribute_i ?= feature_table.item (an_id);
				if attribute_i = Void then
					!!vwst1;
					context.init_error (vwst1);
					vwst1.set_attribute_name (an_id);
					vwst1.set_strip_expr (Current);
					Error_handler.insert_error (vwst1);
				end;
				id_list.forth;
			end;
			context.put (Strip_type);
		end;

	Strip_type: GEN_TYPE_A is
			-- Type of strip expression (ARRAY [ANY])
		require
			any_compiled: System.any_class.compiled;
			array_compiled: System.array_class.compiled;
		local
			generics: ARRAY [TYPE_A];
			any_type: CL_TYPE_A;
		once
			!!Result;
			Result.set_base_type (System.array_id);
			!!generics.make (1,1);
			!!any_type;
			any_type.set_base_type (System.any_id);
			generics.put (any_type, 1);
			Result.set_generics (generics);
		end;

	byte_node: STRIP_B is
			-- Byte code associated to a strip expression
		local
			attribute_i: ATTRIBUTE_I;
			feature_table: FEATURE_TABLE;
		do
			from
				id_list.start;
				!!Result.make;
				feature_table := context.a_class.feature_table;
			until
				id_list.after
			loop
				attribute_i ?= feature_table.item (id_list.item);
				Result.feature_ids.put (attribute_i.feature_id);
				id_list.forth;
			end;
		end;

	format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		local
			first_printed: BOOLEAN;
		do
			ctxt.begin;
			ctxt.put_keyword("strip ");
			ctxt.put_special("(");
			
			from
				id_list.start;
			until
				id_list.after
			loop
				ctxt.new_expression;
				ctxt.prepare_for_feature(id_list.item, void);
				if ctxt.is_feature_visible then	
					if not first_printed then
						ctxt.put_special(",");
						ctxt.put_string(" ");
					end;	
					ctxt.put_current_feature;
					first_printed := true;
				end;
				id_list.forth
			end;
		--	ctxt.same_types;
			if not first_printed then
				ctxt.rollback;
			else
				ctxt.commit;
			end;
		end;

end
