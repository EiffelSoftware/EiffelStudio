indexing
	description: "Button to edit the transitions corresponding to an arrow."
	Id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class APP_LINE_HOLE 

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
			rout_cmd: EV_ROUTINE_COMMAND
		do
			Precursor (par)
			create rout_cmd.make (~process_transition)
			add_pnd_command (Pnd_types.transition_type, rout_cmd, Void)
		end

--	create_focus_label is
--		do
--			set_focus_string (Focus_labels.transition_line_label)
--		end

	symbol: EV_PIXMAP is
		do
			Result := Pixmaps.transition_line_pixmap
		end

feature {APP_LINE_HOLE} -- Hole

	process_transition (arg: EV_ARGUMENT; ev_data: EV_PND_EVENT_DATA) is
			--XX dropped: TRANS_STONE
		local
			st_line: STATE_LINE
		do
			st_line ?= ev_data.data
			st_line.create_editor
		end

end -- class APP_LINE_HOLE

