
class GROUP_BULLETIN_CMD 

inherit

	WINDOWS;
	CONTEXT_CMD
		redefine
			context,
			work, undo, redo
		end;
	
feature {NONE}

	associated_form: INTEGER is
		do
			Result := Context_const.geometry_form_nbr
		end;

	c_name: STRING is
		do
			Result := Context_const.group_cmd_name
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
			Tree.display (context);
		end;

	redo is
		do
			group_c.undo_cut;
			context.transform_in_group (group_c);
			Tree.display (group_c);
		end;

	
feature {NONE}

	context_undo is
		do
		end;

	context_work is
		do
		end;

end
