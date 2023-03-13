note
	description: "Placement of class bubbles in a EIFFEL_WORLD."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_INHERITANCE_LAYOUT

inherit
	EG_LAYOUT
		redefine
			default_create,
			world
		end

create
	make_with_world

feature {NONE} -- Initialization

	default_create
			-- Initialize `table'.
		do
			create table.make (20)
			vertical_spacing := {ES_DIAGRAM_TOOL_PANEL}.default_bon_vertical_spacing
			horizontal_spacing := {ES_DIAGRAM_TOOL_PANEL}.default_bon_horizontal_spacing
		end

feature -- Access

	table: ARRAYED_LIST [like row]
			-- List of rows of class bubbles.

	vertical_spacing: INTEGER
			-- Vertical space between class figures.

	horizontal_spacing: INTEGER
			-- Horizontal space between class figures.

	world: EIFFEL_WORLD

feature -- Element change

	set_spacing (horizontal, vertical: INTEGER)
			-- Set `horizontal_spacing' to `horizontal' and `vertical_spacing' to `vertical'.
		do
			horizontal_spacing := horizontal
			vertical_spacing := vertical
		ensure
			spacings_set: horizontal_spacing = horizontal and vertical_spacing = vertical
		end

feature {NONE} -- Implementation

	vertical_scaled_spacing: INTEGER
	horizontal_scaled_spacing: INTEGER

	row: ARRAYED_LIST [EG_LINKABLE_FIGURE]
			-- To use `like row'.
		do
				-- Never called.
			check
				False
			end
		end

	layout_linkables (linkables: ARRAYED_LIST [EG_LINKABLE_FIGURE]; level: INTEGER; cluster: EG_CLUSTER_FIGURE)
			-- arrange `linkables' that are elements of `clusters' at `level'.
		local
			ew: EIFFEL_WORLD
			l_max_row_width: INTEGER
			l_generation_levels: INTEGER
			l_clusters: ARRAYED_LIST [EG_CLUSTER_FIGURE]
			l_classes: ARRAYED_LIST [EG_LINKABLE_FIGURE]
		do
			ew := world
			vertical_scaled_spacing := (ew.scale_factor * vertical_spacing).rounded
			horizontal_scaled_spacing := (ew.scale_factor * horizontal_spacing).rounded

			table.wipe_out
			create l_clusters.make (linkables.count)
			create l_classes.make (linkables.count)
			set_clusters_and_classes (linkables, l_clusters, l_classes)


			if l_classes.count > 0 then
				arrange_by_generation (l_classes)
				l_generation_levels := generation_levels
				generation_levels := 0
				arrange_clients (l_classes)
			end

			if l_clusters.count > 0 then
				arrange_clusters (l_clusters)
			end
			l_max_row_width := maximum_linear_row_width.min (maximum_row_line_width)
			execute (level, l_generation_levels, l_max_row_width)
			if attached {EIFFEL_CLUSTER_FIGURE} cluster as bcf then
				--Speeeeeeeeed Up
				ew.update
				bcf.set_to_minimum_size
			end
			if ew.is_right_angles then
				ew.apply_right_angles
			end
		end

	set_clusters_and_classes (linkables: ARRAYED_LIST [EG_LINKABLE_FIGURE]; a_clusters: ARRAYED_LIST [EG_CLUSTER_FIGURE]; a_classes: ARRAYED_LIST [EG_LINKABLE_FIGURE])
			-- Build list `clusters' and `classes'.
		require
			linkables_not_void: linkables /= Void
			a_classes_not_void: a_classes /= Void
			a_clusters_not_void: a_clusters /= Void
		local
			i, nb: INTEGER
			l_item: EG_LINKABLE_FIGURE
		do
			from
				i := 1
				nb := linkables.count
			until
				i > nb
			loop
				l_item := linkables.i_th (i)
				if l_item.is_show_requested then
					if attached {EG_CLUSTER_FIGURE} l_item as cf then
						a_clusters.extend (cf)
					else
						a_classes.extend (l_item)
					end
				end
				i := i + 1
			end
		end

	arrange_clusters (a_clusters: ARRAYED_LIST [EG_CLUSTER_FIGURE])
			-- Arrange clusters in a row.
		require
			a_clusters_not_void: a_clusters /= Void
		local
			i, nb: INTEGER
			l_unlinked_row: like row
		do
			from
				i := 1
				nb := a_clusters.count
				create l_unlinked_row.make (a_clusters.count)
				table.extend (l_unlinked_row)
			until
				i > nb
			loop
				l_unlinked_row.extend (a_clusters [i])
				i := i + 1
			end
		end


	height: INTEGER
			-- Vertical dimension in pixels of current placement.
		local
			i: INTEGER
		do
			from
				i := 1
			until
				i > table.count
			loop
				Result := Result + row_height (table.i_th (i))
				i := i + 1
				if i <= table.count then
					Result := Result + vertical_scaled_spacing
				end
			end
		end

	row_height (r: like row): INTEGER
			-- Height in pixels of `r'.
		do
			if r /= Void then
				from
					r.start
				until
					r.after
				loop
					if r.item /= Void and then r.item.is_show_requested then
						Result := Result.max (r.item.height)
					end
					r.forth
				end
			end
		end

	maximum_linear_row_width: INTEGER
			-- Horizontal dimension of widest row.
		local
			i, nb: INTEGER
		do
			from
				i := 1
				nb := table.count
			until
				i > nb
			loop
				Result := Result.max (row_width (table [i]))
				i := i + 1
			end
		end

	row_width (r: like row): INTEGER
			-- Width in pixels of `r'.
		do
			if r /= Void then
				from
					r.start
				until
					r.after
				loop
					if r.item /= Void and then r.item.is_show_requested then
						Result := Result + r.item.width
					end
					r.forth
					if not r.after and then r.item /= Void and then r.item.is_show_requested then
						Result := Result + horizontal_scaled_spacing
					end
				end
			end
		end

	generation_levels: INTEGER
		-- Number of generation levels calculated by `arrange_by_generation'.

	arrange_by_generation (a_classes: ARRAYED_LIST [EG_LINKABLE_FIGURE])
			-- Place class bubbles so that descendants are always below
			-- their ancestors.
		local
			r: like row
		do
			from
				generation_levels := 0
				r := first_generation (a_classes)
			until
				r.is_empty
			loop
				generation_levels := generation_levels + 1
				remove_from_table (r)
				table.extend (r)
				r := next_generation (r)
			end
		end

	first_generation (a_classes: ARRAYED_LIST [EG_LINKABLE_FIGURE]) : like row
			-- Classes in `figure_set' that have no ancestors
			-- in same cluster but descendants in same cluster.
		do
			create Result.make (0)
			from
				a_classes.start
			until
				a_classes.after
			loop
				if has_descendant_but_no_ancestor_in_same_cluster (a_classes.item) then
					Result.extend (a_classes.item)
				end
				a_classes.forth
			end
		end

	has_descendant_but_no_ancestor_in_same_cluster (linkable: EG_LINKABLE_FIGURE): BOOLEAN
			-- Does `linkable' have an descendant but no ancestor in the same cluster?
			-- Used for first generation computation.
		require
			linkable_not_void: linkable /= Void
		local
			l_links: ARRAYED_LIST [EG_LINK_FIGURE]
			i, nb: INTEGER
			l_has_ancestor, l_has_descendent: BOOLEAN
		do
			from
				l_links := linkable.links
				i := 1
				nb := l_links.count
			until
				l_has_ancestor or else i > nb
			loop
				if attached {EIFFEL_INHERITANCE_FIGURE} l_links [i] as bil then
					if not l_has_descendent and then bil.descendant /= linkable and then bil.descendant.cluster = linkable.cluster then
						l_has_descendent := True
					end
					l_has_ancestor := bil.ancestor /= linkable and then bil.ancestor.cluster = linkable.cluster
						-- If we have an ancestor then we can break out of the loop.
				end
				i := i + 1
			end
			Result := l_has_descendent and then not l_has_ancestor
		end

	next_generation (r: like row): like row
			-- Direct descendants of `r' in same cluster.
		local
			l_links: ARRAYED_LIST [EG_LINK_FIGURE]
			i, nb: INTEGER
			l_item, descendant: EG_LINKABLE_FIGURE
		do
			create Result.make (0)
			from
				r.start
			until
				r.after
			loop
				l_item := r.item
				l_links := l_item.links
				from
					i := 1
					nb := l_links.count
				until
					i > nb
				loop
					if attached {EIFFEL_INHERITANCE_FIGURE} l_links [i] as bil then
						descendant := bil.descendant
						if
							descendant.is_show_requested and then
							descendant /= l_item and then
							descendant.cluster = l_item.cluster and then
							not Result.has (descendant)
						then
							Result.extend (descendant)
						end
					end
					i := i + 1
				end
				r.forth
			end
		end

	remove_from_table (r: like row)
			-- Remove any class in `r' if present from `table'.
		local
			tr: like row
			i : INTEGER
		do
			from
				table.start
			until
				table.after
			loop
				tr := table.item
				from i := 1 until i > r.count loop
					tr.prune_all (r [i])
					i := i + 1
				end
				table.forth
			end
		end

	arrange_clients (a_classes: ARRAYED_LIST [EG_LINKABLE_FIGURE])
			-- Place class bubbles that are linked to diagram classes
			-- only by client/supplier links.
		local
			i, nb: INTEGER
			l_unlinked_row: like row
		do
			from
				i := 1
				nb := a_classes.count
			until
				i > nb
			loop
				if not has (a_classes [i]) then
					if l_unlinked_row = Void then
						create l_unlinked_row.make (1)
						table.extend (l_unlinked_row)
					end
					l_unlinked_row.extend (a_classes [i])
				end
				i := i + 1
			end
		end

	has (lf: EG_LINKABLE_FIGURE): BOOLEAN
			-- Does `table' contain `lf'?
		require
			lf_not_void: lf /= Void
		local
			i, nb: INTEGER
			l_table: like table
		do
			from
				l_table := table
				i := 1
				nb := l_table.count
			until
				Result or i > nb
			loop
				Result := l_table [i] /= Void and then l_table [i].has (lf)
				i := i + 1
			end
		end

	execute (level, a_generation_levels, a_max_width: INTEGER)
			-- Perform the actual placement.
		local
			cur_x, cur_y: INTEGER
			l_row_max_height, l_remaining_row_width, l_row_item_index, l_row_item_count, i, l_count: INTEGER
			r: like row
			l_is_grid_enabled: BOOLEAN
			l_original_x: INTEGER
		do
			l_is_grid_enabled := world.grid_enabled
			l_count := table.count
			from
				i := 1
			until
				i > l_count
			loop
				r := table [i]
				if r /= Void then
					l_remaining_row_width := row_width (r)
					if i <= a_generation_levels then
							-- We only want to center generation level classes.
						l_original_x := (a_max_width // 2) - (l_remaining_row_width.min (a_max_width) // 2) + horizontal_scaled_spacing
					else
						l_original_x := horizontal_scaled_spacing
					end
					cur_x := l_original_x
					cur_y := cur_y + vertical_scaled_spacing

					from
						l_row_item_index := 1
						l_row_item_count := r.count
						l_row_max_height := 0
					until
						l_row_item_index > l_row_item_count
					loop
						if cur_x > maximum_row_line_width then
							if i <= a_generation_levels then
								cur_x := (a_max_width // 2) - (l_remaining_row_width.min (cur_x).min (a_max_width) // 2)
							else
								cur_x := l_original_x
							end
							cur_y := cur_y + l_row_max_height + vertical_scaled_spacing
							l_row_max_height := 0
						end
						if r [l_row_item_index].is_show_requested then
							r [l_row_item_index].set_point_position (cur_x, cur_y)
							cur_x := cur_x + r [l_row_item_index].width + horizontal_scaled_spacing
							l_remaining_row_width := l_remaining_row_width - r [l_row_item_index].width - horizontal_scaled_spacing
							l_row_max_height := r [l_row_item_index].height.max (l_row_max_height)
						end
						l_row_item_index := l_row_item_index + 1
					end
					cur_y := cur_y + l_row_max_height
				end
				i := i + 1
			end
		end

	maximum_row_line_width: INTEGER = 5000
		-- Maximum width for a generated row line
		-- Subsequent classes will be placed on the next row.

	center_rows
			-- Add void elements in `table' in order to center rows.
			-- Applies only for class views.
		local
			lgw, class_offset, i: INTEGER
			r: like row
		do
			lgw := largest_row_width
			from
				table.start
			until
				table.after
			loop
				r := table.item
				class_offset := (lgw - r.count) // 2
				from
					i := 1
				until
					i > class_offset
				loop
					r.put_front (Void)
					i := i + 1
				end
				table.forth
			end
		end

	largest_row_width: INTEGER
			-- Number of figures in largest row of `table'.
		do
			from
				table.start
				Result := 0
			until
				table.after
			loop
				Result := Result.max (table.item.count)
				table.forth
			end
		end

note
	copyright:	"Copyright (c) 1984-2023, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class EIFFEL_INHERITANCE_LAYOUT
