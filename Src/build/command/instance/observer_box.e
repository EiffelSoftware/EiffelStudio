indexing
	description: "A box to add observers to a command instance. %
				% Used in a command instance editor";
	date: "$Date$";
	revision: "$Revision$"

class
	OBSERVER_BOX

inherit
	ICON_BOX [CMD_INSTANCE]
		rename
			make as box_create
		export
			{ANY} all
		redefine
			new_icon,
			create_new_icon
		end	
	
creation
	make
	
feature 

	make (a_name: STRING; a_parent: COMPOSITE; ed: COMMAND_TOOL) is
		local
			parent_scrolled_w: SCROLLED_W
		do
			inst_editor := ed
			box_create (a_name, a_parent)
			parent_scrolled_w ?= a_parent
			if parent_scrolled_w /= Void then
				parent_scrolled_w.set_working_area (Current)
			end
			set_row_layout
			set_preferred_count (5)
		end;

feature {NONE}

	inst_editor: COMMAND_TOOL
		-- Associated command instance editor

	new_icon: OBSERVER_ICON
		
	create_new_icon is
			-- Create the icon representing the stone.
		do
			!! new_icon.make (inst_editor)
		end

end -- class OBSERVER_BOX
