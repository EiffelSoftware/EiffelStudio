indexing
	description: "Entry in a menu used to hide or show the interface."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class

	INTERFACE_ENTRY

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
--				new_main_panel.show_interface
				main_panel.show_interface
			else
--				new_main_panel.hide_interface
				main_panel.hide_interface
			end
		end


end -- class INTERFACE_ENTRY
