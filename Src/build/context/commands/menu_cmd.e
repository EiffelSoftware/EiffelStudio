
class MENU_CMD 

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
			M_enu_cmd_name as c_name
		export
			{NONE} all
		end



	
feature {NONE}

	associated_form: INTEGER is
		do
			Result := menu_form_number
		end;

	context: MENU_C;

	old_title: STRING;

	context_work is
		do
			old_title := context.title;
		end;

	context_undo is
		local
			new_title: STRING;
		do
			if not (old_title = Void) then
				new_title := context.title;
				context.set_title (old_title);
				old_title := new_title;
			end;
		end;

end
