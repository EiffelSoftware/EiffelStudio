note
	description: "Shared parts between read and write manager. Contains an array of OBJECT_DATA and some utility functions to manipulate the items."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PS_ABSTRACT_MANAGER

inherit
	PS_ABEL_EXPORT

feature {NONE} -- Initialization

	initialize (meta_mgr: like metadata_factory; id_mgr: like id_manager; key_mapper: like primary_key_mapper)
			-- Initialization for `Current'
		do
			metadata_factory := meta_mgr
			id_manager := id_mgr
			primary_key_mapper := key_mapper
			create identity_type_handlers.make (tiny_size)
			create value_type_handlers.make (tiny_size)
		end

	tiny_size: INTEGER = 5
			-- A predefined size for tiny arrays.

	small_size: INTEGER = 20
			-- A predefined size for small arrays.

	default_size: INTEGER = 100
			-- A predefined size for normal arrays.

feature -- Access

	count: INTEGER
			-- The number of objects known to this manager.
		do
			Result := object_storage.count
		ensure
			correct: object_storage.count = Result
		end

	item (index: INTEGER): PS_OBJECT_DATA
			-- Get the object with index `index'
		require
			valid_index: 1 <= index and index <= count
		do
			Result := object_storage[index]
		ensure
			object_correct: object_storage[index] = Result
			index_set: Result.index = index
		end

feature -- Access

	metadata_factory: PS_METADATA_FACTORY
			-- A factory for PS_TYPE_METADATA.

	id_manager: PS_OBJECT_IDENTIFICATION_MANAGER
			-- The ABEL identifier manager.

	primary_key_mapper: PS_KEY_POID_TABLE
			-- A table to map an ABEL identifier to a primary key.

	transaction: PS_INTERNAL_TRANSACTION
			-- The transaction in which the current operation is running.
		do
			check attached internal_transaction as attached_transaction then
				Result := attached_transaction
			end
		end

feature -- Status report

	is_transaction_initialized: BOOLEAN
			-- Is `transaction' initialized?
		do
			Result := attached internal_transaction
		end

feature -- Element change

	add_handler (handler: PS_HANDLER)
			-- Add `handler' to the current manager.
		do
			if handler.is_mapping_to_value_type then
				value_type_handlers.extend (handler)
			else
				identity_type_handlers.extend (handler)
			end
		end

	cascading_ignore (object: PS_OBJECT_DATA)
			-- Ignore `object' and all objects transitively referenced by it.
		local
			stack: LINKED_STACK[INTEGER]
			i: INTEGER
		do
			from
				create stack.make
				stack.extend (object.index)
			until
				stack.is_empty
			loop
				i := stack.item
				stack.remove

				item(i).ignore

				across
					item(i).references as ref_cursor
				loop

					check
						correct_referer: item (ref_cursor.item).referers.count > 0
						and (item (ref_cursor.item).referers.count = 1
							implies item (ref_cursor.item).referers.first = i)
					end

					if item (ref_cursor.item).referers.count = 1 then
						stack.extend (item (ref_cursor.item).index)
					end
				end
			end
		end

feature {NONE} -- Utilities

	assign_handlers (set: INDEXABLE[INTEGER, INTEGER])
			-- Assign an appropriate handler for all objects with an index in `set'.
		local
			i: INTEGER
			found: BOOLEAN
			not_found_exception: PS_INTERNAL_ERROR
		do
			across
				set as idx_cursor
			loop
				i := idx_cursor.item
				found := False
				-- First search for value types.
				across
					value_type_handlers as v_cursor
				until
					found
				loop
					if v_cursor.item.can_handle (item(i)) then
						item(i).set_handler (v_cursor.item)
						found := True
					end
				end

				across
					identity_type_handlers as i_cursor
				until
					found
				loop
					if i_cursor.item.can_handle (item(i)) then
						item(i).set_handler (i_cursor.item)
						found := True
					end
				end

				if not found then
					create not_found_exception
					not_found_exception.set_description (
						"Could not find a handler for type: " + item(i).type.type.name + "%N")
					not_found_exception.raise
				end
			end
		end

	search_value_type_handler (type: PS_TYPE_METADATA): detachable PS_HANDLER
			-- Try to find a value type handler for `type'
		do
			across
				value_type_handlers as cursor
			until
				attached Result
			loop
				if cursor.item.can_handle_type (type) then
					Result := cursor.item
				end
			end
		ensure
			correct: attached Result implies Result.can_handle_type (type)
		end

	do_all (operation: PROCEDURE[ANY, TUPLE[PS_HANDLER, PS_OBJECT_DATA]])
			-- Apply `operation' on all items.
			-- Ignore items when {PS_OBJECT_DATA}.handler is void or {PS_OBJECT_DATA}.is_ignored is True.
		do
			do_all_in_set (operation, 1 |..| count)
		end

	do_all_in_set (operation: PROCEDURE[ANY, TUPLE[PS_HANDLER, PS_OBJECT_DATA]]; set: INDEXABLE[INTEGER, INTEGER])
			-- Apply `operation' on all items with an index in `set'.
			-- Ignore items when {PS_OBJECT_DATA}.handler is void or {PS_OBJECT_DATA}.is_ignored is True.
			-- Do nothing if `from_index' > `to_index'
--		require
--			indices_valid: 1 <= from_index and to_index <= count
		local
			index: INTEGER
		do
			across
				set as idx_cursor
			loop
				index := idx_cursor.item
				if
					item(index).is_handler_initialized
					and not item(index).is_ignored
				then
					operation.call ([item(index).handler, item(index)])
				end
			end
		end

feature {NONE} -- Internal data structures

	identity_type_handlers: ARRAYED_LIST[PS_HANDLER]
			-- All identity type handlers.

	value_type_handlers: ARRAYED_LIST[PS_HANDLER]
			-- All value type handlers.

	object_storage: ARRAYED_LIST[PS_OBJECT_DATA]
			-- An internal storage for objects.

	internal_transaction: detachable like transaction
			-- The detachable attribute for `transaction'
end
