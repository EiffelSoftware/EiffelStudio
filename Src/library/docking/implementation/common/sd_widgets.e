indexing
	description: "Smart Docking library widget lists."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_WIDGETS

feature -- Query

	all_tool_bars: ARRAYED_LIST [SD_TOOL_BAR] is
			-- All SD_TOOL_BAR instances.
		do
			Result := all_tool_bars_cell.item
			if Result = Void then
				create Result.make (10)
				all_tool_bars_cell.put (Result)
			end
		ensure
			not_void: Result /= Void
		end

	all_tool_bar_zones: ARRAYED_LIST [SD_TOOL_BAR_ZONE] is
			-- All SD_TOOL_BAR_ZONE instances.
		do
			Result := all_tool_bar_zones_cell.item
			if Result = Void then
				create Result.make (10)
				all_tool_bar_zones_cell.put (Result)
			end
		ensure
			not_void: Result /= Void
		end

	all_title_bars: ARRAYED_LIST [SD_TITLE_BAR] is
			-- All SD_TITLE_BAR instances.
		do
			Result := all_title_bars_cell.item
			if Result = Void then
				create Result.make (10)
				all_title_bars_cell.put (Result)
			end
		ensure
			not_void: Result /= Void
		end

	all_notebooks: ARRAYED_LIST [SD_NOTEBOOK] is
			-- All SD_NOTEBOOK instances.
		do
			Result := all_notebooks_cell.item
			if Result = Void then
				create Result.make (10)
				all_notebooks_cell.put (Result)
			end
		ensure
			not_void: Result /= Void
		end

	all_auto_hide_panels: ARRAYED_LIST [SD_AUTO_HIDE_PANEL] is
			-- All SD_AUTO_HIDE_PANEL instances.
		do
			Result := all_auto_hide_panels_cell.item
			if Result = Void then
				create Result.make (10)
				all_auto_hide_panels_cell.put (Result)
			end
		ensure
			not_void: Result /= Void
		end

feature {NONE} -- Implementation

	all_tool_bars_cell:	CELL [ARRAYED_LIST [SD_TOOL_BAR]] is
			-- Singleton cell for `all_tool_bars'.
		once
			create Result
		end

	all_tool_bar_zones_cell: CELL [ARRAYED_LIST [SD_TOOL_BAR_ZONE]] is
			-- Singleton cell for `all_tool_bar_zones'.
		once
			create Result
		end

	all_title_bars_cell: CELL [ARRAYED_LIST [SD_TITLE_BAR]] is
			-- Signleton cell for `all_title_bars'.
		once
			create Result
		end

	all_notebooks_cell: CELL [ARRAYED_LIST [SD_NOTEBOOK]] is
			-- Singleton cell for `all_notebooks'.
		once
			create Result
		end

	all_auto_hide_panels_cell: CELL [ARRAYED_LIST [SD_AUTO_HIDE_PANEL]] is
			-- Singleton cell for `all_auto_hide_panels'.
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
