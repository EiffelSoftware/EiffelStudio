
class MENU_CMD 

inherit

	CONTEXT_CMD
		redefine
			context
		end;
	
feature {NONE}

	associated_form: INTEGER is
		do
			Result := Context_const.menu_sm_form_nbr
		end;

	c_name: STRING is
		do
			Result := Context_const.menu_cmd_name
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
