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

	main_context_editor_state: BOOLEAN
			-- Is the menu entry `Context editor' armed?

	toggle_pressed is
			-- Display or hide the interface.
		do
			if armed then
				if main_context_editor_state and then
					not main_panel.context_editor_entry.armed
				then
					main_panel.context_editor_entry.arm
				end
				window_mgr.show_all_editors
			else
				main_context_editor_state := main_panel.context_editor_entry.armed
				if main_context_editor_state then
					main_panel.context_editor_entry.disarm
				end
				window_mgr.hide_all_editors
			end
		end

end -- class EDITORS_ENTRY
