
class TEXT_H_RESIZE_CMD 

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
			Result := Context_const.text_h_resize_cmd_name
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
