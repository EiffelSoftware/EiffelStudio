
class PULLDOWN_RESIZE_CMD 

inherit

	CONTEXT_CMD
		redefine
			context
		end
	
feature {NONE}

	associated_form: INTEGER is
		do
			Result := Context_const.pulldown_sm_form_nbr
		end;

	c_name: STRING is
		do
			Result := Command_names.cont_pulldown_resize_cmd_name
		end;

	context: PULLDOWN_C;

	old_resize_policy_disabled: BOOLEAN;

	context_work is
		do
			old_resize_policy_disabled := context.resize_policy_disabled;
		end;

	context_undo is
		local
			new_resize_policy: BOOLEAN;
		do
			new_resize_policy := context.resize_policy_disabled;
			context.disable_resize_policy (old_resize_policy_disabled);
			old_resize_policy_disabled := new_resize_policy;
		end;

end
