
class TEXT_HEIGHT_CMD 

inherit

	CONTEXT_CMD
		redefine
			context
		
		end;
	EDITOR_FORMS
		export
			{NONE} all
		end;
	COMMAND_NAMES
		rename
			T_ext_height_cmd_name as c_name
		export
			{NONE} all
		end



	
feature {NONE}

	associated_form: INTEGER is
		do
			Result := text_form_number
		end;

	context: TEXT_C;

	old_margin_height: INTEGER;

	context_work is
		do
			old_margin_height := context.margin_height;
		end;

	context_undo is
		local
			new_h: INTEGER;
		do
			new_h := context.margin_height;
			context.set_margin_height (old_margin_height);
			old_margin_height := new_h;
		end;

end
