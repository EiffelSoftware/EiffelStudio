
class RESIZE_CMD 

inherit

	CONTEXT_CMD

feature {NONE}

	associated_form: INTEGER is
		do
			Result := Context_const.bulletin_resize_form_nbr
		end;
	
	c_name: STRING is
		do
			Result := Command_names.cont_resize_cmd_name
		end;

	old_resize_policy: RESIZE_POLICY;

	context_work is
		do
			!!old_resize_policy;
			old_resize_policy := clone (context.resize_policy);
		end;

	context_undo is
		local
			new_policy: RESIZE_POLICY;
		do
			!!new_policy;
			new_policy := clone (context.resize_policy);
			context.set_resize_policy (old_resize_policy);
			old_resize_policy := new_policy;
		end;

end
