indexing
	description: "Objects that represent the special debug menu for eStudio"
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
	
	EB_SHARED_GRAPHICAL_COMMANDS 
		undefine
			default_create, is_equal, copy
		end
	EB_SHARED_PREFERENCES
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
			set_text (Major_version_number.out + "." + Minor_version_number.out + "." +Build_version_number)
			
				--| Memory tool
			create menu_item.make_with_text ("Memory Analyzer")
			menu_item.select_actions.extend (agent launch_memory_tool)
			extend (menu_item)
		
		end
		
feature {NONE} -- Actions

	launch_memory_tool is
			-- Launch Memory Analyzer.
		local
			l_env: EXECUTION_ENVIRONMENT
			l_path: STRING
			l_dir: DIRECTORY_NAME
			l_dlg: EV_INFORMATION_DIALOG
		do
			if ma_window = Void or ma_window.is_destroyed then
				create l_env
				l_path := l_env.get ("EIFFEL_SRC")
				if l_path = Void then
					create l_dlg.make_with_text ("EIFFEL_SRC not defined.")
					l_dlg.show
				else
					create l_dir.make_from_string (l_path)
					l_dir.extend_from_array (<<"library", "memory_analyzer" >>)
					create ma_window.make (l_dir)
					ma_window.close_request_actions.extend (agent handle_close_window)
				end
			end
			ma_window.show
		end
		
feature {NONE} -- Implementation

	handle_close_window is
			-- Handle user press window action.
		do
			ma_window.hide
		end
		
	window: EV_WINDOW
			-- Main development window.
	
	ma_window: MA_WINDOW
			-- Memory analyzer window.

end
