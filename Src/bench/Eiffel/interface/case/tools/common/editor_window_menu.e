indexing
	description: "Basics for a an editor menu"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	EDITOR_WINDOW_MENU

inherit
	EC_MENU
		redefine
			make
		end

creation
	make

feature -- Initialization

	make (parent: ECASE_WINDOW) is
			-- Initialize
		require else
			exists : parent /= Void
		local
			save_size_i: EV_MENU_ITEM			
			save_size_command: SAVE_SIZE_COM
		do
			-- Your instructions here
			precursor ( parent )
			!! file_m.make_with_text(menu_bar,"&File")

			!! format_m.make_with_text(menu_bar,"&Format")
				!! save_size_i.make_with_text (format_m, widget_names.save_size)
				!! save_size_command.make (parent)
				save_size_i.add_select_command (save_size_command, Void)
		end

feature -- Implementation

	file_m, format_m: EV_MENU

end -- class EDITOR_WINDOW_MENU
