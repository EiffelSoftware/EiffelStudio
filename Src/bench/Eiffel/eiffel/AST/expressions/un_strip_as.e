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

	SHARED_NAMES_HEAP
		export
			{NONE} all
		end

feature {AST_FACTORY} -- Initialization

	initialize (i: like id_list) is
			-- Create a new UN_STRIP AST node.
		require
			i_not_void: i /= Void
		do
			id_list := i
		ensure
			id_list_set: id_list = i
		end

feature -- Attributes

	id_list: ARRAYED_LIST [INTEGER]
			-- Attribute list

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equal (id_list, other.id_list)
		end

feature -- Type check, byte code and dead code removal

	type_check is
			-- Type check a strip expression
		local
			an_id: INTEGER
			pos: INTEGER
			feature_table: FEATURE_TABLE
			attribute_i: ATTRIBUTE_I
			depend_unit: DEPEND_UNIT
			vwst1: VWST1
			vwst2: VWST2
		do
			from
				feature_table := context.current_class.feature_table
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
					vwst2.set_attribute_name (Names_heap.item (an_id))
					Error_handler.insert_error (vwst2)
				else
					attribute_i ?= feature_table.item_id (an_id)
					if attribute_i = Void then
						!! vwst1
						context.init_error (vwst1)
						vwst1.set_attribute_name (Names_heap.item (an_id))
						Error_handler.insert_error (vwst1)
					else
						!! depend_unit.make (context.current_class.class_id,
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
			create generics.make (1,1)
			create any_type
			any_type.set_base_class_id (System.any_id)
			generics.put (any_type, 1)

			create Result.make (generics)
			Result.set_base_class_id (System.array_id)
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
				feature_table := context.current_class.feature_table
			until
				id_list.after
			loop
				attribute_i ?= feature_table.item_id (id_list.item)
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
			l_names_heap: like Names_heap
		do
			ctxt.put_text_item (ti_Strip_keyword)
			ctxt.put_space
			ctxt.put_text_item_without_tabs (ti_L_parenthesis)

			from
				l_names_heap := Names_heap
				id_list.start
			until
				id_list.after
			loop
				ctxt.new_expression
				ctxt.prepare_for_feature (l_names_heap.item (id_list.item), Void)
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
