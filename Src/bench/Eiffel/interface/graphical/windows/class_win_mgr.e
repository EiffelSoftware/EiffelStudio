indexing
	description: "Window manager for class tools."
	date: "$Date$"
	revision: "$Revision$"

class
	CLASS_WIN_MGR 

inherit
	EDITOR_MGR
		redefine
			editor_type, make, update_array_resource
		end

	SHARED_FORMAT_TABLES

creation
	make

feature -- Initialization

	make (a_screen: SCREEN) is
			-- Initialize Current.
		do
			{EDITOR_MGR} Precursor (a_screen)
			Class_resources.add_user (Current)
		end

feature -- Access

	raise_shell_popup is
			-- Raise the shell command popup window if it is popped up.
		local
			c: CURSOR
		do
			from
				c := active_editors.cursor
				active_editors.start
			until
				active_editors.after
			loop
				active_editors.item.raise_shell_popup
				active_editors.forth
			end
			active_editors.go_to (c)
		end

feature -- Update

	update_array_resource (old_res, new_res: ARRAY_RESOURCE) is
			-- Update `old_res' with the value of `new_res',
			-- if the value of `new_res' is applicable.
			-- Also update the interface.
		local
			cr: like Class_resources
		do
			cr := Class_resources
			if old_res = cr.feature_clause_order then
				clear_class_tables
			end
			{EDITOR_MGR} Precursor (old_res, new_res)
		end

feature {NONE} -- Properties

	editor_type: CLASS_W

	create_editor: CLASS_W is
			-- Create a new class tool.
		do
			!! Result.make (screen)
		end

end -- class CLASS_WIN_MGR
