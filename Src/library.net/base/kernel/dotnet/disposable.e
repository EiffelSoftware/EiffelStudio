indexing
	description:
		"Perform cleanup operations before current instance is reclaimed by garbage collection."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	DISPOSABLE

feature -- Removal

	dispose is
			-- Action to be executed just before garbage collection
			-- reclaims an object.
			-- Effect it in descendants to perform specific dispose
			-- actions. Those actions should only take care of freeing
			-- external resources; they should not perform remote calls
			-- on other objects since these may also be dead and reclaimed.
		deferred
		end

feature {NONE} -- Status report

	is_in_final_collect: BOOLEAN is False
			-- Is GC currently performing final collection
			-- after execution of current program?
			-- Safe to use in `dispose'.
			-- On .NET there is no way to access this information
			-- therefore it will always be False.
	
end
