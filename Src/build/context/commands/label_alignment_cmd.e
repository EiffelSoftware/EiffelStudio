
class LABEL_ALIGNMENT_CMD 

inherit

	CONTEXT_CMD
		redefine
			context
		end;

feature {NONE}

	associated_form: INTEGER is
		do
			Result :=  Context_const.label_text_att_form_nbr
		end;

	c_name: STRING is
		do
			Result := Command_names.cont_label_alignment_cmd_name
		end;

	context: LABEL_TEXT_C;

	old_left_alignment: BOOLEAN;

	context_work is
		do
			old_left_alignment := context.left_alignment;
		end;

	context_undo is
		local
			new_left_align: BOOLEAN;
		do
			new_left_align := context.left_alignment;
			context.set_left_alignment (old_left_alignment);
			old_left_alignment := new_left_align;
		end;

end
