
-- Window to enter arguments 

class ARGUMENT_W 

inherit

	COMMAND_W;
	PROMPT_D
		rename
			make as prompt_dialog_create
		end;
	SET_WINDOW_ATTRIBUTES

creation

	make
	
feature 

	argument_list: STRING is
		once
			!!Result.make (0);
		end;

	close is
		do
			if is_popped_up then
				popdown
			end
		end;

	make (a_composite: COMPOSITE; cmd: COMMAND_W) is
			-- Create a file selection dialog
		do
			prompt_dialog_create (l_Argument_w, a_composite);
			set_title (l_Argument_w);
			set_selection_label ("Specify arguments");
			hide_help_button;
			show_apply_button;
			!!apply_it;
			!!cancel_it;
			set_ok_label ("Run");
			set_apply_label ("OK");
			add_ok_action (Current, Void);
			add_apply_action (Current, apply_it);
			add_cancel_action (Current, cancel_it);
			run := cmd;
			set_composite_attributes (Current)
		end;
	
feature {NONE}

	apply_it, cancel_it, run_it: ANY;
			-- Arguments for the command

feature 
	
	call is
		do
			set_selection_text (argument_list);
			popup;
			raise
		end;

feature {NONE}

	run: COMMAND_W;

	work (argument: ANY) is
		local
			arg_list: STRING
		do
			if last_warner /= Void then
				last_warner.popdown
			end;
			if argument = apply_it then
				arg_list := argument_list;
				arg_list.wipe_out;
				arg_list.append (clone (selection_text));
				popdown
			elseif argument = cancel_it then
				popdown
			elseif argument = Void then
				arg_list := argument_list;
				arg_list.wipe_out;
				arg_list.append (clone (selection_text));
				run.execute (Void)
			end
		end;

end
