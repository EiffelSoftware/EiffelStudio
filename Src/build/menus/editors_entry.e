indexing
	description: "Entry in a menu used to hide or show %
				% the editors."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	EDITORS_ENTRY

inherit

	MAIN_PANEL_TOGGLE

	SHARED_CONTEXT

creation

	make

feature {NONE}

	toggle_pressed is
			-- Display or hide the interface.
		do
			if armed then
				main_panel.show_context_editor
				window_mgr.show_all_editors
			else
				main_panel.hide_context_editor
				window_mgr.hide_all_editors
			end
		end

end -- class EDITORS_ENTRY
