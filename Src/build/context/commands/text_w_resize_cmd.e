
class TEXT_W_RESIZE_CMD 

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
			T_ext_w_resize_cmd_name as c_name
		export
			{NONE} all
		end



	
feature {NONE}

	associated_form: INTEGER is
		do
			Result := text_form_number
		end;

	context: TEXT_C;

	old_is_width_resizable: BOOLEAN;

	context_work is
		do
			old_is_width_resizable := context.is_width_resizable;
		end;

	context_undo is
		local
			new_is_width_resizable: BOOLEAN;
		do
			new_is_width_resizable := context.is_width_resizable;
			context.enable_resize_width (old_is_width_resizable);
			old_is_width_resizable := new_is_width_resizable;
		end;

end
