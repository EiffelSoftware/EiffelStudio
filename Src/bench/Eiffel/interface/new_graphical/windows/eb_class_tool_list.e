indexing
	description: "Manager for class tools"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CLASS_TOOL_LIST

inherit
	EB_EDIT_TOOL_LIST [EB_CLASS_TOOL]
		redefine
			make
		end

--	SHARED_FORMAT_TABLES

creation
	make

feature -- Initialization

	make is
			-- Initialize Current.
		do
			precursor
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

feature -- Save command

	save_all is
		local
			c: CURSOR
		do
			from
				c := cursor
				start
			until
				after
			loop
				if item.text_window.changed then
					item.save_text
				end
				forth
			end
			go_to (c)
		end

feature -- Update

	update_boolean_resource (old_res, new_res: EB_BOOLEAN_RESOURCE) is
			-- Update all active class tools according to
			-- `new_res'.
		do
			from
				start
			until
				after
			loop
--				item.update_boolean_resource (old_res, new_res)
				forth
			end
		end

	update_integer_resource (old_res, new_res: EB_INTEGER_RESOURCE) is
			-- Update all active class tools according to
			-- `new_res'.
		do
			from
				start
			until
				after
			loop
--				item.update_integer_resource (old_res, new_res)
				forth
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
