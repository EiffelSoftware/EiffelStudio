indexing
	description: "Toolbar for System Window"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	SYSTEM_WINDOW_TOOLBAR

inherit

	EDITOR_WINDOW_TOOLBAR
		redefine
			make,fill_with_buttons
		end

creation
	make

feature -- Initialization

	make (parent: EC_EDITOR_WINDOW [ANY]) is
		do
			!! tool_bar.make ( parent.global_container )
			precursor ( parent )
			tool_bar.set_vertical_resize ( FALSE )
			tool_bar.set_expand(FALSE)
		end

feature -- Settings

	fill_with_buttons is 
		local
			pixmap: EV_PIXMAP
			trash_hole_command: TRASH_HOLE_COM
		do
			!! but1.make (tool_bar)
			!! trash_hole_command
			but1.add_click_command (trash_hole_command, Void)

			pixmap := pixmaps.trash_pixmap
			but1.set_pixmap (pixmap)

		end

feature {NONE} -- Implementation

	but1,but2: EV_TOOL_BAR_BUTTON

end -- class SYSTEM_WINDOW_TOOLBAR
