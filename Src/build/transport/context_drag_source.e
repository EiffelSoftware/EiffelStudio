-- Initializes the transportation for a context stone
deferred class CONTEXT_DRAG_SOURCE

inherit

	DRAG_SOURCE
		redefine
			initialize_transport
		end

feature {NONE}

	initialize_transport is
			-- Initialize the mechanism through which
			-- the current stone may be dragged and
			-- dropped.
		do	
			source.set_action ("<Btn3Down>", transport_command, Current)
			source.set_action ("Shift<Btn3Down>", namer_command, Current)
			source.set_action ("Ctrl<Btn3Down>", create_editor_command, Current)
			source.set_action ("Shift<Btn1Down>", show_command, Current);
			source.set_action ("<Btn1Up>", show_command, Void);
			source.set_action ("Shift<Btn1Up>", show_command, Void);
			source.add_leave_action (show_command, Void)
		end;

	show_command: SHOW is
  			-- Command which highlights the widget in the interface
		once
			!! Result.make
		end;

end
