note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_MENU_ITEM

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end

	NS_COPYING_PROTOCOL
	NS_CODING_PROTOCOL
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
	make_with_title__action__key_equivalent_,
	make

feature {NONE} -- Initialization

	make_with_title__action__key_equivalent_ (a_string: detachable NS_STRING; a_selector: detachable OBJC_SELECTOR; a_char_code: detachable NS_STRING)
			-- Initialize `Current'.
		local
			a_string__item: POINTER
			a_selector__item: POINTER
			a_char_code__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			if attached a_selector as a_selector_attached then
				a_selector__item := a_selector_attached.item
			end
			if attached a_char_code as a_char_code_attached then
				a_char_code__item := a_char_code_attached.item
			end
			make_with_pointer (objc_init_with_title__action__key_equivalent_(allocate_object, a_string__item, a_selector__item, a_char_code__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSMenuItem Externals

	objc_init_with_title__action__key_equivalent_ (an_item: POINTER; a_string: POINTER; a_selector: POINTER; a_char_code: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMenuItem *)$an_item initWithTitle:$a_string action:$a_selector keyEquivalent:$a_char_code];
			 ]"
		end

	objc_set_menu_ (an_item: POINTER; a_menu: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMenuItem *)$an_item setMenu:$a_menu];
			 ]"
		end

	objc_menu (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMenuItem *)$an_item menu];
			 ]"
		end

	objc_has_submenu (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSMenuItem *)$an_item hasSubmenu];
			 ]"
		end

	objc_set_submenu_ (an_item: POINTER; a_submenu: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMenuItem *)$an_item setSubmenu:$a_submenu];
			 ]"
		end

	objc_submenu (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMenuItem *)$an_item submenu];
			 ]"
		end

	objc_parent_item (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMenuItem *)$an_item parentItem];
			 ]"
		end

	objc_set_title_ (an_item: POINTER; a_string: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMenuItem *)$an_item setTitle:$a_string];
			 ]"
		end

	objc_title (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMenuItem *)$an_item title];
			 ]"
		end

	objc_set_attributed_title_ (an_item: POINTER; a_string: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMenuItem *)$an_item setAttributedTitle:$a_string];
			 ]"
		end

	objc_attributed_title (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMenuItem *)$an_item attributedTitle];
			 ]"
		end

	objc_is_separator_item (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSMenuItem *)$an_item isSeparatorItem];
			 ]"
		end

	objc_set_key_equivalent_ (an_item: POINTER; a_key_equivalent: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMenuItem *)$an_item setKeyEquivalent:$a_key_equivalent];
			 ]"
		end

	objc_key_equivalent (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMenuItem *)$an_item keyEquivalent];
			 ]"
		end

	objc_set_key_equivalent_modifier_mask_ (an_item: POINTER; a_mask: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMenuItem *)$an_item setKeyEquivalentModifierMask:$a_mask];
			 ]"
		end

	objc_key_equivalent_modifier_mask (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSMenuItem *)$an_item keyEquivalentModifierMask];
			 ]"
		end

	objc_user_key_equivalent (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMenuItem *)$an_item userKeyEquivalent];
			 ]"
		end

	objc_set_title_with_mnemonic_ (an_item: POINTER; a_string_with_ampersand: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMenuItem *)$an_item setTitleWithMnemonic:$a_string_with_ampersand];
			 ]"
		end

	objc_set_image_ (an_item: POINTER; a_menu_image: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMenuItem *)$an_item setImage:$a_menu_image];
			 ]"
		end

	objc_image (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMenuItem *)$an_item image];
			 ]"
		end

	objc_set_state_ (an_item: POINTER; a_state: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMenuItem *)$an_item setState:$a_state];
			 ]"
		end

	objc_state (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSMenuItem *)$an_item state];
			 ]"
		end

	objc_set_on_state_image_ (an_item: POINTER; a_image: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMenuItem *)$an_item setOnStateImage:$a_image];
			 ]"
		end

	objc_on_state_image (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMenuItem *)$an_item onStateImage];
			 ]"
		end

	objc_set_off_state_image_ (an_item: POINTER; a_image: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMenuItem *)$an_item setOffStateImage:$a_image];
			 ]"
		end

	objc_off_state_image (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMenuItem *)$an_item offStateImage];
			 ]"
		end

	objc_set_mixed_state_image_ (an_item: POINTER; a_image: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMenuItem *)$an_item setMixedStateImage:$a_image];
			 ]"
		end

	objc_mixed_state_image (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMenuItem *)$an_item mixedStateImage];
			 ]"
		end

	objc_set_enabled_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMenuItem *)$an_item setEnabled:$a_flag];
			 ]"
		end

	objc_is_enabled (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSMenuItem *)$an_item isEnabled];
			 ]"
		end

	objc_set_alternate_ (an_item: POINTER; a_is_alternate: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMenuItem *)$an_item setAlternate:$a_is_alternate];
			 ]"
		end

	objc_is_alternate (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSMenuItem *)$an_item isAlternate];
			 ]"
		end

	objc_set_indentation_level_ (an_item: POINTER; a_indentation_level: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMenuItem *)$an_item setIndentationLevel:$a_indentation_level];
			 ]"
		end

	objc_indentation_level (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSMenuItem *)$an_item indentationLevel];
			 ]"
		end

	objc_set_target_ (an_item: POINTER; an_object: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMenuItem *)$an_item setTarget:$an_object];
			 ]"
		end

	objc_target (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMenuItem *)$an_item target];
			 ]"
		end

	objc_set_action_ (an_item: POINTER; a_selector: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMenuItem *)$an_item setAction:$a_selector];
			 ]"
		end

	objc_action (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMenuItem *)$an_item action];
			 ]"
		end

	objc_set_tag_ (an_item: POINTER; an_int: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMenuItem *)$an_item setTag:$an_int];
			 ]"
		end

	objc_tag (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSMenuItem *)$an_item tag];
			 ]"
		end

	objc_set_represented_object_ (an_item: POINTER; an_object: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMenuItem *)$an_item setRepresentedObject:$an_object];
			 ]"
		end

	objc_represented_object (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMenuItem *)$an_item representedObject];
			 ]"
		end

	objc_set_view_ (an_item: POINTER; a_view: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMenuItem *)$an_item setView:$a_view];
			 ]"
		end

	objc_view (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMenuItem *)$an_item view];
			 ]"
		end

	objc_is_highlighted (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSMenuItem *)$an_item isHighlighted];
			 ]"
		end

	objc_set_hidden_ (an_item: POINTER; a_hidden: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMenuItem *)$an_item setHidden:$a_hidden];
			 ]"
		end

	objc_is_hidden (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSMenuItem *)$an_item isHidden];
			 ]"
		end

	objc_is_hidden_or_has_hidden_ancestor (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSMenuItem *)$an_item isHiddenOrHasHiddenAncestor];
			 ]"
		end

	objc_set_tool_tip_ (an_item: POINTER; a_tool_tip: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMenuItem *)$an_item setToolTip:$a_tool_tip];
			 ]"
		end

	objc_tool_tip (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMenuItem *)$an_item toolTip];
			 ]"
		end

feature -- NSMenuItem

	set_menu_ (a_menu: detachable NS_MENU)
			-- Auto generated Objective-C wrapper.
		local
			a_menu__item: POINTER
		do
			if attached a_menu as a_menu_attached then
				a_menu__item := a_menu_attached.item
			end
			objc_set_menu_ (item, a_menu__item)
		end

	menu: detachable NS_MENU
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_menu (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like menu} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like menu} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	has_submenu: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_has_submenu (item)
		end

	set_submenu_ (a_submenu: detachable NS_MENU)
			-- Auto generated Objective-C wrapper.
		local
			a_submenu__item: POINTER
		do
			if attached a_submenu as a_submenu_attached then
				a_submenu__item := a_submenu_attached.item
			end
			objc_set_submenu_ (item, a_submenu__item)
		end

	submenu: detachable NS_MENU
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_submenu (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like submenu} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like submenu} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	parent_item: detachable NS_MENU_ITEM
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_parent_item (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like parent_item} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like parent_item} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_title_ (a_string: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			objc_set_title_ (item, a_string__item)
		end

	title: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_title (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like title} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like title} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_attributed_title_ (a_string: detachable NS_ATTRIBUTED_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			objc_set_attributed_title_ (item, a_string__item)
		end

	attributed_title: detachable NS_ATTRIBUTED_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_attributed_title (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like attributed_title} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like attributed_title} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	is_separator_item: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_separator_item (item)
		end

	set_key_equivalent_ (a_key_equivalent: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_key_equivalent__item: POINTER
		do
			if attached a_key_equivalent as a_key_equivalent_attached then
				a_key_equivalent__item := a_key_equivalent_attached.item
			end
			objc_set_key_equivalent_ (item, a_key_equivalent__item)
		end

	key_equivalent: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_key_equivalent (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like key_equivalent} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like key_equivalent} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_key_equivalent_modifier_mask_ (a_mask: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_key_equivalent_modifier_mask_ (item, a_mask)
		end

	key_equivalent_modifier_mask: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_key_equivalent_modifier_mask (item)
		end

	user_key_equivalent: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_user_key_equivalent (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like user_key_equivalent} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like user_key_equivalent} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_title_with_mnemonic_ (a_string_with_ampersand: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_string_with_ampersand__item: POINTER
		do
			if attached a_string_with_ampersand as a_string_with_ampersand_attached then
				a_string_with_ampersand__item := a_string_with_ampersand_attached.item
			end
			objc_set_title_with_mnemonic_ (item, a_string_with_ampersand__item)
		end

	set_image_ (a_menu_image: detachable NS_IMAGE)
			-- Auto generated Objective-C wrapper.
		local
			a_menu_image__item: POINTER
		do
			if attached a_menu_image as a_menu_image_attached then
				a_menu_image__item := a_menu_image_attached.item
			end
			objc_set_image_ (item, a_menu_image__item)
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

	set_state_ (a_state: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_state_ (item, a_state)
		end

	state: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_state (item)
		end

	set_on_state_image_ (a_image: detachable NS_IMAGE)
			-- Auto generated Objective-C wrapper.
		local
			a_image__item: POINTER
		do
			if attached a_image as a_image_attached then
				a_image__item := a_image_attached.item
			end
			objc_set_on_state_image_ (item, a_image__item)
		end

	on_state_image: detachable NS_IMAGE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_on_state_image (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like on_state_image} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like on_state_image} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_off_state_image_ (a_image: detachable NS_IMAGE)
			-- Auto generated Objective-C wrapper.
		local
			a_image__item: POINTER
		do
			if attached a_image as a_image_attached then
				a_image__item := a_image_attached.item
			end
			objc_set_off_state_image_ (item, a_image__item)
		end

	off_state_image: detachable NS_IMAGE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_off_state_image (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like off_state_image} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like off_state_image} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_mixed_state_image_ (a_image: detachable NS_IMAGE)
			-- Auto generated Objective-C wrapper.
		local
			a_image__item: POINTER
		do
			if attached a_image as a_image_attached then
				a_image__item := a_image_attached.item
			end
			objc_set_mixed_state_image_ (item, a_image__item)
		end

	mixed_state_image: detachable NS_IMAGE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_mixed_state_image (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like mixed_state_image} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like mixed_state_image} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_enabled_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_enabled_ (item, a_flag)
		end

	is_enabled: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_enabled (item)
		end

	set_alternate_ (a_is_alternate: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_alternate_ (item, a_is_alternate)
		end

	is_alternate: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_alternate (item)
		end

	set_indentation_level_ (a_indentation_level: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_indentation_level_ (item, a_indentation_level)
		end

	indentation_level: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_indentation_level (item)
		end

	set_target_ (an_object: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			an_object__item: POINTER
		do
			if attached an_object as an_object_attached then
				an_object__item := an_object_attached.item
			end
			objc_set_target_ (item, an_object__item)
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

	set_action_ (a_selector: detachable OBJC_SELECTOR)
			-- Auto generated Objective-C wrapper.
		local
			a_selector__item: POINTER
		do
			if attached a_selector as a_selector_attached then
				a_selector__item := a_selector_attached.item
			end
			objc_set_action_ (item, a_selector__item)
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

	set_tag_ (an_int: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_tag_ (item, an_int)
		end

	tag: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_tag (item)
		end

	set_represented_object_ (an_object: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			an_object__item: POINTER
		do
			if attached an_object as an_object_attached then
				an_object__item := an_object_attached.item
			end
			objc_set_represented_object_ (item, an_object__item)
		end

	represented_object: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_represented_object (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like represented_object} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like represented_object} new_eiffel_object (result_pointer, True) as valid_result_pointer then
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

	is_highlighted: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_highlighted (item)
		end

	set_hidden_ (a_hidden: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_hidden_ (item, a_hidden)
		end

	is_hidden: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_hidden (item)
		end

	is_hidden_or_has_hidden_ancestor: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_hidden_or_has_hidden_ancestor (item)
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

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSMenuItem"
		end

end
