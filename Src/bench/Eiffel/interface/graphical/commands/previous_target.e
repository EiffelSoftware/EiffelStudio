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
			execute_warner_ok as loose_changes
		end

creation

	make

feature -- Callbacks

	execute_warner_help is
			-- Useless here
		do
			-- Do Nothing
		end;

	loose_changes (argument: ANY) is
			-- The changes will be lost.
		do
			text_window.disable_clicking;
			execute_licenced (Void)
		end;

feature -- Execution

	execute (argument: ANY) is
			-- Execute the command.
		do
			if last_warner /= Void then
				last_warner.popdown
			end;
			if not text_window.changed then
				execute_licenced (argument)
			 else
				warner (popup_parent).call (Current, Interface_names.w_File_changed)
			end
		end;

feature -- Properties

	symbol: PIXMAP is
			-- Pixmap for the button.
		once
			Result := bm_Previous_target
		end;

	name: STRING is
			-- Name of the command.
		do
			Result := l_Previous_target
		end;

feature {NONE} -- Implementation

	work (argument: ANY) is
			-- Retarget the tool with the previous target in history.
		local
			history: STONE_HISTORY
		do
			history := tool.history;
			if history.empty or else (history.isfirst or history.before) then
				warner (popup_parent).gotcha_call (w_Beginning_of_history)
			else
				history.back;
				tool.last_format.execute (history.item)
			end
		end;

end -- class PREVIOUS_TARGET
