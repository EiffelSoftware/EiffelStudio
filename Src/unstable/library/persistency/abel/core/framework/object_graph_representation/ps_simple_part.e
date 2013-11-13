note
	description: "Represents a simple object graph part that can't have dependencies."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PS_SIMPLE_PART

inherit

	PS_OBJECT_GRAPH_PART

feature {PS_ABEL_EXPORT} -- Access

	root: PS_OBJECT_GRAPH_ROOT
			-- The root of the object graph.

	represented_object: ANY
			-- The object which gets represented by `Current'.

	dependencies: LINKED_LIST [PS_OBJECT_GRAPH_PART]
			-- All parts on which `Current' depends on.

	object_identifier: INTEGER = 0
			-- The object identifier of `Current'. Returns 0 if `Current' is no complex part.

feature {PS_ABEL_EXPORT} -- Status report

	is_complex_attribute: BOOLEAN = False
			-- Is `Current' an instance of PS_COMPLEX_ATTRIBUTE_PART?

	is_collection: BOOLEAN = False
			-- Is `Current' an instance of PS_COLLECTION_PART?

feature {PS_ABEL_EXPORT} -- Basic operations

	break_dependency (dependency: PS_OBJECT_GRAPH_PART)
			-- Break the dependency `dependency'.
		do
		end

feature {NONE} -- Initialization

	default_make (a_root: PS_OBJECT_GRAPH_ROOT)
			-- Initialize `Current'
		do
			create dependencies.make
			write_operation := new_operation
			root := a_root
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

invariant
	no_dependencies: dependencies.is_empty

end
