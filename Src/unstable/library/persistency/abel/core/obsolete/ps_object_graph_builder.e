note
	description: "Converts an object into an web of OBJECT_GRAPH_PARTs."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_OBJECT_GRAPH_BUILDER

inherit

	PS_ABEL_EXPORT

	REFACTORING_HELPER

create
	make

feature {PS_ABEL_EXPORT} -- Access

	object_graph: PS_OBJECT_GRAPH_ROOT
			-- The successfully disassembled object graph.
		require
			no_error: not has_error
		attribute
		end

feature {PS_ABEL_EXPORT} -- Status repurt

	has_error: BOOLEAN
			-- Has there been an error in the last operation?

feature {PS_ABEL_EXPORT} -- Basic operations

	execute_disassembly (object: ANY; operation: PS_WRITE_OPERATION; persistence_query_agent: PREDICATE [ANY])
			-- Take `object' apart and store the result in `object_graph'.
		do
			prepare (operation, persistence_query_agent)
			object_graph.add_dependency (next_object_graph_part (object, object_graph, operation))
			object_graph.dependencies.first.initialize (0, operation, Current)
		end

feature {PS_OBJECT_GRAPH_PART} -- Disassembly: Access

	active_operation: PS_WRITE_OPERATION
			-- The currently active operation.
		do
			Result := operation_stack.item
		end

feature {PS_OBJECT_GRAPH_PART} -- Disassembly: Status report

	is_level_condition_fulfilled (level: INTEGER): BOOLEAN
			-- Is `level' still smaller than the depth parameter of `active_operation'?
		do
			Result := current_depth = settings.object_graph_depth_infinite or level < current_depth
		end

feature {PS_OBJECT_GRAPH_PART} -- Disassembly: Basic operations

	set_operation (operation: PS_WRITE_OPERATION)
			-- Put `active_operation' to `operation'.
		require
			not_no_operation: operation /= operation.no_operation
		do
			operation_stack.put (operation)
		ensure
			operation_set: operation = active_operation
		end

	cancel_operation
			-- Revert the last `set_operation' command.
		do
			operation_stack.remove
		end

feature {PS_OBJECT_GRAPH_PART} -- Disassembly: Factory methods

	next_level (current_level: INTEGER; current_persistent: BOOLEAN; next_is_collection: BOOLEAN; next_persistent: BOOLEAN): INTEGER
			-- Calculate the level of the next object in the object graph.
		do
			if next_persistent /= current_persistent then
					-- We've stepped over a boundary - the next object part will either result in a no-operation
					-- or it will be an insert after update (or vice versa). In any case, the Result is 0.
				Result := 0
			else
				if next_is_collection then
						-- Don't increment the level for collections
					Result := current_level
				else
						-- This should be the normal case: an incremented level for a normal reference between two objects.
					Result := current_level + 1
				end
			end
		end

	next_operation (current_level: INTEGER; current_persistent: BOOLEAN; next_persistent: BOOLEAN): PS_WRITE_OPERATION
			-- Calculate the operation for the next object in the object graph.
		require
			not_no_operation: active_operation /= active_operation.no_operation
		do
			if is_level_condition_fulfilled (current_level) then
					-- The level is still valid, so we should handle the next object.
				if current_persistent = next_persistent then
						-- The normal case: don't change the mode if either both objects are persistent or both objects are new to ABEL.
					Result := active_operation
				elseif active_operation = active_operation.update and not next_persistent and settings.is_insert_during_update_enabled then
						-- This is a case where an insert for a new object during found an update should happen
					Result := active_operation.insert
				elseif active_operation = active_operation.insert and next_persistent and settings.is_update_during_insert_enabled then
						-- This is the case if an update for an already persistent object found during an insert should happen
					Result := active_operation.update
				else
						-- E.g. for a new object found during a delete, or when updates during insert are disabled.
					Result := active_operation.no_operation
				end
			else
					-- The level has become too big, so the next object should not be written any more
				Result := active_operation.no_operation
			end
		end

	next_object_graph_part (next_object: detachable ANY; current_part: PS_OBJECT_GRAPH_PART; current_operation: PS_WRITE_OPERATION): PS_OBJECT_GRAPH_PART
			-- Create the next object graph part.
		require
			current_operation = active_operation
			not_no_operation: active_operation /= active_operation.no_operation
		do
			if attached next_object as object then
				if is_basic_type (object) then
						-- Create a basic attribute part
					create {PS_BASIC_ATTRIBUTE_PART} Result.make (object, metadata_factory.create_metadata_from_object (object), object_graph)
				else
						-- First check the cache to prevent infinite recursion
					if is_cached (object) then
						Result := cached_part (object)
					else
							-- See if it is a collection
						if attached search_handler (next_object) as handler then
							Result := handler.create_collection_part (next_object, metadata_factory.create_metadata_from_object (next_object), is_next_persistent (next_object), current_part)
						else
							if current_operation = current_operation.update and not is_next_persistent (next_object) and not settings.is_insert_during_update_enabled then
									-- Handle special case: An new object was found during update and the automatic insert is disabled
								if settings.throw_error_for_unknown_objects then
									has_error := True
								end
								create {PS_NULL_REFERENCE_PART} Result.default_make (object_graph)
							else -- create the single object part
								create {PS_SINGLE_OBJECT_PART} Result.make (object, metadata_factory.create_metadata_from_object (object), is_next_persistent (object), object_graph)
							end
						end
							-- Cache the result
						if Result.is_complex_attribute then
							cache (Result)
						end
					end
				end
			else
					-- We found a Void reference - Ignore it.
				create {PS_IGNORE_PART} Result.default_make (object_graph)
--				create {PS_NULL_REFERENCE_PART} Result.default_make (object_graph)
			end
		end

feature {NONE} -- Internal: Status report

	is_cached (object: ANY): BOOLEAN
			-- Does `object' have an object graph part in the cache?
		do
			Result := across object_graph_part_cache as cursor some cursor.item.represented_object = object end
		end

	is_next_persistent (next_object: ANY): BOOLEAN
			-- Is `next_object' persistent, i.e. does it have an entry in the database?
		do
			if not is_basic_type (next_object) then
				Result := persistence_query.item ([next_object])
			else
				Result := False
			end
		end

	is_basic_type (object: ANY): BOOLEAN
			-- Is `object' of a basic type?
		do
			Result := attached {NUMERIC} object or attached {BOOLEAN} object or attached {CHARACTER_8} object or attached {CHARACTER_32} object
				--or attached {READABLE_STRING_GENERAL} object
				or object.generating_type.type_id = ({detachable STRING_8}).type_id or object.generating_type.type_id = ({detachable STRING_32}).type_id
				or attached {IMMUTABLE_STRING_GENERAL} object
		end

feature {NONE} -- Internal: Access

	settings: PS_OBJECT_GRAPH_SETTINGS
			-- The current object graph settings.

	search_handler (object: ANY): detachable PS_COLLECTION_HANDLER_OLD [detachable ANY]
			-- Search for a collection handler for `object'. Return Void if none present.
		do
			across
				collection_handlers as cursor
			loop
				if cursor.item.can_handle (object) then
					Result := cursor.item
				end
			end
		end

	collection_handlers: LINKED_LIST [PS_COLLECTION_HANDLER_OLD [detachable ANY]]
			-- The registered collection handlers.

	metadata_factory: PS_METADATA_FACTORY
			-- A factory for PS_TYPE_METADATA.

	cached_part (object: ANY): PS_OBJECT_GRAPH_PART
			-- The cached object graph part for `object'.
		require
			cached: is_cached (object)
		do
			Result := object_graph -- Void safety
			across
				object_graph_part_cache as cursor
			loop
				if cursor.item.represented_object = object then
					Result := cursor.item
				end
			end
		ensure
			not_root: Result /= object_graph
			correct_part: Result.represented_object = object
		end

	current_depth: INTEGER
			-- The depth parameter of the currently active operation.
		do
			if operation_stack.item = operation_stack.item.insert then
				if operation_stack.count > 1 then
					Result := settings.custom_insert_depth_during_update
				else
					Result := settings.insert_depth
				end
			elseif operation_stack.item = operation_stack.item.update then
				if operation_stack.count > 1 then
					Result := settings.custom_update_depth_during_insert
				else
					Result := settings.update_depth
				end
			else
				Result := settings.delete_depth
			end
		end

feature {NONE} -- Internal: Basic operations

	cache (part: PS_OBJECT_GRAPH_PART)
			-- Cache the object graph part `part'.
		require
			complex_attribute: part.is_complex_attribute
		do
			object_graph_part_cache.extend (part)
		ensure
			cached: is_cached (part.represented_object) and cached_part (part.represented_object) = part
		end

feature {NONE} -- Implementation

	object_graph_part_cache: LINKED_LIST [PS_OBJECT_GRAPH_PART]
			-- A cache to avoid creating an object graph part twice.

	persistence_query: PREDICATE [ANY]
			-- An agent to the OBJECT_IDENTIFICATION_MANAGER.is_persistent feature (if correctly initialized).

	operation_stack: LINKED_STACK [PS_WRITE_OPERATION]
			-- A stack to keep track of the active and previous operations.

feature {NONE} -- Initialization

	make (a_factory: PS_METADATA_FACTORY; graph_settings: PS_OBJECT_GRAPH_SETTINGS)
			-- Initialize `Current'.
		do
			metadata_factory := a_factory
			settings := graph_settings
			create collection_handlers.make
				-- Add some void safety defaults for the attributes specific to a single disassembly run.
			create object_graph_part_cache.make
			create object_graph.make
			create operation_stack.make
			persistence_query := agent  (something: ANY): BOOLEAN
				do
					Result := False
				end
		end

	prepare (operation: PS_WRITE_OPERATION; persistence_query_agent: PREDICATE [ANY])
			-- Prepare a disassemble for an object.
		do
			object_graph_part_cache.wipe_out
			create object_graph.make
			operation_stack.wipe_out
			persistence_query := persistence_query_agent
			has_error := False
			operation_stack.extend (operation)
		end

feature {PS_ABEL_EXPORT} -- Initialization

	add_handler (a_handler: PS_COLLECTION_HANDLER_OLD [detachable ANY])
			-- Add `a_handler' to the collection handlers.
		do
			collection_handlers.extend (a_handler)
		ensure
			collection_handlers.has (a_handler)
		end

end
