
class PERM_ICON_NAME_CMD 

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
			P_erm_icon_name_cmd_name as c_name
		export
			{NONE} all
		end



	
feature {NONE}

	associated_form: INTEGER is
		do
			Result := perm_wind_form_number
		end;

	context: PERM_WIND_C;

	old_icon_name: STRING;

	context_work is
		do
			old_icon_name := context.icon_name;
		end;

	context_undo is
		local
			new_icon_name: STRING;
		do
			if not (old_icon_name = Void) then
				new_icon_name := context.icon_name;
				context.set_icon_name (old_icon_name);
				old_icon_name := new_icon_name;
			end;
		end;

end
