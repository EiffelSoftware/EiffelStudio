indexing
	description: "";
	date: "$Date$";
	revision: "$Revision$"

class
	LABEL_BOX

inherit

	ICON_BOX [CMD_LABEL]
		rename
			make as box_create
		export
			{ANY} all
		redefine
			new_icon, create_new_icon
		end
	

creation

	make

	
feature {NONE}

	cmd_editor: COMMAND_EDITOR

	
feature -- Creation

	make (a_name: STRING; a_parent: COMPOSITE; ed: like cmd_editor) is
		local
			scrolled_w: SCROLLED_W
		do
			cmd_editor := ed;
			box_create (a_name, a_parent)
			scrolled_w ?= a_parent
			if scrolled_w /= Void then
				scrolled_w.set_working_area (Current)
			end
			set_row_layout
			set_preferred_count (6)
		end;

feature

	remove_label (a_label: CMD_LABEL) is
			-- Remove `a_label'.
		do
			from
				start
			until
				after or else item.same (a_label)
			loop
				forth
			end
			if not after then
				remove
			end
		end
	
feature {NONE}

	new_icon: LABEL_ICON;
		
	create_new_icon is
		do
			!!new_icon.make (cmd_editor)
		end;

end -- class LABEL_BOX
