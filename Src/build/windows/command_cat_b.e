class COMMAND_CAT_B 
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
				if Command_catalog.realized then
					Command_catalog.show
				else
					Command_catalog.realize
				end
			else
				if Command_catalog.realized then
					Command_catalog.hide
				end
			end
		end

end
