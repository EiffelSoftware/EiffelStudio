indexing
	description: "SD_ZONE which tab is at top side without SD_TITLE_BAR"
	date: "$Date$"
	revision: "$Revision$"

class
	SD_TAB_ZONE_UPPER

inherit
	SD_TAB_ZONE
		redefine
			make,
			on_select_tab,
			internal_notebook,
			on_normal_max_window,
			recover_to_normal_state
		end
create
	make

feature {NONE} -- Initlization

	make (a_content: SD_CONTENT; a_target_zone: SD_DOCKING_ZONE) is
			-- Redefine.
		do
			Precursor {SD_TAB_ZONE} (a_content, a_target_zone)
			internal_notebook.set_tab_position ({SD_NOTEBOOK}.tab_top)
			internal_notebook.close_request_actions.extend (agent on_close_request)
			internal_notebook.normal_max_actions.extend (agent on_normal_max_window)
			
			internal_notebook.tab_double_click_actions.extend (agent on_normal_max_window)
		end

feature {NONE} -- Implementation

	on_select_tab is
			-- Redefine
		local
			l_content: SD_CONTENT
		do
			if not internal_diable_on_select_tab then
				Precursor {SD_TAB_ZONE}
				l_content := contents.i_th (internal_notebook.selected_item_index)
				if l_content.mini_toolbar /= Void then
					internal_notebook.set_mini_tool_bar (l_content.mini_toolbar)
				end
			end
		end
	
	on_normal_max_window is
			-- Redefine. (Just copy from SD_ZONE version)
		local
			l_split_area: EV_SPLIT_AREA
		do
			internal_docking_manager.lock_update
			main_area := internal_docking_manager.inner_container (Current)
			if not is_maximized then
				main_area_widget := main_area.item
				internal_parent := parent
				l_split_area ?= internal_parent
				if l_split_area /= Void then
					internal_parent_split_position := l_split_area.split_position
				end
				internal_parent.prune (Current)
				main_area.wipe_out
				main_area.extend (Current)
				set_max (True)
			else
				recover_to_normal_state
			end
			internal_docking_manager.unlock_update
		end
		
	recover_to_normal_state is
			-- Redefine.
		do
			internal_notebook.set_normal_max_pixmap (False)
			Precursor {SD_TAB_ZONE}
		end
		
feature {NONE}

	internal_notebook: SD_NOTEBOOK_UPPER
			-- Notebook which tabs at top.

end
