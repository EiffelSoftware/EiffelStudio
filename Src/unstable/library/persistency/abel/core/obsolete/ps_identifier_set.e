note
	description: "Collects object identifiers."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"
	TODO: "[
		Speedup things, e.g. by separating objects by class name...
		Also the invariant check takes a very long time, maybe disable it
		The number in ANY.tagged_out is not stable, but stable enough that we might first try to hash on it and then, if the memory location has changed, look at big list
	]"

class
	PS_IDENTIFIER_SET

inherit

	PS_ABEL_EXPORT

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			create deleted_objects.make (0)
			create weak_reference_items.make (50)
			create garbage_collected_items.make (0)
		end

feature {PS_ABEL_EXPORT} -- Access

	identifier (object: ANY): INTEGER
			-- Get the identifier for `object'
		require
			identified: is_identified (object)
		do
			Result := actual_identifier (object)
		end

	current_items: ARRAYED_LIST [TUPLE [object: ANY; identifier: INTEGER]]
			-- All objects and their identifiers in the set.
		do
			create Result.make (weak_reference_items.count)
			across
				weak_reference_items as cursor
			loop
				if attached cursor.item.object.item as strong_ref then
					Result.extend ([strong_ref, cursor.item.identifier])
				end
			end
		end

	deleted_objects: ARRAYED_LIST [ANY]
			-- All object identifiers that have been deleted

feature {PS_ABEL_EXPORT} -- Status report

	is_identified (object: ANY): BOOLEAN
			--Does `Current' have an identifier for `object'?
		do
			Result := not is_deleted (object) and then has_identifier (object)
		end

	is_deleted (object: ANY): BOOLEAN
			-- Has the identifier for `object' been deleted?
		do
			Result := deleted_objects.has (object)
		end

feature {PS_ABEL_EXPORT} -- Element change

	add_identifier (object: ANY; new_identifier: INTEGER)
			-- Add `object' with identifier `new_identifier' to the set
		do
			weak_reference_items.put_front ([create {WEAK_REFERENCE [ANY]}.put (object), new_identifier])
		ensure
			identified: is_identified (object)
			correct: identifier (object) = new_identifier
		end

	delete_identifier (object: ANY)
			-- Delete the idenifier for `object'
		do
			deleted_objects.put_front (object)
		ensure
			not_identified: not is_identified (object)
			deleted: is_deleted (object)
		end

feature {PS_ABEL_EXPORT} -- Set operations

	merge (other: PS_IDENTIFIER_SET)
			-- Merge `Current' with `other'
		require
			equal_objects_have_equal_identifier: across other.current_items as cursor all Current.is_identified (cursor.item.object) implies cursor.item.identifier = identifier (cursor.item.object) end
			deleted_objects_exist: across other.deleted_objects as cursor all is_identified (cursor.item) end
		do
				-- First add all identifiers
			across
				other.current_items as cursor
			loop
				add_identifier (cursor.item.object, cursor.item.identifier)
			end
				-- Then perform all deletions
			from
				weak_reference_items.start
			until
				weak_reference_items.after
			loop
				if attached weak_reference_items.item.object.item as attached_item and then other.deleted_objects.has (attached_item) then
					weak_reference_items.remove
				else
					weak_reference_items.forth
				end
			end
		ensure
			all_added: across other.current_items as cursor all is_identified (cursor.item.object) end
			correctly_deleted: across other.deleted_objects as cursor all not is_identified (cursor.item) end
		end

feature {PS_ABEL_EXPORT} -- Cleanup

	garbage_collected_items: ARRAYED_LIST [INTEGER]
			-- All identifiers whose objects have been garbage collected

feature {NONE} -- Implementation

	weak_reference_items: ARRAYED_LIST [TUPLE [object: WEAK_REFERENCE [ANY]; identifier: INTEGER]]
			-- The actual store with weak references

	has_identifier (object: ANY): BOOLEAN
			-- Does the actual store have an identifier for `object'?
			-- TODO: This query has side effects that should be removed.
		do
			from
				weak_reference_items.start
				Result := False
			until
				weak_reference_items.after or Result
			loop
				if attached weak_reference_items.item.object.item as strong_ref then
						-- See if the objects are the same.
					Result := Result or (strong_ref = object)
					weak_reference_items.forth
				else
						-- Found a garbage-collected item
					garbage_collected_items.extend (weak_reference_items.item.identifier)
					fixme ("For performance reasons, rather copy items to a second location or use two cursors for reading and inserting.")
					weak_reference_items.remove
				end
			end
		end

	actual_identifier (object: ANY): INTEGER
			-- Get the actual identifier from the store.
			-- TODO: This query has side effects that should be removed.
		require
			has_identifier (object)
		local
			found: BOOLEAN
		do
			from
				weak_reference_items.start
				found := False
			until
				weak_reference_items.after or found
			loop
				if attached weak_reference_items.item.object.item as strong_ref then
						-- See if the objects are the same and then return the identifier
					if strong_ref = object then
						Result := weak_reference_items.item.identifier
						found := True
					end
					weak_reference_items.forth
				else
						-- Found a garbage-collected item
					garbage_collected_items.extend (weak_reference_items.item.identifier)
					weak_reference_items.remove
				end
			end
		end

feature {NONE} -- Invariant checking

	are_objects_identified_only_once: BOOLEAN
			-- Is there an object in the set that has been identified twice?
			-- PLEASE NOTE: This is a very expensive operation - it basically doubles the time needed for some unit tests.
		do
			fixme ("Use a set or a hash table")
			Result := across current_items as cursor all across current_items as inner_cursor all cursor.item.object = inner_cursor.item.object implies cursor.item.identifier = inner_cursor.item.identifier end end
		end

invariant
--	no_object_twice_in_set: are_objects_identified_only_once

end
