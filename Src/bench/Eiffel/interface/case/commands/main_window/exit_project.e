indexing

	description: "Commamd that pops up the print window when the button %
				 %associated to which Current is associated is pressed.";
	date: "$Date$";
	revision: "$Revision $"

class 
	EXIT_PROJECT

inherit

	--EC_LICENCED_COMMAND

	EV_COMMAND
		

creation

	make

feature -- Properties

	make (m: like main_window) is
		do
			main_window := m
		end
		
	symbol: EV_PIXMAP is
			-- Symbol representing button to which Current 
			-- command is associated.
	
		do
		--once
		--	Result := Pixmaps.graphics_pixmap
		end;

feature -- Properties

	main_window: MAIN_WINDOW

feature {NONE} -- Execution

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
		local
			exit:EXIT
		do	
		 -- !!exit.make (main_window)
		  --exit.execute(Void)		
		end;

end --   
