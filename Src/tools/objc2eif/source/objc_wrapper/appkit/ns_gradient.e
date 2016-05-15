note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_GRADIENT

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end

	NS_COPYING_PROTOCOL
	NS_CODING_PROTOCOL

create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_starting_color__ending_color_,
	make_with_colors_,
	make

feature {NONE} -- Initialization

	make_with_starting_color__ending_color_ (a_starting_color: detachable NS_COLOR; a_ending_color: detachable NS_COLOR)
			-- Initialize `Current'.
		local
			a_starting_color__item: POINTER
			a_ending_color__item: POINTER
		do
			if attached a_starting_color as a_starting_color_attached then
				a_starting_color__item := a_starting_color_attached.item
			end
			if attached a_ending_color as a_ending_color_attached then
				a_ending_color__item := a_ending_color_attached.item
			end
			make_with_pointer (objc_init_with_starting_color__ending_color_(allocate_object, a_starting_color__item, a_ending_color__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_with_colors_ (a_color_array: detachable NS_ARRAY)
			-- Initialize `Current'.
		local
			a_color_array__item: POINTER
		do
			if attached a_color_array as a_color_array_attached then
				a_color_array__item := a_color_array_attached.item
			end
			make_with_pointer (objc_init_with_colors_(allocate_object, a_color_array__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

--	make_with_colors__at_locations__color_space_ (a_color_array: detachable NS_ARRAY; a_locations: UNSUPPORTED_TYPE; a_color_space: detachable NS_COLOR_SPACE)
--			-- Initialize `Current'.
--		local
--			a_color_array__item: POINTER
--			a_locations__item: POINTER
--			a_color_space__item: POINTER
--		do
--			if attached a_color_array as a_color_array_attached then
--				a_color_array__item := a_color_array_attached.item
--			end
--			if attached a_locations as a_locations_attached then
--				a_locations__item := a_locations_attached.item
--			end
--			if attached a_color_space as a_color_space_attached then
--				a_color_space__item := a_color_space_attached.item
--			end
--			make_with_pointer (objc_init_with_colors__at_locations__color_space_(allocate_object, a_color_array__item, a_locations__item, a_color_space__item))
--			if item = default_pointer then
--				-- TODO: handle initialization error.
--			end
--		end

feature {NONE} -- NSGradient Externals

	objc_init_with_starting_color__ending_color_ (an_item: POINTER; a_starting_color: POINTER; a_ending_color: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSGradient *)$an_item initWithStartingColor:$a_starting_color endingColor:$a_ending_color];
			 ]"
		end

	objc_init_with_colors_ (an_item: POINTER; a_color_array: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSGradient *)$an_item initWithColors:$a_color_array];
			 ]"
		end

--	objc_init_with_colors__at_locations__color_space_ (an_item: POINTER; a_color_array: POINTER; a_locations: UNSUPPORTED_TYPE; a_color_space: POINTER): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSGradient *)$an_item initWithColors:$a_color_array atLocations: colorSpace:$a_color_space];
--			 ]"
--		end

	objc_draw_from_point__to_point__options_ (an_item: POINTER; a_starting_point: POINTER; a_ending_point: POINTER; a_options: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSGradient *)$an_item drawFromPoint:*((NSPoint *)$a_starting_point) toPoint:*((NSPoint *)$a_ending_point) options:$a_options];
			 ]"
		end

	objc_draw_in_rect__angle_ (an_item: POINTER; a_rect: POINTER; a_angle: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSGradient *)$an_item drawInRect:*((NSRect *)$a_rect) angle:$a_angle];
			 ]"
		end

	objc_draw_in_bezier_path__angle_ (an_item: POINTER; a_path: POINTER; a_angle: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSGradient *)$an_item drawInBezierPath:$a_path angle:$a_angle];
			 ]"
		end

	objc_draw_from_center__radius__to_center__radius__options_ (an_item: POINTER; a_start_center: POINTER; a_start_radius: REAL_64; a_end_center: POINTER; a_end_radius: REAL_64; a_options: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSGradient *)$an_item drawFromCenter:*((NSPoint *)$a_start_center) radius:$a_start_radius toCenter:*((NSPoint *)$a_end_center) radius:$a_end_radius options:$a_options];
			 ]"
		end

	objc_draw_in_rect__relative_center_position_ (an_item: POINTER; a_rect: POINTER; a_relative_center_position: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSGradient *)$an_item drawInRect:*((NSRect *)$a_rect) relativeCenterPosition:*((NSPoint *)$a_relative_center_position)];
			 ]"
		end

	objc_draw_in_bezier_path__relative_center_position_ (an_item: POINTER; a_path: POINTER; a_relative_center_position: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSGradient *)$an_item drawInBezierPath:$a_path relativeCenterPosition:*((NSPoint *)$a_relative_center_position)];
			 ]"
		end

	objc_color_space (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSGradient *)$an_item colorSpace];
			 ]"
		end

	objc_number_of_color_stops (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSGradient *)$an_item numberOfColorStops];
			 ]"
		end

--	objc_get_color__location__at_index_ (an_item: POINTER; a_color: UNSUPPORTED_TYPE; a_location: UNSUPPORTED_TYPE; a_index: INTEGER_64)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				[(NSGradient *)$an_item getColor: location: atIndex:$a_index];
--			 ]"
--		end

	objc_interpolated_color_at_location_ (an_item: POINTER; a_location: REAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSGradient *)$an_item interpolatedColorAtLocation:$a_location];
			 ]"
		end

feature -- NSGradient

	draw_from_point__to_point__options_ (a_starting_point: NS_POINT; a_ending_point: NS_POINT; a_options: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_draw_from_point__to_point__options_ (item, a_starting_point.item, a_ending_point.item, a_options)
		end

	draw_in_rect__angle_ (a_rect: NS_RECT; a_angle: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_draw_in_rect__angle_ (item, a_rect.item, a_angle)
		end

	draw_in_bezier_path__angle_ (a_path: detachable NS_BEZIER_PATH; a_angle: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
			a_path__item: POINTER
		do
			if attached a_path as a_path_attached then
				a_path__item := a_path_attached.item
			end
			objc_draw_in_bezier_path__angle_ (item, a_path__item, a_angle)
		end

	draw_from_center__radius__to_center__radius__options_ (a_start_center: NS_POINT; a_start_radius: REAL_64; a_end_center: NS_POINT; a_end_radius: REAL_64; a_options: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_draw_from_center__radius__to_center__radius__options_ (item, a_start_center.item, a_start_radius, a_end_center.item, a_end_radius, a_options)
		end

	draw_in_rect__relative_center_position_ (a_rect: NS_RECT; a_relative_center_position: NS_POINT)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_draw_in_rect__relative_center_position_ (item, a_rect.item, a_relative_center_position.item)
		end

	draw_in_bezier_path__relative_center_position_ (a_path: detachable NS_BEZIER_PATH; a_relative_center_position: NS_POINT)
			-- Auto generated Objective-C wrapper.
		local
			a_path__item: POINTER
		do
			if attached a_path as a_path_attached then
				a_path__item := a_path_attached.item
			end
			objc_draw_in_bezier_path__relative_center_position_ (item, a_path__item, a_relative_center_position.item)
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

	number_of_color_stops: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_number_of_color_stops (item)
		end

--	get_color__location__at_index_ (a_color: UNSUPPORTED_TYPE; a_location: UNSUPPORTED_TYPE; a_index: INTEGER_64)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_color__item: POINTER
--			a_location__item: POINTER
--		do
--			if attached a_color as a_color_attached then
--				a_color__item := a_color_attached.item
--			end
--			if attached a_location as a_location_attached then
--				a_location__item := a_location_attached.item
--			end
--			objc_get_color__location__at_index_ (item, a_color__item, a_location__item, a_index)
--		end

	interpolated_color_at_location_ (a_location: REAL_64): detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_interpolated_color_at_location_ (item, a_location)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like interpolated_color_at_location_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like interpolated_color_at_location_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSGradient"
		end

end
