indexing

	description:	
		"Window to enter arguments.";
	date: "$Date$";
	revision: "$Revision$"

class ARGUMENT_W 

inherit

	COMMAND_W;
	PROMPT_D
		rename
			make as prompt_dialog_create
		end;
	WINDOW_ATTRIBUTES

creation

	make, make_plain
	
feature -- Initialization

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
			set_apply_label (l_Ok);
			add_ok_action (Current, Void);
			add_apply_action (Current, apply_it);
			add_cancel_action (Current, cancel_it);
			run := cmd;
			set_composite_attributes (Current)
		end;
	
	make_plain is
			-- Create Current object
		do
		end;

	initialize (a_composite: COMPOSITE; cmd: COMMAND_W) is
			-- Initialize Current with `a_composite' as parent and
			-- `cmd' as command window.
			--| Use this in conjunction with `make_plain' to
			--| create a shared argument window.
		do
			prompt_dialog_create (l_Argument_w, a_composite);
			set_title (l_Argument_w);
			set_selection_label ("Specify arguments");
			hide_help_button;
			show_apply_button;
			!! apply_it;
			!! cancel_it;
			set_ok_label ("Run");
			set_apply_label (l_Ok);
			add_ok_action (Current, Void);
			add_apply_action (Current, apply_it);
			add_cancel_action (Current, cancel_it);
			run := cmd;
			set_composite_attributes (Current)
		end;

feature -- Properties

	argument_list: STRING is
		once
			!!Result.make (0);
		end;

feature -- Graphical Interface

	close is
		do
			if is_popped_up then
				popdown
			end
		end;

feature -- Access
	
	call is
		do
			set_selection_text (argument_list);
			popup;
			raise
		end;

feature {NONE} -- Properties

	apply_it, cancel_it, run_it: ANY;
			-- Arguments for the command

	run: COMMAND_W;

feature {NONE} -- Implementation

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

end -- class ARGUMENT_W
