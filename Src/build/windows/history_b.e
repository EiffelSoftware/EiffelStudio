class HISTORY_B 
inherit

	MAIN_PANEL_TOGGLE

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
