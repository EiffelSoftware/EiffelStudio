indexing
	description: "Relation Menu"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	RELATION_POPUP_MENU

inherit
	EC_POPUP_MENU

creation
	make_from_workarea

feature -- Initialization
	
	make_from_workarea(worka: WORKAREA) is
			-- Initialize
		require
			workarea_exists: worka /= Void
		local
			it: EV_MENU_ITEM
			com: EV_ROUTINE_COMMAND
		do
			workarea := worka
			make(workarea.scrollable_area)
			data ?= worka.active_entity_data
			
			!! com.make(~popup_editor)
			!! it.make_with_text(Current,"Edit")
			it.add_select_command(com, Void)

			!! com.make(~colorize)
			!! it.make_with_text(Current,"Colorize")
			it.add_select_command(com, Void)

			!! com.make(~remove)
			!! it.make_with_text(Current,"Delete")
			it.add_select_command(com, Void)
		end

feature -- Operations

	remove (args: EV_ARGUMENT; event_data: EV_EVENT_DATA) is
			-- Delete 'data'
		require else
			stone_exists: data.stone /= Void
		do
			data.stone.destroy_data
		end

feature -- Implementation

	data: RELATION_DATA
		-- Relation Data.

end -- class RELATION_POPUP_MENU
