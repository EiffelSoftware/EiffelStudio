indexing
	description	: "Abstract notion of a user of resources."
	author		: "Christophe Bonnard"
	date		: "$Date$"

deferred class
	EB_RESOURCE_USER

inherit
	OBSERVER

	RESOURCE_OBSERVATION_MANAGER

feature -- Implementation

	register_to (s: STRING) is
			-- Specify that update must be call each time
			-- resource named `s' is changed.
		do
			add_observer (s, Current)
		end

	unregister_to (s: STRING) is
			-- Specify that update will not be call anymore
			-- when resource named `s' changes.
		do
			remove_observer (s, Current)
		end

feature -- Basic Operations

	register is
			-- Ask the resource manager ro notify Current (i.e. to call `update') each
			-- time one of the resources he needs has changed.
			-- Usually called once, during creation.
		deferred
		end

	unregister is
			-- Ask the resource manager not to notify Current anymore
			-- when a resource has changed
			-- Usually called once, during destruction.
		deferred
		end

end -- class EB_RESOURCE_USER
