indexing

	description:	
		"Retarget the tool with the next target in history.";
	date: "$Date$";
	revision: "$Revision$"

class NEXT_TARGET

inherit

	ICONED_COMMAND
		redefine
			execute
		end;

creation

	make

feature -- Initialization

	make (c: COMPOSITE; a_text_window: TEXT_WINDOW) is
			-- Initialize the command.
		do 
			init (c, a_text_window)
		end;

feature -- Properties

	symbol: PIXMAP is
			-- Symbol for the button.
		once
			Result := bm_Next_target
		end;

	command_name: STRING is
			-- Name of the command.
		do
			Result := l_Next_target
		end;

feature -- Execution

	execute (argument: ANY) is
			-- Execute the command, with parameter `argument'.
		do
			if argument = get_in then
				text_window.tool.tell_type (command_name)
			elseif argument = get_out then
				text_window.tool.clean_type
			elseif last_warner /= Void and argument = last_warner then
					-- The changes will be lost.
				text_window.clear_clickable;
				text_window.set_changed (false);
				execute_licenced (Void)
			else
				if last_warner /= Void then
					last_warner.popdown
				end;
				if not text_window.changed then
					execute_licenced (argument)
				else
					warner (text_window).call (Current, l_File_changed)
				end
			end
		end;

feature {NONE} -- Implementation

	work (argument: ANY) is
			-- Retarget the tool with the next target in history.
		local
			history: STONE_HISTORY
		do
			history := text_window.history;
			if history.empty or else (history.islast or history.after) then
				warner (text_window).gotcha_call (w_End_of_history)
			else
				history.forth;
				text_window.last_format.execute (history.item)
			end
		end;

end -- class NEXT_TARGET
