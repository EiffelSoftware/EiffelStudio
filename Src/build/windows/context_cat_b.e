class CONTEXT_CAT_B 
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
				Context_catalog.show
			else
				Context_catalog.hide
			end
		end

end
