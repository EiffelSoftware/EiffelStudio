
class CUT_GROUP_CMD 

inherit

	WINDOWS
		export
			{NONE} all
		end;
	GROUP_SHARED
		export
			{NONE} all
		end;
	CONTEXT_CMD
		redefine
			work, undo, redo
		
		end;
	EDITOR_FORMS
		rename
			geometry_form_number as associated_form
		export
			{NONE} all
		end;
	COMMAND_NAMES
		rename
			C_ut_group_type_cmd_name as c_name
		export
			{NONE} all
		end



	
feature {NONE}

	group_type: CONTEXT_GROUP_TYPE;

	
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
			context_catalog.append_group_type (group_type);
			group_list.finish;
			group_list.add_right (group_type.group);
		end;

	redo is
		do
			context_catalog.remove_group_type (group_type);
		end;

	
feature {NONE}

	context_work is
		do
		end;

	context_undo is
		do
		end;

end
