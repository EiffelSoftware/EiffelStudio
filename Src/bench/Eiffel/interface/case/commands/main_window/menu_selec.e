deferred class MENU_SELEC

inherit 
	EV_COMMAND

feature

	make ( t: like toolbar ) is
		do
			toolbar := t
		end

	toolbar:  MAIN_WINDOW_TOOLBAR

end
