indexing

	description: "Abstract class for commands associated to a % 
				 %button, hole, etc.. located in the main panel.";
	date: "$Date$";
	revision: "$Revision $"

deferred class 
	MAIN_PANEL_COM 

inherit
	--EC_LICENCED_COMMAND
	--	rename
	--		work as command_work
	--	end

	EV_COMMAND

	ONCES

	CONSTANTS
	
feature -- Properties

	main_graph_window: MAIN_WINDOW is
			-- Main panel window
		once
		--	Result := Windows.main_graph_window
		end;

feature -- Execution (work)

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Verify if project is initialized, and execute the Current 
			-- command 
		do
			--if main_graph_window.project_initialized then
				work (args)
			--end
		end;

	work (arg: ANY) is
			-- Execute Current command
	--	require
	--		project_initalized: main_graph_window.project_initialized
		deferred
		end;

end -- class MAIN_PANEL_COM
