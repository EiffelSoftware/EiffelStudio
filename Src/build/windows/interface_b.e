class INTERFACE_B 
inherit

	MAIN_PANEL_TOGGLE;
	SHARED_CONTEXT

creation
	make
	
feature {NONE}

	toggle_pressed is
		do
			if armed then
				main_panel.show_interface
			else
				main_panel.hide_interface
			end
		end;

end
