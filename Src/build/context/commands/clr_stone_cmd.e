

    -- Command used for the copy of
    -- the colors,
    -- using an attrib_stone from a context editor

class CLR_STONE_CMD 

inherit

	CONTEXT_CMD
		redefine
			work
		
		end;
	EDITOR_FORMS
		export
			{NONE} all
		end;
	COMMAND_NAMES
		rename
			C_olors_cmd_name as c_name
		export
			{NONE} all
		end



	
feature {NONE}

	bg_cmd: BG_STONE_CMD;

	fg_cmd: FG_STONE_CMD;

	
feature 

	work (argument: CONTEXT) is
		do
			context := argument;
			!!bg_cmd;
			bg_cmd.work (context);
			!!fg_cmd;
			fg_cmd.work (context);
		end;

	
feature {NONE}

	associated_form: INTEGER is
		do
			Result := color_form_number
		end;

	context_undo is
		do
			bg_cmd.undo;
			fg_cmd.undo;
		end;

	context_work is do end;

end
