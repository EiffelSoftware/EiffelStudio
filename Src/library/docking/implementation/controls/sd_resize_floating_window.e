indexing

	description: "Objects that can resize at four directions."

	date: "$Date$"

	revision: "$Revision$"



class

	SD_RESIZE_FLOATING_WINDOW



inherit

	EV_UNTITLED_DIALOG

		rename

			extend as extend_popup_window,

			full as full_popup_window	

		end

	

create

	make

	

feature {NONE} -- Initlization

	make is

			-- 

		do

			default_create

			init_resize_area

			init_resize_actions

		end

		

feature -- Command



	extend (a_item: EV_WIDGET) is

			-- 

		require

			not_full: not full

		do

			internal_hor_box.go_i_th (2)

			internal_hor_box.put_left (a_item)

		end

	

	full: BOOLEAN is

			-- 

		do

			Result := internal_hor_box.count > 2

		end

		

feature {NONE} -- Implementation for resizing.

	

	init_resize_area is

			-- 

		do

			create internal_ver_box

			extend_popup_window (internal_ver_box)

			

			-- Insert top resize bar.

			create internal_resize_bar_top

			internal_resize_bar_top.set_minimum_height (internal_resize_bar_size)

			internal_resize_bar_top.set_pointer_style (default_pixmaps.sizens_cursor)

			internal_ver_box.extend (internal_resize_bar_top)

			internal_ver_box.disable_item_expand (internal_resize_bar_top)

			

			-- Insert left and right resize bar.

			create internal_hor_box

			internal_ver_box.extend (internal_hor_box)

			

			create internal_resize_bar_left

			internal_resize_bar_left.set_minimum_width (internal_resize_bar_size)

			internal_resize_bar_left.set_pointer_style (default_pixmaps.sizewe_cursor)

			internal_hor_box.extend (internal_resize_bar_left)

			internal_hor_box.disable_item_expand (internal_resize_bar_left)

			

			create internal_resize_bar_right

			internal_resize_bar_right.set_minimum_width (internal_resize_bar_size)

			internal_resize_bar_right.set_pointer_style (default_pixmaps.sizewe_cursor)

			internal_hor_box.extend (internal_resize_bar_right)

			internal_hor_box.disable_item_expand (internal_resize_bar_right)

			

			-- Insert resize bar bottom.

			create internal_resize_bar_bottom

			internal_resize_bar_bottom.set_minimum_height (internal_resize_bar_size)

			internal_resize_bar_bottom.set_pointer_style (default_pixmaps.sizens_cursor)

			internal_ver_box.extend (internal_resize_bar_bottom)

			internal_ver_box.disable_item_expand (internal_resize_bar_bottom)

						

		end

	

	init_resize_actions is

			-- 

		do

			internal_resize_bar_top.pointer_button_press_actions.extend (agent handle_pointer_press_top)

			internal_resize_bar_bottom.pointer_button_press_actions.extend (agent handle_pointer_press_bottom)

			internal_resize_bar_left.pointer_button_press_actions.extend (agent handle_pointer_press_left)

			internal_resize_bar_right.pointer_button_press_actions.extend (agent handle_pointer_press_right)

			pointer_motion_actions.extend (agent on_pointer_motion)

			pointer_button_release_actions.extend (agent on_pointer_release)

		end

		

	internal_resize_bar_top, internal_resize_bar_bottom, internal_resize_bar_left, internal_resize_bar_right: EV_CELL

			-- Four resize areas at four sides of `Current'.

			

	internal_resize_bar_size: INTEGER is 3

			-- Resize bar size.

			

	internal_ver_box: EV_VERTICAL_BOX

			-- This container contain top resize bar and bottom resize bar and 	`internal_horizontal_box'.

			

	internal_hor_box: EV_HORIZONTAL_BOX

			-- This container contain left resize bar and right resize bar.



feature {NONE}  -- Implementation for agents.



	handle_pointer_press_top (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is

			-- 

		do

			if a_button = 1 then

				internal_pointer_pressed_top := True

				internal_orignal_position := a_screen_y

				enable_capture

			end

			debug ("larry")

				io.put_string ("%N SD_RESIZE_FLOATING_WINDOW pointer preseed")

			end

		end

	

	handle_pointer_press_bottom (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is

			-- 

		do

			if a_button = 1 then

				internal_pointer_pressed_bottom := True

				internal_orignal_position := a_screen_y

				enable_capture

			end

		end

	

	handle_pointer_press_left (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is

			-- 

		do

			if a_button = 1 then

				internal_pointer_pressed_left := True

				internal_orignal_position := a_screen_x

				enable_capture

			end

		end

		

	handle_pointer_press_right (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is

			-- 

		do

			if a_button = 1 then

				internal_pointer_pressed_right := True

				internal_orignal_position := a_screen_x

				enable_capture

			end

		end	

	

	on_pointer_motion (a_x: INTEGER; a_y: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is

			-- 

		do

			if internal_pointer_pressed_top or internal_pointer_pressed_bottom then

				if internal_pointer_pressed_top then				

					set_y_position (a_screen_y)

					set_height (height + internal_orignal_position - a_screen_y)

				end

				if internal_pointer_pressed_bottom then

					set_height (height - internal_orignal_position + a_screen_y)

				end

				internal_orignal_position := a_screen_y				

			elseif internal_pointer_pressed_left or internal_pointer_pressed_right then

				if internal_pointer_pressed_left then				

					set_x_position (a_screen_x)

					set_width (width + internal_orignal_position - a_screen_x)

				end

				if internal_pointer_pressed_right then

					set_width (width - internal_orignal_position + a_screen_x)

				end

				internal_orignal_position := a_screen_x				

			end

		end

	

	on_pointer_release (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is

			-- 

		do

			if a_button = 1 then

				disable_capture

				internal_pointer_pressed_top := False

				internal_pointer_pressed_bottom := False

				internal_pointer_pressed_left := False

				internal_pointer_pressed_right := False

			end

		end

		

	internal_orignal_position: INTEGER

	

	internal_pointer_pressed_top, internal_pointer_pressed_bottom, internal_pointer_pressed_left, internal_pointer_pressed_right: BOOLEAN

end

