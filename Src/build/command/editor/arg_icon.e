
class ARG_ICON 

inherit

	TYPE_STONE;
	ICON_STONE
		undefine
			stone_cursor, stone
		redefine
			data, set_widget_default
		end;
	REMOVABLE

creation

	make
	
feature {NONE}

	cmd_editor: CMD_EDITOR;
	
feature 

	make (ed: CMD_EDITOR) is
		do
			cmd_editor := ed
		end;

	set_widget_default is
		do
			initialize_transport;
		end;

	remove_yourself is
		do
--			cmd_editor.remove_argument (data)
		end;

	data: ARG;

end
