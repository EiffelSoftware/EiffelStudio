note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_BUTTON_CELL

inherit
	NS_ACTION_CELL
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_text_cell_,
	make_image_cell_,
	make

feature -- NSButtonCell

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

	image_scaling: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_image_scaling (item)
		end

	set_image_scaling_ (a_scaling: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_image_scaling_ (item, a_scaling)
		end

	highlights_by: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_highlights_by (item)
		end

	set_highlights_by_ (a_type: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_highlights_by_ (item, a_type)
		end

	shows_state_by: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_shows_state_by (item)
		end

	set_shows_state_by_ (a_type: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_shows_state_by_ (item, a_type)
		end

	set_button_type_ (a_type: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_button_type_ (item, a_type)
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

	key_equivalent_font: detachable NS_FONT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_key_equivalent_font (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like key_equivalent_font} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like key_equivalent_font} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_key_equivalent_font_ (a_font_obj: detachable NS_FONT)
			-- Auto generated Objective-C wrapper.
		local
			a_font_obj__item: POINTER
		do
			if attached a_font_obj as a_font_obj_attached then
				a_font_obj__item := a_font_obj_attached.item
			end
			objc_set_key_equivalent_font_ (item, a_font_obj__item)
		end

	set_key_equivalent_font__size_ (a_font_name: detachable NS_STRING; a_font_size: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
			a_font_name__item: POINTER
		do
			if attached a_font_name as a_font_name_attached then
				a_font_name__item := a_font_name_attached.item
			end
			objc_set_key_equivalent_font__size_ (item, a_font_name__item, a_font_size)
		end

	draw_image__with_frame__in_view_ (a_image: detachable NS_IMAGE; a_frame: NS_RECT; a_control_view: detachable NS_VIEW)
			-- Auto generated Objective-C wrapper.
		local
			a_image__item: POINTER
			a_control_view__item: POINTER
		do
			if attached a_image as a_image_attached then
				a_image__item := a_image_attached.item
			end
			if attached a_control_view as a_control_view_attached then
				a_control_view__item := a_control_view_attached.item
			end
			objc_draw_image__with_frame__in_view_ (item, a_image__item, a_frame.item, a_control_view__item)
		end

	draw_title__with_frame__in_view_ (a_title: detachable NS_ATTRIBUTED_STRING; a_frame: NS_RECT; a_control_view: detachable NS_VIEW): NS_RECT
			-- Auto generated Objective-C wrapper.
		local
			a_title__item: POINTER
			a_control_view__item: POINTER
		do
			if attached a_title as a_title_attached then
				a_title__item := a_title_attached.item
			end
			if attached a_control_view as a_control_view_attached then
				a_control_view__item := a_control_view_attached.item
			end
			create Result.make
			objc_draw_title__with_frame__in_view_ (item, Result.item, a_title__item, a_frame.item, a_control_view__item)
		end

	draw_bezel_with_frame__in_view_ (a_frame: NS_RECT; a_control_view: detachable NS_VIEW)
			-- Auto generated Objective-C wrapper.
		local
			a_control_view__item: POINTER
		do
			if attached a_control_view as a_control_view_attached then
				a_control_view__item := a_control_view_attached.item
			end
			objc_draw_bezel_with_frame__in_view_ (item, a_frame.item, a_control_view__item)
		end

feature {NONE} -- NSButtonCell Externals

	objc_alternate_title (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSButtonCell *)$an_item alternateTitle];
			 ]"
		end

	objc_set_alternate_title_ (an_item: POINTER; a_string: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSButtonCell *)$an_item setAlternateTitle:$a_string];
			 ]"
		end

	objc_alternate_image (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSButtonCell *)$an_item alternateImage];
			 ]"
		end

	objc_set_alternate_image_ (an_item: POINTER; a_image: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSButtonCell *)$an_item setAlternateImage:$a_image];
			 ]"
		end

	objc_image_position (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSButtonCell *)$an_item imagePosition];
			 ]"
		end

	objc_set_image_position_ (an_item: POINTER; a_position: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSButtonCell *)$an_item setImagePosition:$a_position];
			 ]"
		end

	objc_image_scaling (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSButtonCell *)$an_item imageScaling];
			 ]"
		end

	objc_set_image_scaling_ (an_item: POINTER; a_scaling: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSButtonCell *)$an_item setImageScaling:$a_scaling];
			 ]"
		end

	objc_highlights_by (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSButtonCell *)$an_item highlightsBy];
			 ]"
		end

	objc_set_highlights_by_ (an_item: POINTER; a_type: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSButtonCell *)$an_item setHighlightsBy:$a_type];
			 ]"
		end

	objc_shows_state_by (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSButtonCell *)$an_item showsStateBy];
			 ]"
		end

	objc_set_shows_state_by_ (an_item: POINTER; a_type: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSButtonCell *)$an_item setShowsStateBy:$a_type];
			 ]"
		end

	objc_set_button_type_ (an_item: POINTER; a_type: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSButtonCell *)$an_item setButtonType:$a_type];
			 ]"
		end

	objc_is_transparent (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSButtonCell *)$an_item isTransparent];
			 ]"
		end

	objc_set_transparent_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSButtonCell *)$an_item setTransparent:$a_flag];
			 ]"
		end

	objc_set_periodic_delay__interval_ (an_item: POINTER; a_delay: REAL_32; a_interval: REAL_32)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSButtonCell *)$an_item setPeriodicDelay:$a_delay interval:$a_interval];
			 ]"
		end

	objc_set_key_equivalent_ (an_item: POINTER; a_key_equivalent: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSButtonCell *)$an_item setKeyEquivalent:$a_key_equivalent];
			 ]"
		end

	objc_key_equivalent_modifier_mask (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSButtonCell *)$an_item keyEquivalentModifierMask];
			 ]"
		end

	objc_set_key_equivalent_modifier_mask_ (an_item: POINTER; a_mask: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSButtonCell *)$an_item setKeyEquivalentModifierMask:$a_mask];
			 ]"
		end

	objc_key_equivalent_font (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSButtonCell *)$an_item keyEquivalentFont];
			 ]"
		end

	objc_set_key_equivalent_font_ (an_item: POINTER; a_font_obj: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSButtonCell *)$an_item setKeyEquivalentFont:$a_font_obj];
			 ]"
		end

	objc_set_key_equivalent_font__size_ (an_item: POINTER; a_font_name: POINTER; a_font_size: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSButtonCell *)$an_item setKeyEquivalentFont:$a_font_name size:$a_font_size];
			 ]"
		end

	objc_draw_image__with_frame__in_view_ (an_item: POINTER; a_image: POINTER; a_frame: POINTER; a_control_view: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSButtonCell *)$an_item drawImage:$a_image withFrame:*((NSRect *)$a_frame) inView:$a_control_view];
			 ]"
		end

	objc_draw_title__with_frame__in_view_ (an_item: POINTER; result_pointer: POINTER; a_title: POINTER; a_frame: POINTER; a_control_view: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRect *)$result_pointer = [(NSButtonCell *)$an_item drawTitle:$a_title withFrame:*((NSRect *)$a_frame) inView:$a_control_view];
			 ]"
		end

	objc_draw_bezel_with_frame__in_view_ (an_item: POINTER; a_frame: POINTER; a_control_view: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSButtonCell *)$an_item drawBezelWithFrame:*((NSRect *)$a_frame) inView:$a_control_view];
			 ]"
		end

feature -- NSKeyboardUI

	set_alternate_title_with_mnemonic_ (a_string_with_ampersand: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_string_with_ampersand__item: POINTER
		do
			if attached a_string_with_ampersand as a_string_with_ampersand_attached then
				a_string_with_ampersand__item := a_string_with_ampersand_attached.item
			end
			objc_set_alternate_title_with_mnemonic_ (item, a_string_with_ampersand__item)
		end

	set_alternate_mnemonic_location_ (a_location: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_alternate_mnemonic_location_ (item, a_location)
		end

	alternate_mnemonic_location: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_alternate_mnemonic_location (item)
		end

	alternate_mnemonic: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_alternate_mnemonic (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like alternate_mnemonic} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like alternate_mnemonic} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSKeyboardUI Externals

	objc_set_alternate_title_with_mnemonic_ (an_item: POINTER; a_string_with_ampersand: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSButtonCell *)$an_item setAlternateTitleWithMnemonic:$a_string_with_ampersand];
			 ]"
		end

	objc_set_alternate_mnemonic_location_ (an_item: POINTER; a_location: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSButtonCell *)$an_item setAlternateMnemonicLocation:$a_location];
			 ]"
		end

	objc_alternate_mnemonic_location (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSButtonCell *)$an_item alternateMnemonicLocation];
			 ]"
		end

	objc_alternate_mnemonic (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSButtonCell *)$an_item alternateMnemonic];
			 ]"
		end

feature -- NSButtonCellExtensions

	gradient_type: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_gradient_type (item)
		end

	set_gradient_type_ (a_type: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_gradient_type_ (item, a_type)
		end

	set_image_dims_when_disabled_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_image_dims_when_disabled_ (item, a_flag)
		end

	image_dims_when_disabled: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_image_dims_when_disabled (item)
		end

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

	mouse_entered_ (a_event: detachable NS_EVENT)
			-- Auto generated Objective-C wrapper.
		local
			a_event__item: POINTER
		do
			if attached a_event as a_event_attached then
				a_event__item := a_event_attached.item
			end
			objc_mouse_entered_ (item, a_event__item)
		end

	mouse_exited_ (a_event: detachable NS_EVENT)
			-- Auto generated Objective-C wrapper.
		local
			a_event__item: POINTER
		do
			if attached a_event as a_event_attached then
				a_event__item := a_event_attached.item
			end
			objc_mouse_exited_ (item, a_event__item)
		end

	background_color: detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_background_color (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like background_color} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like background_color} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_background_color_ (a_color: detachable NS_COLOR)
			-- Auto generated Objective-C wrapper.
		local
			a_color__item: POINTER
		do
			if attached a_color as a_color_attached then
				a_color__item := a_color_attached.item
			end
			objc_set_background_color_ (item, a_color__item)
		end

feature {NONE} -- NSButtonCellExtensions Externals

	objc_gradient_type (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSButtonCell *)$an_item gradientType];
			 ]"
		end

	objc_set_gradient_type_ (an_item: POINTER; a_type: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSButtonCell *)$an_item setGradientType:$a_type];
			 ]"
		end

	objc_set_image_dims_when_disabled_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSButtonCell *)$an_item setImageDimsWhenDisabled:$a_flag];
			 ]"
		end

	objc_image_dims_when_disabled (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSButtonCell *)$an_item imageDimsWhenDisabled];
			 ]"
		end

	objc_set_shows_border_only_while_mouse_inside_ (an_item: POINTER; a_show: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSButtonCell *)$an_item setShowsBorderOnlyWhileMouseInside:$a_show];
			 ]"
		end

	objc_shows_border_only_while_mouse_inside (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSButtonCell *)$an_item showsBorderOnlyWhileMouseInside];
			 ]"
		end

	objc_mouse_entered_ (an_item: POINTER; a_event: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSButtonCell *)$an_item mouseEntered:$a_event];
			 ]"
		end

	objc_mouse_exited_ (an_item: POINTER; a_event: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSButtonCell *)$an_item mouseExited:$a_event];
			 ]"
		end

	objc_background_color (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSButtonCell *)$an_item backgroundColor];
			 ]"
		end

	objc_set_background_color_ (an_item: POINTER; a_color: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSButtonCell *)$an_item setBackgroundColor:$a_color];
			 ]"
		end

feature -- NSButtonCellAttributedStringMethods

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

	set_attributed_title_ (a_obj: detachable NS_ATTRIBUTED_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_obj__item: POINTER
		do
			if attached a_obj as a_obj_attached then
				a_obj__item := a_obj_attached.item
			end
			objc_set_attributed_title_ (item, a_obj__item)
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

feature {NONE} -- NSButtonCellAttributedStringMethods Externals

	objc_attributed_title (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSButtonCell *)$an_item attributedTitle];
			 ]"
		end

	objc_set_attributed_title_ (an_item: POINTER; a_obj: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSButtonCell *)$an_item setAttributedTitle:$a_obj];
			 ]"
		end

	objc_attributed_alternate_title (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSButtonCell *)$an_item attributedAlternateTitle];
			 ]"
		end

	objc_set_attributed_alternate_title_ (an_item: POINTER; a_obj: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSButtonCell *)$an_item setAttributedAlternateTitle:$a_obj];
			 ]"
		end

feature -- NSButtonCellBezelStyles

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

feature {NONE} -- NSButtonCellBezelStyles Externals

	objc_set_bezel_style_ (an_item: POINTER; a_bezel_style: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSButtonCell *)$an_item setBezelStyle:$a_bezel_style];
			 ]"
		end

	objc_bezel_style (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSButtonCell *)$an_item bezelStyle];
			 ]"
		end

feature -- NSButtonCellSoundExtensions

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

feature {NONE} -- NSButtonCellSoundExtensions Externals

	objc_set_sound_ (an_item: POINTER; a_sound: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSButtonCell *)$an_item setSound:$a_sound];
			 ]"
		end

	objc_sound (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSButtonCell *)$an_item sound];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSButtonCell"
		end

end
