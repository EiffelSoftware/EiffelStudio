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

	WINDOWS

creation

	make

feature {NONE} -- Initialization

	make (par: EV_TOOL_BAR) is
		local
			rout_cmd: EV_ROUTINE_COMMAND
		do
			{EB_BUTTON} Precursor (par)
			create rout_cmd.make (~process_cut)
			add_default_pnd_command (rout_cmd, Void)
		end

--	create_focus_label is 
--		do
--			set_focus_string (Focus_labels.wastebasket_label)
--		end

	symbol: EV_PIXMAP is
		do
			Result := Pixmaps.wastebasket_pixmap
		end
	
feature {CUT_HOLE}

	process_cut (arg: EV_ARGUMENT; ev_data: EV_PND_EVENT_DATA) is
		local
			r: REMOVABLE
			n: NAMABLE
		do
			r ?= ev_data.data
			if (r /= Void) then
				r.remove_yourself
				n ?= r
				if n /= Void and then namer_window.namable = n then
					namer_window.popdown
				end
			end
		end

end -- class CUT_HOLE
