indexing

	description:	
		"This kind of format is long to process. Ask %
			%for a confirmation before executing it.";
	date: "$Date$";
	revision: "$Revision$"

deferred class LONG_FORMATTER

inherit

	FILTERABLE
		rename
			make as formatter_make
		redefine
			execute
		end;

	FILTERABLE
		redefine
			execute, make
		select
			make
		end;

feature -- Initialization

	make (a_tool: TOOL_W) is
			-- Initialize the format button  with its bitmap.
			-- Set up the mouse click and control-click actions
			-- (click requires a confirmation, control-click doesn't).
		do
			formatter_make (a_tool);
			set_action ("c<Btn1Down>", Current, control_click)
		end;

feature -- Properties

	control_click: ANY is
			-- No confirmation required
		once
			!! Result
		end;

feature -- Execution

	execute (argument: ANY) is
			-- Ask for a confirmation before executing the format.
		local
			mp: MOUSE_PTR
		do
			if last_warner /= Void then
				last_warner.popdown
			end;
			if last_confirmer /= Void and argument = last_confirmer then
					-- The user wants to execute this format,
					-- even though it's a long format.
				if not text_window.changed then
					execute_licensed (formatted);
				else
					warner (popup_parent).custom_call (Current, Warning_messages.w_File_changed (Void),
						Interface_names.b_Yes, Interface_names.b_No, Interface_names.b_Cancel)
				end
			elseif argument = control_click then
					-- No confirmation required.
				formatted ?= tool.stone;
				if not text_window.changed then
					!! mp.set_watch_cursor;
					execute_licensed (formatted);
					mp.restore
				else
					warner (popup_parent).custom_call (Current, Warning_messages.w_File_changed (Void),
						Interface_names.b_Yes, Interface_names.b_No, Interface_names.b_Cancel)
				end
			else
				if argument = tool then
					formatted ?= tool.stone
				else
					formatted ?= argument
				end;
				if formatted = Void then
					execute_licensed (Void)
				elseif formatted /= Void and then formatted.clickable then
					confirmer (popup_parent).call (Current, 
						"This format requires exploring the entire%N%
						%system and may take a long time...", "Continue")
				end
			end
		end;

end -- class LONG_FORMATTER
