indexing

	description:
		"Abstarct notion of a user of resources.";
	date: "$Date$";
	revision: "$Revision$"

class RESOURCE_USER

feature -- Dispatch

	dispatch_modified_resource (old_res, new_res: RESOURCE) is
			-- Dispatch `a_modified_resource' to `users.item' based on
			-- on the actual type of `a_modified_resource.old_resource'.
		local
			old_b, new_b: BOOLEAN_RESOURCE
			old_i, new_i: INTEGER_RESOURCE
			old_s, new_s: STRING_RESOURCE
		do
			old_b ?= old_res;
			if old_b /= Void then
				new_b ?= new_res;
				update_boolean_resource (old_b, new_b)
			else
				old_i ?= old_res;
				if old_i /= Void then
					new_i ?= new_res;
					update_integer_resource (old_i, new_i)
				else
					old_s ?= old_res;
					if old_s /= Void then
						new_s ?= new_res;
						update_string_resource (old_s, new_s)
					end
				end
			end
		end

	update_boolean_resource (old_res, new_res: BOOLEAN_RESOURCE) is
			-- Update Current to reflect changes in `a_modified_resource'.
		do
			old_res.update_with (new_res)
		end;

	update_integer_resource (old_res, new_res: INTEGER_RESOURCE) is
			-- Update Current to reflect changes in `a_modified_resource'.
		do
			old_res.update_with (new_res)
		end;

	update_string_resource (old_res, new_res: STRING_RESOURCE) is
			-- Update Current to reflect changes in `a_modified_resource'.
		do
			old_res.update_with (new_res)
		end

end -- class RESOURCE_USER
