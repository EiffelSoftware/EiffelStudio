indexing
	description: "Entry in a menu used to hide or show %
				% the context editor."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	CONTEXT_EDITOR_ENTRY

inherit

	MAIN_PANEL_TOGGLE

creation

	make
	
feature {NONE}

	toggle_pressed is
			-- Display or hide the context catalog.
		do
			if armed then
				main_panel.show_context_editor
			else
				main_panel.hide_context_editor
			end
		end

end -- class CONTEXT_EDITOR_ENTRY
