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
	make
	
feature -- Initialization

	make is
			-- Create Current object
		do
		end;

	initialize (a_composite: COMPOSITE; cmd: COMMAND) is
			-- Initialize Current with `a_composite' as parent and
			-- `cmd' as command window.
			--| Use this in conjunction with `make_plain' to
			--| create a shared argument window.
		do
			prompt_dialog_create (Interface_names.n_X_resource_name, a_composite);
			set_title (Interface_names.t_Argument_w);
			set_selection_label (Interface_names.l_Specify_arguments);
			hide_help_button;
			show_apply_button;
			set_ok_label (Interface_names.b_Run);
			set_apply_label (Interface_names.b_Ok);
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

	apply_it, cancel_it: ANY is
			-- Arguments for the command
		once
			!! Result
		end

	run: COMMAND;

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
