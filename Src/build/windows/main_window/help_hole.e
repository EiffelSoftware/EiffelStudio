indexing
	description: "General help hole."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class HELP_HOLE 

inherit

	EDIT_BUTTON

creation
	make

feature {NONE} -- Initialysation

--	create_focus_label is 
--		do
--			set_focus_string (Focus_labels.help_label)
--		end

	symbol: EV_PIXMAP is
		do
			Result := Pixmaps.help_pixmap
		end

feature {NONE} -- Command

	create_empty_editor is
		local
			hw: HELP_WINDOW
		do
			create hw.make (main_window)
			hw.show
		end	

end -- class HELP_HOLE

