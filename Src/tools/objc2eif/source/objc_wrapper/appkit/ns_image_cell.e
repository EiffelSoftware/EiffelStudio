note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_IMAGE_CELL

inherit
	NS_CELL
		redefine
			wrapper_objc_class_name
		end

	NS_COPYING_PROTOCOL
	NS_CODING_PROTOCOL

create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_text_cell_,
	make_image_cell_,
	make

feature -- NSImageCell

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

feature {NONE} -- NSImageCell Externals

	objc_image_alignment (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSImageCell *)$an_item imageAlignment];
			 ]"
		end

	objc_set_image_alignment_ (an_item: POINTER; a_new_align: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSImageCell *)$an_item setImageAlignment:$a_new_align];
			 ]"
		end

	objc_image_scaling (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSImageCell *)$an_item imageScaling];
			 ]"
		end

	objc_set_image_scaling_ (an_item: POINTER; a_new_scaling: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSImageCell *)$an_item setImageScaling:$a_new_scaling];
			 ]"
		end

	objc_image_frame_style (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSImageCell *)$an_item imageFrameStyle];
			 ]"
		end

	objc_set_image_frame_style_ (an_item: POINTER; a_new_style: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSImageCell *)$an_item setImageFrameStyle:$a_new_style];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSImageCell"
		end

end
