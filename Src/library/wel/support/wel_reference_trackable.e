note
	description: "Facility to track references of an object."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WEL_REFERENCE_TRACKABLE

inherit
	IDENTIFIED_ROUTINES

feature -- Status Report

	reference_tracked: BOOLEAN
			-- Are number references of `Current' tracked?

	shared: BOOLEAN
			-- Is `item' shared by another object?
			-- If False (by default), `item' will
			-- be destroyed by `destroy_item'.
			-- If True, `item' will not be destroyed.
		deferred
		end

	exists: BOOLEAN
			-- Is `Current' valid?
		deferred
		end

	references_count: INTEGER
			-- Number of object referring to current object.

feature -- Status Setting

	object_id: INTEGER
			-- Runtime Id of `Current'.
		do
			if internal_object_id = 0 then
				internal_object_id := eif_object_id (Current)
			end
			Result := internal_object_id
		end

	enable_reference_tracking
			-- Set `references_tracked' to True.
		require
			exists: exists
			tracking_reference_not_started: not reference_tracked
		do
			reference_tracked := True
			if not shared then
				references_count := 1
			else
				references_count := -1 -- Shared
			end

				-- Give a unique number to current object, to follow it.
			internal_number_id := internal_number_id_cell.item
			debug ("WEL_GDI_REFERENCES")
				io.put_string_32 ({STRING} "references are enabled for object #" + internal_number_id.out + "%N")
				internal_id_list.extend (internal_number_id)
			end
			internal_number_id_cell.put (internal_number_id + 1)
		end

	decrement_reference
			-- Decrement number of references to current object.
			-- When number of references reaches zero,
			-- `delete' is called if object is not protected.
		require
			exists: exists
			tracking_references_started: reference_tracked
		do
			if references_count > 0 then
				references_count := references_count - 1
				if references_count = 0 then
					destroy_item
					debug ("WEL_GDI_REFERENCES")
						internal_id_list.prune_all (internal_number_id)
						io.put_string_32 ({STRING} "Object #" + internal_number_id.out + " destroyed%N")
						io.put_string_32 ({STRING} "Objects currently tracked: ")
						from
							internal_id_list.start
						until
							internal_id_list.after
						loop
							io.put_string_32 (internal_id_list.item.out + " ")
							internal_id_list.forth
						end
						io.put_string ("%N%N")
					end
				end
			else
				debug ("WEL_GDI_REFERENCES")
					if references_count = 0 then
						io.put_string (
							"Error: `decrement_reference' was called with an invalid object%N")
						io.put_string ("Object: %N")
						print (Current)
					end
				end
			end
		end

	increment_reference
			-- Increment number of references to current object.
		require
			exists: exists
			tracking_references_started: reference_tracked
		do
			if references_count > 0 then
				references_count := references_count + 1
			end
		end

feature {NONE} -- Removal

	dispose
			-- Destroy inner structure of `Current'.
			--| Called by GC when object is collected,
			--| developer should use `delete'.
		do
			if exists and then not shared then
				debug ("WEL_GDI_REFERENCES")
					if reference_tracked and references_count > 0 then
						print ("----------------------------------------------------------------%N")
						print ("Warning, reference tracking was enabled for the following object%N")
						print ("but `reference_number' was not equal to zero at dispose time%N%N")
						print ("Put a conditional breakpoint in `enable_reference_tracking' to%N")
						print ("discover when the object with `internal_number_id'=")
						print (internal_number_id.out)
						print (" is created.%N%N")
						print (Current)
						print ("----------------------------------------------------------------%N")
					end
				end
				destroy_item
			end
			if internal_object_id /= 0 then
				eif_object_id_free (internal_object_id)
				internal_object_id := 0
			end
		ensure then
			internal_object_id_freed: internal_object_id = 0
		end

feature -- Removal

	delete
			-- Destroy inner structure of `Current'.
			-- To be called when Current is no more needed
		require
			reference_not_tracked: not reference_tracked
		do
 			if exists and then not shared then
				destroy_item
			end
		ensure
			destroyed: not shared implies not exists
		end

feature {NONE} -- Removal

	destroy_item
			-- Ensure current object is destroyed.
		require
			exists: exists
		deferred
		ensure
			destroyed: not exists
		end

feature {NONE} -- Implementation

	internal_object_id: INTEGER
			-- Object ID of Current if recorded.

	internal_number_id: INTEGER
			-- For debugging purpose only.
			--| Number identifying uniquely every object (do not change
			--| during whole run). Helps debugging object disposed
			--| by a reference_number > 0

	internal_number_id_cell: CELL [INTEGER]
			-- Cell to give a unique integer to each new object.
		once
			create Result.put (0)
		end

	internal_id_list: ARRAYED_LIST [INTEGER]
			-- Cell to give a unique integer to each new object.
		once
			create Result.make (10)
		end

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class WEL_REFERENCE_TRACKABLE

