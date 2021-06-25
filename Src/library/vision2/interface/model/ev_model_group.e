note
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
			create_interface_objects,
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
			force,
			extend,
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
			has,
			make_filled,
			list_make
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
	list_make,
	make_filled

feature {NONE} -- Initialization

	create_interface_objects
			-- <Precursor>
		do
			create lookup_table.make (initiale_size)
			create point_array.make_empty (1)
			make_empty_area (initiale_size)
			Precursor {EV_MODEL}
		end

	default_create
			-- Create an empty EV_MODEL_GROUP.
		do
			Precursor {EV_MODEL}
			point_array.extend (create {EV_COORDINATE}.make (0, 0))
			index := 0
			is_grouped := True
		ensure then
			is_grouped: is_grouped
			not_is_in_group: not is_in_group
		end

	make_filled (n: INTEGER_32)
			-- <Precursor>
		do
			default_create
			Precursor {ARRAYED_LIST} (n)
		end

	list_make (n: INTEGER)
			-- <Precursor>
		do
			default_create
			Precursor {ARRAYED_LIST} (n)
		end

feature -- Access

	angle: DOUBLE
			-- `Current' has to be rotated around (`x',`y') for -`angle'
			-- to be in upright position.
		do
			Result := current_angle
		ensure then
			Result_equal_current_angle: Result = current_angle
		end

	point_x: INTEGER
			-- x position of `point'.
		do
			Result := point_array.item (0).x
		end

	point_y: INTEGER
			-- y position of `point'.
		do
			Result := point_array.item (0).y
		end

	deep_elements: LIST [EV_MODEL]
			-- All elements in `Current' and in its subgroups.
		local
			l_group: detachable EV_MODEL_GROUP
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
			Result := l_list
		ensure
			Result_not_Void: Result /= Void
		end

feature -- Status report

	is_rotatable: BOOLEAN
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

	is_scalable: BOOLEAN
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

	is_transformable: BOOLEAN
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

	has (v: like item): BOOLEAN
			-- Does current include `v'?
			-- (based on v.id)
		do
			if v /= Void then
				Result := lookup_table.has (v.id)
			end
		end

	has_deep (figure: EV_MODEL): BOOLEAN
			-- Does any item contains `figure'?
		local
			grp: detachable EV_MODEL_GROUP
		do
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

	invalid_rectangle: detachable EV_RECTANGLE
			-- Rectangle that needs erasing.
			-- `Void' if no change is made.
		local
			r: detachable EV_RECTANGLE
			l_area: like area
			i, nb: INTEGER
		do
			if not valid then
				from
					l_area := area
					i := 0
					nb := count - 1
				until
					i > nb
				loop
					r := l_area [i].invalid_rectangle
					if r /= Void and then r.has_area and then l_area [i].is_show_requested then
						if Result = Void then
							if internal_invalid_rectangle = Void then
								create internal_invalid_rectangle
							end
							Result := internal_invalid_rectangle
							Result.copy (r)
						else
							Result.merge (r)
						end
					end
					i := i + 1
				end
			end
		end

	update_rectangle: detachable EV_RECTANGLE
			-- Rectangle that needs redrawing.
			-- `Void' if no change is made.
		local
			r: detachable EV_RECTANGLE
			l_area: like area
			i, nb: INTEGER
		do
			if not valid and then is_show_requested and then is_grouped then
				from
					l_area := area
					i := 0
					nb := count - 1
				until
					i > nb
				loop
					r := l_area [i].update_rectangle
					if r /= Void then
						if Result = Void then
							if last_update_rectangle = Void then
									-- Reuse `local_update_rectangle'
								create last_update_rectangle
							end
							Result := last_update_rectangle
							Result.copy (r)
						else
							Result.merge (r)
						end
					end
					i := i + 1
				end
			end
		end

feature -- Visitor

	project (a_projector: EV_MODEL_DRAWING_ROUTINES)
			-- <Precursor>
		do
			across Current as ic_models loop
				if ic_models.is_show_requested then
					ic_models.project (a_projector)
				end
			end
		end

feature -- Element change

	set_x (a_x: INTEGER)
			-- Set `x' to `an_x'.
		local
			a_delta_x: INTEGER
		do
			a_delta_x := a_x - x
			if a_delta_x /= 0 then
				projection_matrix.translate (a_delta_x, 0)
				recursive_transform (projection_matrix)
				if is_in_group and then attached group as l_group and then l_group.is_center_valid then
					l_group.center_invalidate
				end
			end
			center.set_x (a_x)
			is_center_valid := True
		end

	set_y (a_y: INTEGER)
			-- Set `y' to `an_y'.
		local
			a_delta_y: INTEGER
		do
			a_delta_y := a_y - y
			if a_delta_y /= 0 then
				projection_matrix.translate (0, a_delta_y)
				recursive_transform (projection_matrix)
				if is_in_group and then attached group as l_group and then l_group.is_center_valid then
					l_group.center_invalidate
				end
			end
			center.set_y (a_y)
			is_center_valid := True
		end

	set_x_y (a_x, a_y: INTEGER)
			-- Set `x' to `an_x'.
		local
			a_delta_x, a_delta_y: INTEGER
		do
			a_delta_x := a_x - x
			a_delta_y := a_y - y
			if a_delta_x /= 0 or a_delta_y /= 0 then
				projection_matrix.translate (a_delta_x, a_delta_y)
				recursive_transform (projection_matrix)
				if is_in_group and then attached group as l_group and then l_group.is_center_valid then
					l_group.center_invalidate
				end
			end
			center.set (a_x, a_y)
			is_center_valid := True
		end

	set_point_position (a_x, a_y: INTEGER)
			-- Set position of `point' to (`a_x', `a_y').
		local
			a_delta_x, a_delta_y: DOUBLE
		do
			a_delta_x := a_x - point_array [0].x_precise
			a_delta_y := a_y - point_array [0].y_precise
			if a_delta_x /= 0 or a_delta_y /= 0 then
				projection_matrix.translate (a_delta_x, a_delta_y)
				recursive_transform (projection_matrix)
				if is_center_valid then
					center_invalidate
				end
			end
		end

	ungroup
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

	regroup
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

	send_backward (a_figure: EV_MODEL)
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

	bring_forward (a_figure: EV_MODEL)
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

	send_to_back (a_figure: EV_MODEL)
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

	bring_to_front (a_figure: EV_MODEL)
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

	rotate (an_angle: DOUBLE)
			-- Rotate around the center for `an_angle'.
		do
			current_angle := current_angle + an_angle
			Precursor {EV_MODEL} (an_angle)
		ensure then
			angle_equal_an_angle: angle = old angle + an_angle
		end

feature -- List change

	insert (fig: like item; i: INTEGER)
			-- Add `fig' to the group.
		do
			lookup_table.put (fig, fig.id)
			Precursor {ARRAYED_LIST} (fig, i)
			fig.set_group (Current)
			center_invalidate
			invalidate
			full_redraw
		ensure then
			fig_in_lookup_table: fig /= Void implies lookup_table.has (fig.id)
			fig_in_group: fig /= Void implies fig.group = Current
		end

	extend (fig: like item)
			-- Add `fig' to the group.
		do
			lookup_table.put (fig, fig.id)
			Precursor {ARRAYED_LIST} (fig)
			fig.set_group (Current)
			center_invalidate
			invalidate
			full_redraw
		ensure then
			fig_in_lookup_table: fig /= Void implies lookup_table.has (fig.id)
			fig_in_group: fig /= Void implies fig.group = Current
		end

	force (fig: like item)
			-- Add `fig' to the group.
		do
			lookup_table.put (fig, fig.id)
			Precursor {ARRAYED_LIST} (fig)
			fig.set_group (Current)
			center_invalidate
			invalidate
			full_redraw
		ensure then
			fig_in_lookup_table: fig /= Void implies lookup_table.has (fig.id)
			fig_in_group: fig /= Void implies fig.group = Current
		end

	replace (fig: like item)
			-- Replace current item by `fig'.
		do
			item.unreference_group
			lookup_table.remove (item.id)
			Precursor {ARRAYED_LIST} (fig)
			fig.set_group (Current)
			lookup_table.put (fig, fig.id)
			center_invalidate
			invalidate
			full_redraw
		ensure then
			fig_in_lookup_table: fig /= Void implies lookup_table.has (fig.id)
			item_not_in_lookup_table: not lookup_table.has (old item.id)
			fig_in_group: fig /= Void implies fig.group = Current
			item_not_in_group: not (old item).is_in_group
		end

	remove
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

	prune_all (fig: like item)
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

	merge_left (other: ARRAYED_LIST [EV_MODEL])
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

	merge_right (other: ARRAYED_LIST [EV_MODEL])
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

	wipe_out
			-- Remove all items.
		do
			from start until after loop
				if item.is_in_group then
					item.unreference_group
				end
				forth
			end
			Precursor {ARRAYED_LIST}
			lookup_table.wipe_out
			center_invalidate
			invalidate
			full_redraw
		end

	append (s: SEQUENCE [EV_MODEL])
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

	make_from_array (a: ARRAY [EV_MODEL])
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

	swap (i: INTEGER)
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

	invalidate
			-- Some property of `Current' has changed.
		local
			l_area: like area
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
					if l_area [i].valid then
						l_area [i].invalidate
					end
					i := i + 1
				end
			else
				Precursor {EV_MODEL}
			end
		end

	validate
			-- Validate `Current'.
		local
			l_area: like area
			i, nb: INTEGER
			l_figure: EV_MODEL
			l_rect: detachable EV_RECTANGLE
		do
			if not valid then
				if count > 0 then
					create l_rect
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
					if world = Current then
							-- We do not want the origin of the world to be included in the update.
						l_rect := calculated_bounding_box
						if l_rect = Void then
							create l_rect
						end
					else
						update_rectangle_to_bounding_box (l_rect)
					end
					if internal_invalid_rectangle /= Void then
						internal_invalid_rectangle.copy (l_rect)
					else
						internal_invalid_rectangle := l_rect
					end
				elseif internal_invalid_rectangle /= Void then
						-- Reset any previous invalid rectangle.
					internal_invalid_rectangle.move_and_resize (0, 0, 0, 0)
				end
				valid := True
			end
		end

feature -- Events

	position_on_figure (a_x, a_y: INTEGER): BOOLEAN
			-- Is the point on (`a_x', `a_y') on this figure?
			--| Used to generate events.
			-- Always returns `False', but descendants can override
			-- it to improve efficiency.
		do
			Result := False
		end

	bounding_box: EV_RECTANGLE
			-- Smallest orthogonal rectangular area `Current' fits in.
		local
			l_result: detachable EV_RECTANGLE
		do
			if attached internal_bounding_box as l_internal_bounding_box and then l_internal_bounding_box.has_area then
				Result := l_internal_bounding_box.twin
			else
				l_result := calculated_bounding_box
				if world = Current then
						-- If `Current' is the world then we need then we need the origin to be included so that its size is remembered.
					create Result.make (point_x, point_y, 0, 0)
					if l_result /= Void then
						Result.merge (l_result)
					end
				else
					if l_result /= Void then
						Result := l_result
					else
						create Result
					end
				end

				if attached internal_bounding_box as l_internal_bounding_box then
					l_internal_bounding_box.copy (Result)
				else
					internal_bounding_box := Result.twin
				end
			end
		end

feature {EV_MODEL_GROUP} -- Figure group

	recursive_transform (a_transformation: EV_MODEL_TRANSFORMATION)
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

	calculated_bounding_box: detachable EV_RECTANGLE
			-- Smallest orthogonal rectangular area `Current' fits in.
		do
			if is_grouped then
				create Result
				update_rectangle_to_calculated_bounding_box (Result)
			end
		end

	update_rectangle_to_calculated_bounding_box (a_rectangle: EV_RECTANGLE)
			-- Smallest orthogonal rectangular area `Current' fits in.
		local
			l_area: like area
			i, nb: INTEGER
			l_bbox: like internal_bounding_box
			l_initial: BOOLEAN
		do
			if is_grouped then
				from
					create l_bbox
					l_initial := True
					l_area := area
					i := 0
					nb := count - 1
				until
					i > nb
				loop
					if l_area.item (i).is_show_requested then
						l_area [i].update_rectangle_to_bounding_box (l_bbox)
						if l_bbox.width > 0 and then l_bbox.height > 0 then
							if l_initial then
								a_rectangle.copy (l_bbox)
								l_initial := False
							else
								a_rectangle.merge (l_bbox)
							end
						end
					end
					i := i + 1
				end
			end
		end

	current_angle: DOUBLE
			-- The rotating angle.

	set_center
			-- Set x and y such that they are in the
			-- center of the group.
		local
			l_bbox: like bounding_box
		do
			if is_grouped then
				l_bbox := bounding_box
				center.set_precise (l_bbox.left + l_bbox.width / 2, l_bbox.top + l_bbox.height / 2)
			else
				center.set (0, 0)
			end
			is_center_valid := True
		end

	initiale_size: INTEGER = 5
			-- Initialize size of `Current'.

	change_group (other: ARRAYED_LIST [EV_MODEL])
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

	full_redraw
			-- Request `invalid_rectangle' to be ignored.
		local
			w: detachable EV_MODEL_WORLD
		do
			w := world
			if w /= Void then
				w.full_redraw
			end
		end

	lookup_table: HASH_TABLE [EV_MODEL, INTEGER]
			-- Lookup table to search faster.

	insert_list_to_table (list: ARRAYED_LIST [EV_MODEL])
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

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
