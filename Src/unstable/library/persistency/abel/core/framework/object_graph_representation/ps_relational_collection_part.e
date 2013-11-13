note
	description: "Represents a collection that should be stored relationally."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_RELATIONAL_COLLECTION_PART

inherit

	PS_COLLECTION_PART

create
	make

feature {PS_ABEL_EXPORT} -- Access

	reference_owner: PS_SINGLE_OBJECT_PART
			-- The object that holds a reference to `represented_object'.

	reference_owner_attribute_name: STRING
			-- The attribute name for `Current' in `reference_owner'.

	dependencies: LINKED_LIST [PS_OBJECT_GRAPH_PART]
			-- All operations that depend on this one.
		do
			create Result.make
			if is_mapped_as_1_to_N then
					-- no dependency required as foreign keys are stored within the objects.
			else -- M:N relational mode
				Result.append (values)
				Result.extend (reference_owner)
			end
			if attached deletion_dependency_for_updates as dep then
				Result.extend (dep)
			end
		end

feature {PS_ABEL_EXPORT} -- Status report

	is_relationally_mapped: BOOLEAN = True
			-- Is current collection mapped as a 1:N or M:N Relation between two objects?

	is_mapped_as_1_to_N: BOOLEAN
			-- Is current collection mapped as a 1:N - Relation in the database?

feature {PS_ABEL_EXPORT} -- Basic operations

	add_value (a_graph_part: PS_OBJECT_GRAPH_PART)
			-- Add a value to the collection.
		do
			if is_mapped_as_1_to_N then
					-- Add the value to the object instead
				check attached {PS_SINGLE_OBJECT_PART} a_graph_part as obj then
						-- everything else is covered by preconditions
					obj.add_attribute (reference_owner_attribute_name, Current)
				end
			else
				values.extend (a_graph_part)
			end
		end

	break_dependency (dependency: PS_OBJECT_GRAPH_PART)
			-- Break the dependency `dependency'.
		local
			new_insert: like Current
		do
			check
				not_reference_owner: dependency /= reference_owner
			end
			new_insert := clone_empty_with_operation (write_operation.insert)
			new_insert.add_value (dependency)
			root.add_dependency (new_insert)
			values.prune_all (dependency)
		end

feature {PS_COLLECTION_PART} -- Duplication

	clone_empty_with_operation (operation: PS_WRITE_OPERATION): like Current
			-- Create a copy of `Current' with empty values and write_mode set to `operation'.
		do
			create Result.make (represented_object, metadata, reference_owner, is_persistent, is_mapped_as_1_to_N, handler, root)
			Result.set_deletion_dependency (deletion_dependency_for_updates)
			Result.set_mode (operation)
		end

feature {NONE} -- Initialization

	make (obj: ANY; meta: PS_TYPE_METADATA; owner: PS_SINGLE_OBJECT_PART; persistent: BOOLEAN; mapped_as_1_to_n: BOOLEAN; a_handler: PS_COLLECTION_HANDLER_OLD [detachable ANY]; a_root: PS_OBJECT_GRAPH_ROOT)
			-- Initialize `Current', but don't initialize collection items.
		local
			attr_name: STRING
			i: INTEGER
			reflection: INTERNAL
		do
			represented_object := obj
			internal_metadata := meta
			reference_owner := owner
			is_persistent := persistent
			handler := a_handler
			root := a_root
			create values.make
			write_operation := new_operation
			reference_owner_attribute_name := ""
			across
				owner.metadata.attributes as attr
			loop
				if owner.metadata.reflection.field (owner.metadata.field_index (attr.item), owner.represented_object) = obj then
					reference_owner_attribute_name := attr.item
				end
			end
		end

feature {NONE} -- Implementation

	add_additional_information
			-- Ask the handler for additional information about `Current', if `Current' is an instance of PS_OBJECT_COLLECTION_PART.
		do
		end

end
