indexing
	description: "Show/Hide windows."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class SHOW_WINDOW_HOLE

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
--			set_focus_string (Focus_labels.show_window_label)
--		end

	symbol: EV_PIXMAP is
		do
			Result := Pixmaps.show_window_pixmap
		end


feature {NONE} -- Command

	execute (arg: EV_ARGUMENT; ev_data: EV_PND_EVENT_DATA) is
		local
			ctxt: CONTEXT
		do
			ctxt ?= ev_data.data
			if ctxt.is_window then
				if ctxt.shown then
					ctxt.hide
				else
--					main_window.menu_bar.interface_entry.set_selected (True)
					ctxt.show
				end
			end
		end

end -- class SHOW_WINDOW_HOLE

