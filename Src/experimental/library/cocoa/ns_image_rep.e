note
	description: "Wrapper for NSImageRep."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_IMAGE_REP

inherit
	NS_OBJECT

create {NS_OBJECT} -- Creation
	share_from_pointer

feature -- Access

	pixels_wide: INTEGER
		do
			Result := image_rep_pixels_wide (item)
		end

	pixels_high: INTEGER
		do
			Result := image_rep_pixels_high (item)
		end

feature {NONE} -- Implementation


--/* Drawing methods. drawAtPoint: and drawInRect: go through draw after modifying the CTM.
--*/
--- (BOOL)draw;
--- (BOOL)drawAtPoint:(NSPoint)point;
--- (BOOL)drawInRect:(NSRect)rect;

--/* Methods to return info about the image. NSImageRep provides storage for all of these; however, it's illegal to set them in some subclasses.
--*/
--- (void)setSize:(NSSize)aSize;
--- (NSSize)size;
--- (void)setAlpha:(BOOL)flag;
--- (BOOL)hasAlpha;
--- (void)setOpaque:(BOOL)flag;
--- (BOOL)isOpaque;
--- (void)setColorSpaceName:(NSString *)string;
--- (NSString *)colorSpaceName;
--- (void)setBitsPerSample:(NSInteger)anInt;
--- (NSInteger)bitsPerSample;
--- (void)setPixelsWide:(NSInteger)anInt;
	frozen image_rep_pixels_wide (a_image_rep: POINTER) : INTEGER
			--- (NSInteger)pixelsWide;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSImageRep*) $a_image_rep pixelsWide];"
		end
--- (void)setPixelsHigh:(NSInteger)anInt;
	frozen image_rep_pixels_high (a_image_rep: POINTER) : INTEGER
			--- (NSInteger)pixelsHigh;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSImageRep*) $a_image_rep pixelsHigh];"
		end

--/* The rest of the methods all deal with subclassers which can read/write data in files or pasteboards.
--*/

--/* Registry management: Subclasses which deal with file & pasteboard types should register themselves. These classes should also implement imageUnfilteredFileTypes, imageUnfilteredPasteboardTypes, initWithData:, canInitWithData:, imageRepWithData:, and, if they have the ability to read multiple images from a file, imageRepsWithData:. These last three should not do any filtering; all filtering is automatic.
--*/
--+ (void)registerImageRepClass:(Class)imageRepClass;
--+ (void)unregisterImageRepClass:(Class)imageRepClass;
--+ (NSArray *)registeredImageRepClasses;
--+ (Class)imageRepClassForFileType:(NSString *)type;
--+ (Class)imageRepClassForPasteboardType:(NSString *)type;
--+ (Class)imageRepClassForType:(NSString *)type;
--+ (Class)imageRepClassForData:(NSData *)data;
--	
--/* Should be overridden by subclassers to load an unfiltered image.
--*/
--+ (BOOL)canInitWithData:(NSData *)data;

--/* Implemented by subclassers to indicate what data types they can deal with.
--*/
--+ (NSArray *)imageUnfilteredFileTypes;
--+ (NSArray *)imageUnfilteredPasteboardTypes;

--/* These expand the unfiltered lists returned by imageUnfilteredFileTypes and imageUnfilteredPasteboardTypes.
--*/
--+ (NSArray *)imageFileTypes;
--+ (NSArray *)imagePasteboardTypes;

--/* Implemented by subclassers to indicate what UTI-identified data types they can deal with.
--*/
--+ (NSArray *)imageUnfilteredTypes;

--/* This expands the unfiltered list returned by imageUnfilteredTypes.
--*/
--+ (NSArray *)imageTypes;

--/* Convenience method: Checks to see if any of the types on the pasteboard can be understood by a registered imagerep class after filtering or if the pasteboard contains a filename that can be understood by a registered imagerep class after filtering. If sent to a subclass, does this for just the types understood by the subclass.
--*/
--+ (BOOL)canInitWithPasteboard:(NSPasteboard *)pasteboard;

--/* Convenience methods: Checks to see if the provided file or pasteboard types can be understood by a registered imagerep class after filtering; if so, calls imageRepsWithData: or imageRepWithData:. If sent to a subclass, does this just for the types understood by that subclass.
--*/
--+ (NSArray *)imageRepsWithContentsOfFile:(NSString *)filename;
--+ (id)imageRepWithContentsOfFile:(NSString *)filename;
--+ (NSArray *)imageRepsWithContentsOfURL:(NSURL *)url;
--+ (id)imageRepWithContentsOfURL:(NSURL *)url;
--+ (NSArray *)imageRepsWithPasteboard:(NSPasteboard *)pasteboard;
--+ (id)imageRepWithPasteboard:(NSPasteboard *)pasteboard;

end
