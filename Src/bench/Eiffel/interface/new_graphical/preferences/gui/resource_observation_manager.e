indexing
	description:
		"Resource manager. Provide features for registering observers to resources%
		%for them to be notified when resources are changed"
	author: "Christophe Bonnard"
	date: "$Date$"
	revision: "$Revision$"

class
	RESOURCE_OBSERVATION_MANAGER

inherit
	SHARED_RESOURCES

feature -- Access

	observer_manager: OBSERVER_MANAGEMENT is
			-- Observer manager.
		once
			create Result.make
		end

feature -- Basic operations

	add_observer (s: STRING; w: OBSERVER) is
		-- register w to the resource of name s, if any
		require
			w_exists: w /= Void
		local
			r: RESOURCE
		do
			r := resources.item (s)
			if r /= Void then
				observer_manager.add_observer (r, w)
			end
		end

	remove_observer (s: STRING; w: OBSERVER) is
		-- unregister w to the resource of name s, if any
		require
			w_exists: w /= Void
		local
			r: RESOURCE
		do
			r := resources.item (s)
			if r /= Void then
				observer_manager.remove_observer (r, w)
			end
		end

end -- class RESOURCE_OBSERVATION_MANAGER
