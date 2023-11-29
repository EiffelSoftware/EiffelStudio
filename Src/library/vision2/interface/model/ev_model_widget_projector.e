note
	description:
		"Projectors for widgets."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "projector, events"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_MODEL_WIDGET_PROJECTOR

inherit
	EV_MODEL_PROJECTOR

	EV_MODEL_DRAWER
		undefine
			default_colors
		end

	EV_MODEL_PROJECTION_ROUTINES

	EV_SHARED_APPLICATION

feature {NONE} -- Initialization

	make_with_drawable_widget (a_world: like world; a_drawable: EV_DRAWABLE; a_widget: like widget)
			-- Create with `a_world' and `a_drawable' (= `a_widget').
		require
			a_world_not_void: a_world /= Void
			a_drawable_not_void: a_drawable /= Void
			a_widget_not_void: a_widget /= Void
		do
			make_with_drawable (a_drawable)
				-- This is only for letting users who have defined their own figure to still be
				-- able to use the `register_figure'.
			create draw_routines.make_filled (Void, 0, 20)
			make_with_world (a_world)
			widget := a_widget
			project_agent := agent project
			area_x := 0
			area_y := 0

			widget.pointer_motion_actions.extend (agent mouse_move)
			widget.pointer_button_press_actions.extend (agent button_press)
			widget.pointer_double_press_actions.extend (agent double_press)
			widget.pointer_button_release_actions.extend (agent button_release)
			widget.pointer_leave_actions.extend (agent pointer_leave)
			widget.pick_actions.extend (agent on_pick_request)
			widget.set_pebble_function (agent on_pebble_request)
			widget.set_actual_drop_target_agent (agent on_drop_target_request)
		end

	make_with_drawable_widget_and_buffer (
		a_world: like world;
		a_drawable: EV_DRAWABLE;
		a_buffer: EV_PIXMAP;
		a_widget: like widget)
			-- Create with `a_world', `a_drawable' (= `a_widget') and `a_buffer'.
		require
			a_world_not_void: a_world /= Void
			a_drawable_not_void: a_drawable /= Void
			a_buffer_not_void: a_buffer /= Void
			a_widget_not_void: a_widget /= Void
		do
			make_with_drawable_widget (a_world, a_buffer, a_widget)
			area := a_drawable
		end

	project_agent: detachable PROCEDURE note option: stable attribute end
		-- Agent used for projection.

feature -- Access

	widget: EV_WIDGET
			-- `device' if conforms to EV_WIDGET.
			-- `Void' otherwise.

	area: detachable EV_DRAWABLE
			-- Area associated with `widget'.
			-- `Void' if no buffer is used.

	area_x, area_y: INTEGER
			-- Coordinates of top-left corner of displayed part of `drawable'.
			-- (0, 0) when no buffer is used.

feature -- Status report

	buffer_used: BOOLEAN
			-- Is `drawable' only a buffer area for `area'?
		do
			Result := area /= Void
		end

	is_figure_selected: BOOLEAN
			-- Was button pointer pressed on a figure?

feature -- Element change

	change_area_position (a_x, a_y: INTEGER)
			-- `area' has moved to (`a_x', `a_y') of `drawable'.
		local
			u: EV_RECTANGLE
			l_area: like area
		do
			if buffer_used then
				l_area := area
				check l_area /= Void then end
				area_x := a_x
				area_y := a_y
				create u.make (0, 0, l_area.width, l_area.height)
				update_rectangle (u, 0, 0)
			end
		end

feature -- Basic operations

	project
			-- Make a standard projection of world on device.
		local
			a, e, u: detachable EV_RECTANGLE
		do
			if not is_projecting and then attached world as l_world then
				is_projecting := True

				if l_world.is_redraw_needed then
					full_project
					l_world.full_redraw_performed
				else
					e := l_world.invalid_rectangle
					if e /= Void then
						u := l_world.update_rectangle
						if u /= Void then
							e.merge (u)
						end

						a := area_bounding_box
						if a /= Void then
								-- Optimized projection to only project the viewable projection area.
							e := a.intersection (a)
						end
						if e.has_area then
							project_rectangle (e)
						end
					end
				end
				is_projecting := False
			end
		end

	project_rectangle (u: EV_RECTANGLE)
			-- Project area under `u'.
		local
			pixmap: detachable EV_PIXMAP
			l_world: like world
		do
			l_world := world
			check l_world /= Void then end
			drawable.set_background_color (l_world.background_color)
			drawable.set_anti_aliasing (l_world.is_anti_aliasing_enabled)
			drawable.clear_rectangle (u.left, u.top, u.width, u.height)

			if l_world.grid_visible then
				draw_grid (l_world)
			end

			if l_world.is_show_requested then
				project_figure_group (l_world, u)
			end
			if has_mouse then
				change_current (figure_on_position (l_world, last_pointer_x,
				last_pointer_y))
			end
			if l_world.points_visible then
				draw_points (l_world)
			end

			l_world.validate

			if buffer_used then
					-- Flush `drawable' on `area'.
				pixmap ?= drawable
				if pixmap /= Void and then attached area as l_area then
					l_area.draw_sub_pixmap (0, 0, pixmap, u)
				end
			end
		end

	full_project
			-- Project entire area.
		do
			project_rectangle (drawable_bounding_box)
		end

	update_rectangle (u: EV_RECTANGLE; a_x, a_y: INTEGER)
			-- Flush `u' on `area' at (`a_x', `a_y').
		require
			buffer_used: buffer_used
		local
			pixmap: detachable EV_PIXMAP
		do
			pixmap ?= drawable
			if pixmap /= Void and then attached area as l_area then
				u.set_x (u.x + area_x)
				u.set_y (u.y + area_y)
				l_area.draw_sub_pixmap (a_x, a_y, pixmap, u)
			end
		end

	update
		require
			buffer_used: buffer_used
		do
			update_rectangle (create {EV_RECTANGLE}.make (0, 0, drawable.width, drawable.height), 0, 0)
		end

	clear_device
			-- Erase entire canvas.
		do
			drawable.set_background_color (world.background_color)
			drawable.clear
		end

feature {NONE} -- Event implementation

	current_figure: detachable EV_MODEL
			-- Figure mouse is currently on.
			--| To generate leave and enter actions.

	last_pointer_x, last_pointer_y: INTEGER
			-- Last mouse coordinates.
			--| Used when world changes using `project'.

	has_mouse: BOOLEAN
			-- Does canvas have mouse on it?

	figure_on_position (group: EV_MODEL_GROUP; x, y: INTEGER): detachable EV_MODEL
			-- Figure mouse-cursor is on.
		local
			i: INTEGER
			found_closed_figure: detachable EV_MODEL_CLOSED
			l_model: EV_MODEL
		do
			if world.capture_figure /= Void then
				Result := world.capture_figure
			else
				from
					i := group.count
				until
					Result /= Void or else i < 1
				loop
					l_model := group [i]
					if l_model.is_show_requested and l_model.is_sensitive then
						if l_model.position_on_figure (x, y) then
							Result := l_model
						elseif attached {EV_MODEL_GROUP} l_model as grp then
							Result := figure_on_position (grp, x, y)
						end
						if attached {EV_MODEL_CLOSED} Result as closed_figure and then closed_figure.background_color = Void then
							-- is a not closed_figure under it?
							Result := Void
							if found_closed_figure = Void then
								-- if not take the first closed_figure found.
								found_closed_figure := closed_figure
							end
						end
					end
					i := i - 1
				end
				if Result = Void and then found_closed_figure /= Void then
					Result := found_closed_figure
				end
			end
		end

	button_press (x, y, button: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; screen_x, screen_y: INTEGER)
			-- Pointer button down happened.
		local
			event_fig: detachable EV_MODEL
			p: BOOLEAN
			w_x, w_y: INTEGER
		do
			w_x := x + area_x
			w_y := y + area_y
			from
				event_fig := figure_on_position (world, w_x, w_y)

				if event_fig = Void then
					event_fig := world
					is_figure_selected := False
				else
					is_figure_selected := True
				end
			until
				event_fig = Void
			loop
				if event_fig.is_show_requested and event_fig.is_sensitive and attached event_fig.internal_pointer_button_press_actions as l_actions then
					l_actions.call ([w_x, w_y, button,x_tilt, y_tilt, pressure, screen_x, screen_y])
					if event_fig.are_events_sent_to_group then
						event_fig := event_fig.group
					else
						event_fig := Void
					end
				else
					event_fig := event_fig.group
				end
				p := True
			end
			if p then
				project
			end
		end

	double_press (x, y, button: INTEGER; x_tilt, y_tilt, pressure: DOUBLE;
		screen_x, screen_y: INTEGER)
			-- Pointer double click happened.
		local
			event_fig: detachable EV_MODEL
			p: BOOLEAN
			w_x, w_y: INTEGER
		do
			w_x := x + area_x
			w_y := y + area_y
			from
				event_fig := figure_on_position (world, w_x, w_y)
				if event_fig = Void then
					event_fig := world
				end
			until
				event_fig = Void
			loop
				if event_fig.is_show_requested and event_fig.is_sensitive and attached event_fig.internal_pointer_double_press_actions as l_actions then
					l_actions.call ([w_x, w_y, button,x_tilt, y_tilt, pressure, screen_x, screen_y])
					if event_fig.are_events_sent_to_group then
						event_fig := event_fig.group
					else
						event_fig := Void
					end
				else
					event_fig := event_fig.group
				end
				p := True
			end
			if p then
				project
			end
		end

	button_release (x, y, button: INTEGER; x_tilt, y_tilt, pressure: DOUBLE;
		screen_x, screen_y: INTEGER)
			-- Pointer button up happened.
		local
			event_fig: detachable EV_MODEL
			p: BOOLEAN
			w_x, w_y: INTEGER
		do
			w_x := x + area_x
			w_y := y + area_y
			is_figure_selected := False
			from
				event_fig := figure_on_position (world, w_x, w_y)
				if event_fig = Void then
					event_fig := world
				end
			until
				event_fig = Void
			loop
				if event_fig.is_show_requested and event_fig.is_sensitive and attached event_fig.internal_pointer_button_release_actions as l_actions then
					l_actions.call ([w_x, w_y, button, x_tilt, y_tilt, pressure, screen_x, screen_y])
					if event_fig.are_events_sent_to_group then
						event_fig := event_fig.group
					else
						event_fig := Void
					end
				else
					event_fig := event_fig.group
				end
				p := True
			end
			if p then
				project
			end
		end

	pointer_leave
			-- Pointer left canvas.
		do
			has_mouse := False
		end

	has_focus (a_figure: EV_MODEL): BOOLEAN
			-- Is mouse cursor on `a_figure'?
		local
			grp: detachable EV_MODEL_GROUP
		do
			if current_figure = a_figure then
				Result := True
			else
				grp ?= a_figure
				if grp /= Void then
					from grp.start until Result or grp.after loop
						Result := has_focus (grp.item)
						grp.forth
					end
				end
			end
		end

	change_current (new_current_figure: detachable EV_MODEL)
			-- Change current to `new_focused_figure'.
			--| Generate leave and/or enter events accordingly.
		local
			old_figure: detachable EV_MODEL
			event_fig: detachable EV_MODEL
			same_fig: detachable EV_MODEL
			p: BOOLEAN
			action: detachable EV_LITE_ACTION_SEQUENCE [TUPLE]
		do
			if current_figure /= new_current_figure then
				if
					new_current_figure /= Void and then
					new_current_figure.is_show_requested and then
					new_current_figure.is_sensitive and then
					attached new_current_figure.pointer_style as l_new_current_figure_pointer_style
				then
					widget.set_pointer_style (l_new_current_figure_pointer_style)
				else
					widget.set_pointer_style (default_cursor)
				end
				old_figure := current_figure
				current_figure := new_current_figure
				if old_figure /= Void then
					from
						event_fig := old_figure
					until
						event_fig = Void or else has_focus (event_fig)
					loop
						action := event_fig.internal_pointer_leave_actions
						if action /= Void and event_fig.is_show_requested and event_fig.is_sensitive then
							action.call (Void)
							if event_fig.are_events_sent_to_group then
								event_fig := event_fig.group
							else
								event_fig := Void
							end
						else
							event_fig := event_fig.group
						end
						p := True
					end
				end
				same_fig := event_fig
				if current_figure /= Void then
					from
						event_fig := current_figure
					until
						event_fig = Void or else event_fig = same_fig
					loop
						action := event_fig.internal_pointer_enter_actions
						if action /= Void and event_fig.is_show_requested and event_fig.is_sensitive then
							action.call (Void)
							if event_fig.are_events_sent_to_group then
								event_fig := event_fig.group
							else
									-- Exit loop
								event_fig := same_fig
							end
						else
							event_fig := event_fig.group
						end
						p := True
					end
				end
			end
			if p then
				project
			end
		ensure
--			current_figure_assigned: current_figure = new_current_figure
		end

	mouse_move (x, y: INTEGER; x_tilt, y_tilt, pressure: DOUBLE;
		screen_x, screen_y: INTEGER)
			-- Fire events that belong to mouse movement.
			--| i.e. leave, enter, motion.
		local
			event_fig: detachable EV_MODEL
			p: BOOLEAN
			w_x, w_y: INTEGER
		do
			if not is_projecting then
				w_x := x + area_x
				w_y := y + area_y
				has_mouse := True
				last_pointer_x := w_x
				last_pointer_y := w_y
				from
					event_fig := figure_on_position (world, w_x, w_y)
					change_current (event_fig)
					if event_fig = Void then
						event_fig := world
					end
				until
					event_fig = Void
				loop
					if event_fig.is_show_requested and event_fig.is_sensitive and attached event_fig.internal_pointer_motion_actions as l_actions then
						l_actions.call ([w_x, w_y, x_tilt, y_tilt, pressure, screen_x, screen_y])
						p := p or else not event_fig.valid
						if event_fig.are_events_sent_to_group then
							event_fig := event_fig.group
						else
							event_fig := Void
						end
					else
						event_fig := event_fig.group
					end
				end
				if p or else not world.valid then
					if project_agent /= Void then
						ev_application.do_once_on_idle (project_agent)
					end
				end
			end
		end

	on_pebble_request (a_x, a_y: INTEGER): detachable ANY
			-- Pebble of current figure.
			-- If figure is `Void', return pebble of world.
			--| Because when a context menu is up, no events are sent
			--| to the world, first simulate a mouse motion to update
			--| the projection.
		local
			fig: detachable EV_MODEL
		do
			mouse_move (a_x, a_y, 0.0, 0.0, 0.0, 0, 0)
			fig := current_figure
			if fig = Void or else ev_application.ctrl_pressed then
				Result := world.real_pebble (a_x, a_y)
			elseif fig.is_show_requested and fig.is_sensitive then
				from until Result /= Void or fig = Void loop
					Result := fig.real_pebble (a_x, a_y)
					if Result = Void then
						fig := fig.group
					end
				end
				if Result /= Void and then fig /= Void then
					widget.set_accept_cursor (fig.accept_cursor)
					widget.set_deny_cursor (fig.deny_cursor)
				end
			end
		end

	on_drop_target_request (a_x, a_y: INTEGER): detachable EV_ABSTRACT_PICK_AND_DROPABLE
			-- Find actual drop target.
		local
			event_fig: detachable EV_MODEL
			w_x, w_y: INTEGER
		do
			w_x := a_x + area_x
			w_y := a_y + area_y
			event_fig := figure_on_position (world, w_x, w_y)
			if event_fig = Void and then not world.drop_actions.is_empty then
				Result := world
			else
				from until Result /= Void or event_fig = Void loop
					check event_fig /= Void end
					if not event_fig.drop_actions.is_empty then
						Result := event_fig
					end
					event_fig := event_fig.group
				end
			end
		end

	on_pick_request  (a_x, a_y: INTEGER)
			-- Pick event of current figure.
		local
			event_fig, fig: detachable EV_MODEL
		do
			event_fig := figure_on_position (world, a_x + area_x, a_y + area_y)
			if
				event_fig /= Void and then
				event_fig.is_show_requested and then
				event_fig.is_sensitive
			then
				from
				until
					fig /= Void or event_fig = Void
				loop
					check
						event_fig /= Void
					end
					if not event_fig.pick_actions.is_empty then
						fig := event_fig
					else
						event_fig := event_fig.group
					end
				end
				if
					fig /= Void and then
					attached fig.pick_actions as l_actions and then
					not l_actions.is_empty
				then
					l_actions.call ([a_x, a_y])
				end
			end
		end

feature {EV_MODEL_WORLD_CELL} -- Element change

	simulate_mouse_move (ax, ay: INTEGER)
			-- Let `Current' behave as if pointer was moved to `ax', `ay'
		do
			mouse_move (ax, ay, 0, 0, 0, 0, 0)
		end

feature {NONE} -- Implementation

	drawable_position: EV_COORDINATE
			-- Position of drawable relative to world.
			-- Redefined by descendents.
		do
			create Result
		end

	drawable_bounding_box: EV_RECTANGLE
			-- Bounding box of the projector
		do
			create Result.make (drawable_position.x, drawable_position.y, drawable.width, drawable.height)
		end

	area_bounding_box: detachable EV_RECTANGLE
			-- Bounding box of the visible area if used.
		do
			if attached area as l_area then
				create Result.make (area_x, area_y, l_area.width, l_area.height)
			end
		end

	default_cursor: EV_POINTER_STYLE
			-- Default cursor on world.
		do
			Result := default_pixmaps.standard_cursor
		end

	axle_length: INTEGER = 15
			-- Length of x and y axles when points are displayed.

	draw_points (figure: EV_MODEL)
			-- Draw representation of all points in `figure' to canvas.
		require
			figure_not_void: figure /= Void
		local
			group: detachable EV_MODEL_GROUP
			l_points: SPECIAL [EV_COORDINATE]
			i, nb: INTEGER
			bbox: EV_RECTANGLE
			l_item: EV_COORDINATE
		do
			bbox := figure.bounding_box

			drawable.set_foreground_color (default_colors.red)
			drawable.fill_ellipse (figure.x-5 + offset_x, figure.y-5 + offset_y, 11, 11)

			drawable.set_foreground_color (default_colors.black)
			drawable.draw_rectangle (bbox.left + offset_x, bbox.top + offset_y, bbox.width, bbox.height)

			group ?= figure
			if group = Void then
				l_points := figure.point_array
				from
					i := 0
					nb := l_points.count - 1
				until
					i > nb
				loop
					l_item := l_points.item (i)
					drawable.draw_segment (l_item.x + offset_x, l_item.y + offset_y, figure.x + offset_x, figure.y + offset_y)
					drawable.fill_ellipse (l_item.x - 5 + offset_x, l_item.y - 5 + offset_y, 11, 11)
					i := i + 1
				end
			end
			group ?= figure
			if group /= Void then
				from
					group.start
				until
					group.after
				loop
					draw_points (group.item)
					group.forth
				end
			end
		end

note
	copyright: "Copyright (c) 1984-2023, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
