
class TEXT_WRAP_CMD 

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
			T_ext_wrap_cmd_name as c_name
		export
			{NONE} all
		end



	
feature {NONE}

	associated_form: INTEGER is
		do
			Result := text_form_number
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
