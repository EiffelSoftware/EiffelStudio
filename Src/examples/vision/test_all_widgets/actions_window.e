class ACTIONS_WINDOW

inherit

	FORM_D
		rename
			 make as form_d_make
		undefine
			init_toolkit
		end

	COMMAND
		rename
			execute as work
		end

	ENUMS
	WINDOWS

creation

	make

feature
	
	exit_b,
	bg_color_b,
	bg_pixmap_b,
	set_size_b,
	set_xy_b,
	destroy_b,
	hide_b,
	show_b: ACTION_WINDOW_BUTTON

	button_press_b,
	pointer_motion_b,
	button_motion_b: ACTION_WINDOW_TOGGLE_B

	make (a_name: STRING; a_parent: COMPOSITE) is
		do
			form_d_make (a_name, a_parent)
			set_widgets
			!!motion_press_command
			prompt_type:=0
		end

	set_widgets is
		do
			!!exit_b.associate (Current, b_exit, "Exit", 100, 20)
			!!button_press_b.associate (Current, b_button_press, "Button press", 20, 60)
			!!pointer_motion_b.associate (Current, b_pointer_motion, "Pointer motion", 20, 100)
			!!button_motion_b.associate (Current, b_button_motion, "Button motion", 20, 140)
			!!bg_color_b.associate (Current, b_bg_color, "Bg color", 20, 180)
			!!bg_pixmap_b.associate (Current, b_bg_pixmap, "Bg pixmap", 20, 220)
			!!set_size_b.associate (Current, b_set_size, "Set size", 180, 60)
			!!set_xy_b.associate (Current, b_set_xy, "Set x y", 180, 100)
			!!destroy_b.associate (Current, b_destroy, "Destroy", 180, 140)
			!!hide_b.associate (Current, b_hide, "Hide", 180, 180)
			!!show_b.associate (Current, b_show, "Show", 180, 220)
			widgets_insensitive:=False
			set_other_widgets
		end

	set_other_widgets is
		do
			set_size (330, 310)
		end

	finish is
		do
		end

	widgets_insensitive: BOOLEAN
	new_x_entered,
	new_width_entered: BOOLEAN

	motion_press_command: MOTION_PRESS_COMMAND

	new_x,
	new_y,
	new_width,
	new_height,
	prompt_type: INTEGER

	work (arg: INTEGER_REF) is
		local
			widget: WIDGET
			color: COLOR
			pixmap: PIXMAP
		do
			if demo_window_array.valid_index (main_window.current_demo) then
				widget:=demo_window_array.item(main_window.current_demo).main_widget
				inspect arg.item
				when b_exit then			-- exit actions window
					if button_press_b.state then
						button_press_b.set_toggle_off
						widget.remove_button_press_action( 1, motion_press_command, b_button_press)
					end
					if button_motion_b.state then
						button_motion_b.set_toggle_off
						widget.remove_button_motion_action(1, motion_press_command, b_button_motion)
					end
					if pointer_motion_b.state then
						pointer_motion_b.set_toggle_off
						widget.remove_pointer_motion_action(motion_press_command, b_pointer_motion)
					end
					if prompt_type /= 0 then
						prompt.remove_ok_action (Current, prompt_type)
						prompt.remove_cancel_action (Current, b_cancel)
						prompt.popdown
						prompt_type:=0
					end
					if widgets_insensitive then
						set_widgets_sensitive
						widgets_insensitive:=False
					end
					popdown
					finish
					main_window.finish
				when b_button_press then
					if button_press_b.state then
						widget.add_button_press_action (1, motion_press_command, b_button_press)
						if button_motion_b.state then
							widget.remove_button_motion_action(1, motion_press_command, b_button_motion)
							button_motion_b.set_toggle_off
						elseif pointer_motion_b.state then
							widget.remove_pointer_motion_action(motion_press_command, b_pointer_motion)
							pointer_motion_b.set_toggle_off
						end
					else
						widget.remove_button_press_action(1, motion_press_command, b_button_press)
					end
				when b_pointer_motion then
					if pointer_motion_b.state then
						widget.add_pointer_motion_action (motion_press_command, b_pointer_motion)
						if button_motion_b.state then
							widget.remove_button_motion_action(1, motion_press_command, b_button_motion)
							button_motion_b.set_toggle_off
						elseif button_press_b.state then
							widget.remove_button_press_action(1, motion_press_command, b_button_press)
							button_press_b.set_toggle_off
						end
					else
						widget.remove_pointer_motion_action(motion_press_command, b_pointer_motion)
					end
				when b_bg_color then
					if prompt.is_popped_up then
						prompt.remove_ok_action (Current, b_bg_color)
						prompt.remove_cancel_action (Current, b_cancel)
						!!color.make
						color.set_name(prompt.selection_text)
						widget.set_background_color(color)
						set_widgets_sensitive
						prompt.popdown
				else
						prompt.add_ok_action (Current, b_bg_color)
						prompt.add_cancel_action (Current, b_cancel)
						prompt.set_selection_label("Enter color:")
						prompt.set_selection_text ("")
						prompt_type:=b_bg_color
						set_widgets_insensitive
						prompt.popup
					end
				when b_bg_pixmap then
					if prompt.is_popped_up then
						prompt.remove_ok_action (Current, b_bg_pixmap)
						prompt.remove_cancel_action (Current, b_cancel)
						!!pixmap.make
						pixmap.read_from_file (prompt.selection_text)
						if pixmap.is_valid then
							widget.set_background_pixmap (pixmap)
						end
						set_widgets_sensitive
						prompt.popdown
					else
						prompt.add_ok_action (Current, b_bg_pixmap)
						prompt.add_cancel_action (Current, b_cancel)
						prompt.set_selection_label("Enter pixmap file:")
						prompt.set_selection_text ("")
						prompt_type:=b_bg_pixmap
						set_widgets_insensitive
						prompt.popup
					end
				when b_button_motion then
					if button_motion_b.state then
						widget.add_button_motion_action (1, motion_press_command, b_button_motion)
						if pointer_motion_b.state then
							widget.remove_pointer_motion_action(motion_press_command, b_pointer_motion)
							pointer_motion_b.set_toggle_off
						elseif button_press_b.state then
							widget.remove_button_press_action(1, motion_press_command, b_button_press)
							button_press_b.set_toggle_off
						end
					else
						widget.remove_button_motion_action(1, motion_press_command, b_button_motion)
					end
				when b_set_xy then
					if prompt.is_popped_up then
						if new_x_entered then
							new_y:=prompt.selection_text.to_integer
							prompt.remove_ok_action (Current, b_set_xy)
							prompt.remove_cancel_action (Current, b_cancel)
							widget.set_x_y( new_x, new_y)
							set_widgets_sensitive
							prompt.popdown
						else
							new_x_entered:=True
							new_x:=prompt.selection_text.to_integer
							prompt.set_selection_label("Enter new y:")
							prompt.set_selection_text("")
						end
					else
						new_x_entered:=False
						prompt.add_ok_action (Current, b_set_xy)
						prompt.add_cancel_action (Current, b_cancel)
						prompt_type:=b_set_size
						prompt.set_selection_label("Enter new x:")
						prompt.set_selection_text("")
						set_widgets_insensitive
						prompt.popup
					end
				when b_set_size then
					if prompt.is_popped_up then
						if new_width_entered then
							new_height:=prompt.selection_text.to_integer
							prompt.remove_ok_action (Current, b_set_size)
							prompt.remove_cancel_action (Current, b_cancel)
							if new_width > 0 and new_height > 0 then
								widget.set_size( new_width, new_height)
							end
							set_widgets_sensitive
							prompt.popdown
						else
							new_width_entered:=True
							new_width:=prompt.selection_text.to_integer
							prompt.set_selection_label("Enter new height:")
							prompt.set_selection_text("")
						end
					else
						new_width_entered:=False
						prompt.add_ok_action (Current, b_set_size)
						prompt.add_cancel_action (Current, b_cancel)
						prompt_type:=b_set_size
						prompt.set_selection_label("Enter new width:")
						prompt.set_selection_text("")
						set_widgets_insensitive
						prompt.popup
					end
				when b_destroy then
					widget.destroy
					set_widgets_insensitive
				when b_hide then
					widget.hide
				when b_show then
					widget.show
				when b_cancel then
					prompt.remove_ok_action(Current, prompt_type)
					prompt.remove_cancel_action (Current, b_cancel)
					prompt.popdown
					prompt_type:=0
					set_widgets_sensitive
				else
					descendant_actions(arg)
				end
			end
		end -- work
	
	descendant_actions(arg: INTEGER_REF) is
			-- the actions that belong to one particular widget
			-- (to be redefined when necessary)
		do
		end;

	set_widgets_insensitive is
		do
			widgets_insensitive:=False
			destroy_b.set_insensitive
			button_press_b.set_insensitive
			pointer_motion_b.set_insensitive
			bg_color_b.set_insensitive
			bg_pixmap_b.set_insensitive
			button_motion_b.set_insensitive
			set_size_b.set_insensitive
			set_xy_b.set_insensitive
			hide_b.set_insensitive
			show_b.set_insensitive
			set_other_widgets_insensitive
		end

	set_other_widgets_insensitive is
		do
		end

	set_widgets_sensitive is
		do
			widgets_insensitive:=False
			destroy_b.set_sensitive
			button_press_b.set_sensitive
			pointer_motion_b.set_sensitive
			bg_color_b.set_sensitive
			bg_pixmap_b.set_sensitive
			button_motion_b.set_sensitive
			set_size_b.set_sensitive
			set_xy_b.set_sensitive
			hide_b.set_sensitive
			show_b.set_sensitive
			set_other_widgets_sensitive
		end

	set_other_widgets_sensitive is
		do
		end

end -- class ACTIONS_WINDOW

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

