
class TEXT_W_RESIZE_CMD 

inherit

	CONTEXT_CMD
		redefine
			context
		end
	
feature {NONE}

	associated_form: INTEGER is
		do
			Result := Context_const.text_att_form_nbr
		end;

	c_name: STRING is
		do
			Result := Command_names.cont_text_w_resize_cmd_name
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
