note
	description: "Summary description for {NS_MENU_ITEM_API}."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_MENU_ITEM_API

feature -- Creating a Menu Item

	frozen alloc: POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSMenuItem alloc];"
		end

	frozen new: POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSMenuItem new];"
		end

	frozen init_with_title (target: POINTER; a_title, a_action, a_key_equivalent: POINTER)
			-- - (id)initWithTitle:(NSString *)itemName action:(SEL)anAction keyEquivalent:(NSString *)charCode
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSMenuItem*)$target initWithTitle: $a_title action: $a_action keyEquivalent: $a_key_equivalent];"
		end

feature -- Enabling a Menu Item

feature -- Managing Hidden Status

feature -- Managing the Target and Action

	frozen set_target (a_menu_item: POINTER; a_target: POINTER)
			-- - (void)setTarget:(id)anObject;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSMenuItem*)$a_menu_item setTarget: $a_target];"
		end

--- (id)target;

	frozen set_action (a_menu_item: POINTER)
			-- - (void)setAction:(SEL)aSelector;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSMenuItem*)$a_menu_item setAction:@selector(handle_action_event:)];"
		end

--- (SEL)action;

feature -- Managing the Title

feature -- Managing the Tag

feature -- Managing the State

	frozen set_state (a_menu_item: POINTER; a_state: INTEGER)
			--- (void)setState:(NSInteger)state;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSMenuItem*)$a_menu_item setState: $a_state];"
		end

	frozen state (a_menu_item: POINTER): INTEGER
			--- (NSInteger)state;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSMenuItem*)$a_menu_item state];"
		end

feature -- Managing the Image

feature -- Managing Submenus

feature -- Getting a Separator Item

	frozen separator_item: POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSMenuItem separatorItem];"
		end

feature -- Managing the Owning Menu

feature -- Managing Key Equivalents

feature -- Managing Mnemonics

feature -- Managing User Key Equivalents

feature -- Managing Alternates

feature -- Managing Indentation Levels

feature -- Managing Tool Tips

feature -- Representing an Object

feature -- Managing the View

feature -- Getting Highlighted Status

	frozen set_submenu (a_menu_item: POINTER; a_menu: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSMenuItem*)$a_menu_item setSubmenu: $a_menu];"
		end

	frozen set_title (a_menu_item: POINTER; a_nsstring: POINTER)
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

	frozen set_key_equivalent (a_menu_item: POINTER; a_nsstring: POINTER)
			--- (void)setKeyEquivalent:(NSString *)aKeyEquivalent;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSMenuItem*)$a_menu_item setKeyEquivalent: $a_nsstring];"
		end

--- (NSString *)keyEquivalent;

	frozen set_key_equivalent_modifier_mask (a_menu_item: POINTER; a_mask: INTEGER)
			--- (void)setKeyEquivalentModifierMask:(NSUInteger)mask;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSMenuItem*)$a_menu_item setKeyEquivalentModifierMask: $a_mask];"
		end

--- (NSUInteger)keyEquivalentModifierMask;

--- (NSString *)userKeyEquivalent;

--- (void)setMnemonicLocation:(NSUInteger)location;
--- (NSUInteger)mnemonicLocation;
--- (NSString *)mnemonic;
--- (void)setTitleWithMnemonic:(NSString *)stringWithAmpersand;

	frozen set_image (a_menu_item: POINTER; a_image: POINTER)
			--- (void)setImage:(NSImage *)menuImage;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSMenuItem*)$a_menu_item setImage: $a_image];"
		end

--- (NSImage *)image;


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
