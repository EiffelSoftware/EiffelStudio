indexing
	description: "Hole to make a transition which exit the Application."
	Id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class APP_EXIT_HOLE 

inherit
	EB_BUTTON
		redefine
			make
		end

creation
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
		local
			cmd: APP_SET_EXIT
		do
			Precursor (par)
			create cmd
			add_pnd_command (Pnd_types.label_type, cmd, Void)
		end

	symbol: EV_PIXMAP is
		do
			Result := Pixmaps.exit_label_pixmap
		end

--	create_focus_label is
--		do
--			set_focus_string (Focus_labels.exit_label)
--		end

end -- class APP_EXIT_HOLE

