
class EB_FG_COLOR_TF 

inherit

	EB_TEXT_FIELD
		rename
			make as old_create
		-- added by samik
        undefine
            init_toolkit
        -- end of samik     
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
			cmd: FG_STONE_CMD;
			a_context: CONTEXT
		do
			a_context := editor.edited_context;
			!!cmd;
			cmd.execute (a_context);
			a_context.set_fg_color_name (dropped.color_name);
			context_catalog.update_editors (a_context, Context_const.color_form_nbr);
		end;

end

