indexing

	description:
		"Abstract notion of a category of resources."
	date: "$Date$";
	revision: "$Revision$"

deferred class RESOURCE_CATEGORY

feature -- Validation

	valid (a_resource: RESOURCE): BOOLEAN is
			-- Is `a_resource' valid for Current?
		deferred
		end

feature -- Initialization

	initialize (rt: RESOURCE_TABLE) is
			-- Initialize all resources for Current.
		require
			rt_valid: rt /= Void
		deferred
		end

feature -- Access

	users: LINKED_LIST [RESOURCE_USER];
			-- Users of Current

	add_user (a_user: RESOURCE_USER) is
			-- Add `a_user' to `users'.
		do
			users.extend (a_user)
		end;

	modified_resources: LINKED_LIST [MODIFIED_RESOURCE];
			-- Modified resources for Current

	add_modified_resource (a_modified_resource: MODIFIED_RESOURCE) is
			-- Add `a_modified_resource' to `a_modified_resources'.
		require
			a_modified_resource_not_void: a_modified_resource /= Void
			a_modified_resource_is_valid:
				a_modified_resource.old_resource /= Void and
				a_modified_resource.new_resource /= Void
		do
			modified_resources.extend (a_modified_resource)
		end;

	linear_representation: LINKED_LIST [RESOURCE] is
			-- All resources within Current
		deferred
		end

feature -- Update

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
					dispatch_modified_resource (modified_resources.item);
					users.forth
				end;
				modified_resources.forth
			end
		end

	dispatch_modified_resource (a_modified_resource: MODIFIED_RESOURCE) is
			-- Dispatch `a_modified_resource' to `users.item' based on
			-- on the actual type of `a_modified_resource.old_resource'.
		local
			boolean: BOOLEAN_RESOURCE
			integer: INTEGER_RESOURCE
			string: STRING_RESOURCE
		do
			boolean ?= a_modified_resource.old_resource;
			if boolean /= Void then
				users.item.update_boolean_resource (a_modified_resource)
			else
				integer ?= a_modified_resource.old_resource;
				if integer /= Void then
					users.item.update_integer_resource (a_modified_resource)
				else
					string ?= a_modified_resource.old_resource;
					if string /= Void then
						users.item.update_string_resource (a_modified_resource)
					end
				end
			end
		end

end -- class RESOURCE_CATEGORY
