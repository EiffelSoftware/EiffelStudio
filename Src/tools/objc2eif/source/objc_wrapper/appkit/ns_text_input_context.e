note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_TEXT_INPUT_CONTEXT

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_client_,
	make

feature {NONE} -- Initialization

	make_with_client_ (a_the_client: detachable NS_TEXT_INPUT_CLIENT_PROTOCOL)
			-- Initialize `Current'.
		local
			a_the_client__item: POINTER
		do
			if attached a_the_client as a_the_client_attached then
				a_the_client__item := a_the_client_attached.item
			end
			make_with_pointer (objc_init_with_client_(allocate_object, a_the_client__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSTextInputContext Externals

	objc_init_with_client_ (an_item: POINTER; a_the_client: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTextInputContext *)$an_item initWithClient:$a_the_client];
			 ]"
		end

	objc_activate (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextInputContext *)$an_item activate];
			 ]"
		end

	objc_deactivate (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextInputContext *)$an_item deactivate];
			 ]"
		end

	objc_handle_event_ (an_item: POINTER; a_the_event: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTextInputContext *)$an_item handleEvent:$a_the_event];
			 ]"
		end

	objc_discard_marked_text (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextInputContext *)$an_item discardMarkedText];
			 ]"
		end

	objc_invalidate_character_coordinates (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextInputContext *)$an_item invalidateCharacterCoordinates];
			 ]"
		end

feature -- NSTextInputContext

	activate
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_activate (item)
		end

	deactivate
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_deactivate (item)
		end

	handle_event_ (a_the_event: detachable NS_EVENT): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_the_event__item: POINTER
		do
			if attached a_the_event as a_the_event_attached then
				a_the_event__item := a_the_event_attached.item
			end
			Result := objc_handle_event_ (item, a_the_event__item)
		end

	discard_marked_text
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_discard_marked_text (item)
		end

	invalidate_character_coordinates
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_invalidate_character_coordinates (item)
		end

feature -- Properties

	client: detachable NS_TEXT_INPUT_CLIENT_PROTOCOL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_client (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like client} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like client} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	accepts_glyph_info: BOOLEAN assign set_accepts_glyph_info
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_accepts_glyph_info (item)
		end

	set_accepts_glyph_info (an_arg: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_accepts_glyph_info (item, an_arg)
		end

	allowed_input_source_locales: detachable NS_ARRAY assign set_allowed_input_source_locales
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

	set_allowed_input_source_locales (an_arg: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			an_arg__item: POINTER
		do
			if attached an_arg as an_arg_attached then
				an_arg__item := an_arg_attached.item
			end
			objc_set_allowed_input_source_locales (item, an_arg__item)
		end

	keyboard_input_sources: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_keyboard_input_sources (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like keyboard_input_sources} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like keyboard_input_sources} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	selected_keyboard_input_source: detachable NS_STRING assign set_selected_keyboard_input_source
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_selected_keyboard_input_source (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like selected_keyboard_input_source} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like selected_keyboard_input_source} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_selected_keyboard_input_source (an_arg: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			an_arg__item: POINTER
		do
			if attached an_arg as an_arg_attached then
				an_arg__item := an_arg_attached.item
			end
			objc_set_selected_keyboard_input_source (item, an_arg__item)
		end

feature {NONE} -- Properties Externals

	objc_client (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTextInputContext *)$an_item client];
			 ]"
		end

	objc_accepts_glyph_info (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTextInputContext *)$an_item acceptsGlyphInfo];
			 ]"
		end

	objc_set_accepts_glyph_info (an_item: POINTER; an_arg: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextInputContext *)$an_item setAcceptsGlyphInfo:$an_arg]
			 ]"
		end

	objc_allowed_input_source_locales (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTextInputContext *)$an_item allowedInputSourceLocales];
			 ]"
		end

	objc_set_allowed_input_source_locales (an_item: POINTER; an_arg: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextInputContext *)$an_item setAllowedInputSourceLocales:$an_arg]
			 ]"
		end

	objc_keyboard_input_sources (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTextInputContext *)$an_item keyboardInputSources];
			 ]"
		end

	objc_selected_keyboard_input_source (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTextInputContext *)$an_item selectedKeyboardInputSource];
			 ]"
		end

	objc_set_selected_keyboard_input_source (an_item: POINTER; an_arg: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextInputContext *)$an_item setSelectedKeyboardInputSource:$an_arg]
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSTextInputContext"
		end

end
