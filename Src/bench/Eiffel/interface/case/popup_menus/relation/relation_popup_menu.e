indexing
	description: "Relation Menu"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	RELATION_POPUP_MENU

inherit
	EC_POPUP_MENU

	ONCES

creation
	make_from_workarea

feature -- Initialization
	
	make_from_workarea(worka: WORKAREA) is
			-- Initialize
		require
			workarea_exists: worka /= Void
		local
			it,itt: EV_MENU_ITEM
			com: EV_ROUTINE_COMMAND
			cli_sup: CLI_SUP_DATA
			left_handle_command: ADV_LEFT
			right_handle_command: ADV_RIGHT
			orient: CHANGE_LABEL_ORIENTATION_U
		do
			workarea := worka
			make(workarea.scrollable_area)
			data ?= worka.active_entity_data
			check
				good_type: data /= Void
			end
			
			!! it.make_with_text(Current,"Handles")

			!! left_handle_command.make(data)
			!! itt.make_with_text(it,"Left-bottom corner")
			itt.add_select_command(left_handle_command, Void)
			
			!! itt.make_with_text(it,"Right-bottom corner")
			!! right_handle_command.make(data)	
			itt.add_select_command(right_handle_command,Void)

			!! itt.make_with_text(it,"Remove")
			!! com.make(~remove_handles)
			itt.add_select_command(com,Void)

			
			cli_sup ?= data
			if cli_sup /= Void then
				!! it.make_with_text(Current,"Annotations")
			
				!! com.make(~select_share)
				if cli_sup.is_shared then
					!! shared_menu.make_with_text(it,"Unshare")
				else
					!! shared_menu.make_with_text(it,"Share")
				end
				shared_menu.add_select_command(com, Void)

				!! itt.make_with_text(it,"Multiplicity ...")

				!! itt.make_with_text(Current,"Label")
			
				!! it.make_with_text(itt,"Edit")
				!! com.make(~edit_label)
				it.add_select_command(com, Void)
				
			--	!! orient.make(cli_sup,cli_sup.is_vertical_text,FALSE)
				if cli_sup.is_vertical_text then
					!! vertical_label.make_with_text(itt, "Set Vertical")
				else
					!! vertical_label.make_with_text(itt,"Set Horizontal")
				end
			--	vertical_label.add_select_command(orient, Void)
				
				!! it.make_with_text(itt,"Destroy Label")	
			end

			!! com.make(~colorize)
			!! it.make_with_text(Current,"Colorize...")
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

	remove_handles (args: EV_ARGUMENT; event_data: EV_EVENT_DATA) is
			-- Remove the handles.
		local
			remove_handles_u: REMOVE_HANDLES_U
		do
			!! remove_handles_u.make (data)
		end

	select_share (args: EV_ARGUMENT; event_data: EV_EVENT_DATA) is
			-- Select share.
		local
			com1: REMOVE_SHARED_U
			com2: ADD_SHARED_U
			cli_sup: CLI_SUP_DATA
		do
			cli_sup ?= data
			check
				cli_sup_exists: cli_sup /= Void
				-- should be called only for a client-supplier link.
			end
			if cli_sup.is_shared then
				!! com1.make(cli_sup, cli_sup.shared,FALSE)
				shared_menu.set_text("Share")
			else
				!! com2.make(cli_sup, FALSE)
				shared_menu.set_text("Unshare")
			end
		end

	edit_label (args: EV_ARGUMENT; event_data: EV_EVENT_DATA) is
			-- Edit the label.
		local
			namer: EDITOR_WINDOW_NAMER
			cli_sup: CLI_SUP_DATA
		do
			cli_sup ?= data
			check
				correct_type: cli_sup /= Void
			end
			namer := workarea.analysis_window.namer
			namer.initialize_data(cli_sup.label)
			observer_management.update_observer(data)
		end

feature -- Implementation

	data: RELATION_DATA
		-- Relation Data.

	shared_menu,vertical_label: EV_MENU_ITEM

invariant
	RELATION_POPUP_MENU_data_exists: data /= Void
end -- class RELATION_POPUP_MENU
