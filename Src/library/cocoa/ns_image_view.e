note
	description: "Wrapper for NSImageView."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_IMAGE_VIEW

inherit
	NS_CONTROL
		redefine
			make
		end

create
	make

feature {NONE} -- Creation

	make
		do
			make_shared (image_view_new)
		end

feature -- Access

	set_image (a_image: NS_IMAGE)
		do
			image_view_set_image (item, a_image.item)
		end

	set_image_scaling (a_image_scaling: INTEGER)
		do
			image_view_set_image_scaling (item, a_image_scaling)
		end

feature {NONE} -- Objective-C implementation

	frozen image_view_new: POINTER
			-- Create a new NSWindow
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSImageView new];"
		end

--- (NSImage *)image;
	frozen image_view_set_image (a_image_view: POINTER; a_image: POINTER)
			--- (void)setImage:(NSImage *)newImage;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSImageView*) $a_image_view setImage: $a_image];"
		end

--- (NSImageAlignment)imageAlignment;
--- (void)setImageAlignment:(NSImageAlignment)newAlign;
--- (NSImageScaling)imageScaling;
	frozen image_view_set_image_scaling (a_image_view: POINTER; a_image_scaling: INTEGER)
			--- (void)setImageScaling:(NSImageScaling)newScaling;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSImageView*) $a_image_view setImageScaling: $a_image_scaling];"
		end
--- (NSImageFrameStyle)imageFrameStyle;
--- (void)setImageFrameStyle:(NSImageFrameStyle)newStyle;
--- (void)setEditable:(BOOL)yn;
--- (BOOL)isEditable;

--- (void)setAnimates:(BOOL)flag;
--- (BOOL)animates;

--- (BOOL)allowsCutCopyPaste;
--- (void)setAllowsCutCopyPaste:(BOOL)allow;

feature -- NSImageAlignment Constants
--    NSImageAlignCenter = 0,
--    NSImageAlignTop,
--    NSImageAlignTopLeft,
--    NSImageAlignTopRight,
--    NSImageAlignLeft,
--    NSImageAlignBottom,
--    NSImageAlignBottomLeft,
--    NSImageAlignBottomRight,
--    NSImageAlignRight

feature -- NSImageFrameStyle Constants
--    NSImageFrameNone = 0,
--    NSImageFramePhoto,
--    NSImageFrameGrayBezel,
--    NSImageFrameGroove,
--    NSImageFrameButton

feature -- Scaling Constantss

	frozen image_scaling_none: INTEGER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return NSImageScaleNone;"
		end
end
