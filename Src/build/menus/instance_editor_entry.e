indexing
	description: "Entry in a menu used to hide or show %
				% the instance editor."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	INSTANCE_EDITOR_ENTRY

inherit

	MAIN_PANEL_TOGGLE

creation

	make
	
feature {NONE}

	toggle_pressed is
			-- Display or hide the context catalog.
		do
			if armed then
				main_panel.show_command_tool
			else
				main_panel.hide_command_tool
			end
		end

end -- class INSTANCE_EDITOR_ENTRY
