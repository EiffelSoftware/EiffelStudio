
class TEXT_WIDTH_CMD 

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
			T_ext_width_cmd_name as c_name
		export
			{NONE} all
		end



	
feature {NONE}

	associated_form: INTEGER is
		do
			Result := text_form_number
		end;

	context: TEXT_C;

	old_margin_width: INTEGER;

	context_work is
		do
			old_margin_width := context.margin_width;
		end;

	context_undo is
		local
			new_w: INTEGER;
		do
			new_w := context.margin_width;
			context.set_margin_width (old_margin_width);
			old_margin_width := new_w;
		end;

end
