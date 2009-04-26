note
	description: "Summary description for {NS_MENU_ITEM}."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_MENU_ITEM

inherit
	NS_OBJECT

create
	new,
	separator_item

feature

	new
		do
			cocoa_object := menu_item_new
		end

	separator_item
		do
			cocoa_object := menu_item_separator_item
		end

	set_submenu (a_menu: NS_MENU)
		do
			menu_item_set_submenu (cocoa_object, a_menu.cocoa_object)
		end

	set_title (a_title: STRING_GENERAL)
		do
			menu_item_set_title (cocoa_object, (create {NS_STRING}.make_with_string (a_title)).cocoa_object)
		end

	set_action (an_action: PROCEDURE [ANY, TUPLE])
		require
			an_action /= void
		do
			action := an_action
			menu_item_set_target (cocoa_object, target_new ($current, $target))
			menu_item_set_action (cocoa_object)
		end

feature {NONE} -- callback

	target
		do
			action.call([])
		end

	action: PROCEDURE [ANY, TUPLE]

feature {NONE} -- Implementation

	frozen menu_item_new: POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSMenuItem new];"
		end

	frozen menu_item_separator_item: POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSMenuItem separatorItem];"
		end

	frozen menu_item_set_submenu (a_menu_item: POINTER; a_menu: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSMenuItem*)$a_menu_item setSubmenu: $a_menu];"
		end

	frozen menu_item_set_title (a_menu_item: POINTER; a_nsstring: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSMenuItem*)$a_menu_item setTitle: $a_nsstring];"
		end

--+ (void)setUsesUserKeyEquivalents:(BOOL)flag;
--+ (BOOL)usesUserKeyEquivalents;

--+ (NSMenuItem *)separatorItem;

--- (id)initWithTitle:(NSString *)aString action:(SEL)aSelector keyEquivalent:(NSString *)charCode;

--- (void)setMenu:(NSMenu *)menu;
--- (NSMenu *)menu;
--    // Never call the set method directly it is there only for subclassers.


--- (BOOL)hasSubmenu;
--- (void)setSubmenu:(NSMenu *)submenu;
--- (NSMenu *)submenu;

--- (void)setTitle:(NSString *)aString;
--- (NSString *)title;
--- (void)setAttributedTitle:(NSAttributedString*)string;
--- (NSAttributedString*)attributedTitle;

--- (BOOL)isSeparatorItem;

--- (void)setKeyEquivalent:(NSString *)aKeyEquivalent;
--- (NSString *)keyEquivalent;
--- (void)setKeyEquivalentModifierMask:(NSUInteger)mask;
--- (NSUInteger)keyEquivalentModifierMask;

--- (NSString *)userKeyEquivalent;

--- (void)setMnemonicLocation:(NSUInteger)location;
--- (NSUInteger)mnemonicLocation;
--- (NSString *)mnemonic;
--- (void)setTitleWithMnemonic:(NSString *)stringWithAmpersand;

--- (void)setImage:(NSImage *)menuImage;
--- (NSImage *)image;

--- (void)setState:(NSInteger)state;
--- (NSInteger)state;
--- (void)setOnStateImage:(NSImage *)image;  // checkmark by default
--- (NSImage *)onStateImage;
--- (void)setOffStateImage:(NSImage *)image;  // none by default
--- (NSImage *)offStateImage;
--- (void)setMixedStateImage:(NSImage *)image;  // horizontal line by default?
--- (NSImage *)mixedStateImage;

--- (void)setEnabled:(BOOL)flag;
--- (BOOL)isEnabled;

--- (void) setAlternate:(BOOL)isAlternate;
--- (BOOL) isAlternate;

--- (void) setIndentationLevel:(NSInteger)indentationLevel;
--- (NSInteger) indentationLevel;

	frozen menu_item_set_target (a_button: POINTER; a_target: POINTER)
			-- - (void)setTarget:(id)anObject;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSButton*)$a_button setTarget: $a_target];"
		end

--- (id)target;
	frozen menu_item_set_action (a_menu_item: POINTER)
			-- - (void)setAction:(SEL)aSelector;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSMenuItem*)$a_menu_item setAction:@selector(handle_action_event:)];"
		end
--- (SEL)action;

--- (void)setTag:(NSInteger)anInt;
--- (NSInteger)tag;

--- (void)setRepresentedObject:(id)anObject;
--- (id)representedObject;

--/* Set (and get) the view for a menu item.  By default, a menu item has a nil view.
--A menu item with a view does not draw its title, state, font, or other standard drawing attributes, and assigns drawing responsibility entirely to the view.  Keyboard equivalents and type-select continue to use the key equivalent and title as normal.
--A menu item with a view sizes itself according to the view's frame, and the width of the other menu items.  The menu item will always be at least as wide as its view, but it may be wider.  If you want your view to auto-expand to fill the menu item, then make sure that its autoresizing mask has NSViewWidthSizable set; in that case, the view's width at the time setView: is called will be treated as the minimum width for the view.  A menu will resize itself as its containing views change frame size.  Changes to the view's frame during tracking are reflected immediately in the menu.
--A view in a menu item will receive mouse and keyboard events normally.  During non-sticky menu tracking (manipulating menus with the mouse button held down), a view in a menu item will receive mouseDragged: events.
--Animation is possible via the usual mechanism (set a timer to call setNeedsDisplay: or display), but because menu tracking occurs in the NSEventTrackingRunLoopMode, you must add the timer to the run loop in that mode.
--When the menu is opened, the view is added to a window; when the menu is closed the view is removed from the window.  Override viewDidMoveToWindow in your view for a convenient place to start/stop animations, reset tracking rects, etc., but do not attempt to move or otherwise modify the window.
--When a menu item is copied via NSCopying, any attached view is copied via archiving/unarchiving.  Menu item views are not supported in the Dock menu. */
--- (void)setView:(NSView *)view;
--- (NSView *)view;

--/* Indicates whether the menu item should be drawn highlighted or not. */
--- (BOOL)isHighlighted;

--/* Set (and get) the visibility of a menu item.  Hidden menu items (or items with a hidden superitem) do not appear in a menu and do not participate in command key matching.  isHiddenOrHasHiddenAncestor returns YES if the item is hidden or any of its superitems are hidden. */
--- (void)setHidden:(BOOL)hidden;
--- (BOOL)isHidden;
--- (BOOL)isHiddenOrHasHiddenAncestor;

--- (void) setToolTip:(NSString*)toolTip;
--- (NSString*)toolTip;

--@interface NSView (NSViewEnclosingMenuItem)
--/* Returns the menu item containing the receiver or any of its superviews in the view hierarchy, or nil if the receiver's view hierarchy is not in a menu item. */
--- (NSMenuItem *)enclosingMenuItem;
--@end


end
