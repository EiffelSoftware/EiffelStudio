note
	description:
		"Perform cleanup operations before current instance is reclaimed by garbage collection."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	DISPOSABLE

feature -- Removal

	dispose
			-- Action to be executed just before garbage collection
			-- reclaims an object.
			-- Effect it in descendants to perform specific dispose
			-- actions. Those actions should only take care of freeing
			-- external resources; they should not perform remote calls
			-- on other objects since these may also be dead and reclaimed.
		deferred
		end

end
