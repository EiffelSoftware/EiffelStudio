
class RESIZE_CMD 

inherit

	CONTEXT_CMD
		;
	EDITOR_FORMS
		export
			{NONE} all
		end;
	COMMAND_NAMES
		rename
			R_esize_cmd_name as c_name
		export
			{NONE} all
		end



	
feature {NONE}

	associated_form: INTEGER is
		do
			Result := bulletin_resize_form_number
		end;

	old_resize_policy: RESIZE_POLICY;

	context_work is
		do
			!!old_resize_policy.make;
			old_resize_policy := clone (context.resize_policy);
		end;

	context_undo is
		local
			new_policy: RESIZE_POLICY;
		do
			!!new_policy.make;
			new_policy := clone (context.resize_policy);
			context.set_resize_policy (old_resize_policy);
			old_resize_policy := new_policy;
		end;

end
