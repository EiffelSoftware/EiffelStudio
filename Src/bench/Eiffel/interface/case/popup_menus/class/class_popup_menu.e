indexing
	description: "Popup Menu for a Class"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	CLASS_POPUP_MENU

inherit
	POPUP_LINKABLE_MENU
		redefine
			data
		end

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
			make(worka.scrollable_area)
			workarea := worka
			data ?= worka.active_entity_data
			
			!! com.make(~rename_data)
			!! it.make_with_text(Current,"Rename")
			it.add_select_command(com, Void)
			
			!! com.make(~popup_editor)
			!! it.make_with_text(Current,"Edit")
			it.add_select_command(com, Void)

			!! com.make(~colorize)
			!! it.make_with_text(Current,"Colorize")
			it.add_select_command(com, Void)
			
			!! com.make(~hide)
			!! it.make_with_text(Current,"Hide")
			it.add_select_command(com, Void)

			!! com.make(~remove)
			!! it.make_with_text(Current,"Delete")
			it.add_select_command(com, Void)
		end

feature -- Implementation

	data: CLASS_DATA
		-- Class Data that describes Current.

end -- class CLASS_POPUP_MENU
