
class CUT_GROUP_CMD 

inherit

	WINDOWS;
	SHARED_CONTEXT;
	CONTEXT_CMD
		redefine
			work, undo, redo, n_ame
		end;

feature {NONE}

	group_type: CONTEXT_GROUP_TYPE;

	n_ame: STRING is
		do
			!!Result.make (20);
			Result.append (c_name);
			Result.append (" (");	
			Result.append (group_type.label);
			Result.append (" )");
		end;

	c_name: STRING is
		do
			Result := Command_names.cont_cut_group_type_cmd_name
		end;

	associated_form: INTEGER is
		do
			Result := Context_const.geometry_form_nbr
		end
	
feature 

	work (argument: CONTEXT_GROUP_TYPE) is
		do
			group_type := argument;
			if group_type.group.not_used then
				context_catalog.remove_group_type (group_type);
			else
				failed := True
			end;
		end;

	undo is
		do
			context_catalog.add_group_type (group_type);
		end;

	redo is
		do
			context_catalog.remove_group_type (group_type);
		end;

feature
	context_work is
		do
		end;
	context_undo is
		do
		end;

	
end
