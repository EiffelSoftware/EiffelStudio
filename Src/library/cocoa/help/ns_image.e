note
	description: "Summary description for {NS_IMAGE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	NS_IMAGE

inherit
	NS_OBJECT

create
	init_by_referencing_file,
	init_with_size,
	image_named

feature --

	init_by_referencing_file (a_path: STRING_GENERAL)
		do
			cocoa_object := image_init_by_referencing_file ((create {NS_STRING}.make_with_string(a_path)).cocoa_object)
		end

	init_with_size (a_size: NS_SIZE)
		do
			cocoa_object := image_init_with_size (a_size.item)
		end

	image_named (a_name: STRING_GENERAL)
		do
			cocoa_object := image_image_named ((create {NS_STRING}.make_with_string (a_name)).cocoa_object)
		end

	size : TUPLE [width, height: INTEGER]
			-- TODO Looks like it will make more sense to create a class NS_SIZE. Still, the problem of how to nicely extract this from C remains to be solved.
		local
			w, h: INTEGER
		do
			image_size (cocoa_object, $w, $h)
			create Result
			Result.width := w
			Result.height := h
		ensure
			Result.width >= 0
			Result.height >= 0
		end

	representations : NS_ARRAY [NS_IMAGE_REP]
		do
			create Result.make_shared (image_representations (cocoa_object))
		end

	draw_at_point_from_rect_operation_fraction (a_point: NS_POINT; a_from_rect: NS_RECT; a_op: INTEGER; a_delta: REAL)
		do
			image_draw_at_point_from_rect_operation_fraction (cocoa_object, a_point.item, a_from_rect.item, a_op, a_delta)
		end

	lock_focus
		do
			image_lock_focus (cocoa_object)
		end

	unlock_focus
		do
			image_unlock_focus (cocoa_object)
		end

feature {NONE} -- Objective-C implementation

	frozen image_image_named (a_name: POINTER) : POINTER
			--+ (id)imageNamed:(NSString *)name;	/* If this finds & creates the image, only name is saved when archived */
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSImage imageNamed: $a_name];"
		end

	frozen image_init_with_size (a_size: POINTER) : POINTER
			--- (id)initWithSize:(NSSize)aSize;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [[NSImage alloc] initWithSize: *(NSSize *)$a_size];"
		end
--- (id)initWithData:(NSData *)data;			/* When archived, saves contents */
--- (id)initWithContentsOfFile:(NSString *)fileName;	/* When archived, saves contents */
--- (id)initWithContentsOfURL:(NSURL *)url;               /* When archived, saves contents */

	frozen image_init_by_referencing_file (a_path: POINTER) : POINTER
			--- (id)initByReferencingFile:(NSString *)fileName;	/* When archived, saves fileName */
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [[NSImage alloc] initByReferencingFile: $a_path];"
		end

--- (id)initByReferencingURL:(NSURL *)url;		/* When archived, saves url, supports progressive loading */
--- (id)initWithIconRef:(IconRef)iconRef;
--- (id)initWithPasteboard:(NSPasteboard *)pasteboard;

--- (void)setSize:(NSSize)aSize;

	frozen image_size (a_image: POINTER; w, h: POINTER)
			--- (NSSize)size;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[
				{
					NSSize size = [(NSImage*)$a_image size];
					*(int*)$w = size.width;
					*(int*)$h = size.height;
				}
			]"
		end

--- (BOOL)setName:(NSString *)string;
--- (NSString *)name;
--- (void)setScalesWhenResized:(BOOL)flag;
--- (BOOL)scalesWhenResized;
--- (void)setDataRetained:(BOOL)flag;
--- (BOOL)isDataRetained;
--- (void)setCachedSeparately:(BOOL)flag;
--- (BOOL)isCachedSeparately;
--- (void)setCacheDepthMatchesImageDepth:(BOOL)flag;
--- (BOOL)cacheDepthMatchesImageDepth;
--- (void)setBackgroundColor:(NSColor *)aColor;
--- (NSColor *)backgroundColor;
--- (void)setUsesEPSOnResolutionMismatch:(BOOL)flag;
--- (BOOL)usesEPSOnResolutionMismatch;
--- (void)setPrefersColorMatch:(BOOL)flag;
--- (BOOL)prefersColorMatch;
--- (void)setMatchesOnMultipleResolution:(BOOL)flag;
--- (BOOL)matchesOnMultipleResolution;
--- (void)dissolveToPoint:(NSPoint)point fraction:(CGFloat)aFloat;
--- (void)dissolveToPoint:(NSPoint)point fromRect:(NSRect)rect fraction:(CGFloat)aFloat;
--- (void)compositeToPoint:(NSPoint)point operation:(NSCompositingOperation)op;
--- (void)compositeToPoint:(NSPoint)point fromRect:(NSRect)rect operation:(NSCompositingOperation)op;
--- (void)compositeToPoint:(NSPoint)point operation:(NSCompositingOperation)op fraction:(CGFloat)delta;
--- (void)compositeToPoint:(NSPoint)point fromRect:(NSRect)rect operation:(NSCompositingOperation)op fraction:(CGFloat)delta;
--- (void)drawInRect:(NSRect)rect fromRect:(NSRect)fromRect operation:(NSCompositingOperation)op fraction:(CGFloat)delta;
	frozen image_draw_at_point_from_rect_operation_fraction (a_image: POINTER; a_point: POINTER; a_from_rect: POINTER; a_op: INTEGER; a_delta: REAL)
			--- (void)drawAtPoint:(NSPoint)point fromRect:(NSRect)fromRect operation:(NSCompositingOperation)op fraction:(CGFloat)delta;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSImage*) $a_image drawAtPoint: *(NSPoint*)$a_point fromRect: *(NSRect*)$a_from_rect operation: $a_op fraction: $a_delta];"
		end
--- (BOOL)drawRepresentation:(NSImageRep *)imageRep inRect:(NSRect)rect;
--- (void)recache;
--- (NSData *)TIFFRepresentation;
--- (NSData *)TIFFRepresentationUsingCompression:(NSTIFFCompression)comp factor:(float)aFloat;

	frozen image_representations (a_image: POINTER) : POINTER
			--- (NSArray *)representations;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSImage*) $a_image representations];"
		end

--- (void)addRepresentations:(NSArray *)imageReps;
--- (void)addRepresentation:(NSImageRep *)imageRep;
--- (void)removeRepresentation:(NSImageRep *)imageRep;

--- (BOOL)isValid;
	frozen image_lock_focus (a_image: POINTER)
			--- (void)lockFocus;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSImage*) $a_image lockFocus];"
		end
--- (void)lockFocusOnRepresentation:(NSImageRep *)imageRepresentation;
	frozen image_unlock_focus (a_image: POINTER)
			--- (void)unlockFocus;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSImage*) $a_image unlockFocus];"
		end

--- (NSImageRep *)bestRepresentationForDevice:(NSDictionary *)deviceDescription;

--- (void)setDelegate:(id)anObject;
--- (id)delegate;

--/* These return union of all the types registered with NSImageRep.
--*/
--+ (NSArray *)imageUnfilteredFileTypes;
--+ (NSArray *)imageUnfilteredPasteboardTypes;
--+ (NSArray *)imageFileTypes;
--+ (NSArray *)imagePasteboardTypes;

--+ (NSArray *)imageTypes;
--+ (NSArray *)imageUnfilteredTypes;

--+ (BOOL)canInitWithPasteboard:(NSPasteboard *)pasteboard;

--- (void)setFlipped:(BOOL)flag;
--- (BOOL)isFlipped;

--- (void)cancelIncrementalLoad;

---(void)setCacheMode:(NSImageCacheMode)mode;
---(NSImageCacheMode)cacheMode;

--/* The alignmentRect of an image is metadata that a client may use to help determine layout. The bottom of the rect gives the baseline of the image. The other edges give similar information in other directions.
--
-- A 20x20 image of a phone icon with a glow might specify an alignmentRect of {{2,2},{16,16}} that excludes the glow. NSButtonCell can take advantage of the alignmentRect to place the image in the same visual location as an 16x16 phone icon without the glow. A 5x5 star that should render high when aligned with text might specify a rect of {{0,-7},{5,12}}.
--
-- The alignmentRect of an image has no effect on methods such as drawInRect:fromRect:operation:Fraction: or drawAtPoint:fromRect:operation:fraction:. It is the client's responsibility to take the alignmentRect into account where applicable.
--
-- The default alignmentRect of an image is {{0,0},imageSize}. The rect is adjusted when setSize: is called.
-- */
--- (NSRect)alignmentRect;
--- (void)setAlignmentRect:(NSRect)rect;

--/* The 'template' property is metadata that allows clients to be smarter about image processing.  An image should be marked as a template if it is basic glpyh-like black and white art that is intended to be processed into derived images for use on screen.
--
-- NSButtonCell applies effects to images based on the state of the button.  For example, images are shaded darker when the button is pressed.  If a template image is set on a cell, the cell can apply more sophisticated effects.  For example, it may be processed into an image that looks engraved when drawn into a cell whose interiorBackgroundStyle is NSBackgroundStyleRaised, like on a textured button.
-- */
--- (BOOL)isTemplate;
--- (void)setTemplate:(BOOL)isTemplate;

feature -- NSCompositingOperation Constants

	frozen composite_source_over: INTEGER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return NSCompositeSourceOver;"
		end

	frozen composite_xor: INTEGER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return NSCompositeXOR;"
		end

feature {NS_IMAGE_CONSTANTS} -- Named Images

	frozen image_name_info: POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return NSImageNameInfo;"
		end

end
