indexing
	description: "Hole for the wastebasket."
	Id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class 
	CUT_HOLE 

inherit
 	EB_BUTTON
		redefine
			make
		end

	EV_COMMAND

	ERROR_POPUPER

	WINDOWS

creation
	make

feature {NONE} -- Initialization

	make (par: EV_TOOL_BAR) is
		do
			{EB_BUTTON} Precursor (par)
			add_default_pnd_command (Current, Void)
		end

--	create_focus_label is 
--		do
--			set_focus_string (Focus_labels.wastebasket_label)
--		end

	symbol: EV_PIXMAP is
		do
			Result := Pixmaps.wastebasket_pixmap
		end
	
feature {NONE} -- Implementation

	execute (arg: EV_ARGUMENT; ev_data: EV_PND_EVENT_DATA) is
		local
			r: REMOVABLE
			n: NAMABLE
		do
			r ?= ev_data.data
			if r /= Void then
				r.remove_yourself
				n ?= r
				if n /= Void and then namer_window.namable = n then
					namer_window.popdown
				end
			else
				error_dialog.popup (Current, Messages.cannot_remove_er, Void)
			end
		end

end -- class CUT_HOLE
