note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_SCREEN

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make

feature -- NSScreen

	depth: INTEGER_32
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_depth (item)
		end

	frame: NS_RECT
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_frame (item, Result.item)
		end

	visible_frame: NS_RECT
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_visible_frame (item, Result.item)
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

--	supported_window_depths: UNSUPPORTED_TYPE
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--		do
--			result_pointer := objc_supported_window_depths (item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like supported_window_depths} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like supported_window_depths} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

	user_space_scale_factor: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_user_space_scale_factor (item)
		end

feature {NONE} -- NSScreen Externals

	objc_depth (an_item: POINTER): INTEGER_32
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSScreen *)$an_item depth];
			 ]"
		end

	objc_frame (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRect *)$result_pointer = [(NSScreen *)$an_item frame];
			 ]"
		end

	objc_visible_frame (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRect *)$result_pointer = [(NSScreen *)$an_item visibleFrame];
			 ]"
		end

	objc_device_description (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSScreen *)$an_item deviceDescription];
			 ]"
		end

	objc_color_space (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSScreen *)$an_item colorSpace];
			 ]"
		end

--	objc_supported_window_depths (an_item: POINTER): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSScreen *)$an_item supportedWindowDepths];
--			 ]"
--		end

	objc_user_space_scale_factor (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSScreen *)$an_item userSpaceScaleFactor];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSScreen"
		end

end
