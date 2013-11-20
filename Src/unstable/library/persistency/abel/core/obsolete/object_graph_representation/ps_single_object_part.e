note
	description: "[
					Represents a single object in an object graph.
				
					This class encapsulates all information needed to perform a write operation.
					Only the values in the `attributes' lists actually get inserted/updated.
					Any other values that might be present in the object will be ignored.
	]"
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_SINGLE_OBJECT_PART

inherit

	PS_COMPLEX_PART

create
	make

feature {PS_ABEL_EXPORT} -- Access

	attributes: LINKED_LIST [STRING]
			-- The names of all attributes in `Current'.

	attribute_value (name: STRING): PS_OBJECT_GRAPH_PART
			-- Get the value of attribute `name'.
		require
			has_attribute: attributes.has (name)
		do
			Result := attach (attribute_values [name])
		end

	dependencies: LINKED_LIST [PS_OBJECT_GRAPH_PART]
			-- All parts on which `Current' depends on.
		do
			across
				attribute_values as cursor
			from
				create Result.make
			loop
				if cursor.item.is_complex_attribute then
					Result.extend (cursor.item)
				end
			end
		end

feature {PS_ABEL_EXPORT} -- Status report

	is_collection: BOOLEAN = False
			-- Is `Current' an instance of PS_COLLECTION_PART?

feature {PS_ABEL_EXPORT} -- Basic operations

	add_attribute (name: STRING; value: PS_OBJECT_GRAPH_PART)
			-- Add a attribute `name' with value `value' to `Current'.
		do
			if attached {PS_IGNORE_PART} value then
					-- ignore
			elseif attached {PS_RELATIONAL_COLLECTION_PART} value then
					-- Add dependency to root
				root.add_dependency (value)
			else
					-- Add new attribute
				attributes.extend (name)
				attribute_values.extend (value, name)
			end
		ensure
			correctly_set: not attached {PS_IGNORE_PART} value implies (attributes.has (name) and then attribute_value (name) = value)
			correctly_ignored: attached {PS_IGNORE_PART} value implies not attributes.has (name)
		end

	break_dependency (dependency: PS_OBJECT_GRAPH_PART)
			-- Break the dependency `dependency'.
		local
			new_update: PS_SINGLE_OBJECT_PART
			attr: STRING
		do
			create new_update.make (represented_object, metadata, is_persistent, root)
			new_update.internal_initialize (write_operation.update, level)
			across
				attributes as attr_name
			from
				attr := ""
			loop
				if attribute_value (attr_name.item) = dependency then
					attr := attr_name.item
				end
			end
			new_update.add_attribute (attr, dependency)
			root.add_dependency (new_update)
			attribute_values.remove (attr)
			attributes.prune_all (attr)
		end

feature {NONE} -- Initialization

	make (obj: ANY; a_metadata: PS_TYPE_METADATA; persistent: BOOLEAN; a_root: PS_OBJECT_GRAPH_ROOT)
			-- Initialization for `Current'.
		do
			represented_object := obj
			internal_metadata := a_metadata
			is_persistent := persistent
			root := a_root
			write_operation := new_operation
			create attributes.make
			create attribute_values.make (hashtable_size)
			attributes.compare_objects
		end

feature {PS_COMPLEX_PART} -- Initialization

	finish_initialization (disassembler: PS_OBJECT_GRAPH_BUILDER)
			-- Initialize all attributes or collection items of `Current'.
		local
			val: PS_OBJECT_GRAPH_PART
		do
			write_operation := disassembler.active_operation
				-- First create all object graph parts of the attributes
			across
				metadata.attributes as attr
			loop
				val := disassembler.next_object_graph_part (metadata.reflection.field (metadata.field_index (attr.item), represented_object), Current, write_operation)
				add_attribute (attr.item, val)
			end
				-- Then initialize all object graph parts
			across
				attributes as cursor
			loop
				val := attribute_value (cursor.item)
				val.initialize (disassembler.next_level (level, is_persistent, val.is_collection, val.is_persistent), disassembler.next_operation (level, is_persistent, val.is_persistent), disassembler)
			end
		end

feature {PS_SINGLE_OBJECT_PART} -- Implementation

	internal_initialize (operation: PS_WRITE_OPERATION; a_level: INTEGER)
			-- Initialize without attributes, for the `break_dependency' feature.
		do
			write_operation := operation
			level := a_level
			is_initialized := True
		end

	attribute_values: HASH_TABLE [PS_OBJECT_GRAPH_PART, STRING]
			-- A hash table to store the attribute values.

	hashtable_size: INTEGER = 20
			-- The initial capacity for `attribute_values'.

end
