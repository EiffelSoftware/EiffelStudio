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
				History_window.show
			else
				History_window.hide
			end
		end

end
