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

create
	initialize

feature {NONE} -- Initialization

	initialize (i: like id_list) is
			-- Create a new UN_STRIP AST node.
		require
			i_not_void: i /= Void
		do
			id_list := i
		ensure
			id_list_set: id_list = i
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_un_strip_as (Current)
		end

feature -- Attributes

	id_list: CONSTRUCT_LIST [INTEGER]
			-- Attribute list

feature -- Location

	start_location: LOCATION_AS is
			-- Starting point for current construct.
		do
			Result := null_location
		end
		
	end_location: LOCATION_AS is
			-- Ending point for current construct.
		do
			Result := null_location
		end

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
					create vwst2
					context.init_error (vwst2)
					vwst2.set_attribute_name (Names_heap.item (an_id))
					vwst2.set_location (start_location)
					Error_handler.insert_error (vwst2)
				else
					attribute_i ?= feature_table.item_id (an_id)
					if attribute_i = Void then
						create vwst1
						context.init_error (vwst1)
						vwst1.set_attribute_name (Names_heap.item (an_id))
						vwst1.set_location (start_location)
						Error_handler.insert_error (vwst1)
					else
						create depend_unit.make (context.current_class.class_id,
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
			any_compiled: System.any_class.is_compiled
			array_compiled: System.array_class.is_compiled
		local
			generics: ARRAY [TYPE_A]
			any_type: CL_TYPE_A
		once
			create generics.make (1,1)
			create any_type.make (System.any_id)
			generics.put (any_type, 1)

			create Result.make (System.array_id, generics)
		end

	byte_node: STRIP_B is
			-- Byte code associated to a strip expression
		local
			attribute_i: ATTRIBUTE_I
			feature_table: FEATURE_TABLE
		do
			from
				id_list.start
				create Result.make
				feature_table := context.current_class.feature_table
			until
				id_list.after
			loop
				attribute_i ?= feature_table.item_id (id_list.item)
				Result.feature_ids.put (attribute_i.feature_id)
				id_list.forth
			end
		end

invariant
	id_list_not_void: id_list /= Void

end -- class UN_STRIP_AS
