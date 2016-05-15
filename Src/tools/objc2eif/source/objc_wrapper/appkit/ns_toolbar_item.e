note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_TOOLBAR_ITEM

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end

	NS_COPYING_PROTOCOL
	NS_VALIDATED_USER_INTERFACE_ITEM_PROTOCOL
		undefine
			action,
			objc_action,
			tag,
			objc_tag
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_item_identifier_,
	make

feature {NONE} -- Initialization

	make_with_item_identifier_ (a_item_identifier: detachable NS_STRING)
			-- Initialize `Current'.
		local
			a_item_identifier__item: POINTER
		do
			if attached a_item_identifier as a_item_identifier_attached then
				a_item_identifier__item := a_item_identifier_attached.item
			end
			make_with_pointer (objc_init_with_item_identifier_(allocate_object, a_item_identifier__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSToolbarItem Externals

	objc_init_with_item_identifier_ (an_item: POINTER; a_item_identifier: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSToolbarItem *)$an_item initWithItemIdentifier:$a_item_identifier];
			 ]"
		end

	objc_item_identifier (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSToolbarItem *)$an_item itemIdentifier];
			 ]"
		end

	objc_toolbar (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSToolbarItem *)$an_item toolbar];
			 ]"
		end

	objc_set_label_ (an_item: POINTER; a_label: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSToolbarItem *)$an_item setLabel:$a_label];
			 ]"
		end

	objc_label (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSToolbarItem *)$an_item label];
			 ]"
		end

	objc_set_palette_label_ (an_item: POINTER; a_palette_label: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSToolbarItem *)$an_item setPaletteLabel:$a_palette_label];
			 ]"
		end

	objc_palette_label (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSToolbarItem *)$an_item paletteLabel];
			 ]"
		end

	objc_set_tool_tip_ (an_item: POINTER; a_tool_tip: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSToolbarItem *)$an_item setToolTip:$a_tool_tip];
			 ]"
		end

	objc_tool_tip (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSToolbarItem *)$an_item toolTip];
			 ]"
		end

	objc_set_menu_form_representation_ (an_item: POINTER; a_menu_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSToolbarItem *)$an_item setMenuFormRepresentation:$a_menu_item];
			 ]"
		end

	objc_menu_form_representation (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSToolbarItem *)$an_item menuFormRepresentation];
			 ]"
		end

	objc_set_tag_ (an_item: POINTER; a_tag: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSToolbarItem *)$an_item setTag:$a_tag];
			 ]"
		end

	objc_tag (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSToolbarItem *)$an_item tag];
			 ]"
		end

	objc_set_target_ (an_item: POINTER; a_target: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSToolbarItem *)$an_item setTarget:$a_target];
			 ]"
		end

	objc_target (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSToolbarItem *)$an_item target];
			 ]"
		end

	objc_set_action_ (an_item: POINTER; a_action: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSToolbarItem *)$an_item setAction:$a_action];
			 ]"
		end

	objc_action (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSToolbarItem *)$an_item action];
			 ]"
		end

	objc_set_enabled_ (an_item: POINTER; a_enabled: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSToolbarItem *)$an_item setEnabled:$a_enabled];
			 ]"
		end

	objc_is_enabled (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSToolbarItem *)$an_item isEnabled];
			 ]"
		end

	objc_set_image_ (an_item: POINTER; a_image: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSToolbarItem *)$an_item setImage:$a_image];
			 ]"
		end

	objc_image (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSToolbarItem *)$an_item image];
			 ]"
		end

	objc_set_view_ (an_item: POINTER; a_view: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSToolbarItem *)$an_item setView:$a_view];
			 ]"
		end

	objc_view (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSToolbarItem *)$an_item view];
			 ]"
		end

	objc_set_min_size_ (an_item: POINTER; a_size: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSToolbarItem *)$an_item setMinSize:*((NSSize *)$a_size)];
			 ]"
		end

	objc_min_size (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSSize *)$result_pointer = [(NSToolbarItem *)$an_item minSize];
			 ]"
		end

	objc_set_max_size_ (an_item: POINTER; a_size: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSToolbarItem *)$an_item setMaxSize:*((NSSize *)$a_size)];
			 ]"
		end

	objc_max_size (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSSize *)$result_pointer = [(NSToolbarItem *)$an_item maxSize];
			 ]"
		end

	objc_set_visibility_priority_ (an_item: POINTER; a_visibility_priority: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSToolbarItem *)$an_item setVisibilityPriority:$a_visibility_priority];
			 ]"
		end

	objc_visibility_priority (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSToolbarItem *)$an_item visibilityPriority];
			 ]"
		end

	objc_validate (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSToolbarItem *)$an_item validate];
			 ]"
		end

	objc_set_autovalidates_ (an_item: POINTER; a_resistance: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSToolbarItem *)$an_item setAutovalidates:$a_resistance];
			 ]"
		end

	objc_autovalidates (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSToolbarItem *)$an_item autovalidates];
			 ]"
		end

	objc_allows_duplicates_in_toolbar (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSToolbarItem *)$an_item allowsDuplicatesInToolbar];
			 ]"
		end

feature -- NSToolbarItem

	item_identifier: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_item_identifier (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like item_identifier} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like item_identifier} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	toolbar: detachable NS_TOOLBAR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_toolbar (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like toolbar} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like toolbar} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_label_ (a_label: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_label__item: POINTER
		do
			if attached a_label as a_label_attached then
				a_label__item := a_label_attached.item
			end
			objc_set_label_ (item, a_label__item)
		end

	label: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_label (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like label} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like label} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_palette_label_ (a_palette_label: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_palette_label__item: POINTER
		do
			if attached a_palette_label as a_palette_label_attached then
				a_palette_label__item := a_palette_label_attached.item
			end
			objc_set_palette_label_ (item, a_palette_label__item)
		end

	palette_label: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_palette_label (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like palette_label} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like palette_label} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_tool_tip_ (a_tool_tip: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_tool_tip__item: POINTER
		do
			if attached a_tool_tip as a_tool_tip_attached then
				a_tool_tip__item := a_tool_tip_attached.item
			end
			objc_set_tool_tip_ (item, a_tool_tip__item)
		end

	tool_tip: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_tool_tip (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like tool_tip} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like tool_tip} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_menu_form_representation_ (a_menu_item: detachable NS_MENU_ITEM)
			-- Auto generated Objective-C wrapper.
		local
			a_menu_item__item: POINTER
		do
			if attached a_menu_item as a_menu_item_attached then
				a_menu_item__item := a_menu_item_attached.item
			end
			objc_set_menu_form_representation_ (item, a_menu_item__item)
		end

	menu_form_representation: detachable NS_MENU_ITEM
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_menu_form_representation (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like menu_form_representation} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like menu_form_representation} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_tag_ (a_tag: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_tag_ (item, a_tag)
		end

	tag: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_tag (item)
		end

	set_target_ (a_target: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_target__item: POINTER
		do
			if attached a_target as a_target_attached then
				a_target__item := a_target_attached.item
			end
			objc_set_target_ (item, a_target__item)
		end

	target: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_target (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like target} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like target} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_action_ (a_action: detachable OBJC_SELECTOR)
			-- Auto generated Objective-C wrapper.
		local
			a_action__item: POINTER
		do
			if attached a_action as a_action_attached then
				a_action__item := a_action_attached.item
			end
			objc_set_action_ (item, a_action__item)
		end

	action: detachable OBJC_SELECTOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_action (item)
			if result_pointer /= default_pointer then
				create {OBJC_SELECTOR} Result.make_with_pointer (result_pointer)
			end
			
		end

	set_enabled_ (a_enabled: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_enabled_ (item, a_enabled)
		end

	is_enabled: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_enabled (item)
		end

	set_image_ (a_image: detachable NS_IMAGE)
			-- Auto generated Objective-C wrapper.
		local
			a_image__item: POINTER
		do
			if attached a_image as a_image_attached then
				a_image__item := a_image_attached.item
			end
			objc_set_image_ (item, a_image__item)
		end

	image: detachable NS_IMAGE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_image (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like image} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like image} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_view_ (a_view: detachable NS_VIEW)
			-- Auto generated Objective-C wrapper.
		local
			a_view__item: POINTER
		do
			if attached a_view as a_view_attached then
				a_view__item := a_view_attached.item
			end
			objc_set_view_ (item, a_view__item)
		end

	view: detachable NS_VIEW
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_view (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like view} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like view} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_min_size_ (a_size: NS_SIZE)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_min_size_ (item, a_size.item)
		end

	min_size: NS_SIZE
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_min_size (item, Result.item)
		end

	set_max_size_ (a_size: NS_SIZE)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_max_size_ (item, a_size.item)
		end

	max_size: NS_SIZE
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_max_size (item, Result.item)
		end

	set_visibility_priority_ (a_visibility_priority: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_visibility_priority_ (item, a_visibility_priority)
		end

	visibility_priority: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_visibility_priority (item)
		end

	validate
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_validate (item)
		end

	set_autovalidates_ (a_resistance: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_autovalidates_ (item, a_resistance)
		end

	autovalidates: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_autovalidates (item)
		end

	allows_duplicates_in_toolbar: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_allows_duplicates_in_toolbar (item)
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSToolbarItem"
		end

end
