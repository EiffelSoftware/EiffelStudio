indexing

	description:
		"A resource that has been modified.";
	date: "$Date$";
	revision: "$Revision$"

class MODIFIED_RESOURCE

create
	make

feature {NONE} -- Initialization

	make (old_res, new_res: RESOURCE) is
			-- Initialize Current with `old_resource' as `old', and
			-- `new_resource' as `new'.
		require
			old_res_not_void: old_res /= Void;
			new_res_not_void: new_res /= Void
		do
			old_resource := old_res;
			new_resource := new_res
		end

feature -- Setting

	set_old_resource (a_resource: RESOURCE) is
			-- Set `old_resource' to `a_resource'.
		require
			a_resource_not_void: a_resource /= Void
		do
			old_resource := a_resource
		ensure
			old_resource_set: old_resource.is_equal (a_resource)
		end;

	set_new_resource (a_resource: RESOURCE) is
			-- Set `new_resource' to `a_resource'.
		require
			a_resource_not_void: a_resource /= Void
		do
			new_resource := a_resource
		ensure
			new_resource_set: new_resource.is_equal (a_resource)
		end

feature -- Properties

	old_resource: RESOURCE;
			-- The resource as before the modification

	new_resource: RESOURCE
			-- The resource as after the modification

invariant

	old_resource_not_void: old_resource /= Void;
	new_resource_not_void: new_resource /= Void

end -- class MODIFIED_RESOURCE
