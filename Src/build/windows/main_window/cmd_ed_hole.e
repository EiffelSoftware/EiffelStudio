indexing
	description: "Button used to raise a command tool %
				% targeted on the command corresponding %
				% to the dropped stone."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class 
	
	CMD_ED_HOLE

inherit

	EDIT_BUTTON
		redefine
			process_command, process_instance,
			compatible, make
		end;

creation
	make

feature {NONE}

    make (a_parent: COMPOSITE) is
        do
            Precursor (a_parent)
        end

	symbol: PIXMAP is
		do
			Result := Pixmaps.command_pixmap
		end;

	stone_type: INTEGER is
		do
			Result := Stone_types.command_type
		end;

	compatible (st: STONE): BOOLEAN is
		do
			Result :=
				st.stone_type = Stone_types.command_type or else
				st.stone_type = Stone_types.instance_type
		end;

	process_command (dropped: CMD_STONE) is
		do
			dropped.data.create_editor
		end;

	process_instance (dropped: CMD_INST_STONE) is
		do
			dropped.associated_command.create_editor
		end;

	create_focus_label is 
		do
			set_focus_string (Focus_labels.command_type_label)
		end;

	create_empty_editor is
		do
			window_mgr.display (window_mgr.command_tool)	
		end;

end
