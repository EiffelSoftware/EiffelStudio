class CMD_I_ED_HOLE

inherit

	EDIT_BUTTON
		redefine
			process_stone
		end;

creation
	make

feature

	make (a_name: STRING; a_parent: COMPOSITE) is
		do
			make_visible (a_parent);
			set_symbol (Command_instance_pixmap);
			initialize_focus;
		end;

	process_stone is
		local
			inst: CMD_INSTANCE;
		do
			inst ?= stone.original_stone;
			if inst /= Void then
				inst.create_editor;
			end;
		end;

feature {NONE}

	focus_label: LABEL is
		do
			Result := main_panel.focus_label;
		end;

	focus_string: STRING is "Command instance hole";
	

end
