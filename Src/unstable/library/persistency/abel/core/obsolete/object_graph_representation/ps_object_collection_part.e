note
	description: "Represents a collection that should be stored similar to an object."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_OBJECT_COLLECTION_PART

inherit

	PS_COLLECTION_PART

create
	make

feature {PS_ABEL_EXPORT} -- Access

	additional_information: HASH_TABLE [STRING, STRING]
			-- Any additional information that the backend has to store.

	dependencies: LINKED_LIST [PS_OBJECT_GRAPH_PART]
			-- All operations that depend on this one.
		do
			create Result.make
			Result.append (values)
			if attached deletion_dependency_for_updates as dep then
				Result.extend (dep)
			end
		end

	index_of (a_value: PS_OBJECT_GRAPH_PART): INTEGER
			-- Get the index of `a_value' in the actual collection.
		require
			part_of_values: values.has (a_value)
		do
			across
				index_mapping as cursor
			loop
				if cursor.item.first = a_value then
					Result := cursor.item.second
				end
			end
		end

feature {PS_ABEL_EXPORT} -- Status report

	is_relationally_mapped: BOOLEAN = False
			-- Is current collection mapped as a 1:N or M:N Relation between two objects?

feature {PS_ABEL_EXPORT} -- Basic operations

	add_value (a_graph_part: PS_OBJECT_GRAPH_PART)
			-- Add a value to the collection.
		do
			add_value_explicit_index (a_graph_part, next_index)
			next_index := next_index + 1
		end

	add_information (description: STRING; value: STRING)
			-- Add the information `value' with key `description' to `Current'.
		do
			additional_information.extend (value, description)
		end

	break_dependency (dependency: PS_OBJECT_GRAPH_PART)
			-- Break the dependency `dependency'.
		local
			new_insert: like Current
		do
			new_insert := clone_empty_with_operation (write_operation.insert)
			new_insert.add_value_explicit_index (dependency, index_of (dependency))
			root.add_dependency (new_insert)
			values.prune_all (dependency)
		end

feature {PS_COLLECTION_PART} -- Duplication

	clone_empty_with_operation (operation: PS_WRITE_OPERATION): like Current
			-- Create a copy of `Current' with empty values and write_mode set to `operation'.
		do
			create Result.make (represented_object, metadata, is_persistent, handler, root)
			Result.set_deletion_dependency (deletion_dependency_for_updates)
			Result.set_mode (operation)
		end

feature {NONE} -- Initialization

	make (obj: ANY; meta: PS_TYPE_METADATA; persistent: BOOLEAN; a_handler: PS_COLLECTION_HANDLER_OLD [detachable ANY]; a_root: PS_OBJECT_GRAPH_ROOT)
			-- initialize `Current'.
		do
			represented_object := obj
			internal_metadata := meta
			is_persistent := persistent
			handler := a_handler
			root := a_root
			write_operation := new_operation
			create values.make
			create additional_information.make (hashtable_size)
			next_index := 1
			create index_mapping.make
		ensure
			no_update_mode: write_operation /= write_operation.update
		end

feature {PS_OBJECT_COLLECTION_PART} -- Implementation

	add_value_explicit_index (value: PS_OBJECT_GRAPH_PART; index: INTEGER)
			-- Add the value `value' with an explicit index `index'.
		do
			values.extend (value)
			index_mapping.extend (create {PS_PAIR [PS_OBJECT_GRAPH_PART, INTEGER]}.make (value, index))
		end

feature {NONE} -- Implementation

	next_index: INTEGER
			-- The next usable index.

	index_mapping: LINKED_LIST [PS_PAIR [PS_OBJECT_GRAPH_PART, INTEGER]]
			-- The mapping between `values' and their index.

	hashtable_size: INTEGER = 10
			-- The initial capacity for `additional_information'.

	add_additional_information
			-- Ask the handler for additional information about `Current', if `Current' is an instance of PS_OBJECT_COLLECTION_PART.
		do
			handler.add_information (Current)
		end

end
