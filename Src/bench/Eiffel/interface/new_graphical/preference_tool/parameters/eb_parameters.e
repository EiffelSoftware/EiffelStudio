indexing
	description: "Abstract notion of a list of parameters"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_PARAMETERS

feature -- Initialization

	make is
			-- Initialize
		do
			create users.make
			create modified_resources.make
		end

feature -- Access

	users: LINKED_LIST [EB_RESOURCE_USER]
			-- Users of Current
			-- Each user is expected to be present
			-- once only in `users'

	add_user (a_user: EB_RESOURCE_USER) is
			-- Add `a_user' to `users'.
		do
			users.extend (a_user)
		end

	remove_user (a_user: EB_RESOURCE_USER) is
			-- Remove `a_user' from `users'.
		do
			users.prune_all (a_user)
		end

	modified_resources: LINKED_LIST [EB_MODIFIED_RESOURCE]
			-- Modified resources for Current

	add_modified_resource (a_modified_resource: EB_MODIFIED_RESOURCE) is
			-- Add `a_modified_resource' to `modified_resources'.
		require
			a_modified_resource_not_void: a_modified_resource /= Void
		do
			modified_resources.extend (a_modified_resource)
		end

	remove_modified_resource (a_modified_resource: EB_MODIFIED_RESOURCE) is
			-- Remove `a_modified_resource' from `modified_resources'.
		require
			a_modified_resource_not_void: a_modified_resource /= Void
		do
			modified_resources.prune (a_modified_resource)
		end

	update is
			-- Update all users to reflect Current.
		do
			from
				modified_resources.start
			until
				modified_resources.after
			loop
				from
					users.start
				until
					users.after
				loop
					users.item.dispatch_modified_resource (modified_resources.item)
					users.forth
				end
				modified_resources.item.update
				modified_resources.forth
			end
			from
				users.start
			until
				users.after
			loop
				users.item.finish_update
				users.forth
			end
			modified_resources.wipe_out
		end

end -- class EB_PARAMETERS
