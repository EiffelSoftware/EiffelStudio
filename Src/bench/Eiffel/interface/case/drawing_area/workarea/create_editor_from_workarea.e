indexing

	description: 
		"Command to create a window editor.";
	date: "$Date$";
	revision: "$Revision $"

class CREATE_EDITOR_FROM_WORKAREA
inherit
	
	EV_COMMAND;
	ONCES

creation
	make

feature -- Creation

	make (w: like workarea; p: like parent_window) is
		do
			workarea := w
			parent_window := p
		end

feature -- Properties

	workarea: WORKAREA
	parent_window: EV_WINDOW

feature -- Execution

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
		local
			create_editor_window: CREATE_EDITOR_WINDOW_COM
		do
			if workarea /= Void then
				!! create_editor_window.make (parent_window)
				create_editor_window.execute (workarea.active_entity_data)
			end
		end;

end -- class CREATE_EDITOR_WINDOW_COM
