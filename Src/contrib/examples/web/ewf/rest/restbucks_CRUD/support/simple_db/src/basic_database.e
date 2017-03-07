note
	description: "[
			Basic database for simple example.
			
			(no concurrency access control, ...)
		]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	BASIC_DATABASE

feature -- Access

	count_of (a_entry_type: TYPE [detachable ANY]): INTEGER
		deferred
		end

	has (a_entry_type: TYPE [detachable ANY]; a_id: READABLE_STRING_GENERAL): BOOLEAN
			-- Has entry of type `a_entry_type` associated with id `a_id`?
		deferred
		end

	item (a_entry_type: TYPE [detachable ANY]; a_id: READABLE_STRING_GENERAL): detachable ANY
		deferred
		end

	save (a_entry_type: TYPE [detachable ANY]; a_entry: detachable ANY; cl_entry_id: CELL [detachable READABLE_STRING_GENERAL])
		deferred
		ensure
			has_id: cl_entry_id.item /= Void
		end

	delete (a_entry_type: TYPE [detachable ANY]; a_id: READABLE_STRING_GENERAL)
		require
			has_item: has (a_entry_type, a_id)
		deferred
		ensure
			has_not_item: not has (a_entry_type, a_id)
		end

	wipe_out
			-- Remove all items, and delete the database
		deferred
		end

note
	copyright: "2011-2017, Javier Velilla and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
