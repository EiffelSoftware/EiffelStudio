
class PERM_TITLE_CMD 

inherit

	CONTEXT_CMD
		redefine
			context
		end;

feature {NONE}

	associated_form: INTEGER is
		do
			Result := Context_const.perm_wind_att_form_nbr
		end;

	c_name: STRING is
		do
			Result := Command_names.cont_perm_title_cmd_name
		end;

	context: PERM_WIND_C;

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
