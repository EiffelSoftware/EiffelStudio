indexing
	description: "Popup Menu for a Class"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	CLASS_POPUP_MENU

inherit
	EC_POPUP_MENU
		redefine
			data
		end

creation
	make_from_workarea

feature -- Initialization
	
	make_from_workarea(worka: WORKAREA;cont: EV_CONTAINER) is
			-- Initialize
		require
			workarea_exists: worka /= Void
			container_exists: cont /= Void
		local
			it: EV_MENU_ITEM
			com: EV_ROUTINE_COMMAND
		do
			make(cont)
			workarea := worka
			data ?= worka.active_entity_data
			
			!! com.make(~rename_data)
			!! it.make_with_text(Current,"Rename")
			it.add_select_command(com, Void)
			
			!! it.make_with_text(Current,"Edit")

			!! it.make_with_text(Current,"Colorize")

			!! it.make_with_text(Current,"Hide")

			!! com.make(~remove)
			!! it.make_with_text(Current,"Delete")
			it.add_select_command(com, Void)
		end

feature -- Implementation

	data: CLASS_DATA
		-- Class Data that describes Current.

	rename_command: RENAME_ENTITY_COMMAND
		-- Rename Command

	at: EV_UNTITLED_WINDOW

feature -- Operations

	remove (args: EV_ARGUMENT; event_data: EV_EVENT_DATA) is
			-- Delete 'data'
		require
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

end -- class CLASS_POPUP_MENU
