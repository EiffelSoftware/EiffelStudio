indexing

	description:	
		"Retarget the tool with the next target in history.";
	date: "$Date$";
	revision: "$Revision$"

class NEXT_TARGET

inherit

	PIXMAP_COMMAND
		rename
			init as make
		redefine
			execute
		end;
	WARNER_CALLBACKS
		rename
			execute_warner_ok as save_changes
		end

creation

	make

feature -- Callbacks

	execute_warner_help is
		do
		end;

	save_changes (argument: ANY) is
			-- The changes will be lost.
		do
			text_window.disable_clicking;
			if tool.save_cmd_holder /= Void then
				tool.save_cmd_holder.associated_command.execute (Void)
			end
			execute_licensed (Void)
		end;

feature -- Properties

	symbol: PIXMAP is
			-- Symbol for the button
		once
			Result := Pixmaps.bm_Next_target
		end;

	name: STRING is
			-- Name of the command
		do
			Result := Interface_names.f_Next_target
		end;

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_Next_target
		end;

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
			Result := "Alt<key>Right"
		end

feature -- Execution

	execute (argument: ANY) is
			-- Execute the command, with parameter `argument'.
		do
			if last_warner /= Void then
				last_warner.popdown
			end;
			if not text_window.changed then
				execute_licensed (argument)
			else
				warner (popup_parent).call (Current, Warning_messages.w_File_changed)
			end
		end;

feature {NONE} -- Implementation

	work (argument: ANY) is
			-- Retarget the tool with the next target in history.
		local
			history: STONE_HISTORY
		do
			history := tool.history;
			if history.empty or else (history.islast or history.after) then
				warner (popup_parent).gotcha_call (Warning_messages.w_End_of_history)
			else
				history.forth;
				history.set_do_not_update (True);
				tool.receive (history.item);
				history.set_do_not_update (False)
			end
		end;

end -- class NEXT_TARGET
