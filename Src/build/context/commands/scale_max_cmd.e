
class SCALE_MAX_CMD 

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
			S_cale_max_cmd_name as c_name
		export
			{NONE} all
		end



	
feature {NONE}

	associated_form: INTEGER is
		do
			Result := scale_form_number
		end;

	context: SCALE_C;

	old_maximum: INTEGER;

	context_work is
		do
			old_maximum := context.maximum;
		end;

	context_undo is
		local
			new_maximum: INTEGER;
		do
			new_maximum := context.maximum;
			context.set_maximum (old_maximum);
			old_maximum := new_maximum;
		end;

end
