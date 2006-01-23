indexing
	description: "[
				An EV_FIGURE_WORLD_CELL is an EV_CELL with scrollbars displaying
				`world' in the cell. Whenever the `world' does not fit into the frame
				the scrolling area is resized to make sure that every part of the world
				is reachable through the scrollbars. If a figure is moved closer to the
				frame border then `autoscroll_border' the frame starts to scroll.
				If the user clicks into the frame but not onto a figure the frame can
				be moved arround with the "hand". A buffer is used to prefend flickering.
				The buffer size as well as the drawing_area size is constant no matter 
				how large the world is.
				
				example:
				
					create figure_world_cell.make_with_world (create {EV_FIGURE_WORLD})
					figure_world_cell.world.extend (create {EV_FIGURE_LINE}.make_with_positions (0, 0, 100, 100))
					horizontal_box.extend (figure_world_cell)
				
					]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_MODEL_WORLD_CELL

inherit
	EV_CELL
		redefine
			initialize
		end
		
	EV_SHARED_APPLICATION
		undefine
			copy,
			is_equal,
			default_create
		end
	
create
	make_with_world
	
feature {NONE} -- Initialization

	make_with_world (a_world: like world) is
			-- Create an EV_FIGURE_WORLD_FRAM displaying `a_world'.
		require
			a_world_not_void: a_world /= Void
		do
			world := a_world
			default_create
		ensure
			world_set: world = a_world
		end
		
	initialize is
			-- Initialize `Current'.
		local
			vertical_box: EV_VERTICAL_BOX
			horizontal_box: EV_HORIZONTAL_BOX
		do
			Precursor {EV_CELL}
			
			create drawing_area
			drawing_area.set_minimum_size (1, 1)
			drawing_area.clear
			drawing_area.flush
			
			create horizontal_box
			create vertical_scrollbar.make_with_value_range (create {INTEGER_INTERVAL}.make (0, 1))
			vertical_scrollbar.set_step (15)
			vertical_scrollbar.change_actions.extend (agent on_vertical_scroll)
			create horizontal_scrollbar.make_with_value_range (create {INTEGER_INTERVAL}.make (0, 1))
			horizontal_scrollbar.set_step (15)
			horizontal_scrollbar.change_actions.extend (agent on_horizontal_scroll)
			horizontal_box.extend (drawing_area)
			horizontal_box.extend (vertical_scrollbar)
			horizontal_box.disable_item_expand (vertical_scrollbar)
			drawing_area.resize_actions.extend (agent on_resizing)

			create projector.make_with_buffer (world, drawing_area)
			
			create vertical_box
			vertical_box.extend (horizontal_box)
			vertical_box.extend (horizontal_scrollbar)
			vertical_box.disable_item_expand (horizontal_scrollbar)
			
			drawing_area.pointer_button_press_actions.extend (agent on_pointer_button_press_on_drawing_area)
			drawing_area.pointer_button_release_actions.extend (agent on_pointer_button_release_on_drawing_area)
			drawing_area.pointer_motion_actions.extend (agent on_pointer_button_move_on_drawing_area)
			drawing_area.mouse_wheel_actions.extend (agent on_mouse_wheel_on_drawing_area)
			drawing_area.key_press_actions.extend (agent on_key_pressed_on_drawing_area)
			drawing_area.key_release_actions.extend (agent on_key_released_on_drawing_area)
			
			create autoscroll.make_with_interval (normal_timeout_interval)
			autoscroll.actions.extend (agent on_autoscroll_time_out)
			
			extend (vertical_box)
			
			autoscroll_border := 50
			world_border := 20
			is_autoscroll_enabled := True
			is_resize_enabled := True
			scroll_speed := 1.0
		end
		
feature -- Status report

	is_autoscroll_enabled: BOOLEAN
			-- Is autoscroll enabled?
			
	is_resize_enabled: BOOLEAN
			-- Is resizing enabled?
			
	is_scrollbar_enabled: BOOLEAN
			-- Are scrollbars visible?
		
feature -- Access

	world: EV_MODEL_WORLD
			-- The world shown in `Current'.
	
	projector: EV_MODEL_BUFFER_PROJECTOR
			-- Projector to render `world'.
	
	drawing_area: EV_DRAWING_AREA
			-- Graphical surface displaying `world'.
			
	vertical_scrollbar: EV_VERTICAL_SCROLL_BAR
			-- Vertical scroll bar.
			
	horizontal_scrollbar: EV_HORIZONTAL_SCROLL_BAR
			-- Horizontal scroll bar.
			
	autoscroll_border: INTEGER
			-- Distance to the frame border wher scrolling starts.
			
	world_border: INTEGER
			-- Minimal distance between world borders and frame borders.
			
	scroll_speed: DOUBLE
			-- Speed of auto scroll. Autoscroll happens every 50 milliseconds for
			-- scroll_speed * (distance between `autoscroll_border' and cursor)
			-- Pixels. Meaning the nearer the cursor is to the cell border the
			-- faster the scroll plus the higher the scroll_speed value the faster
			-- the scroll. Default is 1.0.
			
feature -- Status setting

	disable_resize is
			-- Set `is_resize_enabled' to False.
		do
			is_resize_enabled := False
		ensure
			set: is_resize_enabled = False
		end
		
	enable_resize is
			-- Set `is_resize_enabled' to True.
		do
			is_resize_enabled := True
		ensure
			set: is_resize_enabled = True
		end
		
	disable_scrollbars is
			-- Hide scrollbars.
		do
			horizontal_scrollbar.hide
			vertical_scrollbar.hide
			is_scrollbar_enabled := False
		ensure
			hide: not horizontal_scrollbar.is_show_requested and not vertical_scrollbar.is_show_requested
			set: not is_scrollbar_enabled
		end
		
	enable_scrollbars is
			-- Show scrollbars.
		do
			horizontal_scrollbar.show
			vertical_scrollbar.show
			is_scrollbar_enabled := True
		ensure
			show: horizontal_scrollbar.is_show_requested and vertical_scrollbar.is_show_requested
			set: is_scrollbar_enabled
		end

feature -- Element change

	set_scroll_speed (a_scroll_speed: like scroll_speed) is
			-- Set `scroll_speed' to `a_scroll_speed'.
		require
			a_scroll_speed_positive: a_scroll_speed >= 0.0
		do
			scroll_speed := a_scroll_speed
		ensure
			set: scroll_speed = a_scroll_speed
		end

	set_world (a_world: like world) is
			-- Set `world' to `a_world'.
		require
			a_world_not_void: a_world /= Void
		do
			world := a_world
			projector.set_world (a_world)
		ensure
			set: world = a_world
		end
		
	set_world_border (a_border: like world_border) is
			-- Set `world_border' to `a_border'.
		require
			a_border_positive: a_border >= 0
		do
			world_border := a_border
		ensure
			set: world_border = a_border
		end
		
	set_autoscroll_border (a_border: like autoscroll_border) is
			-- Set `autoscroll_border' to `a_border'.
		require
			a_border_positive: a_border >= 0
		do
			autoscroll_border := a_border
		ensure
			set: autoscroll_border = a_border
		end

	crop is
			-- Resize Scrollbars such that world plus `world_border' plus `autoscroll_border' fits in cell.
		local
			bbox: EV_RECTANGLE
			border: INTEGER
			position: DOUBLE
			new_value: INTEGER
		do
			bbox := world.bounding_box
			
			world.hide
			border := world_border + autoscroll_border
			position := (horizontal_scrollbar.value - horizontal_scrollbar.value_range.lower) / horizontal_scrollbar.value_range.count
			check
				position_in_range: position >=0 and position <= 1.0
			end
			horizontal_scrollbar.value_range.resize_exactly (bbox.left - border, (bbox.right + border - drawing_area.width).max (bbox.left - border))
			if horizontal_scrollbar.value < horizontal_scrollbar.value_range.lower then
				horizontal_scrollbar.set_value (horizontal_scrollbar.value_range.lower)
				on_horizontal_scroll (horizontal_scrollbar.value_range.lower)
			elseif horizontal_scrollbar.value > horizontal_scrollbar.value_range.upper then
				horizontal_scrollbar.set_value (horizontal_scrollbar.value_range.upper)
				on_horizontal_scroll (horizontal_scrollbar.value_range.upper)
			else
				new_value := horizontal_scrollbar.value_range.lower + ((horizontal_scrollbar.value_range.count - 1) * position).rounded
				check
					valid_value: horizontal_scrollbar.value_range.has (new_value)
				end
				horizontal_scrollbar.set_value (new_value)
				on_horizontal_scroll (new_value)
			end
			position := (vertical_scrollbar.value - vertical_scrollbar.value_range.lower) / vertical_scrollbar.value_range.count
			check
				position_in_range: position >=0 and position <= 1.0
			end
			vertical_scrollbar.value_range.resize_exactly (bbox.top - border, (bbox.bottom + border - drawing_area.height).max (bbox.top - border))
			if vertical_scrollbar.value < vertical_scrollbar.value_range.lower then
				vertical_scrollbar.set_value (vertical_scrollbar.value_range.lower)
				on_vertical_scroll (vertical_scrollbar.value_range.lower)
			elseif vertical_scrollbar.value > vertical_scrollbar.value_range.upper then
				vertical_scrollbar.set_value (vertical_scrollbar.value_range.upper)
				on_vertical_scroll (vertical_scrollbar.value_range.upper)
			else
				new_value := vertical_scrollbar.value_range.lower + ((vertical_scrollbar.value_range.count - 1) * position).rounded
				check
					valid_value: vertical_scrollbar.value_range.has (new_value)
				end
				vertical_scrollbar.set_value (new_value)
				on_vertical_scroll (new_value)
			end
			world.show
			projector.full_project
		end
		
	cut is
			-- Resize scrollbars such that there is no overhang (crop without scrolling).
		local
			bbox: EV_RECTANGLE
			border: INTEGER
		do
			bbox := world.bounding_box
			
			border := world_border + autoscroll_border
			
			if horizontal_scrollbar.value_range.upper > bbox.right + border - drawing_area.width then
				horizontal_scrollbar.value_range.resize_exactly (horizontal_scrollbar.value_range.lower, horizontal_scrollbar.value.max (bbox.right + border - drawing_area.width))
			end
			if horizontal_scrollbar.value_range.lower < bbox.left - border then
				horizontal_scrollbar.value_range.resize_exactly (horizontal_scrollbar.value.min (bbox.left - border), horizontal_scrollbar.value_range.upper)
			end
			
			if vertical_scrollbar.value_range.upper > bbox.bottom + border - drawing_area.height then
				vertical_scrollbar.value_range.resize_exactly (vertical_scrollbar.value_range.lower, vertical_scrollbar.value.max (bbox.bottom + border - drawing_area.height))
			end
			if vertical_scrollbar.value_range.lower < bbox.top - border then
				vertical_scrollbar.value_range.resize_exactly (vertical_scrollbar.value.min (bbox.top - border), vertical_scrollbar.value_range.upper)
			end
		end
		
	fit_to_screen is
			-- Zoom world such that it fits to screen.
		local
			bbox: EV_RECTANGLE
			new_scale_factor: DOUBLE
			l_width, l_height: INTEGER
		do
			bbox := world.bounding_box
			l_width := (width - autoscroll_border - world_border)
			l_height := (height - autoscroll_border - world_border)
			if bbox.width /= 0 and then bbox.height /= 0 then
				new_scale_factor := (l_width / bbox.width).min (l_height / bbox.height)
				world.scale (new_scale_factor)
				crop
				vertical_scrollbar.set_value (vertical_scrollbar.value_range.lower + vertical_scrollbar.value_range.count // 2)
				horizontal_scrollbar.set_value (horizontal_scrollbar.value_range.lower + horizontal_scrollbar.value_range.count // 2)
				projector.full_project
			end
		end

feature {NONE} -- Implementation

	normal_timeout_interval: INTEGER is 500
		-- Normal millesecond timeout interval for autoscrolling
	
	scroll_timeout_interval: INTEGER is 50
		-- Active millesecond timeout interval for autoscrolling

	autoscroll: EV_TIMEOUT
			-- Timer limiting scrolling speed.
	
	is_scroll: BOOLEAN
			-- Is scrolling enabled?
			
	is_hand: BOOLEAN
			-- Is hand enabled?
			
	start_x, start_y: INTEGER
			-- Position of cursor when hand was activated.
	
	start_horizontal_value, start_vertical_value: INTEGER
			-- Position of scroll bars when hand was activated.
			
	on_autoscroll_time_out is
			-- Enable scroll.
		do
			if is_resize_enabled then
				cut
				resize_if_necessary
				if is_scroll then
					scroll_if_necessary
				elseif autoscroll.interval /= normal_timeout_interval then
					autoscroll.set_interval (normal_timeout_interval)
				end
				check
					world.is_show_requested
				end
				projector.project
			end
		end

	on_vertical_scroll (new_value: INTEGER) is
			-- `vertical_scrollbar' has been moved by the user.
		do
			if projector /= Void and then new_value /= projector.area_y then
				projector.change_area_position (projector.area_x, new_value)
			end
		end

	on_horizontal_scroll (new_value: INTEGER) is
			-- `horizontal_scrollbar' has been moved by the user.
		do
			if projector /= Void and then new_value /= projector.area_x then
				projector.change_area_position (new_value, projector.area_y)
			end
		end
		
	on_resizing (a_x, a_y, a_width, a_height: INTEGER) is
			-- `area' has been resized.
			-- Update scrollbars.
		do
			horizontal_scrollbar.set_leap (drawing_area.width.max (1))
			vertical_scrollbar.set_leap (drawing_area.height.max (1))
		end
		
	on_pointer_button_press_on_drawing_area (ax, ay, button: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; ascreen_x, ascreen_y: INTEGER) is
			-- Pointer button was pressed in `drawing_area'.
		do
			if button = 1 then
				if projector.is_figure_selected then	
					is_scroll := True	
				elseif not ev_application.ctrl_pressed then
					drawing_area.set_pointer_style (default_pixmaps.wait_cursor)
					drawing_area.enable_capture
					is_hand := True
					start_x := ax
					start_y := ay
					start_horizontal_value := horizontal_scrollbar.value
					start_vertical_value := vertical_scrollbar.value
				else
					is_scroll := True
				end
			end
		end
		
	on_pointer_button_move_on_drawing_area (ax, ay: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; ascreen_x, ascreen_y: INTEGER) is
			-- Pointer was moved over `drawing_area'.
		local
			offset_x, offset_y: INTEGER
		do
			if is_hand then
				offset_x := ax - start_x
				offset_y := ay - start_y
				horizontal_scrollbar.set_value ((start_horizontal_value - offset_x).max (horizontal_scrollbar.value_range.lower).min (horizontal_scrollbar.value_range.upper))
				vertical_scrollbar.set_value ((start_vertical_value - offset_y).max (vertical_scrollbar.value_range.lower).min (vertical_scrollbar.value_range.upper))
			end
		end
		
	on_pointer_button_release_on_drawing_area (ax, ay, button: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; ascreen_x, ascreen_y: INTEGER) is
			-- Pointer button was released over `drawing_area'.
		do
			is_scroll := False
			is_hand := False
			if drawing_area.has_capture then
				drawing_area.disable_capture
			end
			drawing_area.set_pointer_style (default_pixmaps.standard_cursor)
		end
		
	resize_if_necessary is
			-- Resize the scroll bars to fit in world.
		local
			bbox: EV_RECTANGLE
			top, bottom, left, right: INTEGER
			border: INTEGER
		do
			bbox := world.bounding_box
			if bbox.width /= 0 or else bbox.height /= 0 then
				border := world_border + autoscroll_border
				if bbox.left - border < horizontal_scrollbar.value_range.lower then
					left := bbox.left - border
				end
				if bbox.top - border < vertical_scrollbar.value_range.lower then
					top := bbox.top - border
				end
				if bbox.right + border - drawing_area.width > horizontal_scrollbar.value_range.upper then
					right := bbox.right + border - drawing_area.width
				end
				if bbox.bottom + border - drawing_area.height > vertical_scrollbar.value_range.upper then
					bottom := bbox.bottom + border - drawing_area.height
				end
				if left /= 0 or else right /= 0 then
					horizontal_scrollbar.value_range.resize_exactly (
							left.min (horizontal_scrollbar.value_range.lower), 
							right.max (horizontal_scrollbar.value_range.upper))
				end
				if top /= 0 or else bottom /= 0 then
					vertical_scrollbar.value_range.resize_exactly (
							top.min (vertical_scrollbar.value_range.lower), 
							bottom.max (vertical_scrollbar.value_range.upper))
				end
			end
		end

	scroll_if_necessary is
			-- Scroll if necessary. 
			-- Do nothing if not `is_autoscroll_enabled'.
		local
 			cursor_x, cursor_y, new_value: INTEGER
 			scrolled: BOOLEAN
 			da_width, da_height: INTEGER
		do	
			if is_autoscroll_enabled then
				cursor_x := pointer_position.x
				world.hide
				da_width := drawing_area.width
				da_height := drawing_area.height
				if cursor_x > da_width - autoscroll_border then
					new_value := horizontal_scrollbar.value_range.upper.min (horizontal_scrollbar.value + ((cursor_x - (da_width - autoscroll_border))*scroll_speed).truncated_to_integer)
					horizontal_scrollbar.set_value (new_value)
					scrolled := True
				end
				if cursor_x < autoscroll_border then
					new_value := (horizontal_scrollbar.value - ((autoscroll_border - cursor_x) * scroll_speed).truncated_to_integer).max (horizontal_scrollbar.value_range.lower)
					horizontal_scrollbar.set_value (new_value)
					scrolled := True
				end
				cursor_y := pointer_position.y
				if cursor_y > da_height - autoscroll_border then
					new_value := vertical_scrollbar.value_range.upper.min (vertical_scrollbar.value + ((cursor_y - (da_height - autoscroll_border)) * scroll_speed).truncated_to_integer)
					vertical_scrollbar.set_value (new_value)
					scrolled := True
				end
				if cursor_y < autoscroll_border then
					new_value := (vertical_scrollbar.value - ((autoscroll_border - cursor_y) * scroll_speed).truncated_to_integer).max (vertical_scrollbar.value_range.lower)
					vertical_scrollbar.set_value (new_value)
					scrolled := True
				end
				if scrolled then
					projector.simulate_mouse_move (cursor_x, cursor_y)
					autoscroll.set_interval (scroll_timeout_interval)
				end
				world.show
			end
		end
		
	on_mouse_wheel_on_drawing_area (i: INTEGER) is
			-- User moved mouse wheel.
		local
			step: INTEGER
		do
			if ev_application.ctrl_pressed then
				if i <= -1 then
					world.scale (1.1)
					projector.full_project
				else
					world.scale (0.9)
					projector.full_project
					crop
				end
			else
				if ev_application.shift_pressed then
					step := (horizontal_scrollbar.value_range.count * 0.1).truncated_to_integer
					if i >= 1 then
						horizontal_scrollbar.set_value ((horizontal_scrollbar.value - step).max (horizontal_scrollbar.value_range.lower))
					else
						horizontal_scrollbar.set_value ((horizontal_scrollbar.value + step).min (horizontal_scrollbar.value_range.upper))
					end
				else
					step := (vertical_scrollbar.value_range.count * 0.1).truncated_to_integer
					if i >= 1 then
						vertical_scrollbar.set_value ((vertical_scrollbar.value - step).max (vertical_scrollbar.value_range.lower))
					else
						vertical_scrollbar.set_value ((vertical_scrollbar.value + step).min (vertical_scrollbar.value_range.upper))
					end
				end
			end
		end
		
	on_key_pressed_on_drawing_area (a_key: EV_KEY) is
			-- User pressed a key. Turn on grid if shift was pressed.
		do
			if ev_application.shift_pressed then
				world.enable_grid
			end
		end
		
	on_key_released_on_drawing_area (a_key: EV_KEY) is
			-- User released key. Turn off grid.
		do
			if world.grid_enabled then
				world.disable_grid
			end
		end

invariant
	scroll_speed_positive: scroll_speed >= 0.0
	
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




end -- class EV_MODEL_WORLD_CELL

