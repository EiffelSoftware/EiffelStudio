
class GROUP_BULLETIN_CMD 

inherit

	WINDOWS
		export
			{NONE} all
		end;
	CONTEXT_CMD
		redefine
			context,
			work, undo, redo
		
		end;
	EDITOR_FORMS
		export
			{NONE} all
		end;
	COMMAND_NAMES
		rename
			G_roup_cmd_name as c_name
		export
			{NONE} all
		end



	
feature {NONE}

	associated_form: INTEGER is
		do
			Result := geometry_form_number
		end;

	context: BULLETIN_C;

	group_c: GROUP_C;

	
feature 

	group_create (a_context: BULLETIN_C; a_group: GROUP_C) is
		do
			context := a_context;
			group_c := a_group;
		end;

	work (argument: ANY) is
		do
		end;

	undo is
		do	
			group_c.cut;
			context.transform_in_bulletin;
			tree.display (context);
		end;

	redo is
		do
			group_c.undo_cut;
			context.transform_in_group (group_c);
			tree.display (group_c);
		end;

	
feature {NONE}

	context_undo is
		do
		end;

	context_work is
		do
		end;

end
