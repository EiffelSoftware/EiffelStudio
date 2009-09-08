note
	description: "Summary description for {NS_IMAGE_API}."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_IMAGE_API

feature -- Initializing a New NSImage Object

	frozen alloc: POINTER
			-- + (id)alloc
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSImage alloc];"
		end

	frozen init_by_referencing_file (a_ns_image: POINTER; a_file_name: POINTER): POINTER
			-- - (id)initByReferencingFile: (NSString *) fileName
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSImage*)$a_ns_image initByReferencingFile: $a_file_name];"
		end

	frozen init_by_referencing_url (a_ns_image: POINTER; a_url: POINTER): POINTER
			-- - (id)initByReferencingURL: (NSURL *) url
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSImage*)$a_ns_image initByReferencingURL: $a_url];"
		end

	frozen init_with_contents_of_file (a_ns_image: POINTER; a_file_name: POINTER): POINTER
			-- - (id)initWithContentsOfFile: (NSString *) fileName
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSImage*)$a_ns_image initWithContentsOfFile: $a_file_name];"
		end

	frozen init_with_contents_of_url (a_ns_image: POINTER; a_url: POINTER): POINTER
			-- - (id)initWithContentsOfURL: (NSURL *) url
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSImage*)$a_ns_image initWithContentsOfURL: $a_url];"
		end

	frozen init_with_data (a_ns_image: POINTER; a_data: POINTER): POINTER
			-- - (id)initWithData: (NSData *) data
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSImage*)$a_ns_image initWithData: $a_data];"
		end

	frozen init_with_pasteboard (a_ns_image: POINTER; a_pasteboard: POINTER): POINTER
			-- - (id)initWithPasteboard: (NSPasteboard *) pasteboard
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSImage*)$a_ns_image initWithPasteboard: $a_pasteboard];"
		end

	frozen init_with_size (a_ns_image: POINTER; a_size: POINTER): POINTER
			-- - (id)initWithSize: (NSSize) aSize
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSImage*)$a_ns_image initWithSize: *(NSSize*)$a_size];"
		end

	frozen init_with_icon_ref (a_ns_image: POINTER; a_icon_ref: POINTER): POINTER
			-- - (id)initWithIconRef: (IconRef) iconRef
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSImage*)$a_ns_image initWithIconRef: *(IconRef*)$a_icon_ref];"
		end

feature -- Setting the Image Attributes

	frozen set_size (a_ns_image: POINTER; a_size: POINTER)
			-- - (void)setSize: (NSSize) aSize
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSImage*)$a_ns_image setSize: *(NSSize*)$a_size];"
		end

	frozen size (a_ns_image: POINTER; res: POINTER)
			-- - (NSSize)size
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"NSSize size = [(NSImage*)$a_ns_image size]; memcpy($res, &size, sizeof(NSSize));"
		end

	frozen is_template (a_ns_image: POINTER): BOOLEAN
			-- - (BOOL)isTemplate
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSImage*)$a_ns_image isTemplate];"
		end

	frozen set_template (a_ns_image: POINTER; a_is_template: BOOLEAN)
			-- - (void)setTemplate: (BOOL) isTemplate
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSImage*)$a_ns_image setTemplate: $a_is_template];"
		end

feature -- Referring to Images by Name

	frozen image_named (a_name: POINTER): POINTER
			-- + (id)imageNamed: (NSString *) name
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSImage imageNamed: $a_name];"
		end

	frozen set_name (a_ns_image: POINTER; a_string: POINTER): BOOLEAN
			-- - (BOOL)setName: (NSString *) string
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSImage*)$a_ns_image setName: $a_string];"
		end

	frozen name (a_ns_image: POINTER): POINTER
			-- - (NSString *)name
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSImage*)$a_ns_image name];"
		end

feature -- Determining the Supported Image Types

	frozen can_init_with_pasteboard (a_pasteboard: POINTER): BOOLEAN
			-- + (BOOL)canInitWithPasteboard: (NSPasteboard *) pasteboard
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSImage canInitWithPasteboard: $a_pasteboard];"
		end

	frozen image_types : POINTER
			-- + (NSArray *)imageTypes
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSImage imageTypes];"
		end

	frozen image_unfiltered_types : POINTER
			-- + (NSArray *)imageUnfilteredTypes
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSImage imageUnfilteredTypes];"
		end

	frozen image_file_types : POINTER
			-- + (NSArray *)imageFileTypes
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSImage imageFileTypes];"
		end

	frozen image_unfiltered_file_types : POINTER
			-- + (NSArray *)imageUnfilteredFileTypes
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSImage imageUnfilteredFileTypes];"
		end

	frozen image_pasteboard_types : POINTER
			-- + (NSArray *)imagePasteboardTypes
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSImage imagePasteboardTypes];"
		end

	frozen image_unfiltered_pasteboard_types : POINTER
			-- + (NSArray *)imageUnfilteredPasteboardTypes
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSImage imageUnfilteredPasteboardTypes];"
		end

feature -- Working With Image Representations

	frozen add_representation (a_ns_image: POINTER; a_image_rep: POINTER)
			-- - (void)addRepresentation: (NSImageRep *) imageRep
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSImage*)$a_ns_image addRepresentation: $a_image_rep];"
		end

	frozen add_representations (a_ns_image: POINTER; a_image_reps: POINTER)
			-- - (void)addRepresentations: (NSArray *) imageReps
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSImage*)$a_ns_image addRepresentations: $a_image_reps];"
		end

--	frozen best_representation_for_device (a_ns_image: POINTER; a_device_description: POINTER): POINTER
--			-- - (NSImageRep *)bestRepresentationForDevice: (NSDictionary *) deviceDescription
--		external
--			"C inline use <Cocoa/Cocoa.h>"
--		alias
--			"return [(NSImage*)$a_ns_image bestRepresentationForDevice: $a_device_description];"
--		end

	frozen representations (a_ns_image: POINTER): POINTER
			-- - (NSArray *)representations
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSImage*)$a_ns_image representations];"
		end

	frozen remove_representation (a_ns_image: POINTER; a_image_rep: POINTER)
			-- - (void)removeRepresentation: (NSImageRep *) imageRep
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSImage*)$a_ns_image removeRepresentation: $a_image_rep];"
		end

feature -- Setting the Image Representation Selection Criteria

	frozen set_prefers_color_match (a_ns_image: POINTER; a_flag: BOOLEAN)
			-- - (void)setPrefersColorMatch: (BOOL) flag
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSImage*)$a_ns_image setPrefersColorMatch: $a_flag];"
		end

	frozen prefers_color_match (a_ns_image: POINTER): BOOLEAN
			-- - (BOOL)prefersColorMatch
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSImage*)$a_ns_image prefersColorMatch];"
		end

	frozen set_uses_eps_onresolution_mismatch (a_ns_image: POINTER; a_flag: BOOLEAN)
			-- - (void)setUsesEPSOnResolutionMismatch: (BOOL) flag
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSImage*)$a_ns_image setUsesEPSOnResolutionMismatch: $a_flag];"
		end

	frozen uses_eps_onresolution_mismatch (a_ns_image: POINTER): BOOLEAN
			-- - (BOOL)usesEPSOnResolutionMismatch
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSImage*)$a_ns_image usesEPSOnResolutionMismatch];"
		end

	frozen set_matches_on_multiple_resolution (a_ns_image: POINTER; a_flag: BOOLEAN)
			-- - (void)setMatchesOnMultipleResolution: (BOOL) flag
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSImage*)$a_ns_image setMatchesOnMultipleResolution: $a_flag];"
		end

	frozen matches_on_multiple_resolution (a_ns_image: POINTER): BOOLEAN
			-- - (BOOL)matchesOnMultipleResolution
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSImage*)$a_ns_image matchesOnMultipleResolution];"
		end

feature -- Managing the Focus

	frozen lock_focus (a_ns_image: POINTER)
			-- - (void)lockFocus
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSImage*)$a_ns_image lockFocus];"
		end

	frozen lock_focus_on_representation (a_ns_image: POINTER; a_image_representation: POINTER)
			-- - (void)lockFocusOnRepresentation: (NSImageRep *) imageRepresentation
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSImage*)$a_ns_image lockFocusOnRepresentation: $a_image_representation];"
		end

	frozen unlock_focus (a_ns_image: POINTER)
			-- - (void)unlockFocus
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSImage*)$a_ns_image unlockFocus];"
		end

feature -- Drawing the Image

	frozen draw_at_point_from_rect_operation_fraction (a_ns_image: POINTER; a_point: POINTER; a_from_rect: POINTER; a_op: NATURAL; a_delta: REAL)
			-- - (void)drawAtPoint: (NSPoint) point fromRect: (NSRect) fromRect operation: (NSCompositingOperation) op fraction: (CGFloat) delta
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSImage*)$a_ns_image drawAtPoint: *(NSPoint*)$a_point fromRect: *(NSRect*)$a_from_rect operation: $a_op fraction: $a_delta];"
		end

	frozen draw_in_rect_from_rect_operation_fraction (a_ns_image: POINTER; a_rect: POINTER; a_from_rect: POINTER; a_op: NATURAL; a_delta: REAL)
			-- - (void)drawInRect: (NSRect) rect fromRect: (NSRect) fromRect operation: (NSCompositingOperation) op fraction: (CGFloat) delta
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSImage*)$a_ns_image drawInRect: *(NSRect*)$a_rect fromRect: *(NSRect*)$a_from_rect operation: $a_op fraction: $a_delta];"
		end

	frozen draw_representation_in_rect (a_ns_image: POINTER; a_image_rep: POINTER; a_rect: POINTER): BOOLEAN
			-- - (BOOL)drawRepresentation: (NSImageRep *) imageRep inRect: (NSRect) rect
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSImage*)$a_ns_image drawRepresentation: $a_image_rep inRect: *(NSRect*)$a_rect];"
		end

	frozen composite_to_point_operation (a_ns_image: POINTER; a_point: POINTER; a_op: NATURAL)
			-- - (void)compositeToPoint: (NSPoint) point operation: (NSCompositingOperation) op
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSImage*)$a_ns_image compositeToPoint: *(NSPoint*)$a_point operation: $a_op];"
		end

	frozen composite_to_point_from_rect_operation (a_ns_image: POINTER; a_point: POINTER; a_rect: POINTER; a_op: NATURAL)
			-- - (void)compositeToPoint: (NSPoint) point fromRect: (NSRect) rect operation: (NSCompositingOperation) op
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSImage*)$a_ns_image compositeToPoint: *(NSPoint*)$a_point fromRect: *(NSRect*)$a_rect operation: $a_op];"
		end

	frozen composite_to_point_from_rect_operation_fraction (a_ns_image: POINTER; a_point: POINTER; a_rect: POINTER; a_op: NATURAL; a_delta: REAL)
			-- - (void)compositeToPoint: (NSPoint) point fromRect: (NSRect) rect operation: (NSCompositingOperation) op fraction: (CGFloat) delta
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSImage*)$a_ns_image compositeToPoint: *(NSPoint*)$a_point fromRect: *(NSRect*)$a_rect operation: $a_op fraction: $a_delta];"
		end

	frozen composite_to_point_operation_fraction (a_ns_image: POINTER; a_point: POINTER; a_op: NATURAL; a_delta: REAL)
			-- - (void)compositeToPoint: (NSPoint) point operation: (NSCompositingOperation) op fraction: (CGFloat) delta
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSImage*)$a_ns_image compositeToPoint: *(NSPoint*)$a_point operation: $a_op fraction: $a_delta];"
		end

	frozen dissolve_to_point_fraction (a_ns_image: POINTER; a_point: POINTER; a_float: REAL)
			-- - (void)dissolveToPoint: (NSPoint) point fraction: (CGFloat) aFloat
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSImage*)$a_ns_image dissolveToPoint: *(NSPoint*)$a_point fraction: $a_float];"
		end

	frozen dissolve_to_point_from_rect_fraction (a_ns_image: POINTER; a_point: POINTER; a_rect: POINTER; a_float: REAL)
			-- - (void)dissolveToPoint: (NSPoint) point fromRect: (NSRect) rect fraction: (CGFloat) aFloat
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSImage*)$a_ns_image dissolveToPoint: *(NSPoint*)$a_point fromRect: *(NSRect*)$a_rect fraction: $a_float];"
		end

--	frozen image_did_not_draw_in_rect (a_ns_image: POINTER; a_sender: POINTER; a_rect: POINTER): POINTER
--			-- - (NSImage *)imageDidNotDraw: (id) sender inRect: (NSRect) aRect
--		external
--			"C inline use <Cocoa/Cocoa.h>"
--		alias
--			"return [(NSImage*)$a_ns_image imageDidNotDraw: $a_sender inRect: *(NSRect*)$a_rect];"
--		end

feature -- Working With Alignment Metadata

	frozen alignment_rect (a_ns_image: POINTER; res: POINTER)
			-- - (NSRect)alignmentRect
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"NSRect rect = [(NSImage*)$a_ns_image alignmentRect]; memcpy($res, &rect, sizeof(NSRect));"
		end

	frozen set_alignment_rect (a_ns_image: POINTER; a_rect: POINTER)
			-- - (void)setAlignmentRect: (NSRect) rect
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSImage*)$a_ns_image setAlignmentRect: *(NSRect*)$a_rect];"
		end

feature -- Setting the Image Storage Options

	frozen set_cached_separately (a_ns_image: POINTER; a_flag: BOOLEAN)
			-- - (void)setCachedSeparately: (BOOL) flag
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSImage*)$a_ns_image setCachedSeparately: $a_flag];"
		end

	frozen is_cached_separately (a_ns_image: POINTER): BOOLEAN
			-- - (BOOL)isCachedSeparately
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSImage*)$a_ns_image isCachedSeparately];"
		end

	frozen set_data_retained (a_ns_image: POINTER; a_flag: BOOLEAN)
			-- - (void)setDataRetained: (BOOL) flag
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSImage*)$a_ns_image setDataRetained: $a_flag];"
		end

	frozen is_data_retained (a_ns_image: POINTER): BOOLEAN
			-- - (BOOL)isDataRetained
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSImage*)$a_ns_image isDataRetained];"
		end

	frozen set_cache_depth_matches_image_depth (a_ns_image: POINTER; a_flag: BOOLEAN)
			-- - (void)setCacheDepthMatchesImageDepth: (BOOL) flag
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSImage*)$a_ns_image setCacheDepthMatchesImageDepth: $a_flag];"
		end

	frozen cache_depth_matches_image_depth (a_ns_image: POINTER): BOOLEAN
			-- - (BOOL)cacheDepthMatchesImageDepth
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSImage*)$a_ns_image cacheDepthMatchesImageDepth];"
		end
-- Error generating cacheMode: Message signature for feature not set
-- Error generating setCacheMode:: Message signature for feature not set

feature -- Setting the Image Drawing Options

	frozen is_valid (a_ns_image: POINTER): BOOLEAN
			-- - (BOOL)isValid
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSImage*)$a_ns_image isValid];"
		end

	frozen set_scales_when_resized (a_ns_image: POINTER; a_flag: BOOLEAN)
			-- - (void)setScalesWhenResized: (BOOL) flag
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSImage*)$a_ns_image setScalesWhenResized: $a_flag];"
		end

	frozen scales_when_resized (a_ns_image: POINTER): BOOLEAN
			-- - (BOOL)scalesWhenResized
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSImage*)$a_ns_image scalesWhenResized];"
		end

	frozen set_background_color (a_ns_image: POINTER; a_color: POINTER)
			-- - (void)setBackgroundColor: (NSColor *) aColor
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSImage*)$a_ns_image setBackgroundColor: $a_color];"
		end

	frozen background_color (a_ns_image: POINTER): POINTER
			-- - (NSColor *)backgroundColor
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSImage*)$a_ns_image backgroundColor];"
		end

	frozen set_flipped (a_ns_image: POINTER; a_flag: BOOLEAN)
			-- - (void)setFlipped: (BOOL) flag
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSImage*)$a_ns_image setFlipped: $a_flag];"
		end

	frozen is_flipped (a_ns_image: POINTER): BOOLEAN
			-- - (BOOL)isFlipped
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSImage*)$a_ns_image isFlipped];"
		end

	frozen recache (a_ns_image: POINTER)
			-- - (void)recache
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSImage*)$a_ns_image recache];"
		end

feature -- Assigning a Delegate

	frozen set_delegate (a_ns_image: POINTER; a_an_object: POINTER)
			-- - (void)setDelegate: (id) anObject
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSImage*)$a_ns_image setDelegate: $a_an_object];"
		end

	frozen delegate (a_ns_image: POINTER): POINTER
			-- - (id)delegate
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSImage*)$a_ns_image delegate];"
		end

feature -- Producing TIFF Data for the Image

	frozen tiff_representation (a_ns_image: POINTER): POINTER
			-- - (NSData *)TIFFRepresentation
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSImage*)$a_ns_image TIFFRepresentation];"
		end

	frozen tiff_representation_using_compression_factor (a_ns_image: POINTER; a_comp: POINTER; a_float: REAL): POINTER
			-- - (NSData *)TIFFRepresentationUsingCompression: (NSTIFFCompression) comp factor: (float) aFloat
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSImage*)$a_ns_image TIFFRepresentationUsingCompression: *(NSTIFFCompression*)$a_comp factor: $a_float];"
		end

feature -- Managing Incremental Loads

	frozen cancel_incremental_load (a_ns_image: POINTER)
			-- - (void)cancelIncrementalLoad
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSImage*)$a_ns_image cancelIncrementalLoad];"
		end

--	frozen image_did_load_part_of_representation_with_valid_rows (a_ns_image: POINTER; a_image: POINTER; a_rep: POINTER; a_rows: INTEGER)
--			-- - (void)image: (NSImage*) image didLoadPartOfRepresentation: (NSImageRep*) rep withValidRows: (NSInteger) rows
--		external
--			"C inline use <Cocoa/Cocoa.h>"
--		alias
--			"[(NSImage*)$a_ns_image image: $a_image didLoadPartOfRepresentation: $a_rep withValidRows: $a_rows];"
--		end

--	frozen image_did_load_representation_with_status (a_ns_image: POINTER; a_image: POINTER; a_rep: POINTER; a_status: INTEGER)
--			-- - (void)image: (NSImage*) image didLoadRepresentation: (NSImageRep*) rep withStatus: (NSImageLoadStatus) status
--		external
--			"C inline use <Cocoa/Cocoa.h>"
--		alias
--			"[(NSImage*)$a_ns_image image: $a_image didLoadRepresentation: $a_rep withStatus: $a_status];"
--		end

--	frozen image_did_load_representation_header (a_ns_image: POINTER; a_image: POINTER; a_rep: POINTER)
--			-- - (void)image: (NSImage*) image didLoadRepresentationHeader: (NSImageRep*) rep
--		external
--			"C inline use <Cocoa/Cocoa.h>"
--		alias
--			"[(NSImage*)$a_ns_image image: $a_image didLoadRepresentationHeader: $a_rep];"
--		end

--	frozen image_will_load_representation (a_ns_image: POINTER; a_image: POINTER; a_rep: POINTER)
--			-- - (void)image: (NSImage*) image willLoadRepresentation: (NSImageRep*) rep
--		external
--			"C inline use <Cocoa/Cocoa.h>"
--		alias
--			"[(NSImage*)$a_ns_image image: $a_image willLoadRepresentation: $a_rep];"
--		end

end
