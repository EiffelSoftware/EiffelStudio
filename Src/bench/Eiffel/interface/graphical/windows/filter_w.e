-- Window to enter filter names

class FILTER_W 

inherit

	COMMAND_W;
	NAMER;
	PROMPT_D
		rename
			make as prompt_dialog_create
		end

creation

	make
	
feature 

	make (a_composite: COMPOSITE; cmd: FILTER_COMMAND) is
			-- Create a filter window.
		do
			prompt_dialog_create (l_Filter_w, a_composite);
			set_title (l_Filter_w);
			set_selection_label ("Specify filter name");
			hide_apply_button;
			hide_help_button;
			add_ok_action (Current, ok_it);
			add_cancel_action (Current, cancel_it);
			set_width (350);
			associcated_command := cmd;
		end;

	
feature {NONE}

	ok_it: ANY is once !!Result end;
	cancel_it: ANY is once !!Result end;
			-- Arguments for the command

feature 
	
	call is
		do
			set_exclusive_grab;
			set_selection_text (associcated_command.filter_name);
			popup
		end;

feature {NONE}

	associcated_command: FILTER_COMMAND;

	work (argument: ANY) is
		local
			cmd_name: STRING;
        do
			if argument = ok_it then
				cmd_name := associcated_command.filter_name;
				cmd_name.wipe_out;
				cmd_name.append (clone (selection_text));
				associcated_command.execute (Current)
			elseif argument = cancel_it then
				popdown
			end
		end;

end -- class FILTER_W
