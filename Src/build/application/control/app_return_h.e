indexing
	description: "Hole to do a back trasition on the previous state."
	Id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class APP_RETURN_H 

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
			cmd: APP_SET_RETURN
		do
			Precursor (par)
			create cmd
			add_pnd_command (Pnd_types.label_type, cmd, Void)
		end

	symbol: EV_PIXMAP is
		do
			Result := Pixmaps.return_pixmap
		end

--	create_focus_label is
--		do
--			set_focus_string (Focus_labels.return_label)
--		end

end -- class APP_RETURN_H

