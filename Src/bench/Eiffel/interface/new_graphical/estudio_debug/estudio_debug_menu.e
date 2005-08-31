indexing
	description: "Objects that represent the special debug menu for eStudio"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ESTUDIO_DEBUG_MENU

inherit
	EV_MENU
	
	SYSTEM_CONSTANTS
		undefine
			default_create, is_equal, copy
		end		
		
create
	make_with_window
	
feature {NONE} -- Initialization
	
	make_with_window (w: EV_WINDOW) is
		local
			menu_item: EV_MENU_ITEM
		do
			window := w
			default_create
			set_text ("[eStudioDbg - " + Version_number + "]")
			
				--| Memory tool
			create menu_item.make_with_text ("Memory tool")
			menu_item.select_actions.extend (agent launch_memory_tool)
			extend (menu_item)
		
				-- Breakpoints
			create menu_item.make_with_text_and_action ("Save breakpoints now", agent save_breakpoints)
			extend (menu_item)

				--| Others ...
--			create menu_item.make_with_text_and_action ("Menu item title", agent menu_item_command)
--			extend (menu_item)

				--| Close ...
			extend (create {EV_MENU_SEPARATOR})
			create menu_item.make_with_text_and_action ("Close menu", agent close_menu)
			extend (menu_item)
		end
		
feature -- Access

	close_menu is
		do
			destroy
		end
		
feature {NONE} -- Actions

	save_breakpoints is
		local
			sh_app: SHARED_APPLICATION_EXECUTION
			app: APPLICATION_EXECUTION
		do
			create sh_app
			app := sh_app.application
			app.save_debug_info
			show_popup_message ("Breakpoints saved")
		end			
	
	launch_memory_tool is
		do
			--| to implement
			show_popup_message ("Memory tool : Not yet implemented")
		end
		
feature {NONE} -- Implementation

	window: EV_WINDOW

	show_popup_message (m: STRING) is
		local
			d: EV_INFORMATION_DIALOG
		do
			create d.make_with_text (m)
			d.show_relative_to_window (window)
		end

end
