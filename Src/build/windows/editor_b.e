class EDITOR_B 
inherit

	MAIN_PANEL_TOGGLE

creation
	make
	
feature {NONE}

	toggle_pressed is
		do
			if armed then
				window_mgr.show_all_editors
			else
				window_mgr.hide_all_editors
			end
		end

end
