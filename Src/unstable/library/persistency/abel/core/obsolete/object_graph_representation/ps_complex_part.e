note
	description: "Represents an object in the object graph that can have dependencies."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PS_COMPLEX_PART

inherit

	PS_OBJECT_GRAPH_PART

feature {PS_ABEL_EXPORT} -- Access

	represented_object: ANY
			-- The object which gets represented by `Current'.

	root: PS_OBJECT_GRAPH_ROOT
			-- The root of the object graph

	object_wrapper: PS_OBJECT_IDENTIFIER_WRAPPER
			-- The repository-wide unique object identifier of the object represented by `Current'.
		require
			identified: is_identified
		do
			Result := attach (internal_object_id)
		end

	object_identifier: INTEGER
			-- The object identifier of `Current'. Returns 0 if `Current' is a basic type.
		do
			Result := object_wrapper.object_identifier
		end

feature {PS_ABEL_EXPORT} -- Status report

	is_representing_object: BOOLEAN = True
			-- Is `Current' representing an existing object?

	is_complex_attribute: BOOLEAN = True
			-- Is `Current' an instance of PS_COMPLEX_ATTRIBUTE_PART?

	is_identified: BOOLEAN
			-- Does `Current' have a unique id and an object wrapper?
		do
			Result := attached internal_object_id
		end

feature {PS_ABEL_EXPORT} -- Basic operations

	set_object_wrapper (an_object_id: PS_OBJECT_IDENTIFIER_WRAPPER)
			-- Set the object identifier wrapper of `Current'.
		do
			internal_object_id := an_object_id
		end

feature {PS_OBJECT_GRAPH_PART, PS_OBJECT_GRAPH_BUILDER} -- Initialization

	initialize (a_level: INTEGER; operation: PS_WRITE_OPERATION; disassembler: PS_OBJECT_GRAPH_BUILDER)
			-- Initialize `Current' and its whole object graph.
		local
			new_mode: BOOLEAN
		do
			if not is_initialized and operation /= operation.no_operation then
					-- The following condition only holds when a new object was found during update, or a persistent one during insert.
					-- Then the operation will be switched, but the disassembler doesn't know that yet.
				if a_level = 0 and root.dependencies.first /= Current then
						-- Inform the disassembler about he new operation
					disassembler.set_operation (operation)
					new_mode := True
				end
				if disassembler.is_level_condition_fulfilled (a_level) then
						-- First finish initializing `Current'
					is_initialized := True
					level := a_level
					check
						correct_operation: disassembler.active_operation = operation
					end
						-- Now initialize all attributes or collection items
					finish_initialization (disassembler)
				end
					-- We need to reset the operation if we changed it previously
				if new_mode then
					disassembler.cancel_operation
				end
			end
			is_initialized := True
		end

feature {PS_COMPLEX_PART} -- Initialization

	finish_initialization (disassembler: PS_OBJECT_GRAPH_BUILDER)
			-- Initialize all attributes or collection items of `Current'.
		deferred
		end

feature {NONE} -- Implementation

	internal_object_id: detachable like object_wrapper
			-- A little helper to circumvent Void safety:
			-- The object_id field will be set just before it gets executed by the PS_BACKEND,
			-- and this way the field doesn't always have to be checked by PS_BACKEND for a Void reference

end
