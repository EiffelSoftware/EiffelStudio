indexing
	description: "Manager for class tools"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CLASS_TOOL_LIST

inherit
	EB_EDIT_TOOL_LIST [EB_CLASS_TOOL]
		redefine
			make,
			dispatch_modified_resource
		end

--	SHARED_FORMAT_TABLES

creation
	make

feature -- Initialization

	make is
			-- Initialize Current.
		do
			precursor
--			Class_resources.add_user (Current)
		end

feature -- Access

	raise_shell_popup is
			-- Raise the shell command popup window if it is popped up.
		local
			c: CURSOR
		do
			from
				c := cursor
				start
			until
				after
			loop
				item.raise_shell_popup
				forth
			end
			go_to (c)
		end

feature -- Update

	dispatch_modified_resource (mod_res: EB_MODIFIED_RESOURCE) is
			-- Dispatch modified resource based on
			-- the actual type of `old_res'.
		local
			old_a, new_a: EB_ARRAY_RESOURCE
			old_b, new_b: EB_BOOLEAN_RESOURCE
			old_i, new_i: EB_INTEGER_RESOURCE
		do
			old_b ?= mod_res.old_resource
			if old_b /= Void then
				new_b ?= mod_res.new_resource
				update_boolean_resource (old_b, new_b)
			else
				old_i ?= mod_res.old_resource
				if old_i /= Void then
					new_i ?= mod_res.new_resource
					update_integer_resource (old_i, new_i)
				else
					old_a ?= mod_res.old_resource
					if old_a /= Void then
						new_a ?= mod_res.new_resource
						update_array_resource (old_a, new_a)
					end
				end
			end
		end

	update_array_resource (old_res, new_res: EB_ARRAY_RESOURCE) is
			-- Update `old_res' with the value of `new_res',
			-- if the value of `new_res' is applicable.
			-- Also update the interface.
		local
--			cr: like Class_resources
		do
--			cr := Class_resources
--			if old_res = cr.feature_clause_order then
--				clear_class_tables
--			end
--			old_res.update_with (new_res)
		end

end -- class EB_CLASS_TOOL_LIST
