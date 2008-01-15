indexing
	description: "[
						A EV_FIGURE_GROUP is an ARRAYED_LIST of EV_FIGURE.
						Since EV_FIGURE_GROUP is also an EV_FIGURE (composite pattern) you
						can rotate, scale and change the position of an EV_FIGURE_GROUP.
						All elements in the group are rotated around the center
						of the EV_FIGURE_GROUP. A EV_FIGURE can only be grouped
						in one group at the same time.

					]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_MODEL_GROUP

inherit
	EV_MODEL
		undefine
			point_count
		redefine
			rotate,
			default_create,
			recursive_transform,
			set_x,
			set_y,
			set_x_y,
			invalid_rectangle,
			update_rectangle,
			invalidate,
			validate,
			bounding_box
		end

	ARRAYED_LIST [EV_MODEL]
		rename
			make as list_make
		export
			{NONE} put_i_th
		undefine
			is_equal,
			copy
		redefine
			append,
			force_i_th,
			replace,
			insert,
			prune_all,
			wipe_out,
			remove,
			merge_left,
			merge_right,
			make_from_array,
			default_create,
			swap,
			has
		end

	EV_MODEL_SINGLE_POINTED
		undefine
			default_create
		end

create
	default_create,
	make_with_point,
	make_with_position

create {EV_MODEL_GROUP}
	make_filled

feature {NONE} -- Initialization

	default_create is
			-- Create an empty EV_MODEL_GROUP.
		do
			Precursor {EV_MODEL}
			create point_array.make (1)
			point_array.put (create {EV_COORDINATE}.make (0, 0), 0)

			list_make (initiale_size)
			create lookup_table.make (initiale_size)

			is_grouped := True
		ensure then
			is_grouped: is_grouped
			not_is_in_group: not is_in_group
		end

feature -- Access

	angle: DOUBLE is
			-- `Current' has to be rotated around (`x',`y') for -`angle'
			-- to be in upright position.
		do
			Result := current_angle
		ensure then
			Result_equal_current_angle: Result = current_angle
		end

	point_x: INTEGER is
			-- x position of `point'.
		do
			Result := point_array.item (0).x
		end

	point_y: INTEGER is
			-- y position of `point'.
		do
			Result := point_array.item (0).y
		end

	deep_elements: LIST [EV_MODEL] is
			-- All elements in `Current' and in its subgroups.
		local
			l_group: EV_MODEL_GROUP
			l_list: ARRAYED_LIST [EV_MODEL]
		do
			create l_list.make (0)
			from
				start
			until
				after
			loop
				l_group ?= item
				if l_group /= Void then
					l_list.append (l_group.deep_elements)
				end
				l_list.extend (item)
				forth
			end
		ensure
			Result_not_Void: Result /= Void
		end

feature -- Status report

	is_rotatable: BOOLEAN is
			-- Is this figure group rotatable?
		local
			l_area: like area
			i, nb: INTEGER
		do
			if is_grouped then
				Result := True
				l_area := area
				from
					i := 0
					nb := count - 1
				until
					i > nb or not Result
				loop
					Result := l_area.item (i).is_rotatable
					i := i + 1
				end
			else
				Result := True
			end
		end

	is_scalable: BOOLEAN is
			-- Is this figure group scalable?
		local
			l_area: like area
			i, nb: INTEGER
		do
			if is_grouped then
				Result := True
				l_area := area
				from
					i := 0
					nb := count - 1
				until
					i > nb or not Result
				loop
					Result := l_area.item (i).is_scalable
					i := i + 1
				end
			else
				Result := True
			end
		end

	is_transformable: BOOLEAN is
			-- Is this figure group transformable?
		local
			l_area: like area
			i, nb: INTEGER
		do
			if is_grouped then
				Result := True
				l_area := area
				from
					i := 0
					nb := count - 1
				until
					i > nb or not Result
				loop
					Result := l_area.item (i).is_transformable
					i := i + 1
				end
			else
				Result := True
			end
		end

	is_grouped: BOOLEAN
			-- Is grouped?

	has (v: like item): BOOLEAN is
			-- Does current include `v'?
			-- (based on v.id)
		do
			if v /= Void then
				Result := lookup_table.has (v.id)
			end
		end

	has_deep (figure: EV_MODEL): BOOLEAN is
			-- Does any item contains `figure'?
		local
			grp: EV_MODEL_GROUP
		do
			Result := False
			from
				start
			until
				after or Result
			loop
				grp ?= item
				if grp = Void then
					Result := figure = item
				elseif grp = figure then
					Result := True
				else
					Result := grp.has_deep (figure)
				end
				forth
			end
		end

	invalid_rectangle: EV_RECTANGLE is
			-- Rectangle that needs erasing.
			-- `Void' if no change is made.
		local
			f: EV_MODEL
			r: EV_RECTANGLE
			l_area: like area
			i, nb: INTEGER
		do
			from
				l_area := area
				i := 0
				nb := count - 1
			until
				i > nb
			loop
				f := l_area.item (i)
				r := f.invalid_rectangle
				if r /= Void then
					if Result = Void then
						Result := r
					else
						Result.merge (r)
					end
				end
				i := i + 1
			end
		end

	update_rectangle: EV_RECTANGLE is
			-- Rectangle that needs redrawing.
			-- `Void' if no change is made.
		local
			f: EV_MODEL
			r: EV_RECTANGLE
			l_area: like area
			i, nb: INTEGER
		do
			if is_grouped then
				from
					l_area := area
					i := 0
					nb := count - 1
				until
					i > nb
				loop
					f := l_area.item (i)
					r := f.update_rectangle
					if r /= Void then
						if Result = Void then
							Result := r
						else
							Result.merge (r)
						end
					end
					i := i + 1
				end
			else
				create Result
			end
		end

feature -- Element change

	set_x (a_x: INTEGER) is
			-- Set `x' to `an_x'.
		local
			a_delta_x: INTEGER
		do
			a_delta_x := a_x - x
			if a_delta_x /= 0 then
				projection_matrix.translate (a_delta_x, 0)
				recursive_transform (projection_matrix)
				if is_in_group and then group.is_center_valid then
					group.center_invalidate
				end
			end
			center.set_x (a_x)
			is_center_valid := True
		end

	set_y (a_y: INTEGER) is
			-- Set `y' to `an_y'.
		local
			a_delta_y: INTEGER
		do
			a_delta_y := a_y - y
			if a_delta_y /= 0 then
				projection_matrix.translate (0, a_delta_y)
				recursive_transform (projection_matrix)
				if is_in_group and then group.is_center_valid then
					group.center_invalidate
				end
			end
			center.set_y (a_y)
			is_center_valid := True
		end

	set_x_y (a_x, a_y: INTEGER) is
			-- Set `x' to `an_x'.
		local
			a_delta_x, a_delta_y: INTEGER
		do
			a_delta_x := a_x - x
			a_delta_y := a_y - y
			if a_delta_x /= 0 or a_delta_y /= 0 then
				projection_matrix.translate (a_delta_x, a_delta_y)
				recursive_transform (projection_matrix)
				if is_in_group and then group.is_center_valid then
					group.center_invalidate
				end
			end
			center.set (a_x, a_y)
			is_center_valid := True
		end

	set_point_position (a_x, a_y: INTEGER) is
			-- Set position of `point' to (`a_x', `a_y').
		local
			a_delta_x, a_delta_y: DOUBLE
			l_point: EV_COORDINATE
		do
			l_point := point_array.item (0)
			a_delta_x := a_x - l_point.x_precise
			a_delta_y := a_y - l_point.y_precise
			if a_delta_x /= 0 or a_delta_y /= 0 then
				projection_matrix.translate (a_delta_x, a_delta_y)
				recursive_transform (projection_matrix)
				center_invalidate
			end
		end

	ungroup is
			-- Ungroup all `figures'.
		require
			is_grouped: is_grouped
			not_is_in_group: not is_in_group
		do
			from
				start
			until
				after
			loop
				item.set_group (Void)
				forth
			end
			is_grouped := False
			current_angle := 0
			center_invalidate
		ensure
			is_ungrouped: not is_grouped
			none_is_in_a_group: not there_exists (agent {EV_MODEL}.is_in_group)
			center_is_invalid: not is_center_valid
		end

	regroup is
			-- Group the `figures' in the group.
		require
			not_is_grouped: not is_grouped
			not_is_in_group: not is_in_group
		do
			from
				start
			until
				after
			loop
				item.set_group (Current)
				forth
			end
			is_grouped := True
			center_invalidate
		ensure
			is_grouped: is_grouped
			all_grouped: for_all (agent {EV_MODEL}.is_in_group)
			center_is_invalid: not is_center_valid
		end

	send_backward (a_figure: EV_MODEL) is
			-- Send `a_figure' one layer backwards.
		require
			a_figure_in_figures: has (a_figure)
		do
			if first /= a_figure then
				start
				search (a_figure)
				swap (index - 1)
			end
			full_redraw
		ensure
			a_figure_in_group: a_figure.group = Current
			a_figure_in_current: has (a_figure)
		end

	bring_forward (a_figure: EV_MODEL) is
			-- Bring `a_figure' one layer forwards.
		require
			a_figure_in_figures: has (a_figure)
		do
			if last /= a_figure then
				start
				search (a_figure)
				swap (index + 1)
			end
			full_redraw
		ensure
			a_figure_in_group: a_figure.group = Current
			a_figure_in_current: has (a_figure)
		end

	send_to_back (a_figure: EV_MODEL) is
			-- Send `a_figure' to the bottom most layer.
		require
			a_figure_in_figures: has (a_figure)
		do
			if first /= a_figure then
				start
				search (a_figure)
				remove
				put_front (a_figure)
			end
			full_redraw
		ensure
			is_at_front: first = a_figure
			a_figure_in_group: a_figure.group = Current
			a_figure_in_current: has (a_figure)
		end

	bring_to_front (a_figure: EV_MODEL) is
			-- Bring `a_figure' to the top most layer
		require
			a_figure_in_figures: has (a_figure)
		do
			if last /= a_figure then
				start
				search (a_figure)
				remove
				extend (a_figure)
			end
			full_redraw
		ensure
			is_last: last = a_figure
			a_figure_in_group: a_figure.group = Current
			a_figure_in_current: has (a_figure)
		end

	rotate (an_angle: DOUBLE) is
			-- Rotate around the center for `an_angle'.
		do
			current_angle := current_angle + an_angle
			Precursor {EV_MODEL} (an_angle)
		ensure then
			angle_equal_an_angle: angle = old angle + an_angle
		end

feature -- List change

	insert (fig: like item; i: INTEGER) is
			-- Add `fig' to the group.
		do
			Precursor {ARRAYED_LIST} (fig, i)
			fig.set_group (Current)
			lookup_table.put (fig, fig.id)
			center_invalidate
			invalidate
			full_redraw
		ensure then
			fig_in_lookup_table: fig /= Void implies lookup_table.has (fig.id)
			fig_in_group: fig /= Void implies fig.group = Current
		end

	force_i_th (fig: like item; i: INTEGER) is
			-- Add `fig' to the group.
		do
			Precursor {ARRAYED_LIST} (fig, i)
			if fig /= Void then
				fig.set_group (Current)
				lookup_table.put (fig, fig.id)
			end
			center_invalidate
			invalidate
			full_redraw
		ensure then
			fig_in_lookup_table: fig /= Void implies lookup_table.has (fig.id)
			fig_in_group: fig /= Void implies fig.group = Current
		end

	replace (fig: like item) is
			-- Replace current item by `fig'.
		do
			item.unreference_group
			lookup_table.remove (item.id)
			Precursor {ARRAYED_LIST} (fig)

			if fig /= Void then
				fig.set_group (Current)
				lookup_table.put (fig, fig.id)
			end
			center_invalidate
			invalidate
			full_redraw
		ensure then
			fig_in_lookup_table: fig /= Void implies lookup_table.has (fig.id)
			item_not_in_lookup_table: not lookup_table.has (old item.id)
			fig_in_group: fig /= Void implies fig.group = Current
			item_not_in_group: not (old item).is_in_group
		end

	remove is
			-- Remove `item' from figure.
		do
			item.unreference_group
			lookup_table.remove (item.id)
			Precursor {ARRAYED_LIST}
			center_invalidate
			invalidate
			full_redraw
		ensure then
			item_not_in_lookup_table: not lookup_table.has (old item.id)
			item_not_in_group: not (old item).is_in_group
		end

	prune_all (fig: like item) is
			-- Remove `fig' from the group.
		do
			if has (fig) then
				fig.unreference_group
				lookup_table.remove (fig.id)
			end
			Precursor {ARRAYED_LIST} (fig)
			center_invalidate
			invalidate
			full_redraw
		ensure then
			item_not_in_lookup_table: fig /= Void implies not lookup_table.has (fig.id)
		end

	merge_left (other: ARRAYED_LIST [EV_MODEL]) is
			-- Merge `other' into group before cursor.
			-- `other' will be empty afterwards.
		do
			insert_list_to_table (other)
			change_group (other)
			Precursor {ARRAYED_LIST} (other)
			center_invalidate
			invalidate
			full_redraw
		end

	merge_right (other: ARRAYED_LIST [EV_MODEL]) is
			-- Merge `other' into group after cursor.
			-- `other' will be empty afterwards.
		do
			insert_list_to_table (other)
			change_group (other)
			Precursor {ARRAYED_LIST} (other)
			center_invalidate
			invalidate
			full_redraw
		end

	wipe_out is
			-- Remove all items.
		do
			from start until after loop
				if item.is_in_group then
					item.unreference_group
				end
				forth
			end
			Precursor {ARRAYED_LIST}
			lookup_table.clear_all
			center_invalidate
			invalidate
			full_redraw
		end

	append (s: SEQUENCE [EV_MODEL]) is
			-- Append a copy of `s'.
		local
			l: like s
			l_cursor: CURSOR
		do
			if s = Current then
				l := s.twin
			else
				l := s
			end
			from
				resize (count + s.count)
				l_cursor := cursor
				l.start
			until
				l.exhausted
			loop
				extend (l.item)
				lookup_table.put (l.item, l.item.id)
				l.forth
			end
			go_to (l_cursor)
			center_invalidate
			invalidate
			full_redraw
		end

	make_from_array (a: ARRAY [EV_MODEL]) is
			-- Create list from array `a'.
		local
			i: INTEGER
		do
			wipe_out
			resize (a.count)
			from
				i := a.lower
			until
				i > a.upper
			loop
				if a.item (i) /= Void then
					extend (a.item (i))
				end
				i := i + 1
			end
			center_invalidate
			invalidate
			full_redraw
		end

	swap (i: INTEGER) is
			-- Exchange item at `i'-th position with item
			-- at cursor position.
		local
			old_item: like item
		do
			old_item := item
			Precursor {ARRAYED_LIST} (i)
			lookup_table.put (old_item, old_item.id)
			old_item.set_group (Current)
		ensure then
			item_in_lookup_table: lookup_table.has (old item.id)
			i_in_lookup_table: lookup_table.has (i_th (i).id)
			item_in_group: (old item).group = Current
			i_th_in_group: i_th (i).group = Current
		end

feature -- Status settings

	invalidate is
			-- Some property of `Current' has changed.
		local
			l_area: like area
			l_figure: EV_MODEL
			i, nb: INTEGER
		do
			if valid then
				Precursor {EV_MODEL}
				from
					l_area := area
					i := 0
					nb := count - 1
				until
					i > nb
				loop
					l_figure := l_area.item (i)
					if l_figure.valid then
						l_figure.invalidate
					end
					i := i + 1
				end
			else
				Precursor {EV_MODEL}
			end
		end

	validate is
			-- Validate `Current'.
		local
			l_area: like area
			i, nb: INTEGER
			l_figure: EV_MODEL
		do
			if not valid then
				if count = 0 then
					create internal_invalid_rectangle
				else
					l_area := area
					from
						i := 0
						nb := count - 1
					until
						i > nb
					loop
						l_figure := l_area.item (i)
						if not l_figure.valid then
							l_figure.validate
						end
						i := i + 1
					end
				end
				internal_invalid_rectangle := bounding_box
				valid := True
			end
		end

feature -- Events

	position_on_figure (a_x, a_y: INTEGER): BOOLEAN is
			-- Is the point on (`a_x', `a_y') on this figure?
			--| Used to generate events.
			-- Always returns `False', but descendants can override
			-- it to improve efficiency.
		do
			Result := False
		end

	bounding_box: EV_RECTANGLE is
			-- Smallest orthogonal rectangular area `Current' fits in.
		local
			l_area: like area
			i, nb: INTEGER
			l_bbox: like bounding_box
		do
			if internal_bounding_box /= Void then
				Result := internal_bounding_box.twin
			else
				if is_grouped then
					from
						l_area := area
						i := 0
						nb := count - 1
					until
						i > nb or else l_area.item (i).is_show_requested
					loop
						i := i + 1
					end
					if i <= nb then
						from
						until
							i > nb
						loop
							if l_area.item (i).is_show_requested then
								l_bbox := l_area.item (i).bounding_box
								if l_bbox.height > 0 or else l_bbox.width > 0 then
									if Result = Void then
										Result := l_bbox
									else
										Result.merge (l_bbox)
									end
								end
							end
							i := i + 1
						end
						if Result = Void then
							create Result
						end
					else
						create Result
					end
				else
					create Result
				end
				internal_bounding_box := Result.twin
			end
		end

feature {EV_MODEL_GROUP} -- Figure group

	recursive_transform (a_transformation: EV_MODEL_TRANSFORMATION) is
			-- Same as transform but without precondition
			-- is_transformable and without invalidating
			-- groups center
		local
			l_area: like area
			i, nb: INTEGER
		do
			a_transformation.project (point_array.item (0))
			if is_grouped then
				from
					i := 0
					nb := count - 1
					l_area := area
				until
					i > nb
				loop
					l_area.item (i).recursive_transform (a_transformation)
					i := i + 1
				end
			end
			invalidate
			is_center_valid := False
		end

feature {NONE} -- Implementation

	current_angle: DOUBLE
			-- The rotating angle.

	set_center is
			-- Set x and y such that they are in the
			-- center of the group.
		local
			l_bbox: like bounding_box
		do
			if is_grouped then
				l_bbox := bounding_box
				center.set_precise (l_bbox.left + l_bbox.width /2, l_bbox.top + l_bbox.height / 2)
			else
				center.set (0, 0)
			end
			is_center_valid := True
		end

	initiale_size: INTEGER is 10
			-- Initialize size of `Current'.

	change_group (other: ARRAYED_LIST [EV_MODEL]) is
			-- Change group of all figures in `other' to Current.
			-- Used by `merge_left' and `merge_right'.
		local
			n: INTEGER
		do
			from
				n := 1
			until
				n > other.count
			loop
				other.i_th (n).set_group (Current)
				n := n + 1
			end
		end

	full_redraw is
			-- Request `invalid_rectangle' to be ignored.
		local
			w: EV_MODEL_WORLD
		do
			w := world
			if w /= Void then
				w.full_redraw
			end
		end

	lookup_table: HASH_TABLE [EV_MODEL, INTEGER]
			-- Lookup table to search faster.

	insert_list_to_table (list: ARRAYED_LIST [EV_MODEL]) is
			-- Insert list element to lookup_table.
		do
			from
				list.start
			until
				list.after
			loop
				lookup_table.put (list.item, list.item.id)
				list.forth
			end
		end

invariant

	is_grouped_implies_all_grouped: is_grouped implies for_all (agent {EV_MODEL}.is_in_group)
	angle_equal_current_angle: angle = current_angle
	not_is_grouped_implies_angel_equals_zero: not is_grouped implies (angle = 0)

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




end -- class EV_MODEL_GROUP

