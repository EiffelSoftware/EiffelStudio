note
	description: "Represents a general object graph part."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PS_OBJECT_GRAPH_PART

inherit

	ITERABLE [PS_OBJECT_GRAPH_PART]

	PS_ABEL_EXPORT

feature {PS_ABEL_EXPORT} -- Access

	represented_object: ANY
			-- The object which gets represented by `Current'.
		require
			represents_object: is_representing_object
		deferred
		end

	metadata: PS_TYPE_METADATA
			-- Some metadata about `represented_object'.
		require
			represents_object: is_representing_object
		do
			Result := attach (internal_metadata)
		end

	level: INTEGER
			-- The level of the current object graph part.

	write_operation: PS_WRITE_OPERATION
			-- The operation that should be performed in the database.

	root: PS_OBJECT_GRAPH_ROOT
			-- The root of the object graph.
		deferred
		end

	dependencies: LIST [PS_OBJECT_GRAPH_PART]
			-- All parts on which `Current' depends on.
		deferred
		end

feature {PS_ABEL_EXPORT} -- Status report

	is_persistent: BOOLEAN
			-- Is `Current' already persistent?
		attribute
		ensure
			basic_parts_never_persistent: (is_basic_attribute or not is_representing_object) implies not Result
		end

	is_root: BOOLEAN
			-- Is `Current' an instance of PS_OBJECT_GRAPH_ROOT?
		do
				-- The root node is the only one where this condition holds
			Result := Current = root
		end

	is_basic_attribute: BOOLEAN
			-- Is `Current' an instance of PS_BASIC_ATTRIBUTE_PART?
		do
			Result := is_representing_object and not is_complex_attribute
		end

	is_complex_attribute: BOOLEAN
			-- Is `Current' an instance of PS_COMPLEX_ATTRIBUTE_PART?
		deferred
		end

	is_representing_object: BOOLEAN
			-- Is `Current' representing an existing object?
		deferred
		end

	is_collection: BOOLEAN
			-- Is `Current' an instance of PS_COLLECTION_PART?
		deferred
		end

	is_visited: BOOLEAN
			-- Has current part been visited?

feature {PS_ABEL_EXPORT} -- Utilities

	as_attribute (primary_key: INTEGER): TUPLE [value: STRING; type: STRING]
			-- The value and type of `Current' as an attribute to other objects.
		do
			if not is_representing_object then
				Result := ["", "NONE"]
			elseif is_basic_attribute then
				Result := [basic_attribute_value, metadata.base_class.name]
			else
				Result := [primary_key.out, metadata.base_class.name]
			end
		end

	object_identifier: INTEGER
			-- The object identifier of `Current'. Returns 0 if `Current' is a basic type.
		deferred
		ensure
			is_basic_attribute implies Result = 0
			not is_representing_object implies Result = 0
			is_complex_attribute implies Result > 0
		end

	basic_attribute_value: STRING
			-- The value of `Current' as a string.
		require
			is_basic: is_basic_attribute
		do
			Result := ""
		end

feature {PS_ABEL_EXPORT} -- Basic operations

	set_visited (flag: BOOLEAN)
			-- Set `is_visited' to `flag'.
		do
			is_visited := flag
		ensure
			correctly_set: is_visited = flag
		end

	break_dependency (dependency: PS_OBJECT_GRAPH_PART)
			-- Break the dependency `dependency'.
		require
			is_present: dependencies.has (dependency)
		deferred
		ensure
			not_present: not dependencies.has (dependency)
		end

feature {PS_ABEL_EXPORT} -- Access: Cursor

	new_cursor: PS_OBJECT_GRAPH_CURSOR
			-- Create a new cursor over the current object graph.
		do
			create Result.make (Current)
		end

	new_smart_cursor: PS_SMART_OBJECT_GRAPH_CURSOR
			-- Create a new cursor returning only objects of type COMPLEX_PART and write_operation other than `no_operation'
		do
			create Result.make (Current)
		end

feature {PS_OBJECT_GRAPH_PART, PS_OBJECT_GRAPH_BUILDER} -- Initialization

	initialize (a_level: INTEGER; a_mode: PS_WRITE_OPERATION; disassembler: PS_OBJECT_GRAPH_BUILDER)
			-- Initialize `Current' and its whole object graph.
		deferred
		ensure
			is_initialized
		end

	is_initialized: BOOLEAN
			-- Has `Current' been initialized?

	new_operation: PS_WRITE_OPERATION
			-- Create a new write operation, initialized as no_operation.
		do
			create Result
			Result := Result.no_operation
		end

feature {NONE} -- Implementation

	internal_metadata: detachable like metadata
			-- A little helper to circumvent void safety.

invariant
	no_self_dependence: not dependencies.has (Current)
	metadata_attached_if_representing_object: is_representing_object implies attached internal_metadata
	only_complex_attributes_get_written: not is_complex_attribute implies write_operation = write_operation.no_operation

end
