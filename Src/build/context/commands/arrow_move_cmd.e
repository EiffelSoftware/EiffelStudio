
class ARROW_MOVE_CMD 

inherit

	CMD_LIST
		redefine
			work
		end

feature {NONE}

	associated_form: INTEGER is
		do
			Result := Context_const.geometry_form_nbr
		end;
	
	c_name: STRING is
		do
			Result := Command_names.cont_geometry_cmd_name
		end;

feature 

	work (argument: CONTEXT) is
		local
			list: LINKED_LIST [CONTEXT];
			last_cmd: ARROW_MOVE_CMD
		do
			context := argument;
			if not history.before then
				last_cmd ?= history.item;
			end;
			if (last_cmd = Void) or else last_cmd.context /= context then 
					-- If the previous command in the history
					-- is an arrow_move cmd then do nothing
				!!cmd_list.make;
				if context.grouped then
					list := context.group;
					from
						list.start
					until
						list.after
					loop
						save_context (list.item);
						list.forth
					end;
				else
					save_context (context)
				end;
			else
				failed := True
			end;
		end;

feature {NEW_CONTEXT_TREE, CONTEXT_TREE, SELECTION_MANAGER}

	move_context (d_x, d_y: INTEGER) is
		local
			a_group: LINKED_LIST  [CONTEXT]
		do
			if context.grouped then
				a_group := context.group
				from
					a_group.start
				until
					a_group.after
				loop
					a_group.item.set_real_x_y (a_group.item.x + d_x,
											   a_group.item.y + d_y)
					a_group.forth
				end;
			else
				context.set_real_x_y (context.x + d_x, context.y + d_y)
			end;
		end;

feature {NONE}

	save_context (a_context: CONTEXT) is
		local
			cmd: SEL_SINGLE_CMD;
		do
			!!cmd;
			cmd.work (a_context);
			cmd_list.put_right (cmd);
		end;

end
