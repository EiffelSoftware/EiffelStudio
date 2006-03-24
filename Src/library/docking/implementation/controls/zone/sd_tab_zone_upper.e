indexing
	description: "SD_ZONE which tab is at top side without SD_TITLE_BAR"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			recover_to_normal_state,
			is_maximized,
			set_max,
			title_area
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

feature -- Query

	is_maximized: BOOLEAN is
			-- Redefine
		do
			Result := internal_notebook.is_maximized
		end

	title_area: EV_RECTANGLE is
			-- Redefine
		do
			Result := internal_notebook.tab_area
		end

feature -- Command

	set_max (a_max: BOOLEAN) is
			-- Redefine.
		do
			 internal_notebook.set_show_maximized (a_max)
		end

feature {NONE} -- Implementation

	on_select_tab is
			-- Redefine
		local
			l_content: SD_CONTENT
		do
--			if not internal_diable_on_select_tab then
				Precursor {SD_TAB_ZONE}
				l_content := contents.i_th (internal_notebook.selected_item_index)
				if l_content.mini_toolbar /= Void then
					internal_notebook.set_mini_tool_bar (l_content.mini_toolbar)
				end
--			end
		end

	on_normal_max_window is
			-- Redefine. (Just copy from SD_ZONE version)
		local
			l_split_area: EV_SPLIT_AREA
		do
			internal_docking_manager.command.lock_update (Void, True)
			main_area := internal_docking_manager.query.inner_container (Current)
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
				internal_notebook.set_show_maximized (True)
			else
				recover_to_normal_state
			end
			internal_docking_manager.command.resize
			internal_docking_manager.command.unlock_update
		end

	recover_to_normal_state is
			-- Redefine.
		do
--			internal_notebook.set_show_maximized (False)
			Precursor {SD_TAB_ZONE}
		end

feature {NONE}

	internal_notebook: SD_NOTEBOOK_UPPER;
			-- Notebook which tabs at top.

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end
