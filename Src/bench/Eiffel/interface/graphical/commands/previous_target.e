indexing

	description:	
		"Retarget the tool with the previous target in history.";
	date: "$Date$";
	revision: "$Revision$"

class PREVIOUS_TARGET

inherit

	PIXMAP_COMMAND
		rename
			init as make
		redefine
			execute
		end;
	WARNER_CALLBACKS
		rename
			execute_warner_ok as save_changes,
			execute_warner_help as loose_changes
		end

creation

	make

feature -- Callbacks

	loose_changes is
			-- Useless here
		do
			text_window.disable_clicking;
			execute_licensed (Void)
		end;

	save_changes (argument: ANY) is
			-- The changes will be lost.
		do
			text_window.disable_clicking;
			if tool /= Void then
				tool.save_cmd_holder.associated_command.execute (Void)
			end
			execute_licensed (Void)
		end;

feature -- Execution

	execute (argument: ANY) is
			-- Execute the command.
		do
			if last_warner /= Void then
				last_warner.popdown
			end;
			if not text_window.changed then
				execute_licensed (argument)
			 else
				warner (popup_parent).custom_call (Current, Warning_messages.w_File_changed (Void),
					Interface_names.b_Yes, Interface_names.b_No, Interface_names.b_Cancel)
			end
		end;

feature -- Properties

	symbol: PIXMAP is
			-- Pixmap for the button.
		once
			Result := Pixmaps.bm_Previous_target
		end;

	name: STRING is
			-- Name of the command.
		do
			Result := Interface_names.f_Previous_target
		end;

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_Previous_target
		end;

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
            Result := "Alt<Key>Left"
		end

feature {NONE} -- Implementation

	work (argument: ANY) is
			-- Retarget the tool with the previous target in history.
		local
			history: STONE_HISTORY
		do
			history := tool.history;
			if history.is_empty or else (history.isfirst or history.before) then
				warner (popup_parent).gotcha_call (Warning_messages.w_Beginning_of_history)
			else
				history.back;
				history.set_do_not_update (True);
				tool.receive (history.item)
				history.set_do_not_update (False);
			end
		end;

end -- class PREVIOUS_TARGET
