
class ARG_BOX 

inherit

	ICON_BOX [ARG]
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

	cmd_editor: CMD_EDITOR;

feature 

	make (a_name: STRING; a_parent: COMPOSITE; ed: CMD_EDITOR) is
		do
			cmd_editor := ed;
			box_create (a_name, a_parent)
		end;
	
feature {NONE}

	new_icon: ARG_ICON;
		
	create_new_icon is
		do
			!!new_icon.make (cmd_editor)
		end;

end

