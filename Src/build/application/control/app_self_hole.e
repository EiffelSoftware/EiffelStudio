indexing
	description: "Hole to do a loop transition on a state."
	Id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class APP_SELF_HOLE 

inherit
	EB_BUTTON
		redefine
			make
		end

creation
	make
	
feature {NONE} -- Initialization

	make (a_parent: EV_CONTAINER) is
		local
			cmd: APP_CUT_LABEL
		do
			Precursor (a_parent)
			create cmd
			add_pnd_command (Pnd_types.label_type, cmd, Void)
		end

--	create_focus_label is
--		do
--			set_focus_string (Focus_labels.self_label)
--		end

	symbol: EV_PIXMAP is
		do
			Result := Pixmaps.self_label_pixmap
		end

end -- class APP_SELF_HOLE

