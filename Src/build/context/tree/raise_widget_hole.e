indexing
	description: "Raise the dropped windows."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class RAISE_WIDGET_HOLE

inherit
	EB_BUTTON
		redefine
			make
		end

	CONSTANTS

	EV_COMMAND

creation
	make

feature {NONE} -- Initialization
 
	make (par: EV_TOOL_BAR) is
        do
			{EB_BUTTON} Precursor (par)
			add_pnd_command (Pnd_types.context_type, Current, Void)
        end

--	create_focus_label is
--		do
--			set_focus_string (Focus_labels.raise_widget_label)
--		end

	symbol: EV_PIXMAP is
		do
			Result := Pixmaps.raise_widget_pixmap
		end

feature {NONE} -- Command

	execute (arg: EV_ARGUMENT; ev_data: EV_PND_EVENT_DATA) is
				-- Raise the dropped windows.
		local
			win: WINDOW_C
		do
			win ?= ev_data.data
			win.raise
		end

end -- class RAISE_WIDGET_HOLE

