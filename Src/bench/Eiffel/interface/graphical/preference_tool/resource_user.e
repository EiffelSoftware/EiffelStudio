indexing

	description:
		"Abstarct notion of a user of resources.";
	date: "$Date$";
	revision: "$Revision$"

class RESOURCE_USER

feature -- Update

	update_boolean_resource (a_modified_resource: MODIFIED_RESOURCE) is
			-- Update Current to reflect changes in `a_modified_resource'.
		do
		end;

	update_integer_resource (a_modified_resource: MODIFIED_RESOURCE) is
			-- Update Current to reflect changes in `a_modified_resource'.
		do
		end;

	update_string_resource (a_modified_resource: MODIFIED_RESOURCE) is
			-- Update Current to reflect changes in `a_modified_resource'.
		do
		end

end -- class RESOURCE_USER
