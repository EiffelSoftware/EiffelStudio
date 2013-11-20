note
	description: "Represents a collection in an object graph."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PS_COLLECTION_PART

inherit

	PS_COMPLEX_PART

feature {PS_ABEL_EXPORT} -- Access

	values: LINKED_LIST [PS_OBJECT_GRAPH_PART]
			-- The objects in the collection.

--	actual_collection: COLLECTION_TYPE
--			-- The collection that `Current' represents.
--		do
--			check attached {COLLECTION_TYPE} represented_object as res then
--				Result := res
--			end
--		end

feature {PS_ABEL_EXPORT} -- Status report

	are_items_of_basic_type: BOOLEAN
			-- are the current collection's items of a basic type?
		do
			Result := metadata.actual_generic_parameter (1).is_basic_type
		end

	is_relationally_mapped: BOOLEAN
			-- Is current collection mapped as a 1:N or M:N Relation between two objects?
		deferred
		end

	is_collection: BOOLEAN = True
			-- Is `Current' an instance of PS_COLLECTION_PART?

feature {PS_ABEL_EXPORT} -- Basic operations

	add_value (a_graph_part: PS_OBJECT_GRAPH_PART)
			-- Add a value to the collection.
		require
--			no_mixed_type_collections: not values.is_empty implies values [1].is_basic_attribute = a_graph_part.is_basic_attribute
			no_basic_type_in_relational_mode: is_relationally_mapped implies not a_graph_part.is_basic_attribute
			no_multidimensional_collections_in_relational_mode: is_relationally_mapped implies not attached {PS_COLLECTION_PART} a_graph_part
		deferred
		end

feature {PS_COLLECTION_PART} -- Duplication

	clone_empty_with_operation (operation: PS_WRITE_OPERATION): like Current
			-- Create a copy of `Current' with empty values and write_mode set to `operation'.
		deferred
		end

feature {PS_COMPLEX_PART} -- Initialization

	finish_initialization (disassembler: PS_OBJECT_GRAPH_BUILDER)
			-- Initialize all attributes or collection items of `Current'.
		local
			cursor: ITERATION_CURSOR [detachable ANY]
			next: PS_OBJECT_GRAPH_PART
			operation: PS_WRITE_OPERATION
			generated_items: LINKED_LIST [PS_OBJECT_GRAPH_PART]
		do
			operation := disassembler.active_operation
			handle_operation (operation)
				-- First generate all item parts

			generated_items := handler.create_items (Current, agent disassembler.next_object_graph_part (?, Current, operation))
			from
				generated_items.start
			until
				generated_items.after
			loop
--					-- Change an IGNORE_PART to a NULL_REFRENCE_PART in object collections
				if attached {PS_IGNORE_PART} generated_items.item and not is_relationally_mapped then
					generated_items.replace (create {PS_NULL_REFERENCE_PART}.default_make (generated_items.item.root))
				end
				add_value (generated_items.item)
				generated_items.forth
			end

				-- Now initialize all of them
			across
				generated_items as val
			loop
				if attached val.item as coll_item then
					coll_item.initialize (disassembler.next_level (level, is_persistent, coll_item.is_collection, coll_item.is_persistent), disassembler.next_operation (level, is_persistent, coll_item.is_persistent), disassembler)
				end
			end
			add_additional_information
		end

feature {PS_COLLECTION_PART} -- Implementation

	set_deletion_dependency (deletion_dependency: detachable like Current)
			-- Set a deletion dependency for `Current'.
		require
			operation_is_delete: attached deletion_dependency as dep implies dep.write_operation = dep.write_operation.delete
		do
			deletion_dependency_for_updates := deletion_dependency
		end

	set_mode (operation: PS_WRITE_OPERATION)
			-- Manually set `write_operation' to `operation'.
		do
			write_operation := operation
		end

feature {NONE} -- Implementation

	handle_operation (operation: PS_WRITE_OPERATION)
			-- Set the `write_operation' to `operation'. If `operation' is an update operation, create a new deletion dependency.
		local
			del_dependency: like Current
		do
--			if operation = operation.update then
--				write_operation := operation.insert
--				deletion_dependency_for_updates := clone_empty_with_operation (write_operation.delete)
--			else
				write_operation := operation
--			end
		ensure
--			operation = operation.update implies attached deletion_dependency_for_updates and write_operation = write_operation.insert
--			operation /= operation.update implies not attached deletion_dependency_for_updates and write_operation = operation
		end

	add_additional_information
			-- Ask the handler for additional information about `Current', if `Current' is an instance of PS_OBJECT_COLLECTION_PART.
		deferred
		end

	handler: PS_COLLECTION_HANDLER_OLD [detachable ANY]
			-- The handler which created `Current'.

	deletion_dependency_for_updates: detachable like Current
			-- If `Current' is an update operation, the collection needs to be deleted and inserted again. This is the statement to delete it.

invariant
	same_types: values.for_all (agent {PS_OBJECT_GRAPH_PART}.is_basic_attribute) or not values.for_all (agent {PS_OBJECT_GRAPH_PART}.is_basic_attribute)
	deletion_dependency_mode_correct: attached deletion_dependency_for_updates as dep implies dep.write_operation = dep.write_operation.delete
	deletion_dependency_in_dependencies: attached deletion_dependency_for_updates as dep implies dependencies.has (dep)
end
