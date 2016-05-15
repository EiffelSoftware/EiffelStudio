note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_WINDOW

inherit
	NS_RESPONDER
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_content_rect__style_mask__backing__defer_,
	make_with_content_rect__style_mask__backing__defer__screen_,
	makeial_first_responder,
	make

feature -- NSWindow

	frame_rect_for_content_rect_ (a_content_rect: NS_RECT): NS_RECT
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_frame_rect_for_content_rect_ (item, Result.item, a_content_rect.item)
		end

	content_rect_for_frame_rect_ (a_frame_rect: NS_RECT): NS_RECT
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_content_rect_for_frame_rect_ (item, Result.item, a_frame_rect.item)
		end

	title: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_title (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like title} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like title} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_title_ (a_string: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			objc_set_title_ (item, a_string__item)
		end

	set_represented_ur_l_ (a_url: detachable NS_URL)
			-- Auto generated Objective-C wrapper.
		local
			a_url__item: POINTER
		do
			if attached a_url as a_url_attached then
				a_url__item := a_url_attached.item
			end
			objc_set_represented_ur_l_ (item, a_url__item)
		end

	represented_url: detachable NS_URL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_represented_url (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like represented_url} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like represented_url} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	represented_filename: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_represented_filename (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like represented_filename} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like represented_filename} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_represented_filename_ (a_string: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			objc_set_represented_filename_ (item, a_string__item)
		end

	set_title_with_represented_filename_ (a_filename: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_filename__item: POINTER
		do
			if attached a_filename as a_filename_attached then
				a_filename__item := a_filename_attached.item
			end
			objc_set_title_with_represented_filename_ (item, a_filename__item)
		end

	set_excluded_from_windows_menu_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_excluded_from_windows_menu_ (item, a_flag)
		end

	is_excluded_from_windows_menu: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_excluded_from_windows_menu (item)
		end

	set_content_view_ (a_view: detachable NS_VIEW)
			-- Auto generated Objective-C wrapper.
		local
			a_view__item: POINTER
		do
			if attached a_view as a_view_attached then
				a_view__item := a_view_attached.item
			end
			objc_set_content_view_ (item, a_view__item)
		end

	content_view: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_content_view (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like content_view} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like content_view} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_delegate_ (an_object: detachable NS_WINDOW_DELEGATE_PROTOCOL)
			-- Auto generated Objective-C wrapper.
		local
			an_object__item: POINTER
		do
			if attached an_object as an_object_attached then
				an_object__item := an_object_attached.item
			end
			objc_set_delegate_ (item, an_object__item)
		end

	delegate: detachable NS_WINDOW_DELEGATE_PROTOCOL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_delegate (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like delegate} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like delegate} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	window_number: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_window_number (item)
		end

	style_mask: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_style_mask (item)
		end

	set_style_mask_ (a_style_mask: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_style_mask_ (item, a_style_mask)
		end

	field_editor__for_object_ (a_create_flag: BOOLEAN; an_object: detachable NS_OBJECT): detachable NS_TEXT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			an_object__item: POINTER
		do
			if attached an_object as an_object_attached then
				an_object__item := an_object_attached.item
			end
			result_pointer := objc_field_editor__for_object_ (item, a_create_flag, an_object__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like field_editor__for_object_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like field_editor__for_object_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	end_editing_for_ (an_object: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			an_object__item: POINTER
		do
			if attached an_object as an_object_attached then
				an_object__item := an_object_attached.item
			end
			objc_end_editing_for_ (item, an_object__item)
		end

	constrain_frame_rect__to_screen_ (a_frame_rect: NS_RECT; a_screen: detachable NS_SCREEN): NS_RECT
			-- Auto generated Objective-C wrapper.
		local
			a_screen__item: POINTER
		do
			if attached a_screen as a_screen_attached then
				a_screen__item := a_screen_attached.item
			end
			create Result.make
			objc_constrain_frame_rect__to_screen_ (item, Result.item, a_frame_rect.item, a_screen__item)
		end

	set_frame__display_ (a_frame_rect: NS_RECT; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_frame__display_ (item, a_frame_rect.item, a_flag)
		end

	set_content_size_ (a_size: NS_SIZE)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_content_size_ (item, a_size.item)
		end

	set_frame_origin_ (a_point: NS_POINT)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_frame_origin_ (item, a_point.item)
		end

	set_frame_top_left_point_ (a_point: NS_POINT)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_frame_top_left_point_ (item, a_point.item)
		end

	cascade_top_left_from_point_ (a_top_left_point: NS_POINT): NS_POINT
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_cascade_top_left_from_point_ (item, Result.item, a_top_left_point.item)
		end

	frame: NS_RECT
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_frame (item, Result.item)
		end

	animation_resize_time_ (a_new_frame: NS_RECT): REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_animation_resize_time_ (item, a_new_frame.item)
		end

	set_frame__display__animate_ (a_frame_rect: NS_RECT; a_display_flag: BOOLEAN; a_animate_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_frame__display__animate_ (item, a_frame_rect.item, a_display_flag, a_animate_flag)
		end

	in_live_resize: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_in_live_resize (item)
		end

	set_shows_resize_indicator_ (a_show: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_shows_resize_indicator_ (item, a_show)
		end

	shows_resize_indicator: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_shows_resize_indicator (item)
		end

	set_resize_increments_ (a_increments: NS_SIZE)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_resize_increments_ (item, a_increments.item)
		end

	resize_increments: NS_SIZE
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_resize_increments (item, Result.item)
		end

	set_aspect_ratio_ (a_ratio: NS_SIZE)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_aspect_ratio_ (item, a_ratio.item)
		end

	aspect_ratio: NS_SIZE
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_aspect_ratio (item, Result.item)
		end

	set_content_resize_increments_ (a_increments: NS_SIZE)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_content_resize_increments_ (item, a_increments.item)
		end

	content_resize_increments: NS_SIZE
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_content_resize_increments (item, Result.item)
		end

	set_content_aspect_ratio_ (a_ratio: NS_SIZE)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_content_aspect_ratio_ (item, a_ratio.item)
		end

	content_aspect_ratio: NS_SIZE
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_content_aspect_ratio (item, Result.item)
		end

	use_optimized_drawing_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_use_optimized_drawing_ (item, a_flag)
		end

	disable_flush_window
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_disable_flush_window (item)
		end

	enable_flush_window
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_enable_flush_window (item)
		end

	is_flush_window_disabled: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_flush_window_disabled (item)
		end

	flush_window
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_flush_window (item)
		end

	flush_window_if_needed
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_flush_window_if_needed (item)
		end

	set_views_need_display_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_views_need_display_ (item, a_flag)
		end

	views_need_display: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_views_need_display (item)
		end

	display_if_needed
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_display_if_needed (item)
		end

	display
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_display (item)
		end

	set_autodisplay_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_autodisplay_ (item, a_flag)
		end

	is_autodisplay: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_autodisplay (item)
		end

	preserves_content_during_live_resize: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_preserves_content_during_live_resize (item)
		end

	set_preserves_content_during_live_resize_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_preserves_content_during_live_resize_ (item, a_flag)
		end

	update
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_update (item)
		end

	make_first_responder_ (a_responder: detachable NS_RESPONDER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_responder__item: POINTER
		do
			if attached a_responder as a_responder_attached then
				a_responder__item := a_responder_attached.item
			end
			Result := objc_make_first_responder_ (item, a_responder__item)
		end

	first_responder: detachable NS_RESPONDER
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_first_responder (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like first_responder} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like first_responder} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	resize_flags: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_resize_flags (item)
		end

	close
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_close (item)
		end

	set_released_when_closed_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_released_when_closed_ (item, a_flag)
		end

	is_released_when_closed: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_released_when_closed (item)
		end

	miniaturize_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_miniaturize_ (item, a_sender__item)
		end

	deminiaturize_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_deminiaturize_ (item, a_sender__item)
		end

	is_zoomed: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_zoomed (item)
		end

	zoom_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_zoom_ (item, a_sender__item)
		end

	is_miniaturized: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_miniaturized (item)
		end

	set_background_color_ (a_color: detachable NS_COLOR)
			-- Auto generated Objective-C wrapper.
		local
			a_color__item: POINTER
		do
			if attached a_color as a_color_attached then
				a_color__item := a_color_attached.item
			end
			objc_set_background_color_ (item, a_color__item)
		end

	background_color: detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_background_color (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like background_color} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like background_color} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_content_border_thickness__for_edge_ (a_thickness: REAL_64; a_edge: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_content_border_thickness__for_edge_ (item, a_thickness, a_edge)
		end

	content_border_thickness_for_edge_ (a_edge: NATURAL_64): REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_content_border_thickness_for_edge_ (item, a_edge)
		end

	set_autorecalculates_content_border_thickness__for_edge_ (a_flag: BOOLEAN; a_edge: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_autorecalculates_content_border_thickness__for_edge_ (item, a_flag, a_edge)
		end

	autorecalculates_content_border_thickness_for_edge_ (a_edge: NATURAL_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_autorecalculates_content_border_thickness_for_edge_ (item, a_edge)
		end

	set_movable_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_movable_ (item, a_flag)
		end

	is_movable: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_movable (item)
		end

	set_movable_by_window_background_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_movable_by_window_background_ (item, a_flag)
		end

	is_movable_by_window_background: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_movable_by_window_background (item)
		end

	set_hides_on_deactivate_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_hides_on_deactivate_ (item, a_flag)
		end

	hides_on_deactivate: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_hides_on_deactivate (item)
		end

	set_can_hide_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_can_hide_ (item, a_flag)
		end

	can_hide: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_can_hide (item)
		end

	center
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_center (item)
		end

	make_key_and_order_front_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_make_key_and_order_front_ (item, a_sender__item)
		end

	order_front_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_order_front_ (item, a_sender__item)
		end

	order_back_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_order_back_ (item, a_sender__item)
		end

	order_out_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_order_out_ (item, a_sender__item)
		end

	order_window__relative_to_ (a_place: INTEGER_64; a_other_win: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_order_window__relative_to_ (item, a_place, a_other_win)
		end

	order_front_regardless
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_order_front_regardless (item)
		end

	set_miniwindow_image_ (a_image: detachable NS_IMAGE)
			-- Auto generated Objective-C wrapper.
		local
			a_image__item: POINTER
		do
			if attached a_image as a_image_attached then
				a_image__item := a_image_attached.item
			end
			objc_set_miniwindow_image_ (item, a_image__item)
		end

	set_miniwindow_title_ (a_title: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_title__item: POINTER
		do
			if attached a_title as a_title_attached then
				a_title__item := a_title_attached.item
			end
			objc_set_miniwindow_title_ (item, a_title__item)
		end

	miniwindow_image: detachable NS_IMAGE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_miniwindow_image (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like miniwindow_image} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like miniwindow_image} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	miniwindow_title: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_miniwindow_title (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like miniwindow_title} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like miniwindow_title} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	dock_tile: detachable NS_DOCK_TILE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_dock_tile (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like dock_tile} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like dock_tile} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_document_edited_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_document_edited_ (item, a_flag)
		end

	is_document_edited: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_document_edited (item)
		end

	is_visible: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_visible (item)
		end

	is_key_window: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_key_window (item)
		end

	is_main_window: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_main_window (item)
		end

	can_become_key_window: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_can_become_key_window (item)
		end

	can_become_main_window: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_can_become_main_window (item)
		end

	make_key_window
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_make_key_window (item)
		end

	make_main_window
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_make_main_window (item)
		end

	become_key_window
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_become_key_window (item)
		end

	resign_key_window
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_resign_key_window (item)
		end

	become_main_window
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_become_main_window (item)
		end

	resign_main_window
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_resign_main_window (item)
		end

	works_when_modal: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_works_when_modal (item)
		end

	prevents_application_termination_when_modal: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_prevents_application_termination_when_modal (item)
		end

	set_prevents_application_termination_when_modal_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_prevents_application_termination_when_modal_ (item, a_flag)
		end

	convert_base_to_screen_ (a_point: NS_POINT): NS_POINT
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_convert_base_to_screen_ (item, Result.item, a_point.item)
		end

	convert_screen_to_base_ (a_point: NS_POINT): NS_POINT
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_convert_screen_to_base_ (item, Result.item, a_point.item)
		end

	perform_close_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_perform_close_ (item, a_sender__item)
		end

	perform_miniaturize_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_perform_miniaturize_ (item, a_sender__item)
		end

	perform_zoom_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_perform_zoom_ (item, a_sender__item)
		end

	g_state: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_g_state (item)
		end

	set_one_shot_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_one_shot_ (item, a_flag)
		end

	is_one_shot: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_one_shot (item)
		end

	data_with_eps_inside_rect_ (a_rect: NS_RECT): detachable NS_DATA
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_data_with_eps_inside_rect_ (item, a_rect.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like data_with_eps_inside_rect_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like data_with_eps_inside_rect_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	data_with_pdf_inside_rect_ (a_rect: NS_RECT): detachable NS_DATA
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_data_with_pdf_inside_rect_ (item, a_rect.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like data_with_pdf_inside_rect_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like data_with_pdf_inside_rect_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	print_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_print_ (item, a_sender__item)
		end

	disable_cursor_rects
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_disable_cursor_rects (item)
		end

	enable_cursor_rects
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_enable_cursor_rects (item)
		end

	discard_cursor_rects
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_discard_cursor_rects (item)
		end

	are_cursor_rects_enabled: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_are_cursor_rects_enabled (item)
		end

	invalidate_cursor_rects_for_view_ (a_view: detachable NS_VIEW)
			-- Auto generated Objective-C wrapper.
		local
			a_view__item: POINTER
		do
			if attached a_view as a_view_attached then
				a_view__item := a_view_attached.item
			end
			objc_invalidate_cursor_rects_for_view_ (item, a_view__item)
		end

	reset_cursor_rects
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_reset_cursor_rects (item)
		end

	set_allows_tool_tips_when_application_is_inactive_ (a_allow_when_inactive: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_allows_tool_tips_when_application_is_inactive_ (item, a_allow_when_inactive)
		end

	allows_tool_tips_when_application_is_inactive: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_allows_tool_tips_when_application_is_inactive (item)
		end

	set_backing_type_ (a_buffering_type: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_backing_type_ (item, a_buffering_type)
		end

	backing_type: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_backing_type (item)
		end

	set_level_ (a_new_level: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_level_ (item, a_new_level)
		end

	level: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_level (item)
		end

	set_depth_limit_ (a_limit: INTEGER_32)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_depth_limit_ (item, a_limit)
		end

	depth_limit: INTEGER_32
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_depth_limit (item)
		end

	set_dynamic_depth_limit_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_dynamic_depth_limit_ (item, a_flag)
		end

	has_dynamic_depth_limit: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_has_dynamic_depth_limit (item)
		end

	screen: detachable NS_SCREEN
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_screen (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like screen} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like screen} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	deepest_screen: detachable NS_SCREEN
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_deepest_screen (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like deepest_screen} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like deepest_screen} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	can_store_color: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_can_store_color (item)
		end

	set_has_shadow_ (a_has_shadow: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_has_shadow_ (item, a_has_shadow)
		end

	has_shadow: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_has_shadow (item)
		end

	invalidate_shadow
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_invalidate_shadow (item)
		end

	set_alpha_value_ (a_window_alpha: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_alpha_value_ (item, a_window_alpha)
		end

	alpha_value: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_alpha_value (item)
		end

	set_opaque_ (a_is_opaque: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_opaque_ (item, a_is_opaque)
		end

	is_opaque: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_opaque (item)
		end

	set_sharing_type_ (a_type: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_sharing_type_ (item, a_type)
		end

	sharing_type: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_sharing_type (item)
		end

	set_preferred_backing_location_ (a_backing_location: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_preferred_backing_location_ (item, a_backing_location)
		end

	preferred_backing_location: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_preferred_backing_location (item)
		end

	backing_location: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_backing_location (item)
		end

	allows_concurrent_view_drawing: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_allows_concurrent_view_drawing (item)
		end

	set_allows_concurrent_view_drawing_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_allows_concurrent_view_drawing_ (item, a_flag)
		end

	displays_when_screen_profile_changes: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_displays_when_screen_profile_changes (item)
		end

	set_displays_when_screen_profile_changes_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_displays_when_screen_profile_changes_ (item, a_flag)
		end

	disable_screen_updates_until_flush
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_disable_screen_updates_until_flush (item)
		end

	can_become_visible_without_login: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_can_become_visible_without_login (item)
		end

	set_can_become_visible_without_login_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_can_become_visible_without_login_ (item, a_flag)
		end

	set_collection_behavior_ (a_behavior: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_collection_behavior_ (item, a_behavior)
		end

	collection_behavior: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_collection_behavior (item)
		end

	is_on_active_space: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_on_active_space (item)
		end

	string_with_saved_frame: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_string_with_saved_frame (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like string_with_saved_frame} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like string_with_saved_frame} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_frame_from_string_ (a_string: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			objc_set_frame_from_string_ (item, a_string__item)
		end

	save_frame_using_name_ (a_name: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_name__item: POINTER
		do
			if attached a_name as a_name_attached then
				a_name__item := a_name_attached.item
			end
			objc_save_frame_using_name_ (item, a_name__item)
		end

	set_frame_using_name__force_ (a_name: detachable NS_STRING; a_force: BOOLEAN): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_name__item: POINTER
		do
			if attached a_name as a_name_attached then
				a_name__item := a_name_attached.item
			end
			Result := objc_set_frame_using_name__force_ (item, a_name__item, a_force)
		end

	set_frame_using_name_ (a_name: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_name__item: POINTER
		do
			if attached a_name as a_name_attached then
				a_name__item := a_name_attached.item
			end
			Result := objc_set_frame_using_name_ (item, a_name__item)
		end

	set_frame_autosave_name_ (a_name: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_name__item: POINTER
		do
			if attached a_name as a_name_attached then
				a_name__item := a_name_attached.item
			end
			Result := objc_set_frame_autosave_name_ (item, a_name__item)
		end

	frame_autosave_name: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_frame_autosave_name (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like frame_autosave_name} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like frame_autosave_name} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	cache_image_in_rect_ (a_rect: NS_RECT)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_cache_image_in_rect_ (item, a_rect.item)
		end

	restore_cached_image
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_restore_cached_image (item)
		end

	discard_cached_image
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_discard_cached_image (item)
		end

	min_size: NS_SIZE
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_min_size (item, Result.item)
		end

	max_size: NS_SIZE
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_max_size (item, Result.item)
		end

	set_min_size_ (a_size: NS_SIZE)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_min_size_ (item, a_size.item)
		end

	set_max_size_ (a_size: NS_SIZE)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_max_size_ (item, a_size.item)
		end

	content_min_size: NS_SIZE
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_content_min_size (item, Result.item)
		end

	content_max_size: NS_SIZE
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_content_max_size (item, Result.item)
		end

	set_content_min_size_ (a_size: NS_SIZE)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_content_min_size_ (item, a_size.item)
		end

	set_content_max_size_ (a_size: NS_SIZE)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_content_max_size_ (item, a_size.item)
		end

	next_event_matching_mask_ (a_mask: NATURAL_64): detachable NS_EVENT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_next_event_matching_mask_ (item, a_mask)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like next_event_matching_mask_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like next_event_matching_mask_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	next_event_matching_mask__until_date__in_mode__dequeue_ (a_mask: NATURAL_64; a_expiration: detachable NS_DATE; a_mode: detachable NS_STRING; a_deq_flag: BOOLEAN): detachable NS_EVENT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_expiration__item: POINTER
			a_mode__item: POINTER
		do
			if attached a_expiration as a_expiration_attached then
				a_expiration__item := a_expiration_attached.item
			end
			if attached a_mode as a_mode_attached then
				a_mode__item := a_mode_attached.item
			end
			result_pointer := objc_next_event_matching_mask__until_date__in_mode__dequeue_ (item, a_mask, a_expiration__item, a_mode__item, a_deq_flag)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like next_event_matching_mask__until_date__in_mode__dequeue_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like next_event_matching_mask__until_date__in_mode__dequeue_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	discard_events_matching_mask__before_event_ (a_mask: NATURAL_64; a_last_event: detachable NS_EVENT)
			-- Auto generated Objective-C wrapper.
		local
			a_last_event__item: POINTER
		do
			if attached a_last_event as a_last_event_attached then
				a_last_event__item := a_last_event_attached.item
			end
			objc_discard_events_matching_mask__before_event_ (item, a_mask, a_last_event__item)
		end

	post_event__at_start_ (a_event: detachable NS_EVENT; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
			a_event__item: POINTER
		do
			if attached a_event as a_event_attached then
				a_event__item := a_event_attached.item
			end
			objc_post_event__at_start_ (item, a_event__item, a_flag)
		end

	current_event: detachable NS_EVENT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_current_event (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like current_event} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like current_event} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_accepts_mouse_moved_events_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_accepts_mouse_moved_events_ (item, a_flag)
		end

	accepts_mouse_moved_events: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_accepts_mouse_moved_events (item)
		end

	set_ignores_mouse_events_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_ignores_mouse_events_ (item, a_flag)
		end

	ignores_mouse_events: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_ignores_mouse_events (item)
		end

	device_description: detachable NS_DICTIONARY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_device_description (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like device_description} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like device_description} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	send_event_ (a_the_event: detachable NS_EVENT)
			-- Auto generated Objective-C wrapper.
		local
			a_the_event__item: POINTER
		do
			if attached a_the_event as a_the_event_attached then
				a_the_event__item := a_the_event_attached.item
			end
			objc_send_event_ (item, a_the_event__item)
		end

	mouse_location_outside_of_event_stream: NS_POINT
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_mouse_location_outside_of_event_stream (item, Result.item)
		end

	window_controller: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_window_controller (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like window_controller} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like window_controller} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_window_controller_ (a_window_controller: detachable NS_WINDOW_CONTROLLER)
			-- Auto generated Objective-C wrapper.
		local
			a_window_controller__item: POINTER
		do
			if attached a_window_controller as a_window_controller_attached then
				a_window_controller__item := a_window_controller_attached.item
			end
			objc_set_window_controller_ (item, a_window_controller__item)
		end

	is_sheet: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_sheet (item)
		end

	attached_sheet: detachable NS_WINDOW
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_attached_sheet (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like attached_sheet} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like attached_sheet} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	standard_window_button_ (a_b: NATURAL_64): detachable NS_BUTTON
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_standard_window_button_ (item, a_b)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like standard_window_button_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like standard_window_button_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	add_child_window__ordered_ (a_child_win: detachable NS_WINDOW; a_place: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
			a_child_win__item: POINTER
		do
			if attached a_child_win as a_child_win_attached then
				a_child_win__item := a_child_win_attached.item
			end
			objc_add_child_window__ordered_ (item, a_child_win__item, a_place)
		end

	remove_child_window_ (a_child_win: detachable NS_WINDOW)
			-- Auto generated Objective-C wrapper.
		local
			a_child_win__item: POINTER
		do
			if attached a_child_win as a_child_win_attached then
				a_child_win__item := a_child_win_attached.item
			end
			objc_remove_child_window_ (item, a_child_win__item)
		end

	child_windows: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_child_windows (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like child_windows} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like child_windows} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	parent_window: detachable NS_WINDOW
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_parent_window (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like parent_window} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like parent_window} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_parent_window_ (a_window: detachable NS_WINDOW)
			-- Auto generated Objective-C wrapper.
		local
			a_window__item: POINTER
		do
			if attached a_window as a_window_attached then
				a_window__item := a_window_attached.item
			end
			objc_set_parent_window_ (item, a_window__item)
		end

	graphics_context: detachable NS_GRAPHICS_CONTEXT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_graphics_context (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like graphics_context} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like graphics_context} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	user_space_scale_factor: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_user_space_scale_factor (item)
		end

	set_color_space_ (a_color_space: detachable NS_COLOR_SPACE)
			-- Auto generated Objective-C wrapper.
		local
			a_color_space__item: POINTER
		do
			if attached a_color_space as a_color_space_attached then
				a_color_space__item := a_color_space_attached.item
			end
			objc_set_color_space_ (item, a_color_space__item)
		end

	color_space: detachable NS_COLOR_SPACE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_color_space (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like color_space} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like color_space} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSWindow Externals

	objc_frame_rect_for_content_rect_ (an_item: POINTER; result_pointer: POINTER; a_content_rect: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRect *)$result_pointer = [(NSWindow *)$an_item frameRectForContentRect:*((NSRect *)$a_content_rect)];
			 ]"
		end

	objc_content_rect_for_frame_rect_ (an_item: POINTER; result_pointer: POINTER; a_frame_rect: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRect *)$result_pointer = [(NSWindow *)$an_item contentRectForFrameRect:*((NSRect *)$a_frame_rect)];
			 ]"
		end

	objc_init_with_content_rect__style_mask__backing__defer_ (an_item: POINTER; a_content_rect: POINTER; a_style: NATURAL_64; a_buffering_type: NATURAL_64; a_flag: BOOLEAN): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSWindow *)$an_item initWithContentRect:*((NSRect *)$a_content_rect) styleMask:$a_style backing:$a_buffering_type defer:$a_flag];
			 ]"
		end

	objc_init_with_content_rect__style_mask__backing__defer__screen_ (an_item: POINTER; a_content_rect: POINTER; a_style: NATURAL_64; a_buffering_type: NATURAL_64; a_flag: BOOLEAN; a_screen: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSWindow *)$an_item initWithContentRect:*((NSRect *)$a_content_rect) styleMask:$a_style backing:$a_buffering_type defer:$a_flag screen:$a_screen];
			 ]"
		end

	objc_title (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSWindow *)$an_item title];
			 ]"
		end

	objc_set_title_ (an_item: POINTER; a_string: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item setTitle:$a_string];
			 ]"
		end

	objc_set_represented_ur_l_ (an_item: POINTER; a_url: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item setRepresentedURL:$a_url];
			 ]"
		end

	objc_represented_url (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSWindow *)$an_item representedURL];
			 ]"
		end

	objc_represented_filename (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSWindow *)$an_item representedFilename];
			 ]"
		end

	objc_set_represented_filename_ (an_item: POINTER; a_string: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item setRepresentedFilename:$a_string];
			 ]"
		end

	objc_set_title_with_represented_filename_ (an_item: POINTER; a_filename: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item setTitleWithRepresentedFilename:$a_filename];
			 ]"
		end

	objc_set_excluded_from_windows_menu_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item setExcludedFromWindowsMenu:$a_flag];
			 ]"
		end

	objc_is_excluded_from_windows_menu (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSWindow *)$an_item isExcludedFromWindowsMenu];
			 ]"
		end

	objc_set_content_view_ (an_item: POINTER; a_view: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item setContentView:$a_view];
			 ]"
		end

	objc_content_view (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSWindow *)$an_item contentView];
			 ]"
		end

	objc_set_delegate_ (an_item: POINTER; an_object: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item setDelegate:$an_object];
			 ]"
		end

	objc_delegate (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSWindow *)$an_item delegate];
			 ]"
		end

	objc_window_number (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSWindow *)$an_item windowNumber];
			 ]"
		end

	objc_style_mask (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSWindow *)$an_item styleMask];
			 ]"
		end

	objc_set_style_mask_ (an_item: POINTER; a_style_mask: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item setStyleMask:$a_style_mask];
			 ]"
		end

	objc_field_editor__for_object_ (an_item: POINTER; a_create_flag: BOOLEAN; an_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSWindow *)$an_item fieldEditor:$a_create_flag forObject:$an_object];
			 ]"
		end

	objc_end_editing_for_ (an_item: POINTER; an_object: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item endEditingFor:$an_object];
			 ]"
		end

	objc_constrain_frame_rect__to_screen_ (an_item: POINTER; result_pointer: POINTER; a_frame_rect: POINTER; a_screen: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRect *)$result_pointer = [(NSWindow *)$an_item constrainFrameRect:*((NSRect *)$a_frame_rect) toScreen:$a_screen];
			 ]"
		end

	objc_set_frame__display_ (an_item: POINTER; a_frame_rect: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item setFrame:*((NSRect *)$a_frame_rect) display:$a_flag];
			 ]"
		end

	objc_set_content_size_ (an_item: POINTER; a_size: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item setContentSize:*((NSSize *)$a_size)];
			 ]"
		end

	objc_set_frame_origin_ (an_item: POINTER; a_point: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item setFrameOrigin:*((NSPoint *)$a_point)];
			 ]"
		end

	objc_set_frame_top_left_point_ (an_item: POINTER; a_point: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item setFrameTopLeftPoint:*((NSPoint *)$a_point)];
			 ]"
		end

	objc_cascade_top_left_from_point_ (an_item: POINTER; result_pointer: POINTER; a_top_left_point: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSPoint *)$result_pointer = [(NSWindow *)$an_item cascadeTopLeftFromPoint:*((NSPoint *)$a_top_left_point)];
			 ]"
		end

	objc_frame (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRect *)$result_pointer = [(NSWindow *)$an_item frame];
			 ]"
		end

	objc_animation_resize_time_ (an_item: POINTER; a_new_frame: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSWindow *)$an_item animationResizeTime:*((NSRect *)$a_new_frame)];
			 ]"
		end

	objc_set_frame__display__animate_ (an_item: POINTER; a_frame_rect: POINTER; a_display_flag: BOOLEAN; a_animate_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item setFrame:*((NSRect *)$a_frame_rect) display:$a_display_flag animate:$a_animate_flag];
			 ]"
		end

	objc_in_live_resize (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSWindow *)$an_item inLiveResize];
			 ]"
		end

	objc_set_shows_resize_indicator_ (an_item: POINTER; a_show: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item setShowsResizeIndicator:$a_show];
			 ]"
		end

	objc_shows_resize_indicator (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSWindow *)$an_item showsResizeIndicator];
			 ]"
		end

	objc_set_resize_increments_ (an_item: POINTER; a_increments: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item setResizeIncrements:*((NSSize *)$a_increments)];
			 ]"
		end

	objc_resize_increments (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSSize *)$result_pointer = [(NSWindow *)$an_item resizeIncrements];
			 ]"
		end

	objc_set_aspect_ratio_ (an_item: POINTER; a_ratio: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item setAspectRatio:*((NSSize *)$a_ratio)];
			 ]"
		end

	objc_aspect_ratio (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSSize *)$result_pointer = [(NSWindow *)$an_item aspectRatio];
			 ]"
		end

	objc_set_content_resize_increments_ (an_item: POINTER; a_increments: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item setContentResizeIncrements:*((NSSize *)$a_increments)];
			 ]"
		end

	objc_content_resize_increments (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSSize *)$result_pointer = [(NSWindow *)$an_item contentResizeIncrements];
			 ]"
		end

	objc_set_content_aspect_ratio_ (an_item: POINTER; a_ratio: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item setContentAspectRatio:*((NSSize *)$a_ratio)];
			 ]"
		end

	objc_content_aspect_ratio (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSSize *)$result_pointer = [(NSWindow *)$an_item contentAspectRatio];
			 ]"
		end

	objc_use_optimized_drawing_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item useOptimizedDrawing:$a_flag];
			 ]"
		end

	objc_disable_flush_window (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item disableFlushWindow];
			 ]"
		end

	objc_enable_flush_window (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item enableFlushWindow];
			 ]"
		end

	objc_is_flush_window_disabled (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSWindow *)$an_item isFlushWindowDisabled];
			 ]"
		end

	objc_flush_window (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item flushWindow];
			 ]"
		end

	objc_flush_window_if_needed (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item flushWindowIfNeeded];
			 ]"
		end

	objc_set_views_need_display_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item setViewsNeedDisplay:$a_flag];
			 ]"
		end

	objc_views_need_display (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSWindow *)$an_item viewsNeedDisplay];
			 ]"
		end

	objc_display_if_needed (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item displayIfNeeded];
			 ]"
		end

	objc_display (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item display];
			 ]"
		end

	objc_set_autodisplay_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item setAutodisplay:$a_flag];
			 ]"
		end

	objc_is_autodisplay (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSWindow *)$an_item isAutodisplay];
			 ]"
		end

	objc_preserves_content_during_live_resize (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSWindow *)$an_item preservesContentDuringLiveResize];
			 ]"
		end

	objc_set_preserves_content_during_live_resize_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item setPreservesContentDuringLiveResize:$a_flag];
			 ]"
		end

	objc_update (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item update];
			 ]"
		end

	objc_make_first_responder_ (an_item: POINTER; a_responder: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSWindow *)$an_item makeFirstResponder:$a_responder];
			 ]"
		end

	objc_first_responder (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSWindow *)$an_item firstResponder];
			 ]"
		end

	objc_resize_flags (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSWindow *)$an_item resizeFlags];
			 ]"
		end

	objc_close (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item close];
			 ]"
		end

	objc_set_released_when_closed_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item setReleasedWhenClosed:$a_flag];
			 ]"
		end

	objc_is_released_when_closed (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSWindow *)$an_item isReleasedWhenClosed];
			 ]"
		end

	objc_miniaturize_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item miniaturize:$a_sender];
			 ]"
		end

	objc_deminiaturize_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item deminiaturize:$a_sender];
			 ]"
		end

	objc_is_zoomed (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSWindow *)$an_item isZoomed];
			 ]"
		end

	objc_zoom_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item zoom:$a_sender];
			 ]"
		end

	objc_is_miniaturized (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSWindow *)$an_item isMiniaturized];
			 ]"
		end

	objc_set_background_color_ (an_item: POINTER; a_color: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item setBackgroundColor:$a_color];
			 ]"
		end

	objc_background_color (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSWindow *)$an_item backgroundColor];
			 ]"
		end

	objc_set_content_border_thickness__for_edge_ (an_item: POINTER; a_thickness: REAL_64; a_edge: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item setContentBorderThickness:$a_thickness forEdge:$a_edge];
			 ]"
		end

	objc_content_border_thickness_for_edge_ (an_item: POINTER; a_edge: NATURAL_64): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSWindow *)$an_item contentBorderThicknessForEdge:$a_edge];
			 ]"
		end

	objc_set_autorecalculates_content_border_thickness__for_edge_ (an_item: POINTER; a_flag: BOOLEAN; a_edge: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item setAutorecalculatesContentBorderThickness:$a_flag forEdge:$a_edge];
			 ]"
		end

	objc_autorecalculates_content_border_thickness_for_edge_ (an_item: POINTER; a_edge: NATURAL_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSWindow *)$an_item autorecalculatesContentBorderThicknessForEdge:$a_edge];
			 ]"
		end

	objc_set_movable_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item setMovable:$a_flag];
			 ]"
		end

	objc_is_movable (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSWindow *)$an_item isMovable];
			 ]"
		end

	objc_set_movable_by_window_background_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item setMovableByWindowBackground:$a_flag];
			 ]"
		end

	objc_is_movable_by_window_background (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSWindow *)$an_item isMovableByWindowBackground];
			 ]"
		end

	objc_set_hides_on_deactivate_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item setHidesOnDeactivate:$a_flag];
			 ]"
		end

	objc_hides_on_deactivate (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSWindow *)$an_item hidesOnDeactivate];
			 ]"
		end

	objc_set_can_hide_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item setCanHide:$a_flag];
			 ]"
		end

	objc_can_hide (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSWindow *)$an_item canHide];
			 ]"
		end

	objc_center (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item center];
			 ]"
		end

	objc_make_key_and_order_front_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item makeKeyAndOrderFront:$a_sender];
			 ]"
		end

	objc_order_front_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item orderFront:$a_sender];
			 ]"
		end

	objc_order_back_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item orderBack:$a_sender];
			 ]"
		end

	objc_order_out_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item orderOut:$a_sender];
			 ]"
		end

	objc_order_window__relative_to_ (an_item: POINTER; a_place: INTEGER_64; a_other_win: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item orderWindow:$a_place relativeTo:$a_other_win];
			 ]"
		end

	objc_order_front_regardless (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item orderFrontRegardless];
			 ]"
		end

	objc_set_miniwindow_image_ (an_item: POINTER; a_image: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item setMiniwindowImage:$a_image];
			 ]"
		end

	objc_set_miniwindow_title_ (an_item: POINTER; a_title: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item setMiniwindowTitle:$a_title];
			 ]"
		end

	objc_miniwindow_image (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSWindow *)$an_item miniwindowImage];
			 ]"
		end

	objc_miniwindow_title (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSWindow *)$an_item miniwindowTitle];
			 ]"
		end

	objc_dock_tile (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSWindow *)$an_item dockTile];
			 ]"
		end

	objc_set_document_edited_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item setDocumentEdited:$a_flag];
			 ]"
		end

	objc_is_document_edited (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSWindow *)$an_item isDocumentEdited];
			 ]"
		end

	objc_is_visible (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSWindow *)$an_item isVisible];
			 ]"
		end

	objc_is_key_window (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSWindow *)$an_item isKeyWindow];
			 ]"
		end

	objc_is_main_window (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSWindow *)$an_item isMainWindow];
			 ]"
		end

	objc_can_become_key_window (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSWindow *)$an_item canBecomeKeyWindow];
			 ]"
		end

	objc_can_become_main_window (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSWindow *)$an_item canBecomeMainWindow];
			 ]"
		end

	objc_make_key_window (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item makeKeyWindow];
			 ]"
		end

	objc_make_main_window (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item makeMainWindow];
			 ]"
		end

	objc_become_key_window (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item becomeKeyWindow];
			 ]"
		end

	objc_resign_key_window (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item resignKeyWindow];
			 ]"
		end

	objc_become_main_window (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item becomeMainWindow];
			 ]"
		end

	objc_resign_main_window (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item resignMainWindow];
			 ]"
		end

	objc_works_when_modal (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSWindow *)$an_item worksWhenModal];
			 ]"
		end

	objc_prevents_application_termination_when_modal (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSWindow *)$an_item preventsApplicationTerminationWhenModal];
			 ]"
		end

	objc_set_prevents_application_termination_when_modal_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item setPreventsApplicationTerminationWhenModal:$a_flag];
			 ]"
		end

	objc_convert_base_to_screen_ (an_item: POINTER; result_pointer: POINTER; a_point: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSPoint *)$result_pointer = [(NSWindow *)$an_item convertBaseToScreen:*((NSPoint *)$a_point)];
			 ]"
		end

	objc_convert_screen_to_base_ (an_item: POINTER; result_pointer: POINTER; a_point: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSPoint *)$result_pointer = [(NSWindow *)$an_item convertScreenToBase:*((NSPoint *)$a_point)];
			 ]"
		end

	objc_perform_close_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item performClose:$a_sender];
			 ]"
		end

	objc_perform_miniaturize_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item performMiniaturize:$a_sender];
			 ]"
		end

	objc_perform_zoom_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item performZoom:$a_sender];
			 ]"
		end

	objc_g_state (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSWindow *)$an_item gState];
			 ]"
		end

	objc_set_one_shot_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item setOneShot:$a_flag];
			 ]"
		end

	objc_is_one_shot (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSWindow *)$an_item isOneShot];
			 ]"
		end

	objc_data_with_eps_inside_rect_ (an_item: POINTER; a_rect: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSWindow *)$an_item dataWithEPSInsideRect:*((NSRect *)$a_rect)];
			 ]"
		end

	objc_data_with_pdf_inside_rect_ (an_item: POINTER; a_rect: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSWindow *)$an_item dataWithPDFInsideRect:*((NSRect *)$a_rect)];
			 ]"
		end

	objc_print_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item print:$a_sender];
			 ]"
		end

	objc_disable_cursor_rects (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item disableCursorRects];
			 ]"
		end

	objc_enable_cursor_rects (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item enableCursorRects];
			 ]"
		end

	objc_discard_cursor_rects (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item discardCursorRects];
			 ]"
		end

	objc_are_cursor_rects_enabled (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSWindow *)$an_item areCursorRectsEnabled];
			 ]"
		end

	objc_invalidate_cursor_rects_for_view_ (an_item: POINTER; a_view: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item invalidateCursorRectsForView:$a_view];
			 ]"
		end

	objc_reset_cursor_rects (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item resetCursorRects];
			 ]"
		end

	objc_set_allows_tool_tips_when_application_is_inactive_ (an_item: POINTER; a_allow_when_inactive: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item setAllowsToolTipsWhenApplicationIsInactive:$a_allow_when_inactive];
			 ]"
		end

	objc_allows_tool_tips_when_application_is_inactive (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSWindow *)$an_item allowsToolTipsWhenApplicationIsInactive];
			 ]"
		end

	objc_set_backing_type_ (an_item: POINTER; a_buffering_type: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item setBackingType:$a_buffering_type];
			 ]"
		end

	objc_backing_type (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSWindow *)$an_item backingType];
			 ]"
		end

	objc_set_level_ (an_item: POINTER; a_new_level: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item setLevel:$a_new_level];
			 ]"
		end

	objc_level (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSWindow *)$an_item level];
			 ]"
		end

	objc_set_depth_limit_ (an_item: POINTER; a_limit: INTEGER_32)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item setDepthLimit:$a_limit];
			 ]"
		end

	objc_depth_limit (an_item: POINTER): INTEGER_32
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSWindow *)$an_item depthLimit];
			 ]"
		end

	objc_set_dynamic_depth_limit_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item setDynamicDepthLimit:$a_flag];
			 ]"
		end

	objc_has_dynamic_depth_limit (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSWindow *)$an_item hasDynamicDepthLimit];
			 ]"
		end

	objc_screen (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSWindow *)$an_item screen];
			 ]"
		end

	objc_deepest_screen (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSWindow *)$an_item deepestScreen];
			 ]"
		end

	objc_can_store_color (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSWindow *)$an_item canStoreColor];
			 ]"
		end

	objc_set_has_shadow_ (an_item: POINTER; a_has_shadow: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item setHasShadow:$a_has_shadow];
			 ]"
		end

	objc_has_shadow (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSWindow *)$an_item hasShadow];
			 ]"
		end

	objc_invalidate_shadow (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item invalidateShadow];
			 ]"
		end

	objc_set_alpha_value_ (an_item: POINTER; a_window_alpha: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item setAlphaValue:$a_window_alpha];
			 ]"
		end

	objc_alpha_value (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSWindow *)$an_item alphaValue];
			 ]"
		end

	objc_set_opaque_ (an_item: POINTER; a_is_opaque: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item setOpaque:$a_is_opaque];
			 ]"
		end

	objc_is_opaque (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSWindow *)$an_item isOpaque];
			 ]"
		end

	objc_set_sharing_type_ (an_item: POINTER; a_type: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item setSharingType:$a_type];
			 ]"
		end

	objc_sharing_type (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSWindow *)$an_item sharingType];
			 ]"
		end

	objc_set_preferred_backing_location_ (an_item: POINTER; a_backing_location: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item setPreferredBackingLocation:$a_backing_location];
			 ]"
		end

	objc_preferred_backing_location (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSWindow *)$an_item preferredBackingLocation];
			 ]"
		end

	objc_backing_location (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSWindow *)$an_item backingLocation];
			 ]"
		end

	objc_allows_concurrent_view_drawing (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSWindow *)$an_item allowsConcurrentViewDrawing];
			 ]"
		end

	objc_set_allows_concurrent_view_drawing_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item setAllowsConcurrentViewDrawing:$a_flag];
			 ]"
		end

	objc_displays_when_screen_profile_changes (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSWindow *)$an_item displaysWhenScreenProfileChanges];
			 ]"
		end

	objc_set_displays_when_screen_profile_changes_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item setDisplaysWhenScreenProfileChanges:$a_flag];
			 ]"
		end

	objc_disable_screen_updates_until_flush (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item disableScreenUpdatesUntilFlush];
			 ]"
		end

	objc_can_become_visible_without_login (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSWindow *)$an_item canBecomeVisibleWithoutLogin];
			 ]"
		end

	objc_set_can_become_visible_without_login_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item setCanBecomeVisibleWithoutLogin:$a_flag];
			 ]"
		end

	objc_set_collection_behavior_ (an_item: POINTER; a_behavior: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item setCollectionBehavior:$a_behavior];
			 ]"
		end

	objc_collection_behavior (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSWindow *)$an_item collectionBehavior];
			 ]"
		end

	objc_is_on_active_space (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSWindow *)$an_item isOnActiveSpace];
			 ]"
		end

	objc_string_with_saved_frame (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSWindow *)$an_item stringWithSavedFrame];
			 ]"
		end

	objc_set_frame_from_string_ (an_item: POINTER; a_string: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item setFrameFromString:$a_string];
			 ]"
		end

	objc_save_frame_using_name_ (an_item: POINTER; a_name: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item saveFrameUsingName:$a_name];
			 ]"
		end

	objc_set_frame_using_name__force_ (an_item: POINTER; a_name: POINTER; a_force: BOOLEAN): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSWindow *)$an_item setFrameUsingName:$a_name force:$a_force];
			 ]"
		end

	objc_set_frame_using_name_ (an_item: POINTER; a_name: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSWindow *)$an_item setFrameUsingName:$a_name];
			 ]"
		end

	objc_set_frame_autosave_name_ (an_item: POINTER; a_name: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSWindow *)$an_item setFrameAutosaveName:$a_name];
			 ]"
		end

	objc_frame_autosave_name (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSWindow *)$an_item frameAutosaveName];
			 ]"
		end

	objc_cache_image_in_rect_ (an_item: POINTER; a_rect: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item cacheImageInRect:*((NSRect *)$a_rect)];
			 ]"
		end

	objc_restore_cached_image (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item restoreCachedImage];
			 ]"
		end

	objc_discard_cached_image (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item discardCachedImage];
			 ]"
		end

	objc_min_size (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSSize *)$result_pointer = [(NSWindow *)$an_item minSize];
			 ]"
		end

	objc_max_size (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSSize *)$result_pointer = [(NSWindow *)$an_item maxSize];
			 ]"
		end

	objc_set_min_size_ (an_item: POINTER; a_size: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item setMinSize:*((NSSize *)$a_size)];
			 ]"
		end

	objc_set_max_size_ (an_item: POINTER; a_size: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item setMaxSize:*((NSSize *)$a_size)];
			 ]"
		end

	objc_content_min_size (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSSize *)$result_pointer = [(NSWindow *)$an_item contentMinSize];
			 ]"
		end

	objc_content_max_size (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSSize *)$result_pointer = [(NSWindow *)$an_item contentMaxSize];
			 ]"
		end

	objc_set_content_min_size_ (an_item: POINTER; a_size: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item setContentMinSize:*((NSSize *)$a_size)];
			 ]"
		end

	objc_set_content_max_size_ (an_item: POINTER; a_size: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item setContentMaxSize:*((NSSize *)$a_size)];
			 ]"
		end

	objc_next_event_matching_mask_ (an_item: POINTER; a_mask: NATURAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSWindow *)$an_item nextEventMatchingMask:$a_mask];
			 ]"
		end

	objc_next_event_matching_mask__until_date__in_mode__dequeue_ (an_item: POINTER; a_mask: NATURAL_64; a_expiration: POINTER; a_mode: POINTER; a_deq_flag: BOOLEAN): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSWindow *)$an_item nextEventMatchingMask:$a_mask untilDate:$a_expiration inMode:$a_mode dequeue:$a_deq_flag];
			 ]"
		end

	objc_discard_events_matching_mask__before_event_ (an_item: POINTER; a_mask: NATURAL_64; a_last_event: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item discardEventsMatchingMask:$a_mask beforeEvent:$a_last_event];
			 ]"
		end

	objc_post_event__at_start_ (an_item: POINTER; a_event: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item postEvent:$a_event atStart:$a_flag];
			 ]"
		end

	objc_current_event (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSWindow *)$an_item currentEvent];
			 ]"
		end

	objc_set_accepts_mouse_moved_events_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item setAcceptsMouseMovedEvents:$a_flag];
			 ]"
		end

	objc_accepts_mouse_moved_events (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSWindow *)$an_item acceptsMouseMovedEvents];
			 ]"
		end

	objc_set_ignores_mouse_events_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item setIgnoresMouseEvents:$a_flag];
			 ]"
		end

	objc_ignores_mouse_events (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSWindow *)$an_item ignoresMouseEvents];
			 ]"
		end

	objc_device_description (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSWindow *)$an_item deviceDescription];
			 ]"
		end

	objc_send_event_ (an_item: POINTER; a_the_event: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item sendEvent:$a_the_event];
			 ]"
		end

	objc_mouse_location_outside_of_event_stream (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSPoint *)$result_pointer = [(NSWindow *)$an_item mouseLocationOutsideOfEventStream];
			 ]"
		end

	objc_window_controller (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSWindow *)$an_item windowController];
			 ]"
		end

	objc_set_window_controller_ (an_item: POINTER; a_window_controller: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item setWindowController:$a_window_controller];
			 ]"
		end

	objc_is_sheet (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSWindow *)$an_item isSheet];
			 ]"
		end

	objc_attached_sheet (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSWindow *)$an_item attachedSheet];
			 ]"
		end

	objc_standard_window_button_ (an_item: POINTER; a_b: NATURAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSWindow *)$an_item standardWindowButton:$a_b];
			 ]"
		end

	objc_add_child_window__ordered_ (an_item: POINTER; a_child_win: POINTER; a_place: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item addChildWindow:$a_child_win ordered:$a_place];
			 ]"
		end

	objc_remove_child_window_ (an_item: POINTER; a_child_win: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item removeChildWindow:$a_child_win];
			 ]"
		end

	objc_child_windows (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSWindow *)$an_item childWindows];
			 ]"
		end

	objc_parent_window (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSWindow *)$an_item parentWindow];
			 ]"
		end

	objc_set_parent_window_ (an_item: POINTER; a_window: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item setParentWindow:$a_window];
			 ]"
		end

	objc_graphics_context (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSWindow *)$an_item graphicsContext];
			 ]"
		end

	objc_user_space_scale_factor (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSWindow *)$an_item userSpaceScaleFactor];
			 ]"
		end

	objc_set_color_space_ (an_item: POINTER; a_color_space: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item setColorSpace:$a_color_space];
			 ]"
		end

	objc_color_space (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSWindow *)$an_item colorSpace];
			 ]"
		end

feature {NONE} -- Initialization

	make_with_content_rect__style_mask__backing__defer_ (a_content_rect: NS_RECT; a_style: NATURAL_64; a_buffering_type: NATURAL_64; a_flag: BOOLEAN)
			-- Initialize `Current'.
		local
		do
			make_with_pointer (objc_init_with_content_rect__style_mask__backing__defer_(allocate_object, a_content_rect.item, a_style, a_buffering_type, a_flag))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_with_content_rect__style_mask__backing__defer__screen_ (a_content_rect: NS_RECT; a_style: NATURAL_64; a_buffering_type: NATURAL_64; a_flag: BOOLEAN; a_screen: detachable NS_SCREEN)
			-- Initialize `Current'.
		local
			a_screen__item: POINTER
		do
			if attached a_screen as a_screen_attached then
				a_screen__item := a_screen_attached.item
			end
			make_with_pointer (objc_init_with_content_rect__style_mask__backing__defer__screen_(allocate_object, a_content_rect.item, a_style, a_buffering_type, a_flag, a_screen__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	makeial_first_responder
			-- Initialize `Current'.
		local
		do
			make_with_pointer (objc_initial_first_responder(allocate_object))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

--	make_with_window_ref_ (a_window_ref: UNSUPPORTED_TYPE)
--			-- Initialize `Current'.
--		local
--			a_window_ref__item: POINTER
--		do
--			if attached a_window_ref as a_window_ref_attached then
--				a_window_ref__item := a_window_ref_attached.item
--			end
--			make_with_pointer (objc_init_with_window_ref_(allocate_object, a_window_ref__item))
--			if item = default_pointer then
--				-- TODO: handle initialization error.
--			end
--		end

feature -- NSKeyboardUI

	set_initial_first_responder_ (a_view: detachable NS_VIEW)
			-- Auto generated Objective-C wrapper.
		local
			a_view__item: POINTER
		do
			if attached a_view as a_view_attached then
				a_view__item := a_view_attached.item
			end
			objc_set_initial_first_responder_ (item, a_view__item)
		end

	select_next_key_view_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_select_next_key_view_ (item, a_sender__item)
		end

	select_previous_key_view_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_select_previous_key_view_ (item, a_sender__item)
		end

	select_key_view_following_view_ (a_view: detachable NS_VIEW)
			-- Auto generated Objective-C wrapper.
		local
			a_view__item: POINTER
		do
			if attached a_view as a_view_attached then
				a_view__item := a_view_attached.item
			end
			objc_select_key_view_following_view_ (item, a_view__item)
		end

	select_key_view_preceding_view_ (a_view: detachable NS_VIEW)
			-- Auto generated Objective-C wrapper.
		local
			a_view__item: POINTER
		do
			if attached a_view as a_view_attached then
				a_view__item := a_view_attached.item
			end
			objc_select_key_view_preceding_view_ (item, a_view__item)
		end

	key_view_selection_direction: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_key_view_selection_direction (item)
		end

	set_default_button_cell_ (a_def_butt: detachable NS_BUTTON_CELL)
			-- Auto generated Objective-C wrapper.
		local
			a_def_butt__item: POINTER
		do
			if attached a_def_butt as a_def_butt_attached then
				a_def_butt__item := a_def_butt_attached.item
			end
			objc_set_default_button_cell_ (item, a_def_butt__item)
		end

	default_button_cell: detachable NS_BUTTON_CELL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_default_button_cell (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like default_button_cell} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like default_button_cell} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	disable_key_equivalent_for_default_button_cell
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_disable_key_equivalent_for_default_button_cell (item)
		end

	enable_key_equivalent_for_default_button_cell
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_enable_key_equivalent_for_default_button_cell (item)
		end

	set_autorecalculates_key_view_loop_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_autorecalculates_key_view_loop_ (item, a_flag)
		end

	autorecalculates_key_view_loop: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_autorecalculates_key_view_loop (item)
		end

	recalculate_key_view_loop
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_recalculate_key_view_loop (item)
		end

feature {NONE} -- NSKeyboardUI Externals

	objc_set_initial_first_responder_ (an_item: POINTER; a_view: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item setInitialFirstResponder:$a_view];
			 ]"
		end

	objc_initial_first_responder (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSWindow *)$an_item initialFirstResponder];
			 ]"
		end

	objc_select_next_key_view_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item selectNextKeyView:$a_sender];
			 ]"
		end

	objc_select_previous_key_view_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item selectPreviousKeyView:$a_sender];
			 ]"
		end

	objc_select_key_view_following_view_ (an_item: POINTER; a_view: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item selectKeyViewFollowingView:$a_view];
			 ]"
		end

	objc_select_key_view_preceding_view_ (an_item: POINTER; a_view: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item selectKeyViewPrecedingView:$a_view];
			 ]"
		end

	objc_key_view_selection_direction (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSWindow *)$an_item keyViewSelectionDirection];
			 ]"
		end

	objc_set_default_button_cell_ (an_item: POINTER; a_def_butt: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item setDefaultButtonCell:$a_def_butt];
			 ]"
		end

	objc_default_button_cell (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSWindow *)$an_item defaultButtonCell];
			 ]"
		end

	objc_disable_key_equivalent_for_default_button_cell (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item disableKeyEquivalentForDefaultButtonCell];
			 ]"
		end

	objc_enable_key_equivalent_for_default_button_cell (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item enableKeyEquivalentForDefaultButtonCell];
			 ]"
		end

	objc_set_autorecalculates_key_view_loop_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item setAutorecalculatesKeyViewLoop:$a_flag];
			 ]"
		end

	objc_autorecalculates_key_view_loop (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSWindow *)$an_item autorecalculatesKeyViewLoop];
			 ]"
		end

	objc_recalculate_key_view_loop (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item recalculateKeyViewLoop];
			 ]"
		end

feature -- NSToolbarSupport

	set_toolbar_ (a_toolbar: detachable NS_TOOLBAR)
			-- Auto generated Objective-C wrapper.
		local
			a_toolbar__item: POINTER
		do
			if attached a_toolbar as a_toolbar_attached then
				a_toolbar__item := a_toolbar_attached.item
			end
			objc_set_toolbar_ (item, a_toolbar__item)
		end

	toolbar: detachable NS_TOOLBAR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_toolbar (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like toolbar} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like toolbar} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	toggle_toolbar_shown_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_toggle_toolbar_shown_ (item, a_sender__item)
		end

	run_toolbar_customization_palette_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_run_toolbar_customization_palette_ (item, a_sender__item)
		end

	set_shows_toolbar_button_ (a_show: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_shows_toolbar_button_ (item, a_show)
		end

	shows_toolbar_button: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_shows_toolbar_button (item)
		end

feature {NONE} -- NSToolbarSupport Externals

	objc_set_toolbar_ (an_item: POINTER; a_toolbar: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item setToolbar:$a_toolbar];
			 ]"
		end

	objc_toolbar (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSWindow *)$an_item toolbar];
			 ]"
		end

	objc_toggle_toolbar_shown_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item toggleToolbarShown:$a_sender];
			 ]"
		end

	objc_run_toolbar_customization_palette_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item runToolbarCustomizationPalette:$a_sender];
			 ]"
		end

	objc_set_shows_toolbar_button_ (an_item: POINTER; a_show: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item setShowsToolbarButton:$a_show];
			 ]"
		end

	objc_shows_toolbar_button (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSWindow *)$an_item showsToolbarButton];
			 ]"
		end

feature -- NSDrag

	drag_image__at__offset__event__pasteboard__source__slide_back_ (an_image: detachable NS_IMAGE; a_base_location: NS_POINT; a_initial_offset: NS_SIZE; a_event: detachable NS_EVENT; a_pboard: detachable NS_PASTEBOARD; a_source_obj: detachable NS_OBJECT; a_slide_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
			an_image__item: POINTER
			a_event__item: POINTER
			a_pboard__item: POINTER
			a_source_obj__item: POINTER
		do
			if attached an_image as an_image_attached then
				an_image__item := an_image_attached.item
			end
			if attached a_event as a_event_attached then
				a_event__item := a_event_attached.item
			end
			if attached a_pboard as a_pboard_attached then
				a_pboard__item := a_pboard_attached.item
			end
			if attached a_source_obj as a_source_obj_attached then
				a_source_obj__item := a_source_obj_attached.item
			end
			objc_drag_image__at__offset__event__pasteboard__source__slide_back_ (item, an_image__item, a_base_location.item, a_initial_offset.item, a_event__item, a_pboard__item, a_source_obj__item, a_slide_flag)
		end

	register_for_dragged_types_ (a_new_types: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_new_types__item: POINTER
		do
			if attached a_new_types as a_new_types_attached then
				a_new_types__item := a_new_types_attached.item
			end
			objc_register_for_dragged_types_ (item, a_new_types__item)
		end

	unregister_dragged_types
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_unregister_dragged_types (item)
		end

feature {NONE} -- NSDrag Externals

	objc_drag_image__at__offset__event__pasteboard__source__slide_back_ (an_item: POINTER; an_image: POINTER; a_base_location: POINTER; a_initial_offset: POINTER; a_event: POINTER; a_pboard: POINTER; a_source_obj: POINTER; a_slide_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item dragImage:$an_image at:*((NSPoint *)$a_base_location) offset:*((NSSize *)$a_initial_offset) event:$a_event pasteboard:$a_pboard source:$a_source_obj slideBack:$a_slide_flag];
			 ]"
		end

	objc_register_for_dragged_types_ (an_item: POINTER; a_new_types: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item registerForDraggedTypes:$a_new_types];
			 ]"
		end

	objc_unregister_dragged_types (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item unregisterDraggedTypes];
			 ]"
		end

feature {NONE} -- NSCarbonExtensions Externals

--	objc_init_with_window_ref_ (an_item: POINTER; a_window_ref: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSWindow *)$an_item initWithWindowRef:];
--			 ]"
--		end

--	objc_window_ref (an_item: POINTER): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSWindow *)$an_item windowRef];
--			 ]"
--		end

feature -- NSCarbonExtensions

--	window_ref: UNSUPPORTED_TYPE
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--		do
--			result_pointer := objc_window_ref (item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like window_ref} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like window_ref} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

feature -- Drawers

	drawers: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_drawers (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like drawers} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like drawers} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- Drawers Externals

	objc_drawers (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSWindow *)$an_item drawers];
			 ]"
		end

feature -- NSScripting

	has_close_box: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_has_close_box (item)
		end

	has_title_bar: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_has_title_bar (item)
		end

	is_floating_panel: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_floating_panel (item)
		end

	is_miniaturizable: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_miniaturizable (item)
		end

	is_modal_panel: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_modal_panel (item)
		end

	is_resizable: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_resizable (item)
		end

	is_zoomable: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_zoomable (item)
		end

	ordered_index: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_ordered_index (item)
		end

	set_is_miniaturized_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_is_miniaturized_ (item, a_flag)
		end

	set_is_visible_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_is_visible_ (item, a_flag)
		end

	set_is_zoomed_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_is_zoomed_ (item, a_flag)
		end

	set_ordered_index_ (a_index: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_ordered_index_ (item, a_index)
		end

	handle_close_script_command_ (a_command: detachable NS_CLOSE_COMMAND): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_command__item: POINTER
		do
			if attached a_command as a_command_attached then
				a_command__item := a_command_attached.item
			end
			result_pointer := objc_handle_close_script_command_ (item, a_command__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like handle_close_script_command_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like handle_close_script_command_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	handle_print_script_command_ (a_command: detachable NS_SCRIPT_COMMAND): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_command__item: POINTER
		do
			if attached a_command as a_command_attached then
				a_command__item := a_command_attached.item
			end
			result_pointer := objc_handle_print_script_command_ (item, a_command__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like handle_print_script_command_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like handle_print_script_command_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	handle_save_script_command_ (a_command: detachable NS_SCRIPT_COMMAND): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_command__item: POINTER
		do
			if attached a_command as a_command_attached then
				a_command__item := a_command_attached.item
			end
			result_pointer := objc_handle_save_script_command_ (item, a_command__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like handle_save_script_command_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like handle_save_script_command_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSScripting Externals

	objc_has_close_box (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSWindow *)$an_item hasCloseBox];
			 ]"
		end

	objc_has_title_bar (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSWindow *)$an_item hasTitleBar];
			 ]"
		end

	objc_is_floating_panel (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSWindow *)$an_item isFloatingPanel];
			 ]"
		end

	objc_is_miniaturizable (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSWindow *)$an_item isMiniaturizable];
			 ]"
		end

	objc_is_modal_panel (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSWindow *)$an_item isModalPanel];
			 ]"
		end

	objc_is_resizable (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSWindow *)$an_item isResizable];
			 ]"
		end

	objc_is_zoomable (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSWindow *)$an_item isZoomable];
			 ]"
		end

	objc_ordered_index (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSWindow *)$an_item orderedIndex];
			 ]"
		end

	objc_set_is_miniaturized_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item setIsMiniaturized:$a_flag];
			 ]"
		end

	objc_set_is_visible_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item setIsVisible:$a_flag];
			 ]"
		end

	objc_set_is_zoomed_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item setIsZoomed:$a_flag];
			 ]"
		end

	objc_set_ordered_index_ (an_item: POINTER; a_index: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindow *)$an_item setOrderedIndex:$a_index];
			 ]"
		end

	objc_handle_close_script_command_ (an_item: POINTER; a_command: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSWindow *)$an_item handleCloseScriptCommand:$a_command];
			 ]"
		end

	objc_handle_print_script_command_ (an_item: POINTER; a_command: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSWindow *)$an_item handlePrintScriptCommand:$a_command];
			 ]"
		end

	objc_handle_save_script_command_ (an_item: POINTER; a_command: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSWindow *)$an_item handleSaveScriptCommand:$a_command];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSWindow"
		end

end
