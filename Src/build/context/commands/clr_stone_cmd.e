-- Command used for the copy of the colors,
-- using an attrib_stone from a context editor

class CLR_STONE_CMD 

inherit

	CONTEXT_CMD
		redefine
			work
		end
	
feature {NONE}

	bg_cmd: BG_COLOR_CMD;

	fg_cmd: FG_COLOR_CMD;

feature 

	work (argument: ANY) is
		local
			ed: CONTEXT_EDITOR
		do
			ed ?= argument;
			context := ed.edited_context;
			!!bg_cmd;
			bg_cmd.work (ed);
			!!fg_cmd;
			fg_cmd.work (ed);
		end;

feature {NONE}

	c_name: STRING is
		do
			Result := Command_names.cont_colors_cmd_name
		end;

	associated_form: INTEGER is
		do
			Result := Context_const.color_form_nbr
		end;

	context_undo is
		do
			bg_cmd.undo;
			fg_cmd.undo;
		end;

	context_work is do end;

end
