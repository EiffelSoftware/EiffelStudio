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
			-- Rename 'data'
		local
			namer: EDITOR_WINDOW_NAMER
		do

			namer := workarea.analysis_window.namer
			namer.initialize_data(data)
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
