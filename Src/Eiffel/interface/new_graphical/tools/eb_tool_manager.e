indexing
	description	: "Window containing several tools"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"

deferred class
	EB_TOOL_MANAGER

inherit
	EB_WINDOW
		redefine
			internal_recycle,
			internal_detach_entities
		end

	SHARED_DEBUGGER_MANAGER
		undefine
			default_create
		end

	EB_HISTORY_OWNER
		undefine
			default_create
		redefine
			internal_recycle,
			internal_detach_entities
		end

	EB_SHARED_PREFERENCES
		undefine
			default_create
		end

	ES_TOOLBAR_PREFERENCE
		undefine
			default_create
		end

feature {NONE} -- Initialization

	init_tools_list is
			-- Create and set up the list of tools that can be put on the left
			-- and on the bottom-right.
		do
		end

feature {NONE} -- Clean up

	internal_recycle
			-- To be called when the button has became useless.
		do
			window.accelerators.wipe_out
			toolbars_area.wipe_out
			panel.wipe_out
			container.wipe_out
			toolbars_area.destroy
			panel.destroy
			container.destroy

			Precursor {EB_HISTORY_OWNER}
			Precursor {EB_WINDOW}
		end

	internal_detach_entities
			-- Detaches objects from their container
		do
			container := Void
			toolbars_area := Void
			favorites_manager := Void
			cluster_manager := Void
			status_bar := Void
			panel := Void

			Precursor {EB_HISTORY_OWNER}
			Precursor {EB_WINDOW}
		ensure then
			container_detached: container = Void
			toolbars_area_detached: toolbars_area = Void
			favorites_manager_detached: favorites_manager = Void
			cluster_manager_detached: cluster_manager = Void
			status_bar_detached: status_bar = Void
			panel_detached: panel = Void
		end

feature -- Access

	status_bar: EB_DEVELOPMENT_WINDOW_STATUS_BAR
			-- Status bar.

feature -- Status setting

	hide_tools is
			-- Hide all tools.
			--| Used for optimization purposes, to avoid computing a lot
			--| when changing completely the display of the window.
		do
			status_bar.widget.hide
			panel.hide
		end

	show_tools is
			-- Show all tools.
		do
			panel.show
			status_bar.widget.show
		end

feature {EB_DEBUGGER_MANAGER, EB_TOOL, EB_DEVELOPMENT_WINDOW_BUILDER,
			EB_DEVELOPMENT_WINDOW_DIRECTOR} -- Explorer bars

	panel: EV_CELL
			-- Main panel. It can be either a EV_HORIZONTAL_SPLIT_AREA or an EV_CELL.
			-- It depends whether the left explorer bar is displayed or not.
			--
			-- Panel contains `left_panel' and `right_panel' if it's a split area,
			-- `right_panel' only if it's a cell.

feature {EB_DEVELOPMENT_WINDOW_BUILDER, EB_DEVELOPMENT_WINDOW_MENU_BUILDER} -- Vision2 architechture

	container: EV_VERTICAL_BOX
			-- Main container. It contains everything that appears in the window:
			-- The toolbars area and the panel.

	toolbars_area: EV_VERTICAL_BOX
			-- Area where toolbars will be displayed.

feature -- Favorites & History handling.

	favorites_manager: EB_FAVORITES_MANAGER
			-- Graphical manager for favorites, contains the favorites
			-- tree (`favorites_window') and the favorites menu.

	cluster_manager: EB_CLUSTER_MANAGER
			-- Graphical manager for clusters and classes, contains the cluster tree.

	set_favorites_manager (a_favorites_manager: EB_FAVORITES_MANAGER) is
			-- Set `favorites_manager' to `a_favorites_manager'.
		do
			favorites_manager := a_favorites_manager
		end

	set_cluster_manager (a_cluster_manager: EB_CLUSTER_MANAGER) is
			-- Set `cluster_manager' to `a_cluster_manager'.
		do
			cluster_manager := a_cluster_manager
		end

feature -- Explorer bar handling.

	splitter_position: INTEGER
			-- Position of the main splitter.

	restore_bars is
			-- A maximized item has been restored.
		do
				-- Do not force the bar to be shown if it is empty, as
				-- in that state it should be hidden.
		end

feature {NONE} -- Initialization flags

	tools_initialized: BOOLEAN
			-- Are the tools initialized?

feature {NONE} -- Constants

	Frame_constants: EV_FRAME_CONSTANTS is
			-- Default constants for Frame look.
		once
			create Result
		end

	Default_colors: EV_STOCK_COLORS is
			-- Default Vision2 colors.
		once
			create Result
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class EB_TOOL_MANAGER
