
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

	old_width, old_height: INTEGER;

	context_work is
		do
			old_text := context.text;
			old_width := context.width;
			old_height := context.height;
		end;

	context_undo is
		local
			new_text: STRING;
			tmp_width, tmp_height: INTEGER
		do
			if old_text /= Void then
				new_text := context.text;
				tmp_width := context.width;
				tmp_height := context.height;
				context.set_text (old_text);
				if (old_width /= context.width or else
                	old_height /= context.height)
            	then
                	context.set_size (old_width, old_height);
            	end;

                old_width := tmp_width;
                old_height := tmp_height;
				old_text := new_text;
			end;
		end;

end
