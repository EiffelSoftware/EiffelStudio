indexing

	description:
		"Abstarct notion of a user of resources."
	author: "christophe"
	date: "$Date$"

deferred class
	EB_RESOURCE_USER

inherit
	OBSERVER

	RESOURCE_OBSERVATION_MANAGER

feature -- Implementation

	register_to (s: STRING) is
		do
			add_observer (s, Current)
		end

	unregister_to (s: STRING) is
		do
			remove_observer (s, Current)
		end

feature -- Basic Operations

	register is
		deferred
		end

	unregister is
		deferred
		end

end -- class EB_RESOURCE_USER
