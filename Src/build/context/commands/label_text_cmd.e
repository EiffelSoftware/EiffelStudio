
class LABEL_TEXT_CMD 

inherit

	CONTEXT_CMD
		redefine
			context
		end
	
feature {NONE}

	associated_form: INTEGER is
		do
			Result := Context_const.label_text_att_form_nbr
		end;

	c_name: STRING is
		do
			Result := Command_names.cont_label_text_cmd_name
		end;

	context: LABEL_TEXT_C;

	old_text: STRING;

	context_work is
		do
			old_text := context.text;
		end;

	context_undo is
		local
			new_text: STRING;
		do
			if not (old_text = Void) then
				new_text := context.text;
				context.set_text (old_text);
				old_text := new_text;
			end;
		end;

end
