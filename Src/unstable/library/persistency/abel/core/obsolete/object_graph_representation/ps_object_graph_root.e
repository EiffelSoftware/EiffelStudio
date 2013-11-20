note
	description: "Represents the root of an object graph."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_OBJECT_GRAPH_ROOT

inherit

	PS_OBJECT_GRAPH_PART

create
	make

feature {PS_ABEL_EXPORT} -- Access

	dependencies: LINKED_LIST [PS_OBJECT_GRAPH_PART]
			-- All parts on which `Current' depends on.

	root: PS_OBJECT_GRAPH_ROOT
			-- The root of the object graph.
		do
			Result := Current
		end

	represented_object: ANY
			-- The object which gets represented by `Current'.

	object_identifier: INTEGER = 0
			-- The object identifier of `Current'. Returns 0 if `Current' is no complex part.

feature {PS_ABEL_EXPORT} -- Status report

	is_representing_object: BOOLEAN = False
			-- Is `Current' representing an existing object?

	is_collection: BOOLEAN = False
			-- Is `Current' an instance of PS_COLLECTION_PART?

	is_complex_attribute: BOOLEAN = False
			-- Is `Current' an instance of PS_COMPLEX_ATTRIBUTE_PART?

feature {PS_ABEL_EXPORT} -- Basic operations

	break_dependency (dependency: PS_OBJECT_GRAPH_PART)
			-- Break the dependency `dependency'.
		do
			dependencies.prune_all (dependency)
		end

	add_dependency (obj: PS_OBJECT_GRAPH_PART)
			-- Add `obj' to the dependency list.
		do
			dependencies.extend (obj)
		end

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			create dependencies.make
			write_operation := new_operation
			create represented_object
		end

feature {PS_OBJECT_GRAPH_PART, PS_OBJECT_GRAPH_BUILDER} -- Initialization

	initialize (a_level: INTEGER; a_mode: PS_WRITE_OPERATION; disassembler: PS_OBJECT_GRAPH_BUILDER)
			-- Initialize `Current' and its whole object graph.
		do
			if not is_initialized then
				is_initialized := True
				level := a_level
			end
		end

end
