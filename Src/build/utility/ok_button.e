indexing
	description: "Button OK represented with a pixmap."
	date: "$Date$"
	id: "$Id$"
	revision: "$Revision$"

class OK_BUTTON 

inherit

	EB_BUTTON

creation

	make

feature {NONE} -- focus label

--	create_focus_label is
--		do
--			set_focus_string (Focus_labels.accept_change_label)
--		end

	symbol: EV_PIXMAP is
		do
			Result := Pixmaps.ok_pixmap
		end

end -- class OK_BUTTON
 
