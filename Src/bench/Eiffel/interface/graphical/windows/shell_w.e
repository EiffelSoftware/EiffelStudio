indexing

	description:	
		"Window to enter shell commands.";
	date: "$Date$";
	revision: "$Revision$"

class SHELL_W 

inherit

	COMMAND_W;
	NAMER;
	PROMPT_D
		rename
			make as prompt_dialog_create
		end;

creation

	make
	
feature -- Initialization

	make (a_composite: COMPOSITE; cmd: SHELL_COMMAND) is
			-- Create a file selection dialog
		do
			prompt_dialog_create (Interface_names.n_X_resource_name, a_composite);
			set_title (Interface_names.t_Shell_w);
			set_selection_label ("Specify shell command");
			hide_apply_button;
			hide_help_button;
			set_exclusive_grab;
			add_ok_action (Current, ok_it);
			add_cancel_action (Current, cancel_it);
			set_width (350);
			associcated_command := cmd;
			set_default_position (False);
			realize;
		end;

feature -- Access

	call is
		local
			new_x, new_y: INTEGER;
			p: like parent
		do
			p := parent;
			new_x := p.real_x + (p.width - width) // 2;
			new_y := p.real_y - (height // 2);
			if new_x + width > screen.width then
				new_x := screen.width - width
			elseif new_x < 0 then
				new_x := 0
			end;
			if new_y + height > screen.height then
				new_y := screen.height - height
			elseif new_y < 0 then
				new_y := 0
			end;
			set_x_y (new_x, new_y);
			set_selection_text (associcated_command.command_shell_name);
			popup;
		end;

feature {NONE} -- Implementation

	work (argument: ANY) is
		local
			cmd_name: STRING
		do
			if last_warner /= Void then
				last_warner.popdown
			end;
			if argument = ok_it then
				cmd_name := associcated_command.command_shell_name;
				cmd_name.wipe_out;
				cmd_name.append (clone (selection_text));
				popdown
			elseif argument = cancel_it then
				popdown
			end
		end;

feature {NONE} -- Properties

	associcated_command: SHELL_COMMAND;

	ok_it, cancel_it: ANY is
			-- Arguments for the command
		once
			!! Result
		end

end -- class SHELL_W
