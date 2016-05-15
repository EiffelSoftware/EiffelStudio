note
	description: "[
					CIRCLE_VIEW draws text around a circle using Cocoa's text system for glyph
					generation and layout.
				  ]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CIRCLE_VIEW

inherit
	NS_VIEW
		redefine
			make_with_frame_,
			draw_rect_,
			dispose
		end

	MATH_CONST
		undefine
			is_equal,
			copy
		end

	DOUBLE_MATH
		undefine
			is_equal,
			copy
		end

create
	make_with_frame_

feature {NONE} -- Initialization

	make_with_frame_ (a_frame: NS_RECT)
			-- <Precursor>
		do
			create center.make
			create text_storage.make_with_string_ ("A cup or two of hot cocoa every once in a while can provide a delicious, warm and healhty way to obtain more antioxidants.")
			create layout_manager.make
			create text_container.make

			add_objc_callback ("drawRect:", agent draw_rect_)
			add_objc_callback ("takeColorFrom:", agent take_color_from)
			add_objc_callback ("takeRadiusFrom:", agent take_radius_from)
			add_objc_callback ("takeStartingAngleFrom:", agent take_starting_angle_from)
			add_objc_callback ("takeStringFrom:", agent take_string_from)
			add_objc_callback ("toggleAnimation:", agent toggle_animation)
			add_objc_callback ("performAnimation:", agent perform_animation)
			Precursor (a_frame)
				-- First, we set default values for the various parameters.
			center.x := a_frame.size.width / 2
			center.y := a_frame.size.height / 2
			radius := 115.0
			starting_angle := Pi_2
			angular_velocity := Pi_2
				-- Next, we create and initialize instances of the three
				-- basic non-view components of the text system:
				-- a NS_TEXT_STORAGE, a NS_LAYOUT_MANAGER and an NS_TEXT_CONTAINER.
			layout_manager.add_text_container_ (text_container)
			text_storage.add_layout_manager_ (layout_manager)
				-- Screen fonts are not suitable for scaled or rotated drawing.
				-- Views that use NS_LAYOUT_MANAGER directly for text drawing should
				-- set this parameter appropriately.
			layout_manager.set_uses_screen_fonts_ (False)
		end

feature -- Removal

	dispose
			-- <Precursor>
		do
			if attached timer as attached_timer then
				attached_timer.invalidate
			end
			Precursor
		end

feature -- Drawing

	draw_rect_ (a_rect: NS_RECT)
			-- <Precursor>
		local
			glyph_index: NATURAL_64
			glyph_range: NS_RANGE
			used_rect: NS_RECT
			graphics_context_utils: NS_GRAPHICS_CONTEXT_UTILS
			line_fragment_rect: NS_RECT
			view_location, layout_location: NS_POINT
			angle, distance: REAL_64
			affine_transform_utils: NS_AFFINE_TRANSFORM_UTILS
			transform: NS_AFFINE_TRANSFORM
			app_kit_additons: NS_APP_KIT_ADDITONS_CAT
			range: NS_RANGE
			point: NS_POINT
		do
			create graphics_context_utils
			create affine_transform_utils
			create app_kit_additons
			check attached (create {NS_COLOR_UTILS}).white_color as white_color then
				white_color.set
			end
			(create {NS_BEZIER_PATH_UTILS}).fill_rect_ (bounds)
				 -- Note that used_rect_for_text_container_ does not force layout, so it must
				 -- be called after glyph_range_for_text_container_, which does force layout.
			glyph_range := layout_manager.glyph_range_for_text_container_ (text_container)
			used_rect := layout_manager.used_rect_for_text_container_ (text_container)
			from
				glyph_index := glyph_range.location
			until
				glyph_index >= glyph_range.location + glyph_range.length
			loop
				line_fragment_rect := layout_manager.line_fragment_rect_for_glyph_at_index__effective_range_ (glyph_index, default_pointer)
				view_location := layout_manager.location_for_glyph_at_index_ (glyph_index)
				layout_location := layout_manager.location_for_glyph_at_index_ (glyph_index)
				check attached affine_transform_utils.transform as l_transform then
					transform := l_transform
				end
					-- Here layout_location is the location (in container coordinates) where the glyph was laid out.
				layout_location.x := layout_location.x + line_fragment_rect.origin.x
				layout_location.y := layout_location.y + line_fragment_rect.origin.y
					-- We then use the layout_location to calculate an appropriate position for the glyph
					-- around the circle (by angle and distance, or view_location in rectangular coordinates).
				distance := radius + used_rect.size.height - layout_location.y
				angle := starting_angle + layout_location.x / distance
				view_location.x := center.x + distance * sine(angle)
				view_location.y := center.y + distance * cosine(angle)
					-- We use a different affine transform for each glyph to position and rotate it
					-- based on its calculated position around the circle.
				transform.translate_x_by__y_by_ (view_location.x, view_location.y)
				transform.rotate_by_radians_ (-angle)
					-- We save and restore the graphics state so that the transform applies only to this glyph.
				graphics_context_utils.save_graphics_state
				app_kit_additons.concat (transform)
					-- draw_glyph_for_glyph_range_ draws the glyph at its laid-out location in container coordinates.
					-- Since we are using the transform to place the glyph, we subtract the laid-out location here.
				create range.make
				range.location := glyph_index
				range.length := 1
				create point.make
				point.x := -layout_location.x
				point.y := -layout_location.y
				layout_manager.draw_glyphs_for_glyph_range__at_point_ (range, point)
				glyph_index := glyph_index + 1
				graphics_context_utils.restore_graphics_state
			end
		end

feature -- Actions

	take_color_from (sender: NS_COLOR_WELL)
			--
		do
			check attached sender.color as color then
				print ("Changing color to:" + color.red_component.out + " " + color.green_component.out + " " + color.blue_component.out + "%N")
				set_color (color)
			end
		end

	take_radius_from (sender: NS_SLIDER)
			--
		do
			print ("Changing radius to: " + sender.double_value.out + "%N")
			set_radius (sender.double_value)
		end

	take_starting_angle_from (sender: NS_SLIDER)
			--
		do
			print ("Changing starting angle to: " + sender.double_value.out + "%N")
			set_starting_angle (sender.double_value)
		end

	take_string_from (sender: NS_TEXT_FIELD)
			--
		do
			check attached sender.string_value as string_value then
			print ("Changing string to: " + string_value.to_eiffel_string + "%N")
				set_string (string_value)
			end
		end

	toggle_animation (sender: NS_BUTTON)
			--
		do
			print ("Toggling animation%N")
			if attached timer as attached_timer and then attached_timer.is_valid then
				stop_animation
			else
				start_animation
			end
		end

feature {NONE} -- Animation

	start_animation
			--
		local
			current_run_loop: NS_RUN_LOOP
			ns_modal_panel_run_loop_mode: NS_STRING
			ns_event_tracking_run_loop_mode: NS_STRING
		do
				-- We create a scheduled timer for a desired 10fps animation rate.
				-- In `perform_animation' we determine exactly how much time has
				-- elapsed and animate accordingly.
			check
				attached (create {NS_TIMER_UTILS}).scheduled_timer_with_time_interval__target__selector__user_info__repeats_ (
							1.0 / 10.0,
							Current,
							create {OBJC_SELECTOR}.make_with_name ("performAnimation:"),
							Void,
							True
						)
			as
				attached_timer
			then
				timer := attached_timer
			end
				-- In order to make sure that animation will continue to occur
				-- while modal panels are displayed and while event tracking is taking
				-- place (for example, while a slider is being dragged) we need to add
				-- the timer to the current run loop for both of the modes below.
			check attached (create {NS_RUN_LOOP_UTILS}).current_run_loop as attached_current_run_loop then
				current_run_loop := attached_current_run_loop
			end
			create ns_modal_panel_run_loop_mode.make_with_pointer_and_retain (get_ns_modal_panel_run_loop_mode)
			current_run_loop.add_timer__for_mode_ (timer, ns_modal_panel_run_loop_mode)
			create ns_event_tracking_run_loop_mode.make_with_pointer_and_retain (get_ns_event_tracking_run_loop_mode)
			current_run_loop.add_timer__for_mode_ (timer, ns_event_tracking_run_loop_mode)
			last_time := (create {NS_DATE_UTILS}).time_interval_since_reference_date
		end

	stop_animation
			--
		do
			check attached timer as attached_timer then
				attached_timer.invalidate
			end
		end

	perform_animation (a_timer: NS_TIMER)
			--
		local
			this_time: REAL_64
		do
			this_time := (create {NS_DATE_UTILS}).time_interval_since_reference_date
			set_starting_angle (starting_angle + angular_velocity * (this_time - last_time))
			last_time := this_time
		end

	get_ns_modal_panel_run_loop_mode: POINTER
			--
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[
				return NSModalPanelRunLoopMode;
			]"
		end

	get_ns_event_tracking_run_loop_mode: POINTER
			--
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[
				return NSEventTrackingRunLoopMode;
			]"
		end

feature {NONE} -- Implementation

	set_color (a_color: NS_COLOR)
			-- Change the text color to `a_color'.
		local
			ns_foreground_color_attribute_name: NS_STRING
			range: NS_RANGE
		do
				-- Text drawing uses the attributes set on the text storage rather
				-- than drawing context attributes like the current color.
			create ns_foreground_color_attribute_name.make_with_pointer_and_retain (get_ns_foreground_color_attribute_name)
			create range.make
			range.location := 0
			range.length := text_storage.length
			text_storage.add_attribute__value__range_ (ns_foreground_color_attribute_name, a_color, range)
			set_needs_display_ (True)
		end

	get_ns_foreground_color_attribute_name: POINTER
			--
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[
				return NSForegroundColorAttributeName;
			]"
		end

	set_radius (a_radius: REAL_64)
			--
		do
			radius := a_radius
			set_needs_display_ (True)
		end

	set_starting_angle (an_angle: REAL_64)
			--
		do
			starting_angle := an_angle
			set_needs_display_ (True)
		end

	set_string (a_string: NS_STRING)
			--
		local
			range: NS_RANGE
		do
			create range.make
			range.location := 0
			range.length := text_storage.length
			text_storage.replace_characters_in_range__with_string_ (range, a_string)
			set_needs_display_ (True)
		end

feature {NONE} -- Attributes

	center: NS_POINT
			--

	radius: REAL_64 assign set_radius
			--

	starting_angle: REAL_64 assign set_starting_angle
			--

	angular_velocity: REAL_64
			--

	text_storage: NS_TEXT_STORAGE
			--

	layout_manager: NS_LAYOUT_MANAGER
			--

	text_container: NS_TEXT_CONTAINER
			--

	timer: detachable NS_TIMER
			--

	last_time: REAL_64
			--

end
