note
	description: "Wrapper for NSColorPanel."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_COLOR_PANEL

inherit
	NS_PANEL

create
	shared_color_panel

feature {NONE} -- Creation

	shared_color_panel
		do
			share_from_pointer (color_panel_shared_color_panel)
		end

feature {NONE} -- Objective-C implementation

	frozen color_panel_shared_color_panel: POINTER is
			-- Create a new NSWindow
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSColorPanel sharedColorPanel];"
		end

--+ (NSColorPanel *)sharedColorPanel;
--+ (BOOL)sharedColorPanelExists;
--+ (BOOL)dragColor:(NSColor *)color withEvent:(NSEvent *)theEvent fromView:(NSView *)sourceView;
--+ (void)setPickerMask:(NSUInteger)mask;
--+ (void)setPickerMode:(NSColorPanelMode)mode;

--- (void)setAccessoryView:(NSView *)aView;
--- (NSView *)accessoryView;
--- (void)setContinuous:(BOOL)flag;
--- (BOOL)isContinuous;
--- (void)setShowsAlpha:(BOOL)flag;
--- (BOOL)showsAlpha;
--- (void)setMode:(NSColorPanelMode)mode;
--- (NSColorPanelMode)mode;
--- (void)setColor:(NSColor *)color;
--- (NSColor *)color;
--- (CGFloat)alpha;
--- (void)setAction:(SEL)aSelector;
--- (void)setTarget:(id)anObject;
--- (void)attachColorList:(NSColorList *)colorList;
--- (void)detachColorList:(NSColorList *)colorList;


end
