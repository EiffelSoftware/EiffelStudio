indexing
	description: "Entry in a menu used to hide or show %
				% the application editor."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION_EDITOR_ENTRY

inherit

	MAIN_PANEL_TOGGLE

creation

	make
	
feature {NONE}

	toggle_pressed is
			-- Display or hide the application editor.
		do
			if armed then
				if App_editor.is_initialized then
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

end -- class APPLICATION_EDITOR_ENTRY
