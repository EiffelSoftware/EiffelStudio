note
	description: "Wrapper for NSMenu."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_MENU

inherit
	NS_OBJECT

create
	make
create {NS_OBJECT}
	share_from_pointer

feature {NONE} -- Creation

	make
		do
			make_from_pointer (menu_new)
		end

feature -- Access

	insert_item_at_index (a_menu_item: NS_MENU_ITEM; a_index: INTEGER)
		do
			menu_insert_item_at_index (item, a_menu_item.item, a_index)
		end

	remove_item_at_index (a_index: INTEGER)
		do
			menu_remove_item_at_index (item, a_index)
		end

	set_title (a_title: NS_STRING)
		do
			menu_set_title (item, a_title.item)
		end

	add_item (a_menu_item: NS_MENU_ITEM)
		do
			menu_add_item (item, a_menu_item.item)
		end

feature -- Finding Menu Items

	item_with_tag (a_tag: INTEGER): NS_MENU_ITEM
			-- Returns the first menu item in the receiver with the specified tag.
		do
			create Result.share_from_pointer ({NS_MENU_API}.item_with_tag (item, a_tag.item))
		end

	item_with_title (a_title: NS_STRING): NS_MENU_ITEM
			-- Returns the first menu item in the receiver with a specified title.
		do
			create Result.share_from_pointer ({NS_MENU_API}.item_with_title (item, a_title.item))
		end

	item_at_index (a_index: INTEGER): NS_MENU_ITEM
			-- Returns the menu item at a specific location of the receiver.
		do
			create Result.share_from_pointer ({NS_MENU_API}.item_at_index (item, a_index))
		end

	number_of_items: INTEGER
			-- Returns the number of menu items in the receiver, including separator items.
		do
			Result := {NS_MENU_API}.number_of_items (item)
		end

	item_array: NS_ARRAY [NS_MENU_ITEM]
			-- Returns an array containing the receiver's menu items.
		do
			create Result.share_from_pointer ({NS_MENU_API}.item_array (item))
		end

feature {NONE} -- Objective-C implementation

	frozen menu_new: POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSMenu new];"
		end

--+ (void)setMenuZone:(NSZone *)aZone;
--+ (NSZone *)menuZone;

--+ (void)popUpContextMenu:(NSMenu*)menu withEvent:(NSEvent*)event forView:(NSView*)view;
--+ (void)popUpContextMenu:(NSMenu*)menu withEvent:(NSEvent*)event forView:(NSView*)view withFont:(NSFont*)font;

--+ (void)setMenuBarVisible:(BOOL)visible;
--+ (BOOL)menuBarVisible;

--- (id)initWithTitle:(NSString *)aTitle;

	frozen menu_set_title (a_menu: POINTER; a_nsstring: POINTER)
			-- - (void)setTitle:(NSString *)aString;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSMenu*)$a_menu setTitle: $a_nsstring];"
		end

--- (NSString *)title;

--- (void)setSupermenu:(NSMenu *)supermenu;
--- (NSMenu *)supermenu;
--    // Never call the set method directly it is there only for subclassers.

	frozen menu_insert_item_at_index (a_menu: POINTER; a_menu_item: POINTER; a_index: INTEGER)
			-- - (void)insertItem:(NSMenuItem *)newItem atIndex:(NSInteger)index;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSMenu*)$a_menu insertItem: $a_menu_item atIndex: $a_index];"
		end

	frozen menu_add_item (a_menu: POINTER; a_menu_item: POINTER)
			--- (void)addItem:(NSMenuItem *)newItem;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSMenu*)$a_menu addItem: $a_menu_item];"
		end

--- (NSMenuItem *)insertItemWithTitle:(NSString *)aString action:(SEL)aSelector keyEquivalent:(NSString *)charCode atIndex:(NSInteger)index;
--- (NSMenuItem *)addItemWithTitle:(NSString *)aString action:(SEL)aSelector keyEquivalent:(NSString *)charCode;
	frozen menu_remove_item_at_index (a_menu: POINTER; a_index: INTEGER)
			-- - (void)removeItemAtIndex:(NSInteger)index;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSMenu*)$a_menu removeItemAtIndex: $a_index];"
		end
--- (void)removeItem:(NSMenuItem *)item;
--- (void)setSubmenu:(NSMenu *)aMenu forItem:(NSMenuItem *)anItem;

--- (NSArray *)itemArray;
--- (NSInteger)numberOfItems;

--- (NSInteger)indexOfItem:(NSMenuItem *)index;
--- (NSInteger)indexOfItemWithTitle:(NSString *)aTitle;
--- (NSInteger)indexOfItemWithTag:(NSInteger)aTag;
--- (NSInteger)indexOfItemWithRepresentedObject:(id)object;
--- (NSInteger)indexOfItemWithSubmenu:(NSMenu *)submenu;
--- (NSInteger)indexOfItemWithTarget:(id)target andAction:(SEL)actionSelector;

--- (NSMenuItem *)itemAtIndex:(NSInteger)index;
--- (NSMenuItem *)itemWithTitle:(NSString *)aTitle;
--- (NSMenuItem *)itemWithTag:(NSInteger)tag;

--- (void)setAutoenablesItems:(BOOL)flag;
--- (BOOL)autoenablesItems;

--- (BOOL)performKeyEquivalent:(NSEvent *)theEvent;
--- (void)update;

--- (void)setMenuChangedMessagesEnabled:(BOOL)flag;
--- (BOOL)menuChangedMessagesEnabled;

--- (void)itemChanged:(NSMenuItem *)item;

--- (void)helpRequested:(NSEvent *)eventPtr;

--- (void)setMenuRepresentation:(id)menuRep;
--- (id)menuRepresentation;

--- (void)setContextMenuRepresentation:(id)menuRep;
--- (id)contextMenuRepresentation;

--- (void)setTearOffMenuRepresentation:(id)menuRep;
--- (id)tearOffMenuRepresentation;

--- (BOOL)isTornOff;

--    // These methods are platform specific.  They really make little sense on Windows.  Their use is discouraged.
--- (NSMenu *)attachedMenu;
--- (BOOL)isAttached;
--- (void)sizeToFit;
--- (NSPoint)locationForSubmenu:(NSMenu *)aSubmenu;

--- (void)performActionForItemAtIndex:(NSInteger)index;

--- (void)setDelegate:(idt)anObject;
--- (id)delegate;

--- (CGFloat)menuBarHeight;

--/* Dismisses the menu and ends all menu tracking */
--- (void)cancelTracking;

--/* Returns the highlighted item in the menu, or nil if no item in the menu is highlighted */
--- (NSMenuItem *)highlightedItem;

--- (void)setShowsStateColumn:(BOOL)showsState;
--- (BOOL)showsStateColumn;

--@end

--@interface NSMenu(NSSubmenuAction)
--- (void)submenuAction:(id)sender;
--@end

--@interface NSObject(NSMenuValidation)
--- (BOOL)validateMenuItem:(NSMenuItem *)menuItem;
--@end

--@interface NSObject(NSMenuDelegate)
--- (void)menuNeedsUpdate:(NSMenu*)menu;
--- (NSInteger)numberOfItemsInMenu:(NSMenu*)menu;
--- (BOOL)menu:(NSMenu*)menu updateItem:(NSMenuItem*)item atIndex:(NSInteger)index shouldCancel:(BOOL)shouldCancel;
--    // implement either the first one or the next two to populate the menu
--- (BOOL)menuHasKeyEquivalent:(NSMenu*)menu forEvent:(NSEvent*)event target:(id*)target action:(SEL*)action;
--    // bypasses populating the menu for checking for key equivalents. set target and action on return

--/* indicates that the menu is being opened (displayed) or closed (hidden).  Do not modify the structure of the menu or the menu items from within these callbacks. */
--- (void)menuWillOpen:(NSMenu *)menu;
--- (void)menuDidClose:(NSMenu *)menu;

--/* Indicates that menu is about to highlight item.  Only one item per menu can be highlighted at a time.  If item is nil, it means all items in the menu are about to be unhighlighted. */
--- (void)menu:(NSMenu *)menu willHighlightItem:(NSMenuItem *)item;


end
