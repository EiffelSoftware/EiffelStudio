note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_IMAGE_VIEW

inherit
	NS_CONTROL
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_frame_,
	make

feature -- NSImageView

	image: detachable NS_IMAGE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_image (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like image} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like image} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_image_ (a_new_image: detachable NS_IMAGE)
			-- Auto generated Objective-C wrapper.
		local
			a_new_image__item: POINTER
		do
			if attached a_new_image as a_new_image_attached then
				a_new_image__item := a_new_image_attached.item
			end
			objc_set_image_ (item, a_new_image__item)
		end

	image_alignment: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_image_alignment (item)
		end

	set_image_alignment_ (a_new_align: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_image_alignment_ (item, a_new_align)
		end

	image_scaling: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_image_scaling (item)
		end

	set_image_scaling_ (a_new_scaling: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_image_scaling_ (item, a_new_scaling)
		end

	image_frame_style: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_image_frame_style (item)
		end

	set_image_frame_style_ (a_new_style: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_image_frame_style_ (item, a_new_style)
		end

	set_editable_ (a_yn: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_editable_ (item, a_yn)
		end

	is_editable: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_editable (item)
		end

	set_animates_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_animates_ (item, a_flag)
		end

	animates: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_animates (item)
		end

	allows_cut_copy_paste: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_allows_cut_copy_paste (item)
		end

	set_allows_cut_copy_paste_ (a_allow: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_allows_cut_copy_paste_ (item, a_allow)
		end

feature {NONE} -- NSImageView Externals

	objc_image (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSImageView *)$an_item image];
			 ]"
		end

	objc_set_image_ (an_item: POINTER; a_new_image: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSImageView *)$an_item setImage:$a_new_image];
			 ]"
		end

	objc_image_alignment (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSImageView *)$an_item imageAlignment];
			 ]"
		end

	objc_set_image_alignment_ (an_item: POINTER; a_new_align: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSImageView *)$an_item setImageAlignment:$a_new_align];
			 ]"
		end

	objc_image_scaling (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSImageView *)$an_item imageScaling];
			 ]"
		end

	objc_set_image_scaling_ (an_item: POINTER; a_new_scaling: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSImageView *)$an_item setImageScaling:$a_new_scaling];
			 ]"
		end

	objc_image_frame_style (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSImageView *)$an_item imageFrameStyle];
			 ]"
		end

	objc_set_image_frame_style_ (an_item: POINTER; a_new_style: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSImageView *)$an_item setImageFrameStyle:$a_new_style];
			 ]"
		end

	objc_set_editable_ (an_item: POINTER; a_yn: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSImageView *)$an_item setEditable:$a_yn];
			 ]"
		end

	objc_is_editable (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSImageView *)$an_item isEditable];
			 ]"
		end

	objc_set_animates_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSImageView *)$an_item setAnimates:$a_flag];
			 ]"
		end

	objc_animates (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSImageView *)$an_item animates];
			 ]"
		end

	objc_allows_cut_copy_paste (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSImageView *)$an_item allowsCutCopyPaste];
			 ]"
		end

	objc_set_allows_cut_copy_paste_ (an_item: POINTER; a_allow: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSImageView *)$an_item setAllowsCutCopyPaste:$a_allow];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSImageView"
		end

end
