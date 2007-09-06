indexing
	description: "Smart Docking library widget lists."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_WIDGETS

inherit
	IDENTIFIED

feature -- Query

	all_tool_bars: ARRAYED_LIST [SD_TOOL_BAR] is
			-- All SD_TOOL_BAR instances.
		local
			l_list: ARRAYED_LIST [INTEGER]
			l_item: SD_TOOL_BAR
		do
			create Result.make (10)

			l_list := all_tool_bars_cell.item
			if l_list /= Void then
				from
					l_list.start
				until
					l_list.after
				loop
					l_item ?= id_object (l_list.item)
					if l_item /= Void then
						Result.extend (l_item)
					end
					l_list.forth
				end
			end
		ensure
			not_void: Result /= Void
		end

	all_tool_bar_zones: ARRAYED_LIST [SD_TOOL_BAR_ZONE] is
			-- All SD_TOOL_BAR_ZONE instances.
		local
			l_list: ARRAYED_LIST [INTEGER]
			l_item: SD_TOOL_BAR_ZONE
		do
			create Result.make (10)

			l_list := all_tool_bar_zones_cell.item
			if l_list /= Void then
				from
					l_list.start
				until
					l_list.after
				loop
					l_item ?= id_object (l_list.item)
					if l_item /= Void then
						Result.extend (l_item)
					end
					l_list.forth
				end
			end
		ensure
			not_void: Result /= Void
		end

	all_title_bars: ARRAYED_LIST [SD_TITLE_BAR] is
			-- All SD_TITLE_BAR instances.
		local
			l_list: ARRAYED_LIST [INTEGER]
			l_item: SD_TITLE_BAR
		do
			create Result.make (10)

			l_list := all_title_bars_cell.item
			if l_list /= Void then
				from
					l_list.start
				until
					l_list.after
				loop
					l_item ?= id_object (l_list.item)
					if l_item /= Void then
						Result.extend (l_item)
					end
					l_list.forth
				end
			end
		ensure
			not_void: Result /= Void
		end

	all_notebooks: ARRAYED_LIST [SD_NOTEBOOK] is
			-- All SD_NOTEBOOK instances.
		local
			l_list: ARRAYED_LIST [INTEGER]
			l_item: SD_NOTEBOOK
		do
			create Result.make (10)

			l_list := all_notebooks_cell.item
			if l_list /= Void then
				from
					l_list.start
				until
					l_list.after
				loop
					l_item ?= id_object (l_list.item)
					if l_item /= Void then
						Result.extend (l_item)
					end
					l_list.forth
				end
			end
		ensure
			not_void: Result /= Void
		end

	all_auto_hide_panels: ARRAYED_LIST [SD_AUTO_HIDE_PANEL] is
			-- All SD_AUTO_HIDE_PANEL instances.
		local
			l_list: ARRAYED_LIST [INTEGER]
			l_item: SD_AUTO_HIDE_PANEL
		do
			create Result.make (10)

			l_list := all_auto_hide_panels_cell.item
			if l_list /= Void then
				from
					l_list.start
				until
					l_list.after
				loop
					l_item ?= id_object (l_list.item)
					if l_item /= Void then
						Result.extend (l_item)
					end
					l_list.forth
				end
			end
		ensure
			not_void: Result /= Void
		end

feature -- Command is

	add_tool_bar (a_tool_bar: SD_TOOL_BAR) is
			-- Add `a_tool_bar''s object id.
		require
			not_void: a_tool_bar /= Void
		local
			l_list: ARRAYED_LIST [INTEGER]
		do
			l_list := all_tool_bars_cell.item
			if l_list = Void then
				create l_list.make (10)
				all_tool_bars_cell.put (l_list)
			end
			l_list.extend (a_tool_bar.object_id)
		ensure
			not_void: all_tool_bars_cell.item /= Void
			has: all_tool_bars.has (a_tool_bar)
		end

	prune_tool_bar (a_tool_bar: SD_TOOL_BAR) is
			-- Prune `a_tool_bar''s object id.
		require
			not_void: a_tool_bar /= Void
		local
			l_list: ARRAYED_LIST [INTEGER]
		do
			l_list := all_tool_bars_cell.item
			if l_list /= Void then
				l_list.prune_all (a_tool_bar.object_id)
			end
		ensure
			not_has: not all_tool_bars.has (a_tool_bar)
		end

	add_tool_bar_zone (a_tool_bar_zone: SD_TOOL_BAR_ZONE) is
			-- Add `a_tool_bar_zone''s object id.
		require
			not_void: a_tool_bar_zone /= Void
		local
			l_list: ARRAYED_LIST [INTEGER]
		do
			l_list := all_tool_bar_zones_cell.item
			if l_list = Void then
				create l_list.make (10)
				all_tool_bar_zones_cell.put (l_list)
			end
			l_list.extend (a_tool_bar_zone.object_id)
		ensure
			not_void: all_tool_bar_zones_cell.item /= Void
			has: all_tool_bar_zones.has (a_tool_bar_zone)
		end

	prune_tool_bar_zone (a_tool_bar_zone: SD_TOOL_BAR_ZONE) is
			-- Prune `a_tool_bar_zone''s id.
		require
			not_void: a_tool_bar_zone /= Void
		local
			l_list: ARRAYED_LIST [INTEGER]
		do
			l_list := all_tool_bar_zones_cell.item
			if l_list /= Void then
				l_list.prune_all (a_tool_bar_zone.object_id)
			end
		ensure
			not_has: not all_tool_bar_zones.has (a_tool_bar_zone)
		end

	add_title_bar (a_title_bar: SD_TITLE_BAR) is
			-- Add `a_title_bar''s object id.
		require
			not_void: a_title_bar /= Void
		local
			l_list: ARRAYED_LIST [INTEGER]
		do
			l_list := all_title_bars_cell.item
			if l_list = Void then
				create l_list.make (10)
				all_title_bars_cell.put (l_list)
			end
			l_list.extend (a_title_bar.object_id)
		ensure
			not_void: all_title_bars_cell.item /= Void
			has: all_title_bars.has (a_title_bar)
		end

	prune_title_bar (a_title_bar: SD_TITLE_BAR) is
			-- Prune `a_title_bar''s id.
		require
			not_void: a_title_bar /= Void
		local
			l_list: ARRAYED_LIST [INTEGER]
		do
			l_list := all_title_bars_cell.item
			if l_list /= Void then
				l_list.prune_all (a_title_bar.object_id)
			end
		ensure
			not_has: not all_title_bars.has (a_title_bar)
		end

	add_notebook (a_notebook: SD_NOTEBOOK) is
			-- Add `a_notebook'' object id.
		require
			not_void: a_notebook /= Void
		local
			l_list: ARRAYED_LIST [INTEGER]
		do
			l_list := all_notebooks_cell.item
			if l_list = Void then
				create l_list.make (10)
				all_notebooks_cell.put (l_list)
			end
			l_list.extend (a_notebook.object_id)
		ensure
			not_void: all_notebooks_cell.item /= Void
			has: all_notebooks.has (a_notebook)
		end

	prune_notebook (a_notebook: SD_NOTEBOOK) is
			-- Prune `a_notebook''s object id.
		require
			not_void: a_notebook /= Void
		local
			l_list: ARRAYED_LIST [INTEGER]
		do
			l_list := all_notebooks_cell.item
			if l_list /= Void then
				l_list.prune_all (a_notebook.object_id)
			end
		ensure
			not_has: not all_notebooks.has (a_notebook)
		end

	add_auto_hide_panel (a_auto_hide_panel: SD_AUTO_HIDE_PANEL) is
			-- Add `a_auto_hide_panel''s object id.
		require
			not_void: a_auto_hide_panel /= Void
		local
			l_list: ARRAYED_LIST [INTEGER]
		do
			l_list := all_auto_hide_panels_cell.item
			if l_list = Void then
				create l_list.make (10)
				all_auto_hide_panels_cell.put (l_list)
			end
			l_list.extend (a_auto_hide_panel.object_id)
		ensure
			not_void: all_auto_hide_panels_cell.item /= Void
			has: all_auto_hide_panels.has (a_auto_hide_panel)
		end

	prune_auto_hide_panel (a_auto_hide_panel: SD_AUTO_HIDE_PANEL) is
			-- Prune `a_auto_hide_panel''s object id.
		require
			not_void: a_auto_hide_panel /= Void
		local
			l_list: ARRAYED_LIST [INTEGER]
		do
			l_list := all_auto_hide_panels_cell.item
			if l_list /= Void then
				l_list.prune_all (a_auto_hide_panel.object_id)
			end
		ensure
			not_has: not all_auto_hide_panels.has (a_auto_hide_panel)
		end

feature {NONE} -- Implementation

	all_tool_bars_cell:	CELL [ARRAYED_LIST [INTEGER]] is
			-- Singleton cell for `all_tool_bars''s object id.
		once
			create Result
		end

	all_tool_bar_zones_cell: CELL [ARRAYED_LIST [INTEGER]] is
			-- Singleton cell for `all_tool_bar_zones''s object id.
		once
			create Result
		end

	all_title_bars_cell: CELL [ARRAYED_LIST [INTEGER]] is
			-- Signleton cell for `all_title_bars'' object id.
		once
			create Result
		end

	all_notebooks_cell: CELL [ARRAYED_LIST [INTEGER]] is
			-- Singleton cell for `all_notebooks''s object id.
		once
			create Result
		end

	all_auto_hide_panels_cell: CELL [ARRAYED_LIST [INTEGER]] is
			-- Singleton cell for `all_auto_hide_panels'' object id.
		once
			create Result
		end

indexing
	library:	"SmartDocking: Library of reusable components for Eiffel."
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
