
class TEXT_H_RESIZE_CMD 

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
			T_ext_h_resize_cmd_name as c_name
		export
			{NONE} all
		end



	
feature {NONE}

	associated_form: INTEGER is
		do
			Result := text_form_number
		end;

	context: TEXT_C;

	old_is_height_resizable: BOOLEAN;

	context_work is
		do
			old_is_height_resizable := context.is_height_resizable;
		end;

	context_undo is
		local
			new_is_height_resizable: BOOLEAN;
		do
			new_is_height_resizable := context.is_height_resizable;
			context.enable_resize_height (old_is_height_resizable);
			old_is_height_resizable := new_is_height_resizable;
		end;

end
