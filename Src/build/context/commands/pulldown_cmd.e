
class PULLDOWN_CMD 

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
            P_ulldown_cmd_name as c_name
		export
			{NONE} all
		end



	
feature {NONE}

	associated_form: INTEGER is
		do
			Result := pulldown_form_number
		end;

	context: PULLDOWN_C;

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
