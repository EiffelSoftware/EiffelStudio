indexing
	description: "Entry in a menu used to hide or show %
				% all the command tools."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	COMMAND_EDITOR_ENTRY

inherit

	MAIN_PANEL_TOGGLE

creation

	make
	
feature {NONE}

	toggle_pressed is
			-- Display or hide the context catalog.
		do
			if armed then
				window_mgr.show_all_command_tools
			else
				window_mgr.hide_all_command_tools
			end
		end

end -- class COMMAND_EDITOR_ENTRY
