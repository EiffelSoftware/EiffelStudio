note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_TOOLBAR

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_identifier_,
	make

feature {NONE} -- Initialization

	make_with_identifier_ (a_identifier: detachable NS_STRING)
			-- Initialize `Current'.
		local
			a_identifier__item: POINTER
		do
			if attached a_identifier as a_identifier_attached then
				a_identifier__item := a_identifier_attached.item
			end
			make_with_pointer (objc_init_with_identifier_(allocate_object, a_identifier__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSToolbar Externals

	objc_init_with_identifier_ (an_item: POINTER; a_identifier: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSToolbar *)$an_item initWithIdentifier:$a_identifier];
			 ]"
		end

	objc_insert_item_with_item_identifier__at_index_ (an_item: POINTER; a_item_identifier: POINTER; a_index: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSToolbar *)$an_item insertItemWithItemIdentifier:$a_item_identifier atIndex:$a_index];
			 ]"
		end

	objc_remove_item_at_index_ (an_item: POINTER; a_index: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSToolbar *)$an_item removeItemAtIndex:$a_index];
			 ]"
		end

	objc_set_delegate_ (an_item: POINTER; a_delegate: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSToolbar *)$an_item setDelegate:$a_delegate];
			 ]"
		end

	objc_delegate (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSToolbar *)$an_item delegate];
			 ]"
		end

	objc_set_visible_ (an_item: POINTER; a_shown: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSToolbar *)$an_item setVisible:$a_shown];
			 ]"
		end

	objc_is_visible (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSToolbar *)$an_item isVisible];
			 ]"
		end

	objc_run_customization_palette_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSToolbar *)$an_item runCustomizationPalette:$a_sender];
			 ]"
		end

	objc_customization_palette_is_running (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSToolbar *)$an_item customizationPaletteIsRunning];
			 ]"
		end

	objc_set_display_mode_ (an_item: POINTER; a_display_mode: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSToolbar *)$an_item setDisplayMode:$a_display_mode];
			 ]"
		end

	objc_display_mode (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSToolbar *)$an_item displayMode];
			 ]"
		end

	objc_set_selected_item_identifier_ (an_item: POINTER; a_item_identifier: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSToolbar *)$an_item setSelectedItemIdentifier:$a_item_identifier];
			 ]"
		end

	objc_selected_item_identifier (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSToolbar *)$an_item selectedItemIdentifier];
			 ]"
		end

	objc_set_size_mode_ (an_item: POINTER; a_size_mode: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSToolbar *)$an_item setSizeMode:$a_size_mode];
			 ]"
		end

	objc_size_mode (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSToolbar *)$an_item sizeMode];
			 ]"
		end

	objc_set_shows_baseline_separator_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSToolbar *)$an_item setShowsBaselineSeparator:$a_flag];
			 ]"
		end

	objc_shows_baseline_separator (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSToolbar *)$an_item showsBaselineSeparator];
			 ]"
		end

	objc_set_allows_user_customization_ (an_item: POINTER; a_allow_customization: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSToolbar *)$an_item setAllowsUserCustomization:$a_allow_customization];
			 ]"
		end

	objc_allows_user_customization (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSToolbar *)$an_item allowsUserCustomization];
			 ]"
		end

	objc_identifier (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSToolbar *)$an_item identifier];
			 ]"
		end

	objc_items (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSToolbar *)$an_item items];
			 ]"
		end

	objc_visible_items (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSToolbar *)$an_item visibleItems];
			 ]"
		end

	objc_set_autosaves_configuration_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSToolbar *)$an_item setAutosavesConfiguration:$a_flag];
			 ]"
		end

	objc_autosaves_configuration (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSToolbar *)$an_item autosavesConfiguration];
			 ]"
		end

	objc_set_configuration_from_dictionary_ (an_item: POINTER; a_config_dict: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSToolbar *)$an_item setConfigurationFromDictionary:$a_config_dict];
			 ]"
		end

	objc_configuration_dictionary (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSToolbar *)$an_item configurationDictionary];
			 ]"
		end

	objc_validate_visible_items (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSToolbar *)$an_item validateVisibleItems];
			 ]"
		end

feature -- NSToolbar

	insert_item_with_item_identifier__at_index_ (a_item_identifier: detachable NS_STRING; a_index: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
			a_item_identifier__item: POINTER
		do
			if attached a_item_identifier as a_item_identifier_attached then
				a_item_identifier__item := a_item_identifier_attached.item
			end
			objc_insert_item_with_item_identifier__at_index_ (item, a_item_identifier__item, a_index)
		end

	remove_item_at_index_ (a_index: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_remove_item_at_index_ (item, a_index)
		end

	set_delegate_ (a_delegate: detachable NS_TOOLBAR_DELEGATE_PROTOCOL)
			-- Auto generated Objective-C wrapper.
		local
			a_delegate__item: POINTER
		do
			if attached a_delegate as a_delegate_attached then
				a_delegate__item := a_delegate_attached.item
			end
			objc_set_delegate_ (item, a_delegate__item)
		end

	delegate: detachable NS_TOOLBAR_DELEGATE_PROTOCOL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_delegate (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like delegate} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like delegate} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_visible_ (a_shown: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_visible_ (item, a_shown)
		end

	is_visible: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_visible (item)
		end

	run_customization_palette_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_run_customization_palette_ (item, a_sender__item)
		end

	customization_palette_is_running: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_customization_palette_is_running (item)
		end

	set_display_mode_ (a_display_mode: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_display_mode_ (item, a_display_mode)
		end

	display_mode: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_display_mode (item)
		end

	set_selected_item_identifier_ (a_item_identifier: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_item_identifier__item: POINTER
		do
			if attached a_item_identifier as a_item_identifier_attached then
				a_item_identifier__item := a_item_identifier_attached.item
			end
			objc_set_selected_item_identifier_ (item, a_item_identifier__item)
		end

	selected_item_identifier: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_selected_item_identifier (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like selected_item_identifier} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like selected_item_identifier} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_size_mode_ (a_size_mode: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_size_mode_ (item, a_size_mode)
		end

	size_mode: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_size_mode (item)
		end

	set_shows_baseline_separator_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_shows_baseline_separator_ (item, a_flag)
		end

	shows_baseline_separator: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_shows_baseline_separator (item)
		end

	set_allows_user_customization_ (a_allow_customization: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_allows_user_customization_ (item, a_allow_customization)
		end

	allows_user_customization: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_allows_user_customization (item)
		end

	identifier: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_identifier (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like identifier} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like identifier} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	items: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_items (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like items} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like items} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	visible_items: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_visible_items (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like visible_items} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like visible_items} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_autosaves_configuration_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_autosaves_configuration_ (item, a_flag)
		end

	autosaves_configuration: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_autosaves_configuration (item)
		end

	set_configuration_from_dictionary_ (a_config_dict: detachable NS_DICTIONARY)
			-- Auto generated Objective-C wrapper.
		local
			a_config_dict__item: POINTER
		do
			if attached a_config_dict as a_config_dict_attached then
				a_config_dict__item := a_config_dict_attached.item
			end
			objc_set_configuration_from_dictionary_ (item, a_config_dict__item)
		end

	configuration_dictionary: detachable NS_DICTIONARY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_configuration_dictionary (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like configuration_dictionary} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like configuration_dictionary} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	validate_visible_items
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_validate_visible_items (item)
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSToolbar"
		end

end
