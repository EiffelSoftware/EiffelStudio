indexing
	description: "Namer window: namer tool."
	date: "$Date$"
	id: "$Id$"
	revision: "$Revision$"

class NAMER_WIN_EDIT_HOLE 

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
			cmd: EV_ROUTINE_COMMAND
		do
			{EB_BUTTON} Precursor (par)
			create cmd.make (~process_name)
			add_default_pnd_command (cmd, Void)
		end

--	create_focus_label is
--		do
--			set_focus_string (Focus_labels.namer_label)
--		end

	symbol: EV_PIXMAP is
		do
			Result := Pixmaps.namer_pixmap
		end

feature {NAMER_WIN_EDIT_HOLE} -- Target

	process_name(arg: EV_ARGUMENT; ev_data: EV_PND_EVENT_DATA) is
		local
			namable: NAMABLE
		do
			namable ?= ev_data.data
			if namable /= Void then
				namer_window.set_namable (namable)
			end
		end

--feature {NONE} -- Stone

--	stone: STONE is
--		do
--			Result ?= namer_window.namable
--		end

--	source: WIDGET is
--		do
--			Result := Current
--		end

end -- class NAMER_WIN_EDIT_HOLE

