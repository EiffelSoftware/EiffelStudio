indexing
	description: "Expand/Hide the children."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class EXPAND_PARENT_HOLE

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
--			set_focus_string (Focus_labels.expand_parent_label)
--		end

	symbol: EV_PIXMAP is
		do
			Result := Pixmaps.expand_parent_pixmap
		end

feature {NONE} -- Command

	execute (arg: EV_ARGUMENT; ev_data: EV_PND_EVENT_DATA) is
				-- Raise the dropped windows.
		local
			ctxt: CONTEXT
		do
			ctxt ?= ev_data.data
			if ctxt.tree_element.is_parent then
				if ctxt.tree_element.is_expanded then
					ctxt.tree_element.set_expand (False)
				else
					ctxt.tree_element.set_expand (True)
				end
			end
		end

end -- class EXPAND_PARENT_HOLE

