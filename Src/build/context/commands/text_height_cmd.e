
class TEXT_HEIGHT_CMD 

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
			Result := Command_names.cont_text_height_cmd_name
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
