class APP_EDITOR_B 
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
				if App_editor.realized then
					App_editor.show
				else
					App_editor.realize
				end
				if App_editor.selected_figure = Void then
					App_editor.set_default_selected
				else
					App_editor.display_transitions
				end
			else
				if App_editor.realized then
					App_editor.hide
				end
			end
		end

end
