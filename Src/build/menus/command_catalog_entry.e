indexing
	description: "Entry in a menu used to hide or show the %
				% command catalog."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class

	COMMAND_CATALOG_ENTRY

inherit

	MAIN_PANEL_TOGGLE

	SHARED_CONTEXT

creation

	make

feature {NONE}

	toggle_pressed is
			-- Display or hide the command catalog.
		do
			if armed then
				main_panel.show_command_catalog
			else
				main_panel.hide_command_catalog
			end
		end

end -- class COMMAND_CATALOG_ENTRY
