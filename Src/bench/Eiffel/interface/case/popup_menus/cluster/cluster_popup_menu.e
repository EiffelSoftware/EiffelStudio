indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CLUSTER_POPUP_MENU

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
			check
				good_call: data /= Void
				-- This procedure has to be called only when the mouse points a cluster.
			end
			!! com.make(~rename_data)
			!! it.make_with_text(Current,"Rename")
			it.add_select_command(com, Void)
			
			if data.is_icon then
				!! com.make(~uniconify)
				!! it.make_with_text(Current,"De-iconize")
				it.add_select_command(com, Void)
			else
				!! com.make(~iconify)
				!! it.make_with_text(Current,"Iconize")
				it.add_select_command(com, Void)
			end

			!! com.make(~popup_editor)
			!! it.make_with_text(Current,"Open")
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


feature -- Operation

	iconify (args: EV_ARGUMENT; dat: EV_EVENT_DATA) is
		local
			exec: ICONIFY_U
		do
			!! exec.make(data)
		end
	
	uniconify (args: EV_ARGUMENT; dat: EV_EVENT_DATA) is
		local
			exec: UNICONIFY_U
		do
			!! exec.make(data,data)
		end

feature -- Implementation

	data: CLUSTER_DATA
		-- Relation Data.


end -- class CLUSTER_POPUP_MENU
