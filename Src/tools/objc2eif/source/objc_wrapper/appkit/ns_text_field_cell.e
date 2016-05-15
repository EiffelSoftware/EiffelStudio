note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_TEXT_FIELD_CELL

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

feature -- NSTextFieldCell

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

	set_draws_background_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_draws_background_ (item, a_flag)
		end

	draws_background: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_draws_background (item)
		end

	set_text_color_ (a_color: detachable NS_COLOR)
			-- Auto generated Objective-C wrapper.
		local
			a_color__item: POINTER
		do
			if attached a_color as a_color_attached then
				a_color__item := a_color_attached.item
			end
			objc_set_text_color_ (item, a_color__item)
		end

	text_color: detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_text_color (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like text_color} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like text_color} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_bezel_style_ (a_style: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_bezel_style_ (item, a_style)
		end

	bezel_style: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_bezel_style (item)
		end

	set_placeholder_string_ (a_string: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			objc_set_placeholder_string_ (item, a_string__item)
		end

	placeholder_string: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_placeholder_string (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like placeholder_string} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like placeholder_string} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_placeholder_attributed_string_ (a_string: detachable NS_ATTRIBUTED_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			objc_set_placeholder_attributed_string_ (item, a_string__item)
		end

	placeholder_attributed_string: detachable NS_ATTRIBUTED_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_placeholder_attributed_string (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like placeholder_attributed_string} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like placeholder_attributed_string} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_wants_notification_for_marked_text_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_wants_notification_for_marked_text_ (item, a_flag)
		end

	allowed_input_source_locales: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_allowed_input_source_locales (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like allowed_input_source_locales} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like allowed_input_source_locales} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_allowed_input_source_locales_ (a_locale_identifiers: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_locale_identifiers__item: POINTER
		do
			if attached a_locale_identifiers as a_locale_identifiers_attached then
				a_locale_identifiers__item := a_locale_identifiers_attached.item
			end
			objc_set_allowed_input_source_locales_ (item, a_locale_identifiers__item)
		end

feature {NONE} -- NSTextFieldCell Externals

	objc_set_background_color_ (an_item: POINTER; a_color: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextFieldCell *)$an_item setBackgroundColor:$a_color];
			 ]"
		end

	objc_background_color (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTextFieldCell *)$an_item backgroundColor];
			 ]"
		end

	objc_set_draws_background_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextFieldCell *)$an_item setDrawsBackground:$a_flag];
			 ]"
		end

	objc_draws_background (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTextFieldCell *)$an_item drawsBackground];
			 ]"
		end

	objc_set_text_color_ (an_item: POINTER; a_color: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextFieldCell *)$an_item setTextColor:$a_color];
			 ]"
		end

	objc_text_color (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTextFieldCell *)$an_item textColor];
			 ]"
		end

	objc_set_bezel_style_ (an_item: POINTER; a_style: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextFieldCell *)$an_item setBezelStyle:$a_style];
			 ]"
		end

	objc_bezel_style (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTextFieldCell *)$an_item bezelStyle];
			 ]"
		end

	objc_set_placeholder_string_ (an_item: POINTER; a_string: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextFieldCell *)$an_item setPlaceholderString:$a_string];
			 ]"
		end

	objc_placeholder_string (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTextFieldCell *)$an_item placeholderString];
			 ]"
		end

	objc_set_placeholder_attributed_string_ (an_item: POINTER; a_string: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextFieldCell *)$an_item setPlaceholderAttributedString:$a_string];
			 ]"
		end

	objc_placeholder_attributed_string (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTextFieldCell *)$an_item placeholderAttributedString];
			 ]"
		end

	objc_set_wants_notification_for_marked_text_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextFieldCell *)$an_item setWantsNotificationForMarkedText:$a_flag];
			 ]"
		end

	objc_allowed_input_source_locales (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTextFieldCell *)$an_item allowedInputSourceLocales];
			 ]"
		end

	objc_set_allowed_input_source_locales_ (an_item: POINTER; a_locale_identifiers: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextFieldCell *)$an_item setAllowedInputSourceLocales:$a_locale_identifiers];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSTextFieldCell"
		end

end
