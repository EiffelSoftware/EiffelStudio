indexing
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

	default_create is
			-- Initialize `table'.
		do
			create table.make (20)
			vertical_spacing := {EB_CONTEXT_EDITOR}.default_bon_vertical_spacing
			horizontal_spacing := {EB_CONTEXT_EDITOR}.default_bon_horizontal_spacing
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

	set_spacing (horizontal, vertical: INTEGER) is
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

	row: ARRAYED_LIST [EG_LINKABLE_FIGURE] is
			-- To use `like row'.
		do
				-- Never called.
			check
				False
			end
		end

	layout_linkables (linkables: ARRAYED_LIST [EG_LINKABLE_FIGURE]; level: INTEGER; cluster: EG_CLUSTER_FIGURE) is
			-- arrange `linkables' that are elements of `clusters' at `level'.
		local
			bcf: EIFFEL_CLUSTER_FIGURE
			ew: EIFFEL_WORLD
		do
			ew := world
			vertical_scaled_spacing := (ew.scale_factor * vertical_spacing).truncated_to_integer
			horizontal_scaled_spacing := (ew.scale_factor * horizontal_spacing).truncated_to_integer

			table.wipe_out
			set_clusters_and_classes (linkables)
			if not has_cluster then
				arrange_by_generation
				arrange_clients
			else
				arrange_by_size
			end
			execute
			bcf ?= cluster
			if bcf /= Void then
				--Speeeeeeeeed Up
				ew.update
				bcf.set_to_minimum_size
			end
			if ew.is_right_angles then
				ew.apply_right_angles
			end
		end

	clusters: ARRAYED_LIST [EG_CLUSTER_FIGURE]
			-- Clusters in linkables currently layouted.

	classes: ARRAYED_LIST [EG_LINKABLE_FIGURE]
			-- Classes in linkables currently layouted.

	set_clusters_and_classes (linkables: ARRAYED_LIST [EG_LINKABLE_FIGURE]) is
			-- Build list `clusters' and `classes'.
		require
			linkables_not_void: linkables /= Void
		local
			i, nb: INTEGER
			cf: EG_CLUSTER_FIGURE
			l_item: EG_LINKABLE_FIGURE
		do
			create clusters.make (linkables.count)
			create classes.make (linkables.count)
			from
				i := 1
				nb := linkables.count
			until
				i > nb
			loop
				l_item := linkables.i_th (i)
				if l_item.is_show_requested then
					cf ?= l_item
					if cf /= Void then
						clusters.extend (cf)
					else
						classes.extend (l_item)
					end
				end
				i := i + 1
			end
		ensure
			clusters_not_void: clusters /= Void
			classes_not_void: classes /= Void
		end

	has_cluster: BOOLEAN is
			-- Is `clusters' not empty?
		require
			clusters_not_void: clusters /= Void
		do
			Result := not clusters.is_empty
		end

	has_classes: BOOLEAN is
			-- Is `classes' not empty?
		require
			classes_not_void: classes /= Void
		do
			Result := not classes.is_empty
		end

	arrange_by_size is
			-- Place figures such that space is
			-- not wasted in the diagram.
		local
			i, nb: INTEGER
		do
			arrange_by_generation
			arrange_clients

			from
				i := 1
				nb := clusters.count
			until
				i > nb
			loop
				add_linkable_figure (clusters.i_th (i))
				i := i + 1
			end
		end

	add_linkable_figure (lf: EG_LINKABLE_FIGURE) is
			-- Add `lf' in any row/column not caring about links.
		local
			r: like row
		do
			if height > width // 2 then
				r := smallest_row
			else
				create r.make (0)
				table.extend (r)
			end
			r.extend (lf)
		end

	height: INTEGER is
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

	row_height (r: like row): INTEGER is
			-- Height in pixels of `r'.
		do
			if r /= Void then
				from
					r.start
				until
					r.after
				loop
					if r.item /= Void then
						Result := Result.max (r.item.height)
					end
					r.forth
				end
			end
		end

	width: INTEGER is
			-- Horizontal dimension of widest row.
		local
			max_widths: ARRAYED_LIST [INTEGER]
			i: INTEGER
		do
			if has_classes then
				max_widths := max_x_widths
				from
					max_widths.start
				until
					max_widths.after
				loop
					Result := Result + max_widths.item + horizontal_scaled_spacing
					max_widths.forth
				end
			else
				from
					i := 1
				until
					i > table.count
				loop
					Result := Result.max (row_width (table.i_th (i)))
					i := i + 1
				end
				Result := Result + horizontal_scaled_spacing
			end
		end

	max_x_widths: ARRAYED_LIST [INTEGER] is
			-- Array of maximum bubles width to line them up vertically and horizontally.
			-- | Result is a list from 1 to max column count where each entry is the max width of this column.
		local
			r: like row
			size, max_width, index: INTEGER
			cf: EG_CLUSTER_FIGURE
			cur_item: EG_LINKABLE_FIGURE
		do
			from
				table.start
			until
				table.after
			loop
				if table.item /= Void and then table.item.count > size then
					size := table.item.count
				end
				table.forth
			end

			create Result.make (size)
			from
				index := 1
			until
				index > size
			loop
				max_width := 0
				from
					table.start
				until
					table.after
				loop
					r := table.item
					if r /= Void then
						if index <= r.count then
							cur_item := r.i_th (index)
							cf ?= cur_item
							if cur_item /= Void and then cf = Void and then cur_item.width > max_width then
								max_width := cur_item.width
							end
						end
					end
					table.forth
				end
				Result.extend (max_width)
				index := index + 1
			end
		end

	row_width (r: like row): INTEGER is
			-- Width in pixels of `r'.
		do
			if r /= Void then
				from
					r.start
				until
					r.after
				loop
					if r.item /= Void then
						Result := Result + r.item.width
					end
					r.forth
					if not r.after and then r.item /= Void then
						Result := Result + horizontal_scaled_spacing
					end
				end
			end
		end

	smallest_row: like row is
			-- Row with smallest width.
		local
			w: INTEGER
			r: like row
		do
			from table.start until table.after loop
				r := table.item
				if w = 0 then
					Result := r
					w := row_width (r)
				else
					if w > row_width (r) then
						Result := r
						w := row_width (r)
					end
				end
				table.forth
			end
		end

	arrange_by_generation is
			-- Place class bubbles so that descendants are always below
			-- their ancestors.
		local
			r: like row
		do
			from
				r := first_generation
			until
				r.is_empty
			loop
				remove_from_table (r)
				table.extend (r)
				r := next_generation (r)
			end
		end

	first_generation: like row is
			-- Classes in `figure_set' that have no ancestors
			-- in same cluster but descendants in same cluster.
		local
			l_classes: like classes
			l_item: EG_LINKABLE_FIGURE
		do
			l_classes := classes
			create Result.make (0)
			from
				l_classes.start
			until
				l_classes.after
			loop
				l_item := l_classes.item
				if
					not has_ancestor_in_same_cluster (l_item) and then
					has_descendant_in_same_cluster (l_item)
				then
					Result.extend (l_item)
				end
				l_classes.forth
			end
		end

	next_generation (r: like row): like row is
			-- Direct descendants of `r' in same cluster.
		local
			l_links: ARRAYED_LIST [EG_LINK_FIGURE]
			bil: EIFFEL_INHERITANCE_FIGURE
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
					bil ?= l_links.i_th (i)
					if bil /= Void then
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

	has_ancestor_in_same_cluster (linkable: EG_LINKABLE_FIGURE): BOOLEAN is
			-- Does `linkable' have an ancestor in the same cluster?
		require
			linkable_not_void: linkable /= Void
		local
			bil: EIFFEL_INHERITANCE_FIGURE
			l_links: ARRAYED_LIST [EG_LINK_FIGURE]
			i, nb: INTEGER
		do
			Result := False
			from
				l_links := linkable.links
				i := 1
				nb := l_links.count
			until
				Result or else i > nb
			loop
				bil ?= l_links.i_th (i)
				if bil /= Void then
					if bil.ancestor /= linkable and then bil.ancestor.cluster = linkable.cluster then
						Result := True
					end
				end
				i := i + 1
			end
		end

	has_descendant_in_same_cluster (linkable: EG_LINKABLE_FIGURE): BOOLEAN is
			-- Does `linkable' have an descendant in the same cluster?
		require
			linkable_not_void: linkable /= Void
		local
			bil: EIFFEL_INHERITANCE_FIGURE
			l_links: ARRAYED_LIST [EG_LINK_FIGURE]
			i, nb: INTEGER
		do
			Result := False
			from
				l_links := linkable.links
				i := 1
				nb := l_links.count
			until
				Result or else i > nb
			loop
				bil ?= l_links.i_th (i)
				if bil /= Void then
					if bil.descendant /= linkable and then bil.descendant.cluster = linkable.cluster then
						Result := True
					end
				end
				i := i + 1
			end
		end

	remove_from_table (r: like row) is
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
					tr.prune_all (r.i_th (i))
					i := i + 1
				end
				table.forth
			end
		end

	arrange_clients is
			-- Place class bubbles that are linked to diagram classes
			-- only by client/supplier links.
		local
			l: like classes
		do
			l := classes
			from
				l.start
			until
				l.after
			loop
				if not has (l.item) then
					add_linkable_figure (l.item)
				end
				l.forth
			end
		end

	has (lf: EG_LINKABLE_FIGURE): BOOLEAN is
			-- Does `table' contain `lf'?
		require
			lf_not_void: lf /= Void
		local
			r: like row
		do
			from
				table.start
			until
				Result or table.after
			loop
				r := table.item
				Result := r.has (lf)
				table.forth
			end
		end

	execute is
			-- Perform the actual placement.
		local
			cur_x, cur_y: INTEGER
			l_row_height, max_width: INTEGER
			r: like row
		do
			max_width := 0
			from
				table.start
			until
				table.after
			loop
				max_width := max_width.max (row_width (table.item))
				table.forth
			end
			cur_y := vertical_scaled_spacing
			from
				table.start
			until
				table.after
			loop
				r := table.item
				if r /= Void then
					cur_x := max_width // 2 - row_width (r) // 2 + horizontal_scaled_spacing
					l_row_height := row_height (r)
					cur_y := cur_y + l_row_height // 2

					from
						r.start
					until
						r.after
					loop
						r.item.set_port_position (cur_x + r.item.width // 2, cur_y)
						cur_x := cur_x + r.item.width + horizontal_scaled_spacing

						r.forth
					end
					cur_y := cur_y + l_row_height // 2 + vertical_scaled_spacing
				end
				table.forth
			end
		end

	center_rows is
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

	largest_row_width: INTEGER is
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

end -- class EIFFEL_INHERITANCE_LAYOUT
