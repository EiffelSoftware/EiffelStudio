note
	description: "Summary description for {NS_IMAGE_API}."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_IMAGE_API

feature -- Initializing a New NSImage Object

	frozen image_named (a_name: POINTER) : POINTER
			--+ (id)imageNamed:(NSString *)name;	/* If this finds & creates the image, only name is saved when archived */
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSImage imageNamed: $a_name];"
		end

	frozen init_with_size (a_size: POINTER) : POINTER
			--- (id)initWithSize:(NSSize)aSize;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [[NSImage alloc] initWithSize: *(NSSize *)$a_size];"
		end
--- (id)initWithData:(NSData *)data;			/* When archived, saves contents */
--- (id)initWithContentsOfFile:(NSString *)fileName;	/* When archived, saves contents */
--- (id)initWithContentsOfURL:(NSURL *)url;               /* When archived, saves contents */

	frozen init_by_referencing_file (a_path: POINTER) : POINTER
			--- (id)initByReferencingFile:(NSString *)fileName;	/* When archived, saves fileName */
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [[NSImage alloc] initByReferencingFile: $a_path];"
		end

--- (id)initByReferencingURL:(NSURL *)url;		/* When archived, saves url, supports progressive loading */
--- (id)initWithIconRef:(IconRef)iconRef;
--- (id)initWithPasteboard:(NSPasteboard *)pasteboard;


feature -- Setting the Image Attributes

	frozen set_size (a_image: POINTER; a_size: POINTER)
			--- (void)setSize:(NSSize)aSize;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSImage*)$a_image setSize: *(NSSize*)$a_size];"
		end

	frozen size (a_image: POINTER; res: POINTER)
			--- (NSSize)size;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[
				{
					NSSize size = [(NSImage*)$a_image size];
					memcpy ($res, &size, sizeof(NSSize));
				}
			]"
		end

--- (BOOL)setName:(NSString *)string;

feature -- Referring to Images by Name

feature -- Determining the Supported Image Types

feature -- Working With Image Representations

feature -- Setting the Image Representation Selection Criteria

feature -- Managing the Focus

feature -- Drawing the Image

	frozen draw_at_point_from_rect_operation_fraction (a_image: POINTER; a_point: POINTER; a_from_rect: POINTER; a_op: INTEGER; a_delta: REAL)
			-- - (void)drawAtPoint:(NSPoint)point fromRect:(NSRect)fromRect operation:(NSCompositingOperation)op fraction:(CGFloat)delta;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSImage*) $a_image drawAtPoint: *(NSPoint*)$a_point fromRect: *(NSRect*)$a_from_rect operation: $a_op fraction: $a_delta];"
		end

	frozen draw_in_rect_from_rect_operation_fraction (a_image: POINTER; a_dst_rect: POINTER; a_from_rect: POINTER; a_op: INTEGER; a_delta: REAL)
			-- - (void)drawInRect:(NSRect)dstRect fromRect:(NSRect)srcRect operation:(NSCompositingOperation)op fraction:(CGFloat)delta
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSImage*) $a_image drawInRect: *(NSRect*)$a_dst_rect fromRect: *(NSRect*)$a_from_rect operation: $a_op fraction: $a_delta];"
		end


feature -- Working With Alignment Metadata

feature -- Setting the Image Storage Options

feature -- Setting the Image Drawing Options

	frozen set_flipped (a_image: POINTER; a_flag: BOOLEAN)
			-- - (void)setFlipped:(BOOL)flag
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSImage*) $a_image setFlipped: $a_flag];"
		end

	frozen is_flipped (a_image: POINTER): BOOLEAN
			-- - (BOOL)isFlipped
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSImage*) $a_image isFlipped];"
		end

feature -- Assigning a Delegate

feature -- Producing TIFF Data for the Image

feature -- Managing Incremental Loads


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

--- (BOOL)drawRepresentation:(NSImageRep *)imageRep inRect:(NSRect)rect;
--- (void)recache;
--- (NSData *)TIFFRepresentation;
--- (NSData *)TIFFRepresentationUsingCompression:(NSTIFFCompression)comp factor:(float)aFloat;

	frozen representations (a_image: POINTER) : POINTER
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
	frozen lock_focus (a_image: POINTER)
			--- (void)lockFocus;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSImage*) $a_image lockFocus];"
		end
--- (void)lockFocusOnRepresentation:(NSImageRep *)imageRepresentation;
	frozen unlock_focus (a_image: POINTER)
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

end
