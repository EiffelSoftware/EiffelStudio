indexing
	description: "Popup Linkable menu"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	POPUP_LINKABLE_MENU

inherit
		EC_POPUP_MENU

feature -- Operations

	hide (args: EV_ARGUMENT; event_data: EV_EVENT_DATA) is
			-- Delete 'data'
		local
			hide_com: HIDE_LINKABLE_U
		do
			!! hide_com.make(data)
		end

	remove (args: EV_ARGUMENT; event_data: EV_EVENT_DATA) is
			-- Delete 'data'
		require else
			stone_exists: data.stone /= Void
		do
			data.stone.destroy_data
		end

	rename_data (args: EV_ARGUMENT; event_data: EV_EVENT_DATA) is
			-- Delete 'data'
		local
			att: EV_TEXT_FIELD
			com: EV_ROUTINE_COMMAND
			cl: GRAPH_LINKABLE
		do
			!! at.make(workarea.analysis_window)
			!! att.make_with_text(at,data.name)

			cl := workarea.find_linkable(data)

			att.set_minimum_width_in_characters(data.name.count+2)
			at.set_minimum_height(5)
			att.set_vertical_resize(TRUE)
			att.set_horizontal_resize(TRUE)

			at.set_x_y(cl.upper_left.x,	cl.upper_left.y)

			!! rename_command.make(data, att)
			!! com.make(~update_data)
			att.add_activate_command(com,Void)
			at.show
		end

	update_data  (args: EV_ARGUMENT; event_data: EV_EVENT_DATA) is
		require
			command_exists: rename_command /= Void
		do
			rename_command.execute(Void,Void)
			rename_command := Void
			at.destroy
		ensure
			rename_command_initialized: rename_command = Void
			at_destroyed: at.destroyed
		end

feature -- Implementation

	data: LINKABLE_DATA is deferred end

	rename_command: RENAME_ENTITY_COMMAND
		-- Rename Command

	at: EV_UNTITLED_WINDOW

end -- class POPUP_LINKABLE_MENU
