
class TEXT_WRAP_CMD 

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
			Result := Command_names.cont_text_wrap_cmd_name
		end;

	context: TEXT_C;

	old_is_word_wrap_enable: BOOLEAN;

	context_work is
		do
			old_is_word_wrap_enable := context.is_word_wrap_enable;
		end;

	context_undo is
		local
			new_is_word_wrap_enable: BOOLEAN;
		do
			new_is_word_wrap_enable := context.is_word_wrap_enable;
			context.enable_word_wrap (old_is_word_wrap_enable);
			old_is_word_wrap_enable := new_is_word_wrap_enable;
		end;

end
