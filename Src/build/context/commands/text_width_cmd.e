
class TEXT_WIDTH_CMD 

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
			Result := Command_names.cont_text_width_cmd_name
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
