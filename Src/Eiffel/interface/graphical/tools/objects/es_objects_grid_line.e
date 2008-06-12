indexing
	description: "Objects that represent the data of a objects grid row."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_OBJECTS_GRID_LINE

inherit

	ES_GRID_ROW_CONTROLLER

	EB_CONSTANTS
		export
			{NONE} all
		undefine
			is_equal, copy, default_create
		end

	EB_VISION2_FACILITIES
		undefine
			default_create, copy, is_equal
		end

	REFACTORING_HELPER
		undefine
			default_create, copy, is_equal
		end

	DEBUG_OUTPUT
		undefine
			default_create, copy, is_equal
		end

	EB_SHARED_DEBUGGER_MANAGER
		undefine
			default_create, copy, is_equal
		end

	EB_PIXMAPABLE_ITEM_PIXMAP_FACTORY
		export
			{NONE} all
		undefine
			default_create, copy, is_equal
		end

	DEBUGGER_EXPORTER
		export
			{NONE} all
		undefine
			default_create, copy, is_equal
		end


feature {NONE} -- Initialization

	make is
			-- Make Current object
		do
			default_create
			create compute_grid_row_completed_action
		end

	make_with_grid (g: like parent_grid) is
			-- Make current object related to grid `g'
		do
			make
			parent_grid := g
		end

feature -- Debug output

	debug_output: STRING is
		deferred
		end

feature -- Recycling

	reset is
			-- Recycle data
			-- in order to free special data (for instance dotnet references)
		do
			if is_attached_to_row then
				unattach
			end
		end

feature {ES_OBJECTS_GRID, ES_OBJECTS_GRID_MANAGER} -- Grid and row attachement

	relocate_to_parent_grid (a_parent_grid: like parent_grid) is
			-- relocate current line to `a_parent_grid'.
		require
			is_not_attached_to_row: not is_attached_to_row
		do
			parent_grid := a_parent_grid
		end

	attach_to_row (a_row: EV_GRID_ROW) is
		require
			row_not_void: a_row /= Void
			row_parented: a_row.parent /= Void
			row_is_objects_grid_row: {ES_OBJECTS_GRID_ROW} #? a_row = a_row
			is_not_attached_to_row: not is_attached_to_row
		do
			row ?= a_row
			check row /= Void end
			parent_grid := row.parent_objects_grid
			check parent_grid = row.parent end
			row.set_data (Current)
			if row.parent /= Void then
				row.clear
				row.set_background_color (Void)
			end
			compute_grid_display_done := False
		ensure
			attached_to_row: row /= Void
		end

	safe_unattach is
		do
			if is_attached_to_row then
				unattach
			end
		end

	unattach is
		require
			is_attached_to_row: is_attached_to_row
		do
			if row.parent /= Void then
				check row.parent = parent_grid end
				grid_remove_and_clear_subrows_from (row)
				row.clear
			end
			row.set_data (Void)
			compute_grid_row_completed_action.wipe_out
			reset_row_actions
			row := Void
			compute_grid_display_done := False
		ensure
			is_not_attached_to_row: not is_attached_to_row
		end

	refresh is
		require
			is_attached_to_row: is_attached_to_row
		do
			if row.parent /= Void then
				grid_remove_and_clear_subrows_from (row)
				row.ensure_non_expandable
				row.clear
				row.set_background_color (Void)
			end

			set_expand_action (Void)
			set_collapse_action (Void)

			compute_grid_display_done := False
			compute_grid_display
		ensure
			is_attached_to_row: is_attached_to_row
		end

feature -- Status

	is_attached_to_row: BOOLEAN is
		do
			Result := row /= Void
		end

feature -- Properties

	row: ES_OBJECTS_GRID_ROW

	parent_grid: ES_OBJECTS_GRID

	is_read_only: BOOLEAN

feature -- Change

	set_read_only (b: like is_read_only) is
			-- set `is_read_only'
		do
			is_read_only := b
		end

feature -- Query

	text_data_for_clipboard: STRING_32 is
		deferred
		end

feature -- Record layout

	record_layout is
		do
			-- do nothing for now
		end

feature -- Graphical computation

	compute_grid_display_done: BOOLEAN
			-- is `compute_grid_display' called and done ?

	reset_compute_grid_display_done is
			-- Reset value of `compute_grid_display_done'
		do
			compute_grid_display_done := False
		end

	computed_grid_item (c: INTEGER): EV_GRID_ITEM is
		require
			is_attached_to_row: is_attached_to_row
		do
			if
				not compute_grid_display_done
				and then debugger_manager.safe_application_is_stopped
			then
				compute_grid_row
			end
			if row /= Void and then c <= row.count then
				Result := row.item (c)
				if Result = Void then
					create Result
				end
			end
		ensure
			result_not_void_if_stopped: (row /= Void and debugger_manager.safe_application_is_stopped ) implies Result /= Void
		end

	compute_grid_row is
		require
			is_attached_to_row: is_attached_to_row
		do
			compute_grid_display
			compute_grid_row_completed_action.call (Void) -- call ([Current])				
		end

	compute_grid_display is
			-- Compute the grid display related to current Line
		require
			is_attached_to_row: is_attached_to_row
			row_parented: row /= Void and then row.parent /= Void
			not_computed: not compute_grid_display_done
		deferred
		end

feature -- Actions

	compute_grid_row_completed_action: EV_NOTIFY_ACTION_SEQUENCE -- [TUPLE [ES_OBJECTS_GRID_LINE]]
			-- Actions to be trigger when the row is computation is completed.

feature -- Updating

	update is
		deferred
		end

feature {NONE} -- Implementation

	folder_label_item (s: STRING_GENERAL): EV_GRID_LABEL_ITEM is
		require
			parent_grid_not_void: parent_grid /= Void
		do
			Result := parent_grid.folder_label_item (s)
		end

	cell (c: INTEGER): EV_GRID_ITEM is
		require
			row_not_void: row /= Void
		do
			if c > 0 and c <= row.count then
				Result := row.item (c)
			end
		end

	set_cell (c: INTEGER; v: EV_GRID_ITEM) is
		require
			row_not_void: row /= Void
		do
			row.set_item (c, v)
		end

invariant
	parent_grid_not_void_if_row_not_void: row /= Void implies parent_grid /= Void
	parent_grid_related_to_attached_row: (row /= Void and then row.parent /= Void) implies parent_grid = row.parent

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

end
