note
	description: "Summary description for {NS_COMBO_BOX}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	NS_COMBO_BOX

inherit
	NS_TEXT_FIELD
		redefine
			new
		end

create
	new

feature

	new
			--
		do
			cocoa_object := combo_box_new
		end

feature {NONE} -- Objective-C implementation

	frozen combo_box_new: POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSComboBox new];"
		end

--- (BOOL)hasVerticalScroller;
--- (void)setHasVerticalScroller:(BOOL)flag;
--- (NSSize)intercellSpacing;
--- (void)setIntercellSpacing:(NSSize)aSize;
--- (CGFloat)itemHeight;
--- (void)setItemHeight:(CGFloat)itemHeight;
--- (NSInteger)numberOfVisibleItems;
--- (void)setNumberOfVisibleItems:(NSInteger)visibleItems;

--- (void)setButtonBordered:(BOOL)flag;
--- (BOOL)isButtonBordered;

--- (void)reloadData;
--- (void)noteNumberOfItemsChanged;

--- (void)setUsesDataSource:(BOOL)flag;
--- (BOOL)usesDataSource;

--- (void)scrollItemAtIndexToTop:(NSInteger)index;
--- (void)scrollItemAtIndexToVisible:(NSInteger)index;

--- (void)selectItemAtIndex:(NSInteger)index;
--- (void)deselectItemAtIndex:(NSInteger)index;
--- (NSInteger)indexOfSelectedItem;
--- (NSInteger)numberOfItems;

--- (BOOL)completes;
--- (void)setCompletes:(BOOL)completes;

--/* These two methods can only be used when usesDataSource is YES */
--- (id)dataSource;
--- (void)setDataSource:(id)aSource;

--/* These methods can only be used when usesDataSource is NO */
--- (void)addItemWithObjectValue:(id)object;
--- (void)addItemsWithObjectValues:(NSArray *)objects;
--- (void)insertItemWithObjectValue:(id)object atIndex:(NSInteger)index;
--- (void)removeItemWithObjectValue:(id)object;
--- (void)removeItemAtIndex:(NSInteger)index;
--- (void)removeAllItems;
--- (void)selectItemWithObjectValue:(id)object;
--- (id)itemObjectValueAtIndex:(NSInteger)index;
--- (id)objectValueOfSelectedItem;
--- (NSInteger)indexOfItemWithObjectValue:(id)object;
--- (NSArray *)objectValues;



end
