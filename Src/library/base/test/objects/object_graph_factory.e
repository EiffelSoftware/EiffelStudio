note
	description: "A factory class for generating different object graphs."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	OBJECT_GRAPH_FACTORY

feature -- Access

	reference_type_graphs: ARRAYED_LIST[ANY]
			-- A collection of object graphs that don't contain expanded or copy-semantics references.
		do
			create Result.make (7)
			Result.extend (flat_basic_type)
			Result.extend (void_reference)
			Result.extend (single_reference)
			Result.extend (linear_object_graph)
--			Result.extend (object_tree)
			Result.extend (shared_object)
			Result.extend (object_graph_cycle)
		end

	expanded_type_graphs: ARRAYED_LIST[ANY]
			-- A collection of object graphs that contain expanded attributes or copy-semantics references.
		do
			create Result.make (5)
			Result.extend (any_cell_with_integer)
			Result.extend (any_cell_with_expanded)
			Result.extend (embedded_expanded)
			Result.extend (embedded_expanded_with_integer)
			Result.extend (direct_expanded)
			Result.extend (nested_embedded_with_copysemantics)
		end


	all_basic_types: ARRAYED_LIST [ANY]
			-- Return a collection of basic types.
		do
			create Result.make (27)

				-- Integers
			Result.extend ({INTEGER_8}.max_value)
			Result.extend ({INTEGER_8}.min_value)
			Result.extend ({INTEGER_16}.max_value)
			Result.extend ({INTEGER_16}.min_value)
			Result.extend ({INTEGER_32}.max_value)
			Result.extend ({INTEGER_32}.min_value)
			Result.extend ({INTEGER_64}.max_value)
			Result.extend ({INTEGER_64}.min_value)

				-- Naturals
			Result.extend ({NATURAL_8}.max_value)
			Result.extend ({NATURAL_8}.min_value)
			Result.extend ({NATURAL_16}.max_value)
			Result.extend ({NATURAL_16}.min_value)
			Result.extend ({NATURAL_32}.max_value)
			Result.extend ({NATURAL_32}.min_value)
			Result.extend ({NATURAL_64}.max_value)
			Result.extend ({NATURAL_64}.min_value)

				-- Reals
			Result.extend ({REAL_32}.max_value)
			Result.extend ({REAL_32}.min_value)
			Result.extend ({REAL_64}.max_value)
			Result.extend ({REAL_64}.min_value)

				-- Characters
			Result.extend ({CHARACTER_8}.max_value)
			Result.extend ({CHARACTER_8}.min_value)
			Result.extend ({CHARACTER_32}.max_value)
			Result.extend ({CHARACTER_32}.min_value)

				-- Boolean
			Result.extend (True)
			Result.extend (False)

				-- Pointer
			Result.extend (default_pointer)
		end

feature -- Flat objects

	flat_basic_type: FLAT_CLASS
			-- A single object containing all basic types.
		do
			create Result
		end

	void_reference: OBJECT_GRAPH_ITEM
			-- A single object containing only Void references.
		do
			create Result
		end

feature -- Reference-type object graphs

	single_reference: OBJECT_GRAPH_ITEM
			-- An object with a reference to another object.
		local
			other: OBJECT_GRAPH_ITEM
		do
			create other
			create Result
			Result.first := other
		end

	two_flat_objects: DOUBLE_CELL[FLAT_CLASS, FLAT_CLASS]
			-- An object containing two references to FLAT_CLASS objects.
		do
			create Result.make (create {FLAT_CLASS}, create {FLAT_CLASS})
		end

	linear_object_graph: OBJECT_GRAPH_ITEM
			-- An object graph consisting of a linear sequence of 10 objects.
		local
			head, tail: OBJECT_GRAPH_ITEM
			i: INTEGER
		do
			from
				create head
				i := 10
			until
				i < 2
			loop
				create tail
				tail.first := head
				head := tail
				i := i - 1
			variant
				i
			end

			Result := head
		end

	object_tree: OBJECT_GRAPH_ITEM
			-- A (rather big) object graph consisting of a binary tree of height 10.
		local
			parent, child: OBJECT_GRAPH_ITEM
			i: INTEGER
		do
			from
				create child
				i := 10
			until
				i < 2
			loop
				create parent
				parent.first := child.deep_twin
				parent.second := child.deep_twin
				child := parent
				i := i - 1
			variant
				i
			end

			Result := child
		end

	shared_object: OBJECT_GRAPH_ITEM
			-- An object graph with a shared object
		local
			left, right, shared: OBJECT_GRAPH_ITEM
		do
			create shared
			create left
			left.first := shared
			create right
			right.first := shared
			create Result
			Result.first := left
			Result.second := right
		end

	object_graph_cycle: OBJECT_GRAPH_ITEM
			-- An object graph with a cycle
		local
			one, two, three: OBJECT_GRAPH_ITEM
		do
			create one
			create two
			create three
			three.first := one
			two.first := three
			one.first := two

			Result := one
		end

feature -- Copy-semantics items

	any_cell_with_integer: CELL [detachable ANY]
			-- A CELL object containing an integer
		do
			create Result.put (42)
		end

	any_cell_with_expanded: CELL [detachable ANY]
			-- A CELL object containing a user-defined expanded object.
		local
			item: E_DOUBLE_CELL [ANY, ANY]
		do
			item.first := create {ANY}
			item.second := create {ANY}
			create Result.put (item)
		end

	embedded_expanded: CELL [E_DOUBLE_CELL [separate ANY, separate ANY]]
			-- A CELL object containing an embedded expanded object
		local
			item: E_DOUBLE_CELL [ANY, ANY]
		do
			create Result.put (item)
			Result.item.first := create {ANY}
			Result.item.second := create {ANY}
		end

	embedded_expanded_with_integer: CELL [E_DOUBLE_CELL [separate ANY, INTEGER]]
			-- A CELL object containing an embedded expanded object with an integer
		local
			item: E_DOUBLE_CELL [ANY, INTEGER]
		do
			create Result.put (item)
			Result.item.first := create {ANY}
			Result.item.second := 42
		end

	direct_expanded: E_DOUBLE_CELL [ANY, ANY]
			-- A user-defined expanded object.
		do
			Result.first := create {ANY}
			Result.second := create {ANY}
		end

	nested_embedded_with_copysemantics: CELL [E_DOUBLE_CELL [E_FLAT_CLASS, separate ANY]]
			-- A CELL containing two user-defined expanded attributes and a copy-semantics object.
		local
			item: E_DOUBLE_CELL [E_FLAT_CLASS, ANY]
			item2: E_DOUBLE_CELL [separate ANY, separate ANY]
		do
			create Result.put (item)
			item2.first := 42
			item2.second := "a_string"
			Result.item.second := item2
		end


note
	copyright: "Copyright (c) 1984-2018, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
