indexing

	description:
		"Abstarct notion of a user of resources."
	date: "$Date$"

deferred class
	EB_RESOURCE_USER

feature -- Dispatch

	dispatch_modified_resource (mod_res: EB_MODIFIED_RESOURCE) is
			-- Dispatch modified resource based on
			-- the actual type of `old_res'.
		do
--			old_b ?= old_res
--			if old_b /= Void then
--				new_b ?= new_res
--				update_boolean_resource (old_b, new_b)
--			else
--				old_i ?= old_res
--				if old_i /= Void then
--					new_i ?= new_res
--					update_integer_resource (old_i, new_i)
--				else
--					old_s ?= old_res
--					if old_s /= Void then
--						new_s ?= new_res
--						update_string_resource (old_s, new_s)
--					end
--				end
--			end
		update_resource (mod_res)
		end

	update_resource (mod_res: EB_MODIFIED_RESOURCE) is
			-- Update Current to reflect changes in `a_modified_resource'.
		do
			mod_res.old_resource.update_with (mod_res.new_resource)
		end

	finish_update is
			-- Finish the update of resources.
		do
		end

end -- class EB_RESOURCE_USER
