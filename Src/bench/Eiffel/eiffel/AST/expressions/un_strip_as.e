indexing
	description: "AST represenation of a unary `strip' operation."
	date: "$Date$"
	revision: "$Revision$"

class
	UN_STRIP_AS

inherit
	EXPR_AS
		redefine
			type_check, byte_node
		end

feature {NONE} -- Initialization

	set is
			-- Yacc initialization
		do
			id_list ?= yacc_arg (0)
			if id_list = Void then
				-- Empty list
				!! id_list.make_filled (0)
			end
			id_list.compare_objects
		ensure then
			id_list /= Void
		end

feature -- Attributes

	id_list: EIFFEL_LIST [ID_AS]
			-- Attribute list

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (id_list, other.id_list)
		end

feature -- Type check, byte code and dead code removal

	type_check is
			-- Type check a strip expression
		local
			an_id: ID_AS
			pos: INTEGER
			feature_table: FEATURE_TABLE
			attribute_i: ATTRIBUTE_I
			depend_unit: DEPEND_UNIT
			vwst1: VWST1
			vwst2: VWST2
		do
			from
				feature_table := context.a_class.feature_table
				id_list.start
			until
				id_list.after
			loop
				an_id := id_list.item
				pos := id_list.index
				id_list.forth
				id_list.search (an_id)
				if not id_list.after then
						-- Id appears more than once in attribute list
					!! vwst2
					context.init_error (vwst2)
					vwst2.set_attribute_name (an_id)
					Error_handler.insert_error (vwst2)
				else
					attribute_i ?= feature_table.item (an_id)
					if attribute_i = Void then
						!! vwst1
						context.init_error (vwst1)
						vwst1.set_attribute_name (an_id)
						Error_handler.insert_error (vwst1)
					else
						!! depend_unit.make (context.a_class.id,
											attribute_i)
						context.supplier_ids.extend (depend_unit)
					end
				end
				id_list.go_i_th (pos)
				id_list.forth
			end
			context.put (Strip_type)
		end

	Strip_type: GEN_TYPE_A is
			-- Type of strip expression (ARRAY [ANY])
		require
			any_compiled: System.any_class.compiled
			array_compiled: System.array_class.compiled
		local
			generics: ARRAY [TYPE_A]
			any_type: CL_TYPE_A
		once
			!! Result
			Result.set_base_class_id (System.array_id)
			!! generics.make (1,1)
			!! any_type
			any_type.set_base_class_id (System.any_id)
			generics.put (any_type, 1)
			Result.set_generics (generics)
		end

	byte_node: STRIP_B is
			-- Byte code associated to a strip expression
		local
			attribute_i: ATTRIBUTE_I
			feature_table: FEATURE_TABLE
		do
			from
				id_list.start
				!! Result.make
				feature_table := context.a_class.feature_table
			until
				id_list.after
			loop
				attribute_i ?= feature_table.item (id_list.item)
				if not attribute_i.feature_name.is_equal ("void") then
					Result.feature_ids.put (attribute_i.feature_id)
				end
				id_list.forth
			end
		end

feature -- Replication

	-- nothing is done and that is a bug (Didier)
	-- The correct policy should be something like
	-- fill_calls_list does nothing (ok): strip cannot
	-- trigger a replication by itself.
	-- replicate should replace a feature with all its version,
	-- and add the attribute introduced in the descendant class		

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		local
			first_printed: BOOLEAN
		do
			ctxt.put_text_item (ti_Strip_keyword)
			ctxt.put_space
			ctxt.put_text_item_without_tabs (ti_L_parenthesis)

			from
				id_list.start
			until
				id_list.after
			loop
				ctxt.new_expression
				ctxt.prepare_for_feature (id_list.item, Void)
				if ctxt.is_feature_visible then
					if first_printed then
						ctxt.put_text_item_without_tabs (ti_Comma)
						ctxt.put_space
					end
					ctxt.put_current_feature
					first_printed := True
				end
				id_list.forth
			end
			ctxt.put_text_item_without_tabs (ti_R_parenthesis)
		end

end -- class UN_STRIP_AS
