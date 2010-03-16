note
	description: "Summary description for {NS_IMAGE_REP_API}."
	author: "Daniel Furrer <daniel.furrer@gmail.com>"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_IMAGE_REP_API

feature -- Creating an NSImageRep

	frozen image_reps_with_contents_of_file (a_filename: POINTER): POINTER
			-- + (NSArray *)imageRepsWithContentsOfFile: (NSString *) filename
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSImageRep imageRepsWithContentsOfFile: $a_filename];"
		end

	frozen image_reps_with_pasteboard (a_pasteboard: POINTER): POINTER
			-- + (NSArray *)imageRepsWithPasteboard: (NSPasteboard *) pasteboard
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSImageRep imageRepsWithPasteboard: $a_pasteboard];"
		end

	frozen image_reps_with_contents_of_url (a_url: POINTER): POINTER
			-- + (NSArray *)imageRepsWithContentsOfURL: (NSURL *) url
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSImageRep imageRepsWithContentsOfURL: $a_url];"
		end

	frozen image_rep_with_contents_of_file (a_filename: POINTER): POINTER
			-- + (id)imageRepWithContentsOfFile: (NSString *) filename
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSImageRep imageRepWithContentsOfFile: $a_filename];"
		end

	frozen image_rep_with_pasteboard (a_pasteboard: POINTER): POINTER
			-- + (id)imageRepWithPasteboard: (NSPasteboard *) pasteboard
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSImageRep imageRepWithPasteboard: $a_pasteboard];"
		end

	frozen image_rep_with_contents_of_url (a_url: POINTER): POINTER
			-- + (id)imageRepWithContentsOfURL: (NSURL *) url
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSImageRep imageRepWithContentsOfURL: $a_url];"
		end

feature -- Determining the Supported Image Types

	frozen can_init_with_data (a_data: POINTER): BOOLEAN
			-- + (BOOL)canInitWithData: (NSData *) data
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSImageRep canInitWithData: $a_data];"
		end

	frozen can_init_with_pasteboard (a_pasteboard: POINTER): BOOLEAN
			-- + (BOOL)canInitWithPasteboard: (NSPasteboard *) pasteboard
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSImageRep canInitWithPasteboard: $a_pasteboard];"
		end

	frozen image_types : POINTER
			-- + (NSArray *)imageTypes
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSImageRep imageTypes];"
		end

	frozen image_unfiltered_types : POINTER
			-- + (NSArray *)imageUnfilteredTypes
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSImageRep imageUnfilteredTypes];"
		end

	frozen image_file_types : POINTER
			-- + (NSArray *)imageFileTypes
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSImageRep imageFileTypes];"
		end

	frozen image_pasteboard_types : POINTER
			-- + (NSArray *)imagePasteboardTypes
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSImageRep imagePasteboardTypes];"
		end

	frozen image_unfiltered_file_types : POINTER
			-- + (NSArray *)imageUnfilteredFileTypes
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSImageRep imageUnfilteredFileTypes];"
		end

	frozen image_unfiltered_pasteboard_types : POINTER
			-- + (NSArray *)imageUnfilteredPasteboardTypes
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSImageRep imageUnfilteredPasteboardTypes];"
		end

feature -- Setting the Size of the Image

	frozen set_size (a_ns_image_rep: POINTER; a_size: POINTER)
			-- - (void)setSize: (NSSize) aSize
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSImageRep*)$a_ns_image_rep setSize: *(NSSize*)$a_size];"
		end

	frozen size (a_ns_image_rep: POINTER; res: POINTER)
			-- - (NSSize)size
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"NSSize size = [(NSImageRep*)$a_ns_image_rep size]; memcpy($res, &size, sizeof(NSRect));"
		end

feature -- Specifying Information About the Representation

	frozen bits_per_sample (a_ns_image_rep: POINTER): INTEGER
			-- - (NSInteger)bitsPerSample
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSImageRep*)$a_ns_image_rep bitsPerSample];"
		end

	frozen color_space_name (a_ns_image_rep: POINTER): POINTER
			-- - (NSString *)colorSpaceName
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSImageRep*)$a_ns_image_rep colorSpaceName];"
		end

	frozen has_alpha (a_ns_image_rep: POINTER): BOOLEAN
			-- - (BOOL)hasAlpha
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSImageRep*)$a_ns_image_rep hasAlpha];"
		end

	frozen is_opaque (a_ns_image_rep: POINTER): BOOLEAN
			-- - (BOOL)isOpaque
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSImageRep*)$a_ns_image_rep isOpaque];"
		end

	frozen pixels_high (a_ns_image_rep: POINTER): INTEGER
			-- - (NSInteger)pixelsHigh
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSImageRep*)$a_ns_image_rep pixelsHigh];"
		end

	frozen pixels_wide (a_ns_image_rep: POINTER): INTEGER
			-- - (NSInteger)pixelsWide
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSImageRep*)$a_ns_image_rep pixelsWide];"
		end

	frozen set_alpha (a_ns_image_rep: POINTER; a_flag: BOOLEAN)
			-- - (void)setAlpha: (BOOL) flag
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSImageRep*)$a_ns_image_rep setAlpha: $a_flag];"
		end

	frozen set_bits_per_sample (a_ns_image_rep: POINTER; a_an_int: INTEGER)
			-- - (void)setBitsPerSample: (NSInteger) anInt
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSImageRep*)$a_ns_image_rep setBitsPerSample: $a_an_int];"
		end

	frozen set_color_space_name (a_ns_image_rep: POINTER; a_string: POINTER)
			-- - (void)setColorSpaceName: (NSString *) string
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSImageRep*)$a_ns_image_rep setColorSpaceName: $a_string];"
		end

	frozen set_opaque (a_ns_image_rep: POINTER; a_flag: BOOLEAN)
			-- - (void)setOpaque: (BOOL) flag
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSImageRep*)$a_ns_image_rep setOpaque: $a_flag];"
		end

	frozen set_pixels_high (a_ns_image_rep: POINTER; a_an_int: INTEGER)
			-- - (void)setPixelsHigh: (NSInteger) anInt
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSImageRep*)$a_ns_image_rep setPixelsHigh: $a_an_int];"
		end

	frozen set_pixels_wide (a_ns_image_rep: POINTER; a_an_int: INTEGER)
			-- - (void)setPixelsWide: (NSInteger) anInt
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSImageRep*)$a_ns_image_rep setPixelsWide: $a_an_int];"
		end

feature -- Drawing the Image

	frozen draw (a_ns_image_rep: POINTER): BOOLEAN
			-- - (BOOL)draw
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSImageRep*)$a_ns_image_rep draw];"
		end

	frozen draw_at_point (a_ns_image_rep: POINTER; a_point: POINTER): BOOLEAN
			-- - (BOOL)drawAtPoint: (NSPoint) point
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSImageRep*)$a_ns_image_rep drawAtPoint: *(NSPoint*)$a_point];"
		end

	frozen draw_in_rect (a_ns_image_rep: POINTER; a_rect: POINTER): BOOLEAN
			-- - (BOOL)drawInRect: (NSRect) rect
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSImageRep*)$a_ns_image_rep drawInRect: *(NSRect*)$a_rect];"
		end

feature -- Managing NSImageRep Subclasses

	frozen image_rep_class_for_type (a_type: POINTER): POINTER
			-- + (Class)imageRepClassForType: (NSString *) type
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSImageRep imageRepClassForType: $a_type];"
		end

	frozen image_rep_class_for_data (a_data: POINTER): POINTER
			-- + (Class)imageRepClassForData: (NSData *) data
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSImageRep imageRepClassForData: $a_data];"
		end

	frozen image_rep_class_for_file_type (a_type: POINTER): POINTER
			-- + (Class)imageRepClassForFileType: (NSString *) type
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSImageRep imageRepClassForFileType: $a_type];"
		end

	frozen image_rep_class_for_pasteboard_type (a_type: POINTER): POINTER
			-- + (Class)imageRepClassForPasteboardType: (NSString *) type
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSImageRep imageRepClassForPasteboardType: $a_type];"
		end

	frozen registered_image_rep_classes : POINTER
			-- + (NSArray *)registeredImageRepClasses
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSImageRep registeredImageRepClasses];"
		end

	frozen register_image_rep_class (a_image_rep_class: POINTER)
			-- + (void)registerImageRepClass: (Class) imageRepClass
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[NSImageRep registerImageRepClass: *(Class*)$a_image_rep_class];"
		end

	frozen unregister_image_rep_class (a_image_rep_class: POINTER)
			-- + (void)unregisterImageRepClass: (Class) imageRepClass
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[NSImageRep unregisterImageRepClass: *(Class*)$a_image_rep_class];"
		end

end
