
class SCALE_GRAN_CMD 

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
			S_cale_gran_cmd_name as c_name
		export
			{NONE} all
		end



	
feature {NONE}

	associated_form: INTEGER is
		do
			Result := scale_form_number
		end;

	context: SCALE_C;

	old_granularity: INTEGER;

	context_work is
		do
			old_granularity := context.granularity;
		end;

	context_undo is
		local
			new_granularity: INTEGER;
		do
			new_granularity := context.granularity;
			context.set_granularity (old_granularity);
			old_granularity := new_granularity;
		end;

end
