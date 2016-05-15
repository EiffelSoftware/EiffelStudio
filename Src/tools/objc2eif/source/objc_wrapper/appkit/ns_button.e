note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_BUTTON

inherit
	NS_CONTROL
		redefine
			wrapper_objc_class_name
		end

	NS_USER_INTERFACE_VALIDATIONS_PROTOCOL

create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_frame_,
	make

feature -- NSButton

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

	alternate_title: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_alternate_title (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like alternate_title} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like alternate_title} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_alternate_title_ (a_string: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			objc_set_alternate_title_ (item, a_string__item)
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

	alternate_image: detachable NS_IMAGE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_alternate_image (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like alternate_image} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like alternate_image} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_alternate_image_ (a_image: detachable NS_IMAGE)
			-- Auto generated Objective-C wrapper.
		local
			a_image__item: POINTER
		do
			if attached a_image as a_image_attached then
				a_image__item := a_image_attached.item
			end
			objc_set_alternate_image_ (item, a_image__item)
		end

	image_position: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_image_position (item)
		end

	set_image_position_ (a_position: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_image_position_ (item, a_position)
		end

	set_button_type_ (a_type: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_button_type_ (item, a_type)
		end

	state: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_state (item)
		end

	set_state_ (a_value: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_state_ (item, a_value)
		end

	is_bordered: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_bordered (item)
		end

	set_bordered_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_bordered_ (item, a_flag)
		end

	is_transparent: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_transparent (item)
		end

	set_transparent_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_transparent_ (item, a_flag)
		end

	set_periodic_delay__interval_ (a_delay: REAL_32; a_interval: REAL_32)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_periodic_delay__interval_ (item, a_delay, a_interval)
		end

--	get_periodic_delay__interval_ (a_delay: UNSUPPORTED_TYPE; a_interval: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_delay__item: POINTER
--			a_interval__item: POINTER
--		do
--			if attached a_delay as a_delay_attached then
--				a_delay__item := a_delay_attached.item
--			end
--			if attached a_interval as a_interval_attached then
--				a_interval__item := a_interval_attached.item
--			end
--			objc_get_periodic_delay__interval_ (item, a_delay__item, a_interval__item)
--		end

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

	set_key_equivalent_ (a_char_code: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_char_code__item: POINTER
		do
			if attached a_char_code as a_char_code_attached then
				a_char_code__item := a_char_code_attached.item
			end
			objc_set_key_equivalent_ (item, a_char_code__item)
		end

	key_equivalent_modifier_mask: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_key_equivalent_modifier_mask (item)
		end

	set_key_equivalent_modifier_mask_ (a_mask: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_key_equivalent_modifier_mask_ (item, a_mask)
		end

	highlight_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_highlight_ (item, a_flag)
		end

feature {NONE} -- NSButton Externals

	objc_title (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSButton *)$an_item title];
			 ]"
		end

	objc_set_title_ (an_item: POINTER; a_string: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSButton *)$an_item setTitle:$a_string];
			 ]"
		end

	objc_alternate_title (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSButton *)$an_item alternateTitle];
			 ]"
		end

	objc_set_alternate_title_ (an_item: POINTER; a_string: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSButton *)$an_item setAlternateTitle:$a_string];
			 ]"
		end

	objc_image (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSButton *)$an_item image];
			 ]"
		end

	objc_set_image_ (an_item: POINTER; a_image: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSButton *)$an_item setImage:$a_image];
			 ]"
		end

	objc_alternate_image (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSButton *)$an_item alternateImage];
			 ]"
		end

	objc_set_alternate_image_ (an_item: POINTER; a_image: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSButton *)$an_item setAlternateImage:$a_image];
			 ]"
		end

	objc_image_position (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSButton *)$an_item imagePosition];
			 ]"
		end

	objc_set_image_position_ (an_item: POINTER; a_position: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSButton *)$an_item setImagePosition:$a_position];
			 ]"
		end

	objc_set_button_type_ (an_item: POINTER; a_type: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSButton *)$an_item setButtonType:$a_type];
			 ]"
		end

	objc_state (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSButton *)$an_item state];
			 ]"
		end

	objc_set_state_ (an_item: POINTER; a_value: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSButton *)$an_item setState:$a_value];
			 ]"
		end

	objc_is_bordered (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSButton *)$an_item isBordered];
			 ]"
		end

	objc_set_bordered_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSButton *)$an_item setBordered:$a_flag];
			 ]"
		end

	objc_is_transparent (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSButton *)$an_item isTransparent];
			 ]"
		end

	objc_set_transparent_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSButton *)$an_item setTransparent:$a_flag];
			 ]"
		end

	objc_set_periodic_delay__interval_ (an_item: POINTER; a_delay: REAL_32; a_interval: REAL_32)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSButton *)$an_item setPeriodicDelay:$a_delay interval:$a_interval];
			 ]"
		end

--	objc_get_periodic_delay__interval_ (an_item: POINTER; a_delay: UNSUPPORTED_TYPE; a_interval: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				[(NSButton *)$an_item getPeriodicDelay: interval:];
--			 ]"
--		end

	objc_key_equivalent (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSButton *)$an_item keyEquivalent];
			 ]"
		end

	objc_set_key_equivalent_ (an_item: POINTER; a_char_code: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSButton *)$an_item setKeyEquivalent:$a_char_code];
			 ]"
		end

	objc_key_equivalent_modifier_mask (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSButton *)$an_item keyEquivalentModifierMask];
			 ]"
		end

	objc_set_key_equivalent_modifier_mask_ (an_item: POINTER; a_mask: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSButton *)$an_item setKeyEquivalentModifierMask:$a_mask];
			 ]"
		end

	objc_highlight_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSButton *)$an_item highlight:$a_flag];
			 ]"
		end

feature -- NSKeyboardUI

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

feature {NONE} -- NSKeyboardUI Externals

	objc_set_title_with_mnemonic_ (an_item: POINTER; a_string_with_ampersand: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSButton *)$an_item setTitleWithMnemonic:$a_string_with_ampersand];
			 ]"
		end

feature -- NSButtonAttributedStringMethods

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

	attributed_alternate_title: detachable NS_ATTRIBUTED_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_attributed_alternate_title (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like attributed_alternate_title} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like attributed_alternate_title} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_attributed_alternate_title_ (a_obj: detachable NS_ATTRIBUTED_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_obj__item: POINTER
		do
			if attached a_obj as a_obj_attached then
				a_obj__item := a_obj_attached.item
			end
			objc_set_attributed_alternate_title_ (item, a_obj__item)
		end

feature {NONE} -- NSButtonAttributedStringMethods Externals

	objc_attributed_title (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSButton *)$an_item attributedTitle];
			 ]"
		end

	objc_set_attributed_title_ (an_item: POINTER; a_string: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSButton *)$an_item setAttributedTitle:$a_string];
			 ]"
		end

	objc_attributed_alternate_title (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSButton *)$an_item attributedAlternateTitle];
			 ]"
		end

	objc_set_attributed_alternate_title_ (an_item: POINTER; a_obj: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSButton *)$an_item setAttributedAlternateTitle:$a_obj];
			 ]"
		end

feature -- NSButtonBezelStyles

	set_bezel_style_ (a_bezel_style: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_bezel_style_ (item, a_bezel_style)
		end

	bezel_style: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_bezel_style (item)
		end

feature {NONE} -- NSButtonBezelStyles Externals

	objc_set_bezel_style_ (an_item: POINTER; a_bezel_style: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSButton *)$an_item setBezelStyle:$a_bezel_style];
			 ]"
		end

	objc_bezel_style (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSButton *)$an_item bezelStyle];
			 ]"
		end

feature -- NSButtonMixedState

	set_allows_mixed_state_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_allows_mixed_state_ (item, a_flag)
		end

	allows_mixed_state: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_allows_mixed_state (item)
		end

	set_next_state
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_next_state (item)
		end

feature {NONE} -- NSButtonMixedState Externals

	objc_set_allows_mixed_state_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSButton *)$an_item setAllowsMixedState:$a_flag];
			 ]"
		end

	objc_allows_mixed_state (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSButton *)$an_item allowsMixedState];
			 ]"
		end

	objc_set_next_state (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSButton *)$an_item setNextState];
			 ]"
		end

feature -- NSButtonBorder

	set_shows_border_only_while_mouse_inside_ (a_show: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_shows_border_only_while_mouse_inside_ (item, a_show)
		end

	shows_border_only_while_mouse_inside: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_shows_border_only_while_mouse_inside (item)
		end

feature {NONE} -- NSButtonBorder Externals

	objc_set_shows_border_only_while_mouse_inside_ (an_item: POINTER; a_show: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSButton *)$an_item setShowsBorderOnlyWhileMouseInside:$a_show];
			 ]"
		end

	objc_shows_border_only_while_mouse_inside (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSButton *)$an_item showsBorderOnlyWhileMouseInside];
			 ]"
		end

feature -- NSButtonSoundExtensions

	set_sound_ (a_sound: detachable NS_SOUND)
			-- Auto generated Objective-C wrapper.
		local
			a_sound__item: POINTER
		do
			if attached a_sound as a_sound_attached then
				a_sound__item := a_sound_attached.item
			end
			objc_set_sound_ (item, a_sound__item)
		end

	sound: detachable NS_SOUND
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_sound (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like sound} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like sound} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSButtonSoundExtensions Externals

	objc_set_sound_ (an_item: POINTER; a_sound: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSButton *)$an_item setSound:$a_sound];
			 ]"
		end

	objc_sound (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSButton *)$an_item sound];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSButton"
		end

end
