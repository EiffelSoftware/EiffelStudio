class HISTORY_B 
inherit

	MAIN_PANEL_TOGGLE;
	WINDOWS;
	LICENCE_COMMAND

creation
	make
	
feature {NONE}

	toggle_pressed is
		do
			if armed then
				if not History_window.is_popped_up then
					History_window.popup
				end
			else
				if History_window.is_popped_up then
					History_window.popdown
				end
			end
		end

end
