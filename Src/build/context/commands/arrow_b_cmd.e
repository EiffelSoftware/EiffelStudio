
class ARROW_B_CMD 

inherit

	CONTEXT_CMD
		redefine
			context
		end;
	
feature {NONE}

	associated_form: INTEGER is
		do
			Result := Context_const.arrow_b_att_form_nbr
		end;

	c_name: STRING is
		do
			Result := Command_names.cont_arrow_cmd_name
		end;

	context: ARROW_B_C;

	old_direction: INTEGER;

	context_work is
		do
			old_direction := context.direction;
		end;

	context_undo is
		local
			new_direction: INTEGER;
		do
			new_direction := context.direction;
			context.set_direction (old_direction);
			old_direction := new_direction
		end;

feature {CONTEXT_TREE, SELECTION_MANAGER}

	move_context (d_x, d_y: INTEGER) is
		local
			a_group: LINKED_LIST  [CONTEXT]
		do
			if context.grouped then
				a_group := context.group;
				from
					a_group.start
				until
					a_group.after
				loop
					a_group.item.set_x_y (a_group.item.x+d_x, a_group.item.y+d_y);
					a_group.forth;
				end;
			else
				context.set_x_y (context.x + d_x, context.y + d_y);
			end;
		end;

end
