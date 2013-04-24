note
	description: "Summary description for {NS_TOOLBAR_API}."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_TOOLBAR_API

feature -- Creating an NSToolbar Object

	frozen init_with_identifier (a_ns_toolbar: POINTER; a_identifier: POINTER): POINTER
			-- - (id)initWithIdentifier: (NSString *) identifier
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSToolbar*)$a_ns_toolbar initWithIdentifier: $a_identifier];"
		end

feature -- Toolbar Attributes

	frozen display_mode (a_ns_toolbar: POINTER): INTEGER
			-- - (NSToolbarDisplayMode)displayMode
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSToolbar*)$a_ns_toolbar displayMode];"
		end

	frozen set_display_mode (a_ns_toolbar: POINTER; a_display_mode: INTEGER)
			-- - (void)setDisplayMode: (NSToolbarDisplayMode) displayMode
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSToolbar*)$a_ns_toolbar setDisplayMode: $a_display_mode];"
		end

	frozen shows_baseline_separator (a_ns_toolbar: POINTER): BOOLEAN
			-- - (BOOL)showsBaselineSeparator
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSToolbar*)$a_ns_toolbar showsBaselineSeparator];"
		end

	frozen set_shows_baseline_separator (a_ns_toolbar: POINTER; a_flag: BOOLEAN)
			-- - (void)setShowsBaselineSeparator: (BOOL) flag
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSToolbar*)$a_ns_toolbar setShowsBaselineSeparator: $a_flag];"
		end

	frozen allows_user_customization (a_ns_toolbar: POINTER): BOOLEAN
			-- - (BOOL)allowsUserCustomization
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSToolbar*)$a_ns_toolbar allowsUserCustomization];"
		end

	frozen set_allows_user_customization (a_ns_toolbar: POINTER; a_allow_customization: BOOLEAN)
			-- - (void)setAllowsUserCustomization: (BOOL) allowCustomization
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSToolbar*)$a_ns_toolbar setAllowsUserCustomization: $a_allow_customization];"
		end

	frozen identifier (a_ns_toolbar: POINTER): POINTER
			-- - (NSString *)identifier
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSToolbar*)$a_ns_toolbar identifier];"
		end

	frozen items (a_ns_toolbar: POINTER): POINTER
			-- - (NSArray *)items
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSToolbar*)$a_ns_toolbar items];"
		end

	frozen visible_items (a_ns_toolbar: POINTER): POINTER
			-- - (NSArray *)visibleItems
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSToolbar*)$a_ns_toolbar visibleItems];"
		end

	frozen size_mode (a_ns_toolbar: POINTER): INTEGER
			-- - (NSToolbarSizeMode)sizeMode
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSToolbar*)$a_ns_toolbar sizeMode];"
		end

	frozen set_size_mode (a_ns_toolbar: POINTER; a_size_mode: INTEGER)
			-- - (void)setSizeMode: (NSToolbarSizeMode) sizeMode
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSToolbar*)$a_ns_toolbar setSizeMode: $a_size_mode];"
		end

feature -- Managing the Delegate

	frozen delegate (a_ns_toolbar: POINTER): POINTER
			-- - (id)delegate
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSToolbar*)$a_ns_toolbar delegate];"
		end

	frozen set_delegate (a_ns_toolbar: POINTER; a_delegate: POINTER)
			-- - (void)setDelegate: (id) delegate
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSToolbar*)$a_ns_toolbar setDelegate: *(id*)$a_delegate];"
		end

feature -- Managing Items on the Toolbar

	frozen insert_item_with_item_identifier_at_index (a_ns_toolbar: POINTER; a_item_identifier: POINTER; a_index: INTEGER)
			-- - (void)insertItemWithItemIdentifier: (NSString *) itemIdentifier atIndex: (NSString *) index
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSToolbar*)$a_ns_toolbar insertItemWithItemIdentifier: $a_item_identifier atIndex: $a_index];"
		end

	frozen remove_item_at_index (a_ns_toolbar: POINTER; a_index: INTEGER)
			-- - (void)removeItemAtIndex: (NSInteger) index
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSToolbar*)$a_ns_toolbar removeItemAtIndex: $a_index];"
		end

	frozen toolbar_will_add_item (a_ns_toolbar: POINTER; a_notification: POINTER)
			-- - (void)toolbarWillAddItem: (NSNotification *) notification
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSToolbar*)$a_ns_toolbar toolbarWillAddItem: $a_notification];"
		end

	frozen toolbar_did_remove_item (a_ns_toolbar: POINTER; a_notification: POINTER)
			-- - (void)toolbarDidRemoveItem: (NSNotification *) notification
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSToolbar*)$a_ns_toolbar toolbarDidRemoveItem: $a_notification];"
		end

	frozen set_selected_item_identifier (a_ns_toolbar: POINTER; a_item_identifier: POINTER)
			-- - (void)setSelectedItemIdentifier: (NSString *) itemIdentifier
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSToolbar*)$a_ns_toolbar setSelectedItemIdentifier: $a_item_identifier];"
		end

	frozen selected_item_identifier (a_ns_toolbar: POINTER): POINTER
			-- - (NSString *)selectedItemIdentifier
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSToolbar*)$a_ns_toolbar selectedItemIdentifier];"
		end

feature -- Displaying the Toolbar

	frozen is_visible (a_ns_toolbar: POINTER): BOOLEAN
			-- - (BOOL)isVisible
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSToolbar*)$a_ns_toolbar isVisible];"
		end

	frozen set_visible (a_ns_toolbar: POINTER; a_shown: BOOLEAN)
			-- - (void)setVisible: (BOOL) shown
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSToolbar*)$a_ns_toolbar setVisible: $a_shown];"
		end

feature -- Toolbar Customization

	frozen run_customization_palette (a_ns_toolbar: POINTER; a_sender: POINTER)
			-- - (void)runCustomizationPalette: (id) sender
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSToolbar*)$a_ns_toolbar runCustomizationPalette: *(id*)$a_sender];"
		end

	frozen customization_palette_is_running (a_ns_toolbar: POINTER): BOOLEAN
			-- - (BOOL)customizationPaletteIsRunning
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSToolbar*)$a_ns_toolbar customizationPaletteIsRunning];"
		end

feature -- Autosaving the Configuration

	frozen autosaves_configuration (a_ns_toolbar: POINTER): BOOLEAN
			-- - (BOOL)autosavesConfiguration
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSToolbar*)$a_ns_toolbar autosavesConfiguration];"
		end

	frozen set_autosaves_configuration (a_ns_toolbar: POINTER; a_flag: BOOLEAN)
			-- - (void)setAutosavesConfiguration: (BOOL) flag
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSToolbar*)$a_ns_toolbar setAutosavesConfiguration: $a_flag];"
		end

	frozen configuration_dictionary (a_ns_toolbar: POINTER): POINTER
			-- - (NSDictionary *)configurationDictionary
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSToolbar*)$a_ns_toolbar configurationDictionary];"
		end

	frozen set_configuration_from_dictionary (a_ns_toolbar: POINTER; a_config_dict: POINTER)
			-- - (void)setConfigurationFromDictionary: (NSDictionary *) configDict
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSToolbar*)$a_ns_toolbar setConfigurationFromDictionary: $a_config_dict];"
		end

feature -- Working With Item Identifiers

	frozen toolbar_item_for_item_identifier_will_be_inserted_into_toolbar (a_ns_toolbar: POINTER; a_toolbar: POINTER; a_item_identifier: POINTER; a_flag: BOOLEAN): POINTER
			-- - (NSToolbarItem *)toolbar: (NSToolbar *) toolbar itemForItemIdentifier: (NSToolbar *) itemIdentifier willBeInsertedIntoToolbar: (NSToolbar *) flag
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSToolbar*)$a_ns_toolbar toolbar: $a_toolbar itemForItemIdentifier: $a_item_identifier willBeInsertedIntoToolbar: $a_flag];"
		end

	frozen toolbar_allowed_item_identifiers (a_ns_toolbar: POINTER; a_toolbar: POINTER): POINTER
			-- - (NSArray *)toolbarAllowedItemIdentifiers: (NSToolbar*) toolbar
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSToolbar*)$a_ns_toolbar toolbarAllowedItemIdentifiers: $a_toolbar];"
		end

	frozen toolbar_default_item_identifiers (a_ns_toolbar: POINTER; a_toolbar: POINTER): POINTER
			-- - (NSArray *)toolbarDefaultItemIdentifiers: (NSToolbar*) toolbar
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSToolbar*)$a_ns_toolbar toolbarDefaultItemIdentifiers: $a_toolbar];"
		end

	frozen toolbar_selectable_item_identifiers (a_ns_toolbar: POINTER; a_toolbar: POINTER): POINTER
			-- - (NSArray *)toolbarSelectableItemIdentifiers: (NSToolbar *) toolbar
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSToolbar*)$a_ns_toolbar toolbarSelectableItemIdentifiers: $a_toolbar];"
		end

	frozen validate_visible_items (a_ns_toolbar: POINTER)
			-- - (void)validateVisibleItems
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSToolbar*)$a_ns_toolbar validateVisibleItems];"
		end

end
