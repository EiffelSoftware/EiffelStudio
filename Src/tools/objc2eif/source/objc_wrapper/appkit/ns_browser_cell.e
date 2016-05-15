note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_BROWSER_CELL

inherit
	NS_CELL
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_text_cell_,
	make_image_cell_,
	make

feature -- NSBrowserCell

	highlight_color_in_view_ (a_control_view: detachable NS_VIEW): detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_control_view__item: POINTER
		do
			if attached a_control_view as a_control_view_attached then
				a_control_view__item := a_control_view_attached.item
			end
			result_pointer := objc_highlight_color_in_view_ (item, a_control_view__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like highlight_color_in_view_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like highlight_color_in_view_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	is_leaf: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_leaf (item)
		end

	set_leaf_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_leaf_ (item, a_flag)
		end

	is_loaded: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_loaded (item)
		end

	set_loaded_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_loaded_ (item, a_flag)
		end

	reset
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_reset (item)
		end

	set
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set (item)
		end

	set_alternate_image_ (a_new_alt_image: detachable NS_IMAGE)
			-- Auto generated Objective-C wrapper.
		local
			a_new_alt_image__item: POINTER
		do
			if attached a_new_alt_image as a_new_alt_image_attached then
				a_new_alt_image__item := a_new_alt_image_attached.item
			end
			objc_set_alternate_image_ (item, a_new_alt_image__item)
		end

	alternate_image: detachable NS_IMAGE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_alternate_image (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like alternate_image} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like alternate_image} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSBrowserCell Externals

	objc_highlight_color_in_view_ (an_item: POINTER; a_control_view: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSBrowserCell *)$an_item highlightColorInView:$a_control_view];
			 ]"
		end

	objc_is_leaf (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSBrowserCell *)$an_item isLeaf];
			 ]"
		end

	objc_set_leaf_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBrowserCell *)$an_item setLeaf:$a_flag];
			 ]"
		end

	objc_is_loaded (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSBrowserCell *)$an_item isLoaded];
			 ]"
		end

	objc_set_loaded_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBrowserCell *)$an_item setLoaded:$a_flag];
			 ]"
		end

	objc_reset (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBrowserCell *)$an_item reset];
			 ]"
		end

	objc_set (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBrowserCell *)$an_item set];
			 ]"
		end

	objc_set_alternate_image_ (an_item: POINTER; a_new_alt_image: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBrowserCell *)$an_item setAlternateImage:$a_new_alt_image];
			 ]"
		end

	objc_alternate_image (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSBrowserCell *)$an_item alternateImage];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSBrowserCell"
		end

end
