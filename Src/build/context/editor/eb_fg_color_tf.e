
class EB_FG_COLOR_TF 

inherit

	EB_TEXT_FIELD
		rename
			make as old_create
		end;
	CONSTANTS
	HOLE
		redefine
			process_color
		end;


creation

	make

	
feature {NONE}

	editor: CONTEXT_EDITOR;

	Fg_color_cmd: FG_COLOR_CMD is
		once
			!!Result
		end;

	make (a_name: STRING; 
				a_parent: COMPOSITE; 
				an_editor: CONTEXT_EDITOR) is
		do
			editor := an_editor;
			old_create (a_name, a_parent, Fg_color_cmd, an_editor);
			register;
		end;

feature {NONE}

	target: WIDGET is
		do
			Result := Current
		end;

	stone_type: INTEGER is
		do
			Result := Stone_types.color_type
		end;

	process_color (dropped: COLOR_STONE) is
		local
			cmd: like Fg_color_cmd;
		do
			set_text (dropped.color_name);
			!!cmd;
			cmd.execute (editor);
		end;

end

