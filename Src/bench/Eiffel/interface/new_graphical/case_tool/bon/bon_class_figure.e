indexing
	description: "Graphical representations of classes in BON notation."
	date: "$Date$"
	revision: "$Revision$"

class
	BON_CLASS_FIGURE

inherit
	CLASS_FIGURE
		undefine
			snap_to_grid,
			out
		redefine
			wipe_out,
			position_on_figure,
			real_pebble,
			bounding_box
		end

	EV_MOVE_HANDLE
		rename
			initialize as initialize_mover
		undefine
			default_create,
			world,
			wipe_out,
			set_origin,
			bounding_box,
			is_equal
		redefine
			position_on_figure,
			real_pebble
		end

create
	make_with_class

feature {NONE} -- Initialization

	initialize is
			-- Initialize figures.
		do
			initialize_mover
			create broken_name.make (10)

			create ellipse
			ellipse.point_a.set_origin (point)
			ellipse.point_b.set_origin (ellipse.point_a)
			ellipse.set_line_width (bon_class_line_width)
			ellipse.set_foreground_color (bon_class_line_color)
			ellipse.set_background_color (bon_class_fill_color)

			create name_figures.make
			create icon_figures.make

			create generics_figure
			generics_figure.set_font (bon_generics_font)
			generics_figure.point.set_origin (point)

			pointer_button_press_actions.extend (~button_press)
			move_actions.force_extend (~update)
			move_actions.force_extend (~update_scrollable_area_size)
			start_actions.extend (~move_to_front)
			start_actions.extend (~save_position)
			start_actions.extend (agent start_capture)
			end_actions.extend (agent stop_capture)
			start_actions.extend (~set_pointer_style (Default_pixmaps.Sizeall_cursor))
			end_actions.extend (~set_pointer_style (Default_pixmaps.Standard_cursor))
			end_actions.extend (~update_cluster_size)
			end_actions.extend (~extend_history)
		end

feature -- Memory management

	recycle is
			-- Frees `Current's memory, and leave `Current' in an unstable state
			-- so that we know whether we're still referenced or not.
		do
			ancestor_figures.wipe_out
			descendant_figures.wipe_out
			client_figures.wipe_out
			supplier_figures.wipe_out
		end

feature -- Access

	left: INTEGER is
			-- Absolute left position.
		do
			Result := ellipse.point_a.x_abs
		end

	top: INTEGER is
			-- Absolute top position.
		do
			Result := ellipse.point_a.y_abs
		end
		
	right: INTEGER is
			-- Absolute right position.
		do
			Result := ellipse.point_b.x_abs
		end

	bottom: INTEGER is
			-- Absolute bottom position.
		do
			Result := ellipse.point_b.y_abs
		end

	x_position: INTEGER is
			-- Absolute center x coordinate.
		do
			Result := point.x_abs
		end

	y_position: INTEGER is
			-- Absolute center y coordinate.
		do
			Result := point.y_abs
		end

	width: INTEGER is
			-- Horizontal size.
		do
			Result := ellipse.point_b.x
		end

	height: INTEGER is
			-- Vertical size.
		do
			Result := ellipse.point_b.y
		end

	real_pebble: ANY is
			-- Calculated `pebble'.
			-- Void if key ctrl pressed.
		do
			if not ctrl_pressed then
				Result := Precursor {CLASS_FIGURE}
			end
		end

feature -- Figures

	ellipse: EV_FIGURE_ELLIPSE
			-- BON symbol for a class.

	name_figures: LINKED_LIST [EV_FIGURE_TEXT]
			-- Figure for every broken part of the name.

	generics_figure: EV_FIGURE_TEXT
			-- Class generics, between brackets.

	icon_figures: LINKED_LIST [EV_FIGURE_PICTURE]
			-- Optional icon for class types deferred, effective, persistent, interfaced.

	color: EV_COLOR is
			-- User selected color.
		do
			Result := ellipse.background_color
		end

feature -- Status report

	bounding_box: EV_RECTANGLE is
			-- Smallest orthogonal rectangular area `Current' fits in.
		do
			Result := ellipse.bounding_box
		end

feature -- Status setting

	set_size (a_width, a_height: INTEGER) is
			-- Resize `Current' to `a_width', `a_height'.
		require
			a_width_positive: a_width > 0
			a_height_positive: a_height > 0
		do
			ellipse.point_a.set_position (-a_width // 2, -a_height // 2)
			ellipse.point_b.set_position (a_width, a_height)
		end

	name_width: INTEGER is
			-- Width of the `name' figures.
		do
			Result := bon_class_name_font.string_size (broken_name).integer_item (1)
		end

	icon_width: INTEGER is
			-- Width of all icons.
		do
			from
				icon_figures.start
			until
				icon_figures.after
			loop
				Result := Result + icon_figures.item.width
				icon_figures.forth
			end
			Result := Result + (icon_figures.count - 1) * Icon_spacing
		end

	set_active (b: BOOLEAN) is
			-- Highlight `Current' if `b' `True'.
		do
			if b then
				ellipse.set_line_width (3)
			else
				ellipse.set_line_width (1)
			end
		end

	update_edge_point (p: EV_RELATIVE_POINT; angle: REAL) is
			-- Move `p', which is relative to `Current', to a point on the
			-- edge where the outline intersects a line from the center point
			-- in direction `angle'.
		local
			x, y, l, a, b: REAL
		do
			l := tangent (angle)
			a := ellipse.point_b.x / 2
			b := ellipse.point_b.y / 2
			x := (a * b) / sqrt (b^2 + l^2 * a^2)
			y := l * x
			if cosine (angle) > 0 then
				x := -x
				y := -y
			end
			p.set_position (x.truncated_to_integer, -y.truncated_to_integer)
		end

	set_color (a_color: EV_COLOR) is
			-- Assign `a_color' to `color'.
		do
			ellipse.set_background_color (a_color)
		end

	set_name_color (a_color: EV_COLOR) is
			-- Assign `a_color' to `name_figures' items.
		do
			from
				name_figures.start
			until
				name_figures.after
			loop
				name_figures.item.set_foreground_color (a_color)
				name_figures.forth
			end
		end

	set_generics_color (a_color: EV_COLOR) is
			-- Assign `a_color' to `generics_figure'.
		do
			generics_figure.set_foreground_color (a_color)
		end

	set_bounds (a_x, a_y, a_width, a_height: INTEGER) is
			-- Assign bounds.
		do
			point.set_x (a_x - point.origin.x_abs)
			point.set_y (a_y - point.origin.y_abs)
			set_size (a_width, a_height)
			update
		end

	set_relative_position_and_size (a_x, a_y, a_width, a_height: INTEGER) is
			-- Assign bounds.
		do
			point.set_x (a_x)
			point.set_y (a_y)
			set_size (a_width, a_height)
			update
		end

	mask is 
			-- `Current' no longer needs to be displayed.
		do
			hide
			disable_sensitive
			from ancestor_figures.start until ancestor_figures.after loop
				ancestor_figures.item.mask
				ancestor_figures.forth
			end
			from descendant_figures.start until descendant_figures.after loop
				descendant_figures.item.mask
				descendant_figures.forth
			end
			from client_figures.start until client_figures.after loop
				client_figures.item.mask
				client_figures.forth
			end
			from supplier_figures.start until supplier_figures.after loop
				supplier_figures.item.mask
				supplier_figures.forth
			end
		end

	unmask is
			-- `Current' needs to be displayed again.
		do
			show
			enable_sensitive
			from ancestor_figures.start until ancestor_figures.after loop
				ancestor_figures.item.unmask
				ancestor_figures.forth
			end
			from descendant_figures.start until descendant_figures.after loop
				descendant_figures.item.unmask
				descendant_figures.forth
			end
			from client_figures.start until client_figures.after loop
				client_figures.item.unmask
				client_figures.forth
			end
			from supplier_figures.start until supplier_figures.after loop
				supplier_figures.item.unmask
				supplier_figures.forth
			end
		end

feature {BON_DIAGRAM_FACTORY} -- Drawing

	draw is
			-- Do a quick draw on `drawable'.
		local
			cx, cy, r1, r2: INTEGER
			fig_txt: EV_FIGURE_TEXT
			fig_pic: EV_FIGURE_PICTURE
			re: EV_FIGURE_ELLIPSE
			name_font, generics_font: EV_FONT
			d: like drawable
		do
			d := drawable
			cx := ellipse.center_x
			cy := ellipse.center_y
			r1 := ellipse.radius1
			r2 := ellipse.radius2
			d.set_line_width (bon_class_line_width)
			d.set_foreground_color (ellipse.background_color)
			d.fill_ellipse (cx - r1, cy - r2, 2 * r1, 2 * r2)
			d.set_foreground_color (bon_class_line_color)
			d.draw_ellipse (cx - r1, cy - r2, 2 * r1, 2 * r2)
			if is_root_class then
			    re := root_ellipse
			    cx := re.center_x
			    cy := re.center_y
			    r1 := re.radius1
			    r2 := re.radius2
			    d.draw_ellipse (cx - r1, cy - r2, 2 * r1, 2 * r2)
			end

			create name_font.make_with_values (
				bon_class_name_font.family,
				bon_class_name_font.weight,
				bon_class_name_font.shape,
				bon_class_name_font.height)
			name_font.set_height ((name_font.height * world.point.scale_y).rounded)
			d.set_font (name_font)
			d.set_foreground_color (bon_class_name_color)
			from
				name_figures.start
			until
				name_figures.after
			loop
				fig_txt := name_figures.item
				d.set_foreground_color (fig_txt.foreground_color)
				d.draw_text_top_left (fig_txt.point.x_abs, fig_txt.point.y_abs, fig_txt.text)
				name_figures.forth
			end

			if generics /= Void then
				fig_txt := generics_figure
				create generics_font.make_with_values (
					bon_generics_font.family,
					bon_generics_font.weight,
					bon_generics_font.shape,
					bon_generics_font.height)
				generics_font.set_height ((generics_font.height * world.point.scale_y).rounded)
				d.set_font (generics_font)
				d.set_foreground_color (generics_figure.foreground_color)
				d.draw_text_top_left (fig_txt.point.x_abs, fig_txt.point.y_abs, fig_txt.text)
			end

			from
				icon_figures.start
			until
				icon_figures.after
			loop
				fig_pic := icon_figures.item
				d.draw_pixmap (fig_pic.point.x_abs, fig_pic.point.y_abs, fig_pic.pixmap)
				icon_figures.forth
			end
		end

feature {NONE} -- Implementation

	wipe_out is
		do
			Precursor {CLASS_FIGURE}
			name_figures.wipe_out
			icon_figures.wipe_out
		end

	Extra_width: INTEGER is 30

	Extra_height: INTEGER is 20

	build_figure is
			-- Build graphical representation from recently updated structure.
		local
			t: EB_DIMENSIONS
		do
			extend (ellipse)

			broken_name.wipe_out
			add_name_figure (name)

			if generics /= Void then
				generics_figure.set_text (generics)
				generics_figure.set_font (bon_generics_font)
				generics_figure.set_foreground_color (bon_generics_color)
				extend (generics_figure)
			end

			set_bon_icons

			layout_figures

			t := minimum_dimension
			set_size (t.width + Extra_width, t.height + Extra_height)
		end

	layout_figures is
			-- Set all figures to a nice position relative to `point'.
		local
			name_y, icon_x: INTEGER
			nf: EV_FIGURE_TEXT
			ifig: EV_FIGURE_PICTURE
		do
			name_y := name_figures.count * (bon_class_name_font.height + Text_spacing)
			if generics /= Void then
				name_y := name_y + bon_generics_font.height + 2
			end
			name_y := - name_y // 2

			icon_x := - icon_width // 2
			from
				icon_figures.start
			until
				icon_figures.after
			loop
				ifig := icon_figures.item
				ifig.point.set_position (icon_x, name_y - ifig.height)
				icon_x := icon_x + ifig.width + Icon_spacing
				icon_figures.forth
			end

			from
				name_figures.start
			until
				name_figures.after
			loop
				nf := name_figures.item
				nf.point.set_position (- nf.width // 2, name_y)
				name_y := name_y + bon_class_name_font.height + Text_spacing
				name_figures.forth
			end
			
			if generics /= Void then
				generics_figure.point.set_position (- generics_figure.width // 2, name_y)
			end
		end

	Max_backup: INTEGER is 7
			-- Break at underscores, but do not search further than this index.

	Icon_spacing: INTEGER is 2
			-- Pixels between icons.

	Text_spacing: INTEGER is 0
			-- Pixels between texts.

	root_ellipse: EV_FIGURE_ELLIPSE is
			-- BON specifies that a root class should have a double ellipse.
		require
			is_root_class
		local
			lw: INTEGER
		do
			lw := bon_class_line_width
			create Result
			Result.set_line_width (lw)
			Result.set_foreground_color (bon_class_line_color)
			Result.remove_background_color
			Result.point_a.set_origin (ellipse.point_a)
			Result.point_a.set_position (lw * 2 + 1, lw * 2 + 1)
			Result.point_b.set_origin (ellipse.point_b)
			Result.point_b.set_position (-lw * 2 - 1, -lw * 2 - 1)
		end
	
	set_bon_icons is
			-- Examine the properties of the class and add BON pixmaps.
		do
			if is_deferred then
				add_icon (Pixmaps.Icon_bon_deferred)
			end
			if is_effective then
				add_icon (Pixmaps.Icon_bon_effective)
			end
			if is_persistent then
				add_icon (Pixmaps.Icon_bon_persistent)
			end
			if is_interfaced then
				add_icon (Pixmaps.Icon_bon_interfaced)
			end
		end

	add_icon (p: EV_PIXMAP) is
			-- Add picture figure for `p' to `icon_figures'.
		local
			icon: EV_FIGURE_PICTURE
		do
			create icon
			icon.set_pixmap (p)
			icon_figures.extend (icon)
			icon.point.set_origin (point)
			extend (icon)
		end

	add_name_figure (n: STRING) is
			-- Add first characters as name figure, then call recursively.
		local
			name_figure: EV_FIGURE_TEXT
			reused_figure: EV_FIGURE_LINE
			s, rest: STRING
			i: INTEGER
		do
			if n.count > max_class_name_length then
				i := n.last_index_of ('_', max_class_name_length)
				if i < Max_backup then
					i := max_class_name_length
				end
				s := n.substring (1, i)
				rest := n.substring (i + 1, n.count)
			else
				s := clone (n)
			end

			create name_figure
			name_figure.set_font (bon_class_name_font)
			name_figure.set_foreground_color (bon_class_name_color)
			name_figure.set_text (s)
			name_figure.point.set_origin (point)
			name_figure.drop_actions.extend (~on_class_drop)
			name_figures.extend (name_figure)
			extend (name_figure)

			if is_reused then
				create reused_figure
				reused_figure.point_a.set_origin (name_figure.point)
				reused_figure.point_a.set_position (0, name_figure.height + 1)
				reused_figure.point_b.set_origin (reused_figure.point_a)
				reused_figure.point_b.set_position (name_figure.width, 0)
				extend (reused_figure)
			end

			broken_name.append (s)
			if rest /= Void then
				broken_name.extend ('%N')
				add_name_figure (rest)
			end
		end

	minimum_dimension: EB_DIMENSIONS is
			-- Best values for `width' and `height'.
		local
			height_ratio, width_ratio: DOUBLE
		do
			create Result.set (
				name_width,
				name_figures.count * (bon_class_name_font.height + Text_spacing))
			if generics /= Void then
				height_ratio := 0.55
				width_ratio := 0.25
				Result.set (
					Result.width.max (generics_figure.width + (width_ratio * generics_figure.text.count).rounded),
					Result.height + bon_generics_font.height + (height_ratio * generics_figure.text.count).rounded + Text_spacing)
			end
		end

	position_on_figure (x, y: INTEGER): BOOLEAN is
			-- Is the point on (`x', `y') on this figure?
			--| Used to generate events.
		do
			Result := ellipse.position_on_figure (x, y)
		end

	saved_x: INTEGER
			-- Backup of `Current' X-coordinate.

	saved_y: INTEGER
			-- Backup of `Current' Y-coordinate.

feature {NONE} -- Events

	button_press (x, y, b: INTEGER; xt, yt, p: DOUBLE; sx, sy: INTEGER) is
			-- User pressed pointer button on `Current'.
		local
			pebble_as_stone: STONE
		do
			if b = 3 and then ctrl_pressed then
				pebble_as_stone ?= pebble
				if pebble_as_stone /= Void then
					world.context_editor.create_development_window (pebble_as_stone)
				end
			end
		end

	move_to_front is
			-- Make `Current' appear in front of its peers.
		local
			w: CONTEXT_DIAGRAM
			g: EV_FIGURE_GROUP
		do
			w := world
			if w /= Void then
				g := w.class_layer
				g.prune_all (Current)
				g.extend (Current)
				w.full_redraw_performed
			end
		end

	save_position is
			-- Make a backup of current coordinates.
		do
			saved_x := point.x
			saved_y := point.y
		end 

	extend_history is
			-- Register move in the history.
		local
			cd: CLUSTER_DIAGRAM
			new_cluster_figure: CLUSTER_FIGURE
			saved_x_abs, saved_y_abs: INTEGER
		do
			cd ?= world
			if cd /= Void then
				new_cluster_figure := cd.smallest_cluster_containing_point (x_position, y_position)
				if new_cluster_figure = Void then
					point.set_position (saved_x, saved_y)
					update_and_project
				elseif new_cluster_figure /= cluster_figure then
					saved_x_abs := (saved_x * cluster_figure.point.scale_x_abs).rounded + cluster_figure.point.x_abs
					saved_y_abs := (saved_y * cluster_figure.point.scale_y_abs).rounded + cluster_figure.point.y_abs
					world.context_editor.history.do_named_undoable (
						Interface_names.t_Diagram_move_class_cmd,
						[<<cd~on_move_class_end (Current, new_cluster_figure),
							point~set_position (
								((point.x_abs - new_cluster_figure.point.x_abs) /
									new_cluster_figure.point.scale_x_abs).rounded,
								((point.y_abs - new_cluster_figure.point.y_abs) /
									new_cluster_figure.point.scale_y_abs).rounded),
							~update_and_project>>],
						[<<cd~on_move_class_end (Current, cluster_figure),
							point~set_position (saved_x, saved_y),
							~update_and_project>>])	
				else
					world.context_editor.history.do_named_undoable (
						Interface_names.t_Diagram_move_class_cmd,
						[<<point~set_position (point.x, point.y),
							~update_and_project>>],
						[<<point~set_position (saved_x, saved_y),
							~update_and_project>>])	
				end
			else
				world.context_editor.history.do_named_undoable (
					Interface_names.t_Diagram_move_class_cmd,
					[<<point~set_position (point.x, point.y),
						~update_and_project>>],
					[<<point~set_position (saved_x, saved_y),
						~update_and_project>>])
			end
		end

	update_cluster_size is
			-- Minimum size of `cluster_figure' needs to be updated
			-- according to `Current' last move.
		do
			if cluster_figure /= Void then
				if cluster_figure.position_on_figure (left, top) or else
					cluster_figure.position_on_figure (right, bottom) or else
					cluster_figure.position_on_figure (right, top) or else
					cluster_figure.position_on_figure (left, bottom) then
						cluster_figure.update_minimum_size
				end
			end
		end

	update_scrollable_area_size is
			-- Minimum size of the scrollable area needs to be updated
			-- according to `Current' last move.
		do
			world.context_editor.on_figure_moved
		end
	
end -- class BON_CLASS_FIGURE
