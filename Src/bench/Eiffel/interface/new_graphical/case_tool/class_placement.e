indexing
	description: "Placement of class bubbles in a CONTEXT_DIAGRAM."
	date: "$Date$"
	revision: "$Revision$"

class
	CLASS_PLACEMENT

inherit
	ANY
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create is
			-- Initialize `table'.
		do
			create table.make (20)
		end

feature -- Element change

	arrange_all (lfg: LINKABLE_FIGURE_GROUP) is
			-- Arrange the class bubbles and cluster figures in `lfg'.
			-- Performs a sequence of actions that should
			-- give nice for result for non-degenerate cases.
		require
			lfg_not_void: lfg /= Void
		do
			table.wipe_out
			figure_set := lfg
			if lfg.cluster_figures.is_empty then
				arrange_by_generation
				arrange_clients
			else
				arrange_by_size
			end
			execute
		ensure
			all_figures_inserted: has_all_classes (lfg.class_figures) and 
				has_all_clusters (lfg.cluster_figures)
		end

	arrange_clusters (lfg: LINKABLE_FIGURE_GROUP) is
			-- Arrange cluster figures of `lfg',
			-- without resizing them.
		require
			lfg_not_void: lfg /= Void
		do
			table.wipe_out
			figure_set := lfg
			arrange_clusters_by_size
			execute
		end

feature -- Access

	table: ARRAYED_LIST [like row]
			-- List of rows of class bubbles.

	row_count: INTEGER is
			-- Number of rows used.
		do
			from 
				table.start 
			until 
				table.after 
			loop
				if table.item /= Void then
					Result := Result + 1
				end
				table.forth
			end
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
					Result := Result + figure_set.vertical_spacing
				end
			end
		end

	width: INTEGER is
			-- Horizontal dimension of widest row.
		local
			max_widths: ARRAYED_LIST [INTEGER]
			i: INTEGER
		do
			if not figure_set.class_figures.is_empty then
				max_widths := max_x_widths
				from
					max_widths.start
				until
					max_widths.after
				loop
					Result := Result + max_widths.item + figure_set.horizontal_spacing
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
				Result := Result + figure_set.horizontal_spacing
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
						Result := Result + figure_set.horizontal_spacing
					end
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

feature -- Status report

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

	has (lf: LINKABLE_FIGURE): BOOLEAN is
			-- Does `table' contain `cf'?
		require
			lf_not_void: lf /= Void
		local
			r: LIST [LINKABLE_FIGURE]
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

feature -- Contract support

	has_all_classes (l: LINKED_LIST [CLASS_FIGURE]): BOOLEAN is
			-- Does `table' contain all class figures in `l'?
		local
			cf: CLASS_FIGURE
		do
			Result := True
			from l.start until not Result or l.after loop
				cf := l.item
				Result := has (cf)
				l.forth
			end
		end

	has_all_clusters (l: LINKED_LIST [CLUSTER_FIGURE]): BOOLEAN is
			-- Does `table' contain all cluster figures in `l'?
		local
			cf: CLUSTER_FIGURE
		do
			Result := True
			from l.start until not Result or l.after loop
				cf := l.item
				Result := has (cf)
				l.forth
			end
		end

	is_cluster_diagram: BOOLEAN is
			-- Does `Current' lay out a cluster view?
		local
			cld: CLUSTER_DIAGRAM
		do
			cld ?= table
			Result := cld /= Void
		end

feature {NONE} -- Implementation

	row: LINKED_LIST [LINKABLE_FIGURE] is
			-- To use `like row'.
		do
				-- Never called.
			check False end
		end

	figure_set: LINKABLE_FIGURE_GROUP
			-- The subject of placement.

	add_linkable_figure (lf: LINKABLE_FIGURE) is
			-- Add `lf' in any row/column not caring about links.
		local
			r: like row
		do
			if height > width // 2 then
				r := smallest_row
			else
				create r.make
				table.extend (r)
			end
			r.extend (lf)
		end

	first_generation: like row is
			-- Classes in `figure_set' that have no ancestors.
		local
			l: LINKED_LIST [CLASS_FIGURE]
			cf: CLASS_FIGURE
		do
			l := figure_set.class_figures
			create Result.make
			from
				l.start
			until
				l.after
			loop
				cf := l.item
				if cf.ancestor_figures_of_same_cluster.is_empty 
					and then not cf.descendant_figures_of_same_cluster.is_empty then 
					Result.extend (cf)
				end
				l.forth
			end
		end

	next_generation (r: like row): like row is
			-- Direct descendants of `r'.
		local
			df: LINKED_LIST [INHERITANCE_FIGURE]
			cf: CLASS_FIGURE
		do
			create Result.make
			from
				r.start
			until
				r.after
			loop
				cf ?= r.item
				if cf /= Void then
					df := cf.descendant_figures_of_same_cluster
					from df.start until df.after loop
						if not Result.has (df.item.descendant) then
							Result.extend (df.item.descendant)
						end
						df.forth
					end
					r.forth
				end
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

	arrange_clients is
			-- Place class bubbles that are linked to diagram classes
			-- only by client/supplier links.
		local
			l: LINKED_LIST [CLASS_FIGURE]
			clf: CLUSTER_FIGURE
		do
			l := figure_set.class_figures
			from
				l.start
			until
				l.after
			loop
				if not has (l.item) then
					clf ?= figure_set
					if clf /= Void and then
						clf.classes.has (l.item) then
						add_linkable_figure (l.item)
					elseif clf = Void then
						add_linkable_figure (l.item)
					end
				end
				l.forth
			end
		end

	arrange_by_size is
			-- Place linkable figures so that space is
			-- not wasted in the diagram.
		local
			clusters: LINKED_LIST [CLUSTER_FIGURE]			
			classes: LINKED_LIST [CLASS_FIGURE]
			cluster_layout: CLASS_PLACEMENT
			cursor: CURSOR
		do
			clusters := figure_set.cluster_figures
			classes := figure_set.class_figures
			from 
				clusters.start
			until	
				clusters.after
			loop
				create cluster_layout
				cursor := clusters.cursor
				cluster_layout.arrange_all (clusters.item)
				clusters.go_to (cursor)
				clusters.item.update_minimum_size
				clusters.go_to (cursor)
				add_linkable_figure (clusters.item)
				clusters.forth
			end
			from 
				classes.start
			until	
				classes.after
			loop
				add_linkable_figure (classes.item)
				classes.forth
			end
		end

	arrange_clusters_by_size is
			-- Place clusters so that space is
			-- not wasted in the diagram, without resizing them
			-- or moving their classes.
		local
			clusters: LINKED_LIST [CLUSTER_FIGURE]			
		do
			clusters := figure_set.cluster_figures
			from 
				clusters.start
			until	
				clusters.after
			loop
				add_linkable_figure (clusters.item)
				clusters.forth
			end
		end

	refresh is
			-- Update the links between classes.
		local
			l: LINKED_LIST [CLASS_FIGURE]
		do
			l := figure_set.class_figures
			from
				l.start
			until
				l.after
			loop
				l.item.update
				l.forth
			end
		end

	max_x_widths: ARRAYED_LIST [INTEGER] is
			-- Array of maximum bubles width to line them up vertically and horizontally.
		local
			r: like row
			size, max_width, index: INTEGER
			cur_item: CLASS_FIGURE
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
							cur_item ?= r.i_th (index)
							if cur_item /= Void and then cur_item.width > max_width then
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

	largest_row_width: INTEGER is
			-- Number of figures in largest row of `table'.
		do
			from
				table.start
				Result := 0
			until
				table.after
			loop
				if (table.item.count > Result) then
					Result := table.item.count
				end
				table.forth
			end
		end
	
	center_rows is
			-- Add void elements in `table' in order to center rows.
			-- Applies only for class views.
		require
			not is_cluster_diagram
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
				class_offset := (lgw - r.count) // 2 + 1
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
	
	execute is
			-- Perform the actual placement.
		local
			cur_x_class, cur_y_class, cur_x_cluster, cur_y_cluster: INTEGER
			index, cur_max_width: INTEGER
			r: like row
			clf: CLUSTER_FIGURE
			max_widths: ARRAYED_LIST [INTEGER]
			cd: CONTEXT_DIAGRAM
			cld: CLUSTER_DIAGRAM
		do
			cd ?= figure_set
			cld ?= figure_set
			cur_y_class := figure_set.vertical_spacing
			if cd /= Void then
				cur_y_class := cur_y_class * 2
			end
			cur_y_cluster := cur_y_class

			if cld = Void then
				center_rows
			end
			max_widths := max_x_widths
			from
				table.start
			until
				table.after
			loop
				r := table.item
				if r /= Void then
					cur_x_class := figure_set.horizontal_spacing * 2
					if cd /= Void then
						cur_x_class := cur_x_class * 2
					end
					cur_x_cluster := cur_x_class
					cur_y_class := cur_y_class + row_height (r) // 2
					from
						r.start
						index := 1
					until
						r.after
					loop
						cur_max_width := max_widths.i_th (index)
						if r.item /= Void then
							if cur_max_width > 0 then
								cur_x_class := cur_x_class + cur_max_width.max (r.item.width) // 2
							else
								cur_x_class := cur_x_class + r.item.width // 2
							end
							clf ?= r.item
							if clf /= Void then
								r.item.point.set_position (cur_x_cluster, cur_y_cluster)
								r.item.snap_to_default_grid
								r.item.update
							else
								r.item.point.set_position (cur_x_class, cur_y_class)
								r.item.snap_to_default_grid
								r.item.update
							end
							if cur_max_width > 0 then
								cur_x_class := cur_x_class + cur_max_width.max (r.item.width) // 2 + figure_set.horizontal_spacing
							else
								cur_x_class := cur_x_class + r.item.width // 2 + figure_set.horizontal_spacing
							end
							cur_x_cluster := cur_x_cluster + r.item.width + figure_set.horizontal_spacing
						else
							cur_x_class := cur_x_class + cur_max_width.max (0) + figure_set.horizontal_spacing
						end
						r.forth
						index := index + 1
					end
					cur_y_class := cur_y_class + row_height (r) // 2 + figure_set.vertical_spacing
					cur_y_cluster := cur_y_cluster + row_height (r) + figure_set.vertical_spacing
				end
				table.forth
			end
		end

end -- class CLASS_PLACEMENT
