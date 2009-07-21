note
	description: "Wrapper for NSToolbar."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_TOOLBAR

inherit
	NS_OBJECT

feature -- Creating an NSToolbar Object

	init_with_identifier (a_identifier: NS_STRING): NS_OBJECT
			-- Initializes a newly allocated toolbar with the specified identifier.
		do
			create Result.share_from_pointer ({NS_TOOLBAR_API}.init_with_identifier (item, a_identifier.item))
		end

feature -- Toolbar Attributes

	display_mode: INTEGER
			-- Returns the receiver`s display mode.
		do
			Result := {NS_TOOLBAR_API}.display_mode (item)
		end

	set_display_mode (a_display_mode: INTEGER)
			-- Sets the receiver`s display mode.
		do
			{NS_TOOLBAR_API}.set_display_mode (item, a_display_mode.item)
		end

	shows_baseline_separator: BOOLEAN
			-- Returns a Boolean value that indicates whether the toolbar shows the separator between the toolbar and the main window contents.
		do
			Result := {NS_TOOLBAR_API}.shows_baseline_separator (item)
		end

	set_shows_baseline_separator (a_flag: BOOLEAN)
			-- Sets whether the toolbar shows the separator between the toolbar and the main window contents.
		do
			{NS_TOOLBAR_API}.set_shows_baseline_separator (item, a_flag.item)
		end

	allows_user_customization: BOOLEAN
			-- Returns a Boolean value that indicates whether users are allowed to modify the toolbar.
		do
			Result := {NS_TOOLBAR_API}.allows_user_customization (item)
		end

	set_allows_user_customization (a_allow_customization: BOOLEAN)
			-- Sets whether users are allowed to modify the toolbar.
		do
			{NS_TOOLBAR_API}.set_allows_user_customization (item, a_allow_customization.item)
		end

	identifier: NS_STRING
			-- Returns the receiver`s identifier.
		do
			create Result.share_from_pointer ({NS_TOOLBAR_API}.identifier (item))
		end

	items: NS_ARRAY [NS_TOOLBAR_ITEM]
			-- Returns the receiver's current items, in order.
		do
			create Result.share_from_pointer ({NS_TOOLBAR_API}.items (item))
		end

	visible_items: NS_ARRAY [NS_TOOLBAR_ITEM]
			-- Returns the receiver`s currently visible items.
		do
			create Result.share_from_pointer ({NS_TOOLBAR_API}.visible_items (item))
		end

	size_mode: INTEGER
			-- Returns the receiver`s size mode.
		do
			Result := {NS_TOOLBAR_API}.size_mode (item)
		end

	set_size_mode (a_size_mode: INTEGER)
			-- Sets the receiver`s size mode.
		do
			{NS_TOOLBAR_API}.set_size_mode (item, a_size_mode.item)
		end

feature -- Managing the Delegate

	delegate: NS_OBJECT
			-- Returns the receiver`s delegate.
		do
			create Result.share_from_pointer ({NS_TOOLBAR_API}.delegate (item))
		end

	set_delegate (a_delegate: NS_OBJECT)
			-- Sets the receiver`s delegate.
		do
			{NS_TOOLBAR_API}.set_delegate (item, a_delegate.item)
		end

feature -- Managing Items on the Toolbar

	insert_item_with_item_identifier_at_index (a_item_identifier: NS_STRING; a_index: INTEGER)
			-- Inserts the specified item at the specified index.
		do
			{NS_TOOLBAR_API}.insert_item_with_item_identifier_at_index (item, a_item_identifier.item, a_index.item)
		end

	remove_item_at_index (a_index: INTEGER)
			-- Removes the specified item.
		do
			{NS_TOOLBAR_API}.remove_item_at_index (item, a_index.item)
		end

	toolbar_will_add_item (a_notification: NS_NOTIFICATION)
			-- Sent just before a new item is added to a toolbar.
		do
			{NS_TOOLBAR_API}.toolbar_will_add_item (item, a_notification.item)
		end

	toolbar_did_remove_item (a_notification: NS_NOTIFICATION)
			-- Sent just after an item has been removed from a toolbar.
		do
			{NS_TOOLBAR_API}.toolbar_did_remove_item (item, a_notification.item)
		end

	set_selected_item_identifier (a_item_identifier: NS_STRING)
			-- Sets the receiver&#8217;s selected item to the specified toolbar item.
		do
			{NS_TOOLBAR_API}.set_selected_item_identifier (item, a_item_identifier.item)
		end

	selected_item_identifier: NS_STRING
			-- Returns the identifier of the receiver`s currently selected item, or <code>nil</code> if there is no selection.
		do
			create Result.share_from_pointer ({NS_TOOLBAR_API}.selected_item_identifier (item))
		end

feature -- Displaying the Toolbar

	is_visible: BOOLEAN
			-- Returns a Boolean value that indicates whether the receiver is visible.
		do
			Result := {NS_TOOLBAR_API}.is_visible (item)
		end

	set_visible (a_shown: BOOLEAN)
			-- Sets whether the receiver is visible or hidden.
		do
			{NS_TOOLBAR_API}.set_visible (item, a_shown.item)
		end

feature -- Toolbar Customization

	run_customization_palette (a_sender: NS_OBJECT)
			-- Runs the receiver`s customization palette.
		do
			{NS_TOOLBAR_API}.run_customization_palette (item, a_sender.item)
		end

	customization_palette_is_running: BOOLEAN
			-- Returns a Boolean value that indicates whether the receiver`s customization palette is running (in use).
		do
			Result := {NS_TOOLBAR_API}.customization_palette_is_running (item)
		end

feature -- Autosaving the Configuration

	autosaves_configuration: BOOLEAN
			-- Returns a Boolean value that indicates whether the receiver autosaves its configuration.
		do
			Result := {NS_TOOLBAR_API}.autosaves_configuration (item)
		end

	set_autosaves_configuration (a_flag: BOOLEAN)
			-- Sets whether the receiver autosaves its configuration.
		do
			{NS_TOOLBAR_API}.set_autosaves_configuration (item, a_flag.item)
		end

	configuration_dictionary: NS_DICTIONARY
			-- Returns the receiver`s configuration as a dictionary.
		do
			create Result.share_from_pointer ({NS_TOOLBAR_API}.configuration_dictionary (item))
		end

	set_configuration_from_dictionary (a_config_dict: NS_DICTIONARY)
			-- Sets the receiver`s configuration using <em>configDict</em>.
		do
			{NS_TOOLBAR_API}.set_configuration_from_dictionary (item, a_config_dict.item)
		end

feature -- Working With Item Identifiers

	toolbar_item_for_item_identifier_will_be_inserted_into_toolbar (a_toolbar: NS_TOOLBAR; a_item_identifier: NS_STRING; a_flag: BOOLEAN): NS_TOOLBAR_ITEM
			-- Sent to request a new toolbar item; returns a toolbar item of the identified kind for the specified toolbar.
		do
			create Result.share_from_pointer ({NS_TOOLBAR_API}.toolbar_item_for_item_identifier_will_be_inserted_into_toolbar (item, a_toolbar.item, a_item_identifier.item, a_flag.item))
		end

	toolbar_allowed_item_identifiers (a_toolbar: NS_TOOLBAR): NS_ARRAY [NS_OBJECT]
			-- Sent to discover the allowed item identifiers for a toolbar.
		do
			create Result.share_from_pointer ({NS_TOOLBAR_API}.toolbar_allowed_item_identifiers (item, a_toolbar.item))
		end

	toolbar_default_item_identifiers (a_toolbar: NS_TOOLBAR): NS_ARRAY [NS_OBJECT]
			-- Sent to discover the default item identifiers for a toolbar.
		do
			create Result.share_from_pointer ({NS_TOOLBAR_API}.toolbar_default_item_identifiers (item, a_toolbar.item))
		end

	toolbar_selectable_item_identifiers (a_toolbar: NS_TOOLBAR): NS_ARRAY [NS_OBJECT]
			-- Sent to discover the selectable item identifiers for a toolbar.
		do
			create Result.share_from_pointer ({NS_TOOLBAR_API}.toolbar_selectable_item_identifiers (item, a_toolbar.item))
		end

	validate_visible_items
			-- Called on window updates to validate the visible items.
		do
			{NS_TOOLBAR_API}.validate_visible_items (item)
		end

end
