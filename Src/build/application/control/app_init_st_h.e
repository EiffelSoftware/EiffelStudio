indexing
	description: "Hole to set the initial state of the Application."
	Id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class APP_INIT_ST_H 	

inherit
	EB_BUTTON
		redefine
			make
		end

creation
	make
	
feature {NONE}

	make (par: EV_CONTAINER) is
		local
			cmd: APP_SET_INIT_STATE
		do
			Precursor (par)
			create cmd
			add_pnd_command (Pnd_types.state_type, cmd, Void)
		end

	symbol: EV_PIXMAP is
		do
			Result := Pixmaps.initial_state_pixmap
		end

--	create_focus_label is
--		do
--			set_focus_string (Focus_labels.initial_state_label)
--		end

end -- class APP_INIT_ST_H

