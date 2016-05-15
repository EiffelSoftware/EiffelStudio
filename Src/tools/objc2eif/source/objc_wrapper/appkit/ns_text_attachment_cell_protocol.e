note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NS_TEXT_ATTACHMENT_CELL_PROTOCOL

inherit
	NS_OBJECT_PROTOCOL

feature -- Required Methods

	draw_with_frame__in_view_ (a_cell_frame: NS_RECT; a_control_view: detachable NS_VIEW)
			-- Auto generated Objective-C wrapper.
		local
			a_control_view__item: POINTER
		do
			if attached a_control_view as a_control_view_attached then
				a_control_view__item := a_control_view_attached.item
			end
			objc_draw_with_frame__in_view_ (item, a_cell_frame.item, a_control_view__item)
		end

	wants_to_track_mouse: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_wants_to_track_mouse (item)
		end

	highlight__with_frame__in_view_ (a_flag: BOOLEAN; a_cell_frame: NS_RECT; a_control_view: detachable NS_VIEW)
			-- Auto generated Objective-C wrapper.
		local
			a_control_view__item: POINTER
		do
			if attached a_control_view as a_control_view_attached then
				a_control_view__item := a_control_view_attached.item
			end
			objc_highlight__with_frame__in_view_ (item, a_flag, a_cell_frame.item, a_control_view__item)
		end

	track_mouse__in_rect__of_view__until_mouse_up_ (a_the_event: detachable NS_EVENT; a_cell_frame: NS_RECT; a_control_view: detachable NS_VIEW; a_flag: BOOLEAN): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_the_event__item: POINTER
			a_control_view__item: POINTER
		do
			if attached a_the_event as a_the_event_attached then
				a_the_event__item := a_the_event_attached.item
			end
			if attached a_control_view as a_control_view_attached then
				a_control_view__item := a_control_view_attached.item
			end
			Result := objc_track_mouse__in_rect__of_view__until_mouse_up_ (item, a_the_event__item, a_cell_frame.item, a_control_view__item, a_flag)
		end

	cell_size: NS_SIZE
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_cell_size (item, Result.item)
		end

	cell_baseline_offset: NS_POINT
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_cell_baseline_offset (item, Result.item)
		end

	set_attachment_ (an_object: detachable NS_TEXT_ATTACHMENT)
			-- Auto generated Objective-C wrapper.
		local
			an_object__item: POINTER
		do
			if attached an_object as an_object_attached then
				an_object__item := an_object_attached.item
			end
			objc_set_attachment_ (item, an_object__item)
		end

	attachment: detachable NS_TEXT_ATTACHMENT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_attachment (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like attachment} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like attachment} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	draw_with_frame__in_view__character_index_ (a_cell_frame: NS_RECT; a_control_view: detachable NS_VIEW; a_char_index: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
			a_control_view__item: POINTER
		do
			if attached a_control_view as a_control_view_attached then
				a_control_view__item := a_control_view_attached.item
			end
			objc_draw_with_frame__in_view__character_index_ (item, a_cell_frame.item, a_control_view__item, a_char_index)
		end

	draw_with_frame__in_view__character_index__layout_manager_ (a_cell_frame: NS_RECT; a_control_view: detachable NS_VIEW; a_char_index: NATURAL_64; a_layout_manager: detachable NS_LAYOUT_MANAGER)
			-- Auto generated Objective-C wrapper.
		local
			a_control_view__item: POINTER
			a_layout_manager__item: POINTER
		do
			if attached a_control_view as a_control_view_attached then
				a_control_view__item := a_control_view_attached.item
			end
			if attached a_layout_manager as a_layout_manager_attached then
				a_layout_manager__item := a_layout_manager_attached.item
			end
			objc_draw_with_frame__in_view__character_index__layout_manager_ (item, a_cell_frame.item, a_control_view__item, a_char_index, a_layout_manager__item)
		end

	wants_to_track_mouse_for_event__in_rect__of_view__at_character_index_ (a_the_event: detachable NS_EVENT; a_cell_frame: NS_RECT; a_control_view: detachable NS_VIEW; a_char_index: NATURAL_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_the_event__item: POINTER
			a_control_view__item: POINTER
		do
			if attached a_the_event as a_the_event_attached then
				a_the_event__item := a_the_event_attached.item
			end
			if attached a_control_view as a_control_view_attached then
				a_control_view__item := a_control_view_attached.item
			end
			Result := objc_wants_to_track_mouse_for_event__in_rect__of_view__at_character_index_ (item, a_the_event__item, a_cell_frame.item, a_control_view__item, a_char_index)
		end

	track_mouse__in_rect__of_view__at_character_index__until_mouse_up_ (a_the_event: detachable NS_EVENT; a_cell_frame: NS_RECT; a_control_view: detachable NS_VIEW; a_char_index: NATURAL_64; a_flag: BOOLEAN): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_the_event__item: POINTER
			a_control_view__item: POINTER
		do
			if attached a_the_event as a_the_event_attached then
				a_the_event__item := a_the_event_attached.item
			end
			if attached a_control_view as a_control_view_attached then
				a_control_view__item := a_control_view_attached.item
			end
			Result := objc_track_mouse__in_rect__of_view__at_character_index__until_mouse_up_ (item, a_the_event__item, a_cell_frame.item, a_control_view__item, a_char_index, a_flag)
		end

	cell_frame_for_text_container__proposed_line_fragment__glyph_position__character_index_ (a_text_container: detachable NS_TEXT_CONTAINER; a_line_frag: NS_RECT; a_position: NS_POINT; a_char_index: NATURAL_64): NS_RECT
			-- Auto generated Objective-C wrapper.
		local
			a_text_container__item: POINTER
		do
			if attached a_text_container as a_text_container_attached then
				a_text_container__item := a_text_container_attached.item
			end
			create Result.make
			objc_cell_frame_for_text_container__proposed_line_fragment__glyph_position__character_index_ (item, Result.item, a_text_container__item, a_line_frag.item, a_position.item, a_char_index)
		end

feature {NONE} -- Required Methods Externals

	objc_draw_with_frame__in_view_ (an_item: POINTER; a_cell_frame: POINTER; a_control_view: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSTextAttachmentCell>)$an_item drawWithFrame:*((NSRect *)$a_cell_frame) inView:$a_control_view];
			 ]"
		end

	objc_wants_to_track_mouse (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSTextAttachmentCell>)$an_item wantsToTrackMouse];
			 ]"
		end

	objc_highlight__with_frame__in_view_ (an_item: POINTER; a_flag: BOOLEAN; a_cell_frame: POINTER; a_control_view: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSTextAttachmentCell>)$an_item highlight:$a_flag withFrame:*((NSRect *)$a_cell_frame) inView:$a_control_view];
			 ]"
		end

	objc_track_mouse__in_rect__of_view__until_mouse_up_ (an_item: POINTER; a_the_event: POINTER; a_cell_frame: POINTER; a_control_view: POINTER; a_flag: BOOLEAN): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSTextAttachmentCell>)$an_item trackMouse:$a_the_event inRect:*((NSRect *)$a_cell_frame) ofView:$a_control_view untilMouseUp:$a_flag];
			 ]"
		end

	objc_cell_size (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSSize *)$result_pointer = [(id <NSTextAttachmentCell>)$an_item cellSize];
			 ]"
		end

	objc_cell_baseline_offset (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSPoint *)$result_pointer = [(id <NSTextAttachmentCell>)$an_item cellBaselineOffset];
			 ]"
		end

	objc_set_attachment_ (an_item: POINTER; a_an_object: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSTextAttachmentCell>)$an_item setAttachment:$a_an_object];
			 ]"
		end

	objc_attachment (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSTextAttachmentCell>)$an_item attachment];
			 ]"
		end

	objc_draw_with_frame__in_view__character_index_ (an_item: POINTER; a_cell_frame: POINTER; a_control_view: POINTER; a_char_index: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSTextAttachmentCell>)$an_item drawWithFrame:*((NSRect *)$a_cell_frame) inView:$a_control_view characterIndex:$a_char_index];
			 ]"
		end

	objc_draw_with_frame__in_view__character_index__layout_manager_ (an_item: POINTER; a_cell_frame: POINTER; a_control_view: POINTER; a_char_index: NATURAL_64; a_layout_manager: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSTextAttachmentCell>)$an_item drawWithFrame:*((NSRect *)$a_cell_frame) inView:$a_control_view characterIndex:$a_char_index layoutManager:$a_layout_manager];
			 ]"
		end

	objc_wants_to_track_mouse_for_event__in_rect__of_view__at_character_index_ (an_item: POINTER; a_the_event: POINTER; a_cell_frame: POINTER; a_control_view: POINTER; a_char_index: NATURAL_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSTextAttachmentCell>)$an_item wantsToTrackMouseForEvent:$a_the_event inRect:*((NSRect *)$a_cell_frame) ofView:$a_control_view atCharacterIndex:$a_char_index];
			 ]"
		end

	objc_track_mouse__in_rect__of_view__at_character_index__until_mouse_up_ (an_item: POINTER; a_the_event: POINTER; a_cell_frame: POINTER; a_control_view: POINTER; a_char_index: NATURAL_64; a_flag: BOOLEAN): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSTextAttachmentCell>)$an_item trackMouse:$a_the_event inRect:*((NSRect *)$a_cell_frame) ofView:$a_control_view atCharacterIndex:$a_char_index untilMouseUp:$a_flag];
			 ]"
		end

	objc_cell_frame_for_text_container__proposed_line_fragment__glyph_position__character_index_ (an_item: POINTER; result_pointer: POINTER; a_text_container: POINTER; a_line_frag: POINTER; a_position: POINTER; a_char_index: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRect *)$result_pointer = [(id <NSTextAttachmentCell>)$an_item cellFrameForTextContainer:$a_text_container proposedLineFragment:*((NSRect *)$a_line_frag) glyphPosition:*((NSPoint *)$a_position) characterIndex:$a_char_index];
			 ]"
		end

end
