note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_TEXT_VIEW

inherit
	NS_TEXT
		redefine
			wrapper_objc_class_name
		end

	NS_TEXT_INPUT_PROTOCOL
		undefine
			insert_text_,
			objc_insert_text_,
			do_command_by_selector_,
			objc_do_command_by_selector_,
			unmark_text,
			objc_unmark_text,
			has_marked_text,
			objc_has_marked_text,
			marked_range,
			objc_marked_range,
			selected_range,
			objc_selected_range,
			character_index_for_point_,
			objc_character_index_for_point_,
			valid_attributes_for_marked_text,
			objc_valid_attributes_for_marked_text
		end

	NS_USER_INTERFACE_VALIDATIONS_PROTOCOL
	NS_TEXT_INPUT_CLIENT_PROTOCOL
		undefine
			do_command_by_selector_,
			objc_do_command_by_selector_,
			selected_range,
			objc_selected_range
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_frame__text_container_,
	make_with_frame_,
	make

feature {NONE} -- Initialization

	make_with_frame__text_container_ (a_frame_rect: NS_RECT; a_container: detachable NS_TEXT_CONTAINER)
			-- Initialize `Current'.
		local
			a_container__item: POINTER
		do
			if attached a_container as a_container_attached then
				a_container__item := a_container_attached.item
			end
			make_with_pointer (objc_init_with_frame__text_container_(allocate_object, a_frame_rect.item, a_container__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSTextView Externals

	objc_init_with_frame__text_container_ (an_item: POINTER; a_frame_rect: POINTER; a_container: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTextView *)$an_item initWithFrame:*((NSRect *)$a_frame_rect) textContainer:$a_container];
			 ]"
		end

	objc_text_container (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTextView *)$an_item textContainer];
			 ]"
		end

	objc_set_text_container_ (an_item: POINTER; a_container: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextView *)$an_item setTextContainer:$a_container];
			 ]"
		end

	objc_replace_text_container_ (an_item: POINTER; a_new_container: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextView *)$an_item replaceTextContainer:$a_new_container];
			 ]"
		end

	objc_set_text_container_inset_ (an_item: POINTER; a_inset: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextView *)$an_item setTextContainerInset:*((NSSize *)$a_inset)];
			 ]"
		end

	objc_text_container_inset (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSSize *)$result_pointer = [(NSTextView *)$an_item textContainerInset];
			 ]"
		end

	objc_text_container_origin (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSPoint *)$result_pointer = [(NSTextView *)$an_item textContainerOrigin];
			 ]"
		end

	objc_invalidate_text_container_origin (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextView *)$an_item invalidateTextContainerOrigin];
			 ]"
		end

	objc_layout_manager (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTextView *)$an_item layoutManager];
			 ]"
		end

	objc_text_storage (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTextView *)$an_item textStorage];
			 ]"
		end

	objc_set_constrained_frame_size_ (an_item: POINTER; a_desired_size: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextView *)$an_item setConstrainedFrameSize:*((NSSize *)$a_desired_size)];
			 ]"
		end

	objc_set_alignment__range_ (an_item: POINTER; a_alignment: NATURAL_64; a_range: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextView *)$an_item setAlignment:$a_alignment range:*((NSRange *)$a_range)];
			 ]"
		end

	objc_set_base_writing_direction__range_ (an_item: POINTER; a_writing_direction: INTEGER_64; a_range: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextView *)$an_item setBaseWritingDirection:$a_writing_direction range:*((NSRange *)$a_range)];
			 ]"
		end

	objc_turn_off_kerning_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextView *)$an_item turnOffKerning:$a_sender];
			 ]"
		end

	objc_tighten_kerning_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextView *)$an_item tightenKerning:$a_sender];
			 ]"
		end

	objc_loosen_kerning_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextView *)$an_item loosenKerning:$a_sender];
			 ]"
		end

	objc_use_standard_kerning_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextView *)$an_item useStandardKerning:$a_sender];
			 ]"
		end

	objc_turn_off_ligatures_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextView *)$an_item turnOffLigatures:$a_sender];
			 ]"
		end

	objc_use_standard_ligatures_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextView *)$an_item useStandardLigatures:$a_sender];
			 ]"
		end

	objc_use_all_ligatures_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextView *)$an_item useAllLigatures:$a_sender];
			 ]"
		end

	objc_raise_baseline_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextView *)$an_item raiseBaseline:$a_sender];
			 ]"
		end

	objc_lower_baseline_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextView *)$an_item lowerBaseline:$a_sender];
			 ]"
		end

	objc_toggle_traditional_character_shape_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextView *)$an_item toggleTraditionalCharacterShape:$a_sender];
			 ]"
		end

	objc_outline_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextView *)$an_item outline:$a_sender];
			 ]"
		end

	objc_perform_find_panel_action_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextView *)$an_item performFindPanelAction:$a_sender];
			 ]"
		end

	objc_align_justified_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextView *)$an_item alignJustified:$a_sender];
			 ]"
		end

	objc_change_attributes_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextView *)$an_item changeAttributes:$a_sender];
			 ]"
		end

	objc_change_document_background_color_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextView *)$an_item changeDocumentBackgroundColor:$a_sender];
			 ]"
		end

	objc_order_front_spacing_panel_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextView *)$an_item orderFrontSpacingPanel:$a_sender];
			 ]"
		end

	objc_order_front_link_panel_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextView *)$an_item orderFrontLinkPanel:$a_sender];
			 ]"
		end

	objc_order_front_list_panel_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextView *)$an_item orderFrontListPanel:$a_sender];
			 ]"
		end

	objc_order_front_table_panel_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextView *)$an_item orderFrontTablePanel:$a_sender];
			 ]"
		end

	objc_set_needs_display_in_rect__avoid_additional_layout_ (an_item: POINTER; a_rect: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextView *)$an_item setNeedsDisplayInRect:*((NSRect *)$a_rect) avoidAdditionalLayout:$a_flag];
			 ]"
		end

	objc_should_draw_insertion_point (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTextView *)$an_item shouldDrawInsertionPoint];
			 ]"
		end

	objc_draw_insertion_point_in_rect__color__turned_on_ (an_item: POINTER; a_rect: POINTER; a_color: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextView *)$an_item drawInsertionPointInRect:*((NSRect *)$a_rect) color:$a_color turnedOn:$a_flag];
			 ]"
		end

	objc_draw_view_background_in_rect_ (an_item: POINTER; a_rect: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextView *)$an_item drawViewBackgroundInRect:*((NSRect *)$a_rect)];
			 ]"
		end

	objc_update_ruler (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextView *)$an_item updateRuler];
			 ]"
		end

	objc_update_font_panel (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextView *)$an_item updateFontPanel];
			 ]"
		end

	objc_update_drag_type_registration (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextView *)$an_item updateDragTypeRegistration];
			 ]"
		end

	objc_selection_range_for_proposed_range__granularity_ (an_item: POINTER; result_pointer: POINTER; a_proposed_char_range: POINTER; a_granularity: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRange *)$result_pointer = [(NSTextView *)$an_item selectionRangeForProposedRange:*((NSRange *)$a_proposed_char_range) granularity:$a_granularity];
			 ]"
		end

	objc_clicked_on_link__at_index_ (an_item: POINTER; a_link: POINTER; a_char_index: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextView *)$an_item clickedOnLink:$a_link atIndex:$a_char_index];
			 ]"
		end

	objc_start_speaking_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextView *)$an_item startSpeaking:$a_sender];
			 ]"
		end

	objc_stop_speaking_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextView *)$an_item stopSpeaking:$a_sender];
			 ]"
		end

	objc_character_index_for_insertion_at_point_ (an_item: POINTER; a_point: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTextView *)$an_item characterIndexForInsertionAtPoint:*((NSPoint *)$a_point)];
			 ]"
		end

feature -- NSTextView

	text_container: detachable NS_TEXT_CONTAINER
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_text_container (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like text_container} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like text_container} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_text_container_ (a_container: detachable NS_TEXT_CONTAINER)
			-- Auto generated Objective-C wrapper.
		local
			a_container__item: POINTER
		do
			if attached a_container as a_container_attached then
				a_container__item := a_container_attached.item
			end
			objc_set_text_container_ (item, a_container__item)
		end

	replace_text_container_ (a_new_container: detachable NS_TEXT_CONTAINER)
			-- Auto generated Objective-C wrapper.
		local
			a_new_container__item: POINTER
		do
			if attached a_new_container as a_new_container_attached then
				a_new_container__item := a_new_container_attached.item
			end
			objc_replace_text_container_ (item, a_new_container__item)
		end

	set_text_container_inset_ (a_inset: NS_SIZE)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_text_container_inset_ (item, a_inset.item)
		end

	text_container_inset: NS_SIZE
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_text_container_inset (item, Result.item)
		end

	text_container_origin: NS_POINT
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_text_container_origin (item, Result.item)
		end

	invalidate_text_container_origin
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_invalidate_text_container_origin (item)
		end

	layout_manager: detachable NS_LAYOUT_MANAGER
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_layout_manager (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like layout_manager} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like layout_manager} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	text_storage: detachable NS_TEXT_STORAGE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_text_storage (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like text_storage} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like text_storage} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_constrained_frame_size_ (a_desired_size: NS_SIZE)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_constrained_frame_size_ (item, a_desired_size.item)
		end

	set_alignment__range_ (a_alignment: NATURAL_64; a_range: NS_RANGE)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_alignment__range_ (item, a_alignment, a_range.item)
		end

	set_base_writing_direction__range_ (a_writing_direction: INTEGER_64; a_range: NS_RANGE)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_base_writing_direction__range_ (item, a_writing_direction, a_range.item)
		end

	turn_off_kerning_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_turn_off_kerning_ (item, a_sender__item)
		end

	tighten_kerning_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_tighten_kerning_ (item, a_sender__item)
		end

	loosen_kerning_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_loosen_kerning_ (item, a_sender__item)
		end

	use_standard_kerning_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_use_standard_kerning_ (item, a_sender__item)
		end

	turn_off_ligatures_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_turn_off_ligatures_ (item, a_sender__item)
		end

	use_standard_ligatures_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_use_standard_ligatures_ (item, a_sender__item)
		end

	use_all_ligatures_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_use_all_ligatures_ (item, a_sender__item)
		end

	raise_baseline_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_raise_baseline_ (item, a_sender__item)
		end

	lower_baseline_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_lower_baseline_ (item, a_sender__item)
		end

	toggle_traditional_character_shape_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_toggle_traditional_character_shape_ (item, a_sender__item)
		end

	outline_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_outline_ (item, a_sender__item)
		end

	perform_find_panel_action_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_perform_find_panel_action_ (item, a_sender__item)
		end

	align_justified_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_align_justified_ (item, a_sender__item)
		end

	change_attributes_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_change_attributes_ (item, a_sender__item)
		end

	change_document_background_color_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_change_document_background_color_ (item, a_sender__item)
		end

	order_front_spacing_panel_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_order_front_spacing_panel_ (item, a_sender__item)
		end

	order_front_link_panel_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_order_front_link_panel_ (item, a_sender__item)
		end

	order_front_list_panel_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_order_front_list_panel_ (item, a_sender__item)
		end

	order_front_table_panel_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_order_front_table_panel_ (item, a_sender__item)
		end

	set_needs_display_in_rect__avoid_additional_layout_ (a_rect: NS_RECT; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_needs_display_in_rect__avoid_additional_layout_ (item, a_rect.item, a_flag)
		end

	should_draw_insertion_point: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_should_draw_insertion_point (item)
		end

	draw_insertion_point_in_rect__color__turned_on_ (a_rect: NS_RECT; a_color: detachable NS_COLOR; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
			a_color__item: POINTER
		do
			if attached a_color as a_color_attached then
				a_color__item := a_color_attached.item
			end
			objc_draw_insertion_point_in_rect__color__turned_on_ (item, a_rect.item, a_color__item, a_flag)
		end

	draw_view_background_in_rect_ (a_rect: NS_RECT)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_draw_view_background_in_rect_ (item, a_rect.item)
		end

	update_ruler
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_update_ruler (item)
		end

	update_font_panel
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_update_font_panel (item)
		end

	update_drag_type_registration
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_update_drag_type_registration (item)
		end

	selection_range_for_proposed_range__granularity_ (a_proposed_char_range: NS_RANGE; a_granularity: NATURAL_64): NS_RANGE
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_selection_range_for_proposed_range__granularity_ (item, Result.item, a_proposed_char_range.item, a_granularity)
		end

	clicked_on_link__at_index_ (a_link: detachable NS_OBJECT; a_char_index: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
			a_link__item: POINTER
		do
			if attached a_link as a_link_attached then
				a_link__item := a_link_attached.item
			end
			objc_clicked_on_link__at_index_ (item, a_link__item, a_char_index)
		end

	start_speaking_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_start_speaking_ (item, a_sender__item)
		end

	stop_speaking_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_stop_speaking_ (item, a_sender__item)
		end

	character_index_for_insertion_at_point_ (a_point: NS_POINT): NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_character_index_for_insertion_at_point_ (item, a_point.item)
		end

feature -- NSCompletion

	range_for_user_completion: NS_RANGE
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_range_for_user_completion (item, Result.item)
		end

--	completions_for_partial_word_range__index_of_selected_item_ (a_char_range: NS_RANGE; a_index: UNSUPPORTED_TYPE): detachable NS_ARRAY
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			a_index__item: POINTER
--		do
--			if attached a_index as a_index_attached then
--				a_index__item := a_index_attached.item
--			end
--			result_pointer := objc_completions_for_partial_word_range__index_of_selected_item_ (item, a_char_range.item, a_index__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like completions_for_partial_word_range__index_of_selected_item_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like completions_for_partial_word_range__index_of_selected_item_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

	insert_completion__for_partial_word_range__movement__is_final_ (a_word: detachable NS_STRING; a_char_range: NS_RANGE; a_movement: INTEGER_64; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
			a_word__item: POINTER
		do
			if attached a_word as a_word_attached then
				a_word__item := a_word_attached.item
			end
			objc_insert_completion__for_partial_word_range__movement__is_final_ (item, a_word__item, a_char_range.item, a_movement, a_flag)
		end

feature {NONE} -- NSCompletion Externals

	objc_range_for_user_completion (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRange *)$result_pointer = [(NSTextView *)$an_item rangeForUserCompletion];
			 ]"
		end

--	objc_completions_for_partial_word_range__index_of_selected_item_ (an_item: POINTER; a_char_range: POINTER; a_index: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSTextView *)$an_item completionsForPartialWordRange:*((NSRange *)$a_char_range) indexOfSelectedItem:];
--			 ]"
--		end

	objc_insert_completion__for_partial_word_range__movement__is_final_ (an_item: POINTER; a_word: POINTER; a_char_range: POINTER; a_movement: INTEGER_64; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextView *)$an_item insertCompletion:$a_word forPartialWordRange:*((NSRange *)$a_char_range) movement:$a_movement isFinal:$a_flag];
			 ]"
		end

feature -- NSPasteboard

	writable_pasteboard_types: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_writable_pasteboard_types (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like writable_pasteboard_types} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like writable_pasteboard_types} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	write_selection_to_pasteboard__type_ (a_pboard: detachable NS_PASTEBOARD; a_type: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_pboard__item: POINTER
			a_type__item: POINTER
		do
			if attached a_pboard as a_pboard_attached then
				a_pboard__item := a_pboard_attached.item
			end
			if attached a_type as a_type_attached then
				a_type__item := a_type_attached.item
			end
			Result := objc_write_selection_to_pasteboard__type_ (item, a_pboard__item, a_type__item)
		end

	readable_pasteboard_types: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_readable_pasteboard_types (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like readable_pasteboard_types} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like readable_pasteboard_types} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	preferred_pasteboard_type_from_array__restricted_to_types_from_array_ (a_available_types: detachable NS_ARRAY; a_allowed_types: detachable NS_ARRAY): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_available_types__item: POINTER
			a_allowed_types__item: POINTER
		do
			if attached a_available_types as a_available_types_attached then
				a_available_types__item := a_available_types_attached.item
			end
			if attached a_allowed_types as a_allowed_types_attached then
				a_allowed_types__item := a_allowed_types_attached.item
			end
			result_pointer := objc_preferred_pasteboard_type_from_array__restricted_to_types_from_array_ (item, a_available_types__item, a_allowed_types__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like preferred_pasteboard_type_from_array__restricted_to_types_from_array_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like preferred_pasteboard_type_from_array__restricted_to_types_from_array_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	read_selection_from_pasteboard__type_ (a_pboard: detachable NS_PASTEBOARD; a_type: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_pboard__item: POINTER
			a_type__item: POINTER
		do
			if attached a_pboard as a_pboard_attached then
				a_pboard__item := a_pboard_attached.item
			end
			if attached a_type as a_type_attached then
				a_type__item := a_type_attached.item
			end
			Result := objc_read_selection_from_pasteboard__type_ (item, a_pboard__item, a_type__item)
		end

	paste_as_plain_text_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_paste_as_plain_text_ (item, a_sender__item)
		end

	paste_as_rich_text_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_paste_as_rich_text_ (item, a_sender__item)
		end

feature {NONE} -- NSPasteboard Externals

	objc_writable_pasteboard_types (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTextView *)$an_item writablePasteboardTypes];
			 ]"
		end

	objc_write_selection_to_pasteboard__type_ (an_item: POINTER; a_pboard: POINTER; a_type: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTextView *)$an_item writeSelectionToPasteboard:$a_pboard type:$a_type];
			 ]"
		end

	objc_readable_pasteboard_types (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTextView *)$an_item readablePasteboardTypes];
			 ]"
		end

	objc_preferred_pasteboard_type_from_array__restricted_to_types_from_array_ (an_item: POINTER; a_available_types: POINTER; a_allowed_types: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTextView *)$an_item preferredPasteboardTypeFromArray:$a_available_types restrictedToTypesFromArray:$a_allowed_types];
			 ]"
		end

	objc_read_selection_from_pasteboard__type_ (an_item: POINTER; a_pboard: POINTER; a_type: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTextView *)$an_item readSelectionFromPasteboard:$a_pboard type:$a_type];
			 ]"
		end

	objc_paste_as_plain_text_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextView *)$an_item pasteAsPlainText:$a_sender];
			 ]"
		end

	objc_paste_as_rich_text_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextView *)$an_item pasteAsRichText:$a_sender];
			 ]"
		end

feature -- NSDragging

	drag_selection_with_event__offset__slide_back_ (a_event: detachable NS_EVENT; a_mouse_offset: NS_SIZE; a_slide_back: BOOLEAN): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_event__item: POINTER
		do
			if attached a_event as a_event_attached then
				a_event__item := a_event_attached.item
			end
			Result := objc_drag_selection_with_event__offset__slide_back_ (item, a_event__item, a_mouse_offset.item, a_slide_back)
		end

--	drag_image_for_selection_with_event__origin_ (a_event: detachable NS_EVENT; a_origin: UNSUPPORTED_TYPE): detachable NS_IMAGE
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			a_event__item: POINTER
--			a_origin__item: POINTER
--		do
--			if attached a_event as a_event_attached then
--				a_event__item := a_event_attached.item
--			end
--			if attached a_origin as a_origin_attached then
--				a_origin__item := a_origin_attached.item
--			end
--			result_pointer := objc_drag_image_for_selection_with_event__origin_ (item, a_event__item, a_origin__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like drag_image_for_selection_with_event__origin_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like drag_image_for_selection_with_event__origin_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

	acceptable_drag_types: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_acceptable_drag_types (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like acceptable_drag_types} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like acceptable_drag_types} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	drag_operation_for_dragging_info__type_ (a_drag_info: detachable NS_DRAGGING_INFO_PROTOCOL; a_type: detachable NS_STRING): NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
			a_drag_info__item: POINTER
			a_type__item: POINTER
		do
			if attached a_drag_info as a_drag_info_attached then
				a_drag_info__item := a_drag_info_attached.item
			end
			if attached a_type as a_type_attached then
				a_type__item := a_type_attached.item
			end
			Result := objc_drag_operation_for_dragging_info__type_ (item, a_drag_info__item, a_type__item)
		end

	clean_up_after_drag_operation
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_clean_up_after_drag_operation (item)
		end

feature {NONE} -- NSDragging Externals

	objc_drag_selection_with_event__offset__slide_back_ (an_item: POINTER; a_event: POINTER; a_mouse_offset: POINTER; a_slide_back: BOOLEAN): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTextView *)$an_item dragSelectionWithEvent:$a_event offset:*((NSSize *)$a_mouse_offset) slideBack:$a_slide_back];
			 ]"
		end

--	objc_drag_image_for_selection_with_event__origin_ (an_item: POINTER; a_event: POINTER; a_origin: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSTextView *)$an_item dragImageForSelectionWithEvent:$a_event origin:];
--			 ]"
--		end

	objc_acceptable_drag_types (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTextView *)$an_item acceptableDragTypes];
			 ]"
		end

	objc_drag_operation_for_dragging_info__type_ (an_item: POINTER; a_drag_info: POINTER; a_type: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTextView *)$an_item dragOperationForDraggingInfo:$a_drag_info type:$a_type];
			 ]"
		end

	objc_clean_up_after_drag_operation (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextView *)$an_item cleanUpAfterDragOperation];
			 ]"
		end

feature -- NSSharing

	selected_ranges: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_selected_ranges (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like selected_ranges} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like selected_ranges} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_selected_ranges__affinity__still_selecting_ (a_ranges: detachable NS_ARRAY; a_affinity: NATURAL_64; a_still_selecting_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
			a_ranges__item: POINTER
		do
			if attached a_ranges as a_ranges_attached then
				a_ranges__item := a_ranges_attached.item
			end
			objc_set_selected_ranges__affinity__still_selecting_ (item, a_ranges__item, a_affinity, a_still_selecting_flag)
		end

	set_selected_ranges_ (a_ranges: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_ranges__item: POINTER
		do
			if attached a_ranges as a_ranges_attached then
				a_ranges__item := a_ranges_attached.item
			end
			objc_set_selected_ranges_ (item, a_ranges__item)
		end

	set_selected_range__affinity__still_selecting_ (a_char_range: NS_RANGE; a_affinity: NATURAL_64; a_still_selecting_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_selected_range__affinity__still_selecting_ (item, a_char_range.item, a_affinity, a_still_selecting_flag)
		end

	selection_affinity: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_selection_affinity (item)
		end

	selection_granularity: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_selection_granularity (item)
		end

	set_selection_granularity_ (a_granularity: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_selection_granularity_ (item, a_granularity)
		end

	set_selected_text_attributes_ (a_attribute_dictionary: detachable NS_DICTIONARY)
			-- Auto generated Objective-C wrapper.
		local
			a_attribute_dictionary__item: POINTER
		do
			if attached a_attribute_dictionary as a_attribute_dictionary_attached then
				a_attribute_dictionary__item := a_attribute_dictionary_attached.item
			end
			objc_set_selected_text_attributes_ (item, a_attribute_dictionary__item)
		end

	selected_text_attributes: detachable NS_DICTIONARY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_selected_text_attributes (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like selected_text_attributes} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like selected_text_attributes} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_insertion_point_color_ (a_color: detachable NS_COLOR)
			-- Auto generated Objective-C wrapper.
		local
			a_color__item: POINTER
		do
			if attached a_color as a_color_attached then
				a_color__item := a_color_attached.item
			end
			objc_set_insertion_point_color_ (item, a_color__item)
		end

	insertion_point_color: detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_insertion_point_color (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like insertion_point_color} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like insertion_point_color} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	update_insertion_point_state_and_restart_timer_ (a_restart_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_update_insertion_point_state_and_restart_timer_ (item, a_restart_flag)
		end

	set_marked_text_attributes_ (a_attribute_dictionary: detachable NS_DICTIONARY)
			-- Auto generated Objective-C wrapper.
		local
			a_attribute_dictionary__item: POINTER
		do
			if attached a_attribute_dictionary as a_attribute_dictionary_attached then
				a_attribute_dictionary__item := a_attribute_dictionary_attached.item
			end
			objc_set_marked_text_attributes_ (item, a_attribute_dictionary__item)
		end

	marked_text_attributes: detachable NS_DICTIONARY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_marked_text_attributes (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like marked_text_attributes} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like marked_text_attributes} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_link_text_attributes_ (a_attribute_dictionary: detachable NS_DICTIONARY)
			-- Auto generated Objective-C wrapper.
		local
			a_attribute_dictionary__item: POINTER
		do
			if attached a_attribute_dictionary as a_attribute_dictionary_attached then
				a_attribute_dictionary__item := a_attribute_dictionary_attached.item
			end
			objc_set_link_text_attributes_ (item, a_attribute_dictionary__item)
		end

	link_text_attributes: detachable NS_DICTIONARY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_link_text_attributes (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like link_text_attributes} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like link_text_attributes} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	displays_link_tool_tips: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_displays_link_tool_tips (item)
		end

	set_displays_link_tool_tips_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_displays_link_tool_tips_ (item, a_flag)
		end

	accepts_glyph_info: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_accepts_glyph_info (item)
		end

	set_accepts_glyph_info_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_accepts_glyph_info_ (item, a_flag)
		end

	set_ruler_visible_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_ruler_visible_ (item, a_flag)
		end

	uses_ruler: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_uses_ruler (item)
		end

	set_uses_ruler_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_uses_ruler_ (item, a_flag)
		end

	set_continuous_spell_checking_enabled_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_continuous_spell_checking_enabled_ (item, a_flag)
		end

	is_continuous_spell_checking_enabled: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_continuous_spell_checking_enabled (item)
		end

	toggle_continuous_spell_checking_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_toggle_continuous_spell_checking_ (item, a_sender__item)
		end

	spell_checker_document_tag: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_spell_checker_document_tag (item)
		end

	set_grammar_checking_enabled_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_grammar_checking_enabled_ (item, a_flag)
		end

	is_grammar_checking_enabled: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_grammar_checking_enabled (item)
		end

	toggle_grammar_checking_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_toggle_grammar_checking_ (item, a_sender__item)
		end

	set_spelling_state__range_ (a_value: INTEGER_64; a_char_range: NS_RANGE)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_spelling_state__range_ (item, a_value, a_char_range.item)
		end

	typing_attributes: detachable NS_DICTIONARY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_typing_attributes (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like typing_attributes} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like typing_attributes} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_typing_attributes_ (a_attrs: detachable NS_DICTIONARY)
			-- Auto generated Objective-C wrapper.
		local
			a_attrs__item: POINTER
		do
			if attached a_attrs as a_attrs_attached then
				a_attrs__item := a_attrs_attached.item
			end
			objc_set_typing_attributes_ (item, a_attrs__item)
		end

	should_change_text_in_ranges__replacement_strings_ (a_affected_ranges: detachable NS_ARRAY; a_replacement_strings: detachable NS_ARRAY): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_affected_ranges__item: POINTER
			a_replacement_strings__item: POINTER
		do
			if attached a_affected_ranges as a_affected_ranges_attached then
				a_affected_ranges__item := a_affected_ranges_attached.item
			end
			if attached a_replacement_strings as a_replacement_strings_attached then
				a_replacement_strings__item := a_replacement_strings_attached.item
			end
			Result := objc_should_change_text_in_ranges__replacement_strings_ (item, a_affected_ranges__item, a_replacement_strings__item)
		end

	ranges_for_user_text_change: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_ranges_for_user_text_change (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like ranges_for_user_text_change} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like ranges_for_user_text_change} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	ranges_for_user_character_attribute_change: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_ranges_for_user_character_attribute_change (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like ranges_for_user_character_attribute_change} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like ranges_for_user_character_attribute_change} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	ranges_for_user_paragraph_attribute_change: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_ranges_for_user_paragraph_attribute_change (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like ranges_for_user_paragraph_attribute_change} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like ranges_for_user_paragraph_attribute_change} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	should_change_text_in_range__replacement_string_ (a_affected_char_range: NS_RANGE; a_replacement_string: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_replacement_string__item: POINTER
		do
			if attached a_replacement_string as a_replacement_string_attached then
				a_replacement_string__item := a_replacement_string_attached.item
			end
			Result := objc_should_change_text_in_range__replacement_string_ (item, a_affected_char_range.item, a_replacement_string__item)
		end

	did_change_text
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_did_change_text (item)
		end

	range_for_user_text_change: NS_RANGE
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_range_for_user_text_change (item, Result.item)
		end

	range_for_user_character_attribute_change: NS_RANGE
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_range_for_user_character_attribute_change (item, Result.item)
		end

	range_for_user_paragraph_attribute_change: NS_RANGE
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_range_for_user_paragraph_attribute_change (item, Result.item)
		end

	set_uses_find_panel_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_uses_find_panel_ (item, a_flag)
		end

	uses_find_panel: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_uses_find_panel (item)
		end

	set_allows_document_background_color_change_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_allows_document_background_color_change_ (item, a_flag)
		end

	allows_document_background_color_change: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_allows_document_background_color_change (item)
		end

	set_default_paragraph_style_ (a_paragraph_style: detachable NS_PARAGRAPH_STYLE)
			-- Auto generated Objective-C wrapper.
		local
			a_paragraph_style__item: POINTER
		do
			if attached a_paragraph_style as a_paragraph_style_attached then
				a_paragraph_style__item := a_paragraph_style_attached.item
			end
			objc_set_default_paragraph_style_ (item, a_paragraph_style__item)
		end

	default_paragraph_style: detachable NS_PARAGRAPH_STYLE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_default_paragraph_style (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like default_paragraph_style} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like default_paragraph_style} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_allows_undo_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_allows_undo_ (item, a_flag)
		end

	allows_undo: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_allows_undo (item)
		end

	break_undo_coalescing
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_break_undo_coalescing (item)
		end

	is_coalescing_undo: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_coalescing_undo (item)
		end

	allows_image_editing: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_allows_image_editing (item)
		end

	set_allows_image_editing_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_allows_image_editing_ (item, a_flag)
		end

	show_find_indicator_for_range_ (a_char_range: NS_RANGE)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_show_find_indicator_for_range_ (item, a_char_range.item)
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

feature {NONE} -- NSSharing Externals

	objc_selected_ranges (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTextView *)$an_item selectedRanges];
			 ]"
		end

	objc_set_selected_ranges__affinity__still_selecting_ (an_item: POINTER; a_ranges: POINTER; a_affinity: NATURAL_64; a_still_selecting_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextView *)$an_item setSelectedRanges:$a_ranges affinity:$a_affinity stillSelecting:$a_still_selecting_flag];
			 ]"
		end

	objc_set_selected_ranges_ (an_item: POINTER; a_ranges: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextView *)$an_item setSelectedRanges:$a_ranges];
			 ]"
		end

	objc_set_selected_range__affinity__still_selecting_ (an_item: POINTER; a_char_range: POINTER; a_affinity: NATURAL_64; a_still_selecting_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextView *)$an_item setSelectedRange:*((NSRange *)$a_char_range) affinity:$a_affinity stillSelecting:$a_still_selecting_flag];
			 ]"
		end

	objc_selection_affinity (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTextView *)$an_item selectionAffinity];
			 ]"
		end

	objc_selection_granularity (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTextView *)$an_item selectionGranularity];
			 ]"
		end

	objc_set_selection_granularity_ (an_item: POINTER; a_granularity: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextView *)$an_item setSelectionGranularity:$a_granularity];
			 ]"
		end

	objc_set_selected_text_attributes_ (an_item: POINTER; a_attribute_dictionary: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextView *)$an_item setSelectedTextAttributes:$a_attribute_dictionary];
			 ]"
		end

	objc_selected_text_attributes (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTextView *)$an_item selectedTextAttributes];
			 ]"
		end

	objc_set_insertion_point_color_ (an_item: POINTER; a_color: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextView *)$an_item setInsertionPointColor:$a_color];
			 ]"
		end

	objc_insertion_point_color (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTextView *)$an_item insertionPointColor];
			 ]"
		end

	objc_update_insertion_point_state_and_restart_timer_ (an_item: POINTER; a_restart_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextView *)$an_item updateInsertionPointStateAndRestartTimer:$a_restart_flag];
			 ]"
		end

	objc_set_marked_text_attributes_ (an_item: POINTER; a_attribute_dictionary: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextView *)$an_item setMarkedTextAttributes:$a_attribute_dictionary];
			 ]"
		end

	objc_marked_text_attributes (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTextView *)$an_item markedTextAttributes];
			 ]"
		end

	objc_set_link_text_attributes_ (an_item: POINTER; a_attribute_dictionary: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextView *)$an_item setLinkTextAttributes:$a_attribute_dictionary];
			 ]"
		end

	objc_link_text_attributes (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTextView *)$an_item linkTextAttributes];
			 ]"
		end

	objc_displays_link_tool_tips (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTextView *)$an_item displaysLinkToolTips];
			 ]"
		end

	objc_set_displays_link_tool_tips_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextView *)$an_item setDisplaysLinkToolTips:$a_flag];
			 ]"
		end

	objc_accepts_glyph_info (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTextView *)$an_item acceptsGlyphInfo];
			 ]"
		end

	objc_set_accepts_glyph_info_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextView *)$an_item setAcceptsGlyphInfo:$a_flag];
			 ]"
		end

	objc_set_ruler_visible_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextView *)$an_item setRulerVisible:$a_flag];
			 ]"
		end

	objc_uses_ruler (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTextView *)$an_item usesRuler];
			 ]"
		end

	objc_set_uses_ruler_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextView *)$an_item setUsesRuler:$a_flag];
			 ]"
		end

	objc_set_continuous_spell_checking_enabled_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextView *)$an_item setContinuousSpellCheckingEnabled:$a_flag];
			 ]"
		end

	objc_is_continuous_spell_checking_enabled (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTextView *)$an_item isContinuousSpellCheckingEnabled];
			 ]"
		end

	objc_toggle_continuous_spell_checking_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextView *)$an_item toggleContinuousSpellChecking:$a_sender];
			 ]"
		end

	objc_spell_checker_document_tag (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTextView *)$an_item spellCheckerDocumentTag];
			 ]"
		end

	objc_set_grammar_checking_enabled_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextView *)$an_item setGrammarCheckingEnabled:$a_flag];
			 ]"
		end

	objc_is_grammar_checking_enabled (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTextView *)$an_item isGrammarCheckingEnabled];
			 ]"
		end

	objc_toggle_grammar_checking_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextView *)$an_item toggleGrammarChecking:$a_sender];
			 ]"
		end

	objc_set_spelling_state__range_ (an_item: POINTER; a_value: INTEGER_64; a_char_range: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextView *)$an_item setSpellingState:$a_value range:*((NSRange *)$a_char_range)];
			 ]"
		end

	objc_typing_attributes (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTextView *)$an_item typingAttributes];
			 ]"
		end

	objc_set_typing_attributes_ (an_item: POINTER; a_attrs: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextView *)$an_item setTypingAttributes:$a_attrs];
			 ]"
		end

	objc_should_change_text_in_ranges__replacement_strings_ (an_item: POINTER; a_affected_ranges: POINTER; a_replacement_strings: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTextView *)$an_item shouldChangeTextInRanges:$a_affected_ranges replacementStrings:$a_replacement_strings];
			 ]"
		end

	objc_ranges_for_user_text_change (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTextView *)$an_item rangesForUserTextChange];
			 ]"
		end

	objc_ranges_for_user_character_attribute_change (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTextView *)$an_item rangesForUserCharacterAttributeChange];
			 ]"
		end

	objc_ranges_for_user_paragraph_attribute_change (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTextView *)$an_item rangesForUserParagraphAttributeChange];
			 ]"
		end

	objc_should_change_text_in_range__replacement_string_ (an_item: POINTER; a_affected_char_range: POINTER; a_replacement_string: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTextView *)$an_item shouldChangeTextInRange:*((NSRange *)$a_affected_char_range) replacementString:$a_replacement_string];
			 ]"
		end

	objc_did_change_text (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextView *)$an_item didChangeText];
			 ]"
		end

	objc_range_for_user_text_change (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRange *)$result_pointer = [(NSTextView *)$an_item rangeForUserTextChange];
			 ]"
		end

	objc_range_for_user_character_attribute_change (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRange *)$result_pointer = [(NSTextView *)$an_item rangeForUserCharacterAttributeChange];
			 ]"
		end

	objc_range_for_user_paragraph_attribute_change (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRange *)$result_pointer = [(NSTextView *)$an_item rangeForUserParagraphAttributeChange];
			 ]"
		end

	objc_set_uses_find_panel_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextView *)$an_item setUsesFindPanel:$a_flag];
			 ]"
		end

	objc_uses_find_panel (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTextView *)$an_item usesFindPanel];
			 ]"
		end

	objc_set_allows_document_background_color_change_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextView *)$an_item setAllowsDocumentBackgroundColorChange:$a_flag];
			 ]"
		end

	objc_allows_document_background_color_change (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTextView *)$an_item allowsDocumentBackgroundColorChange];
			 ]"
		end

	objc_set_default_paragraph_style_ (an_item: POINTER; a_paragraph_style: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextView *)$an_item setDefaultParagraphStyle:$a_paragraph_style];
			 ]"
		end

	objc_default_paragraph_style (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTextView *)$an_item defaultParagraphStyle];
			 ]"
		end

	objc_set_allows_undo_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextView *)$an_item setAllowsUndo:$a_flag];
			 ]"
		end

	objc_allows_undo (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTextView *)$an_item allowsUndo];
			 ]"
		end

	objc_break_undo_coalescing (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextView *)$an_item breakUndoCoalescing];
			 ]"
		end

	objc_is_coalescing_undo (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTextView *)$an_item isCoalescingUndo];
			 ]"
		end

	objc_allows_image_editing (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTextView *)$an_item allowsImageEditing];
			 ]"
		end

	objc_set_allows_image_editing_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextView *)$an_item setAllowsImageEditing:$a_flag];
			 ]"
		end

	objc_show_find_indicator_for_range_ (an_item: POINTER; a_char_range: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextView *)$an_item showFindIndicatorForRange:*((NSRange *)$a_char_range)];
			 ]"
		end

	objc_allowed_input_source_locales (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTextView *)$an_item allowedInputSourceLocales];
			 ]"
		end

	objc_set_allowed_input_source_locales_ (an_item: POINTER; a_locale_identifiers: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextView *)$an_item setAllowedInputSourceLocales:$a_locale_identifiers];
			 ]"
		end

feature -- NSTextChecking

	smart_insert_delete_enabled: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_smart_insert_delete_enabled (item)
		end

	set_smart_insert_delete_enabled_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_smart_insert_delete_enabled_ (item, a_flag)
		end

	smart_delete_range_for_proposed_range_ (a_proposed_char_range: NS_RANGE): NS_RANGE
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_smart_delete_range_for_proposed_range_ (item, Result.item, a_proposed_char_range.item)
		end

	toggle_smart_insert_delete_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_toggle_smart_insert_delete_ (item, a_sender__item)
		end

--	smart_insert_for_string__replacing_range__before_string__after_string_ (a_paste_string: detachable NS_STRING; a_char_range_to_replace: NS_RANGE; a_before_string: UNSUPPORTED_TYPE; a_after_string: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_paste_string__item: POINTER
--			a_before_string__item: POINTER
--			a_after_string__item: POINTER
--		do
--			if attached a_paste_string as a_paste_string_attached then
--				a_paste_string__item := a_paste_string_attached.item
--			end
--			if attached a_before_string as a_before_string_attached then
--				a_before_string__item := a_before_string_attached.item
--			end
--			if attached a_after_string as a_after_string_attached then
--				a_after_string__item := a_after_string_attached.item
--			end
--			objc_smart_insert_for_string__replacing_range__before_string__after_string_ (item, a_paste_string__item, a_char_range_to_replace.item, a_before_string__item, a_after_string__item)
--		end

	smart_insert_before_string_for_string__replacing_range_ (a_paste_string: detachable NS_STRING; a_char_range_to_replace: NS_RANGE): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_paste_string__item: POINTER
		do
			if attached a_paste_string as a_paste_string_attached then
				a_paste_string__item := a_paste_string_attached.item
			end
			result_pointer := objc_smart_insert_before_string_for_string__replacing_range_ (item, a_paste_string__item, a_char_range_to_replace.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like smart_insert_before_string_for_string__replacing_range_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like smart_insert_before_string_for_string__replacing_range_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	smart_insert_after_string_for_string__replacing_range_ (a_paste_string: detachable NS_STRING; a_char_range_to_replace: NS_RANGE): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_paste_string__item: POINTER
		do
			if attached a_paste_string as a_paste_string_attached then
				a_paste_string__item := a_paste_string_attached.item
			end
			result_pointer := objc_smart_insert_after_string_for_string__replacing_range_ (item, a_paste_string__item, a_char_range_to_replace.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like smart_insert_after_string_for_string__replacing_range_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like smart_insert_after_string_for_string__replacing_range_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_automatic_quote_substitution_enabled_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_automatic_quote_substitution_enabled_ (item, a_flag)
		end

	is_automatic_quote_substitution_enabled: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_automatic_quote_substitution_enabled (item)
		end

	toggle_automatic_quote_substitution_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_toggle_automatic_quote_substitution_ (item, a_sender__item)
		end

	set_automatic_link_detection_enabled_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_automatic_link_detection_enabled_ (item, a_flag)
		end

	is_automatic_link_detection_enabled: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_automatic_link_detection_enabled (item)
		end

	toggle_automatic_link_detection_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_toggle_automatic_link_detection_ (item, a_sender__item)
		end

	set_automatic_data_detection_enabled_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_automatic_data_detection_enabled_ (item, a_flag)
		end

	is_automatic_data_detection_enabled: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_automatic_data_detection_enabled (item)
		end

	toggle_automatic_data_detection_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_toggle_automatic_data_detection_ (item, a_sender__item)
		end

	set_automatic_dash_substitution_enabled_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_automatic_dash_substitution_enabled_ (item, a_flag)
		end

	is_automatic_dash_substitution_enabled: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_automatic_dash_substitution_enabled (item)
		end

	toggle_automatic_dash_substitution_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_toggle_automatic_dash_substitution_ (item, a_sender__item)
		end

	set_automatic_text_replacement_enabled_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_automatic_text_replacement_enabled_ (item, a_flag)
		end

	is_automatic_text_replacement_enabled: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_automatic_text_replacement_enabled (item)
		end

	toggle_automatic_text_replacement_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_toggle_automatic_text_replacement_ (item, a_sender__item)
		end

	set_automatic_spelling_correction_enabled_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_automatic_spelling_correction_enabled_ (item, a_flag)
		end

	is_automatic_spelling_correction_enabled: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_automatic_spelling_correction_enabled (item)
		end

	toggle_automatic_spelling_correction_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_toggle_automatic_spelling_correction_ (item, a_sender__item)
		end

	enabled_text_checking_types: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_enabled_text_checking_types (item)
		end

	set_enabled_text_checking_types_ (a_checking_types: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_enabled_text_checking_types_ (item, a_checking_types)
		end

	check_text_in_range__types__options_ (a_range: NS_RANGE; a_checking_types: NATURAL_64; a_options: detachable NS_DICTIONARY)
			-- Auto generated Objective-C wrapper.
		local
			a_options__item: POINTER
		do
			if attached a_options as a_options_attached then
				a_options__item := a_options_attached.item
			end
			objc_check_text_in_range__types__options_ (item, a_range.item, a_checking_types, a_options__item)
		end

	handle_text_checking_results__for_range__types__options__orthography__word_count_ (a_results: detachable NS_ARRAY; a_range: NS_RANGE; a_checking_types: NATURAL_64; a_options: detachable NS_DICTIONARY; a_orthography: detachable NS_ORTHOGRAPHY; a_word_count: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
			a_results__item: POINTER
			a_options__item: POINTER
			a_orthography__item: POINTER
		do
			if attached a_results as a_results_attached then
				a_results__item := a_results_attached.item
			end
			if attached a_options as a_options_attached then
				a_options__item := a_options_attached.item
			end
			if attached a_orthography as a_orthography_attached then
				a_orthography__item := a_orthography_attached.item
			end
			objc_handle_text_checking_results__for_range__types__options__orthography__word_count_ (item, a_results__item, a_range.item, a_checking_types, a_options__item, a_orthography__item, a_word_count)
		end

	order_front_substitutions_panel_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_order_front_substitutions_panel_ (item, a_sender__item)
		end

	check_text_in_selection_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_check_text_in_selection_ (item, a_sender__item)
		end

	check_text_in_document_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_check_text_in_document_ (item, a_sender__item)
		end

feature {NONE} -- NSTextChecking Externals

	objc_smart_insert_delete_enabled (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTextView *)$an_item smartInsertDeleteEnabled];
			 ]"
		end

	objc_set_smart_insert_delete_enabled_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextView *)$an_item setSmartInsertDeleteEnabled:$a_flag];
			 ]"
		end

	objc_smart_delete_range_for_proposed_range_ (an_item: POINTER; result_pointer: POINTER; a_proposed_char_range: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRange *)$result_pointer = [(NSTextView *)$an_item smartDeleteRangeForProposedRange:*((NSRange *)$a_proposed_char_range)];
			 ]"
		end

	objc_toggle_smart_insert_delete_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextView *)$an_item toggleSmartInsertDelete:$a_sender];
			 ]"
		end

--	objc_smart_insert_for_string__replacing_range__before_string__after_string_ (an_item: POINTER; a_paste_string: POINTER; a_char_range_to_replace: POINTER; a_before_string: UNSUPPORTED_TYPE; a_after_string: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				[(NSTextView *)$an_item smartInsertForString:$a_paste_string replacingRange:*((NSRange *)$a_char_range_to_replace) beforeString: afterString:];
--			 ]"
--		end

	objc_smart_insert_before_string_for_string__replacing_range_ (an_item: POINTER; a_paste_string: POINTER; a_char_range_to_replace: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTextView *)$an_item smartInsertBeforeStringForString:$a_paste_string replacingRange:*((NSRange *)$a_char_range_to_replace)];
			 ]"
		end

	objc_smart_insert_after_string_for_string__replacing_range_ (an_item: POINTER; a_paste_string: POINTER; a_char_range_to_replace: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTextView *)$an_item smartInsertAfterStringForString:$a_paste_string replacingRange:*((NSRange *)$a_char_range_to_replace)];
			 ]"
		end

	objc_set_automatic_quote_substitution_enabled_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextView *)$an_item setAutomaticQuoteSubstitutionEnabled:$a_flag];
			 ]"
		end

	objc_is_automatic_quote_substitution_enabled (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTextView *)$an_item isAutomaticQuoteSubstitutionEnabled];
			 ]"
		end

	objc_toggle_automatic_quote_substitution_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextView *)$an_item toggleAutomaticQuoteSubstitution:$a_sender];
			 ]"
		end

	objc_set_automatic_link_detection_enabled_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextView *)$an_item setAutomaticLinkDetectionEnabled:$a_flag];
			 ]"
		end

	objc_is_automatic_link_detection_enabled (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTextView *)$an_item isAutomaticLinkDetectionEnabled];
			 ]"
		end

	objc_toggle_automatic_link_detection_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextView *)$an_item toggleAutomaticLinkDetection:$a_sender];
			 ]"
		end

	objc_set_automatic_data_detection_enabled_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextView *)$an_item setAutomaticDataDetectionEnabled:$a_flag];
			 ]"
		end

	objc_is_automatic_data_detection_enabled (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTextView *)$an_item isAutomaticDataDetectionEnabled];
			 ]"
		end

	objc_toggle_automatic_data_detection_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextView *)$an_item toggleAutomaticDataDetection:$a_sender];
			 ]"
		end

	objc_set_automatic_dash_substitution_enabled_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextView *)$an_item setAutomaticDashSubstitutionEnabled:$a_flag];
			 ]"
		end

	objc_is_automatic_dash_substitution_enabled (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTextView *)$an_item isAutomaticDashSubstitutionEnabled];
			 ]"
		end

	objc_toggle_automatic_dash_substitution_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextView *)$an_item toggleAutomaticDashSubstitution:$a_sender];
			 ]"
		end

	objc_set_automatic_text_replacement_enabled_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextView *)$an_item setAutomaticTextReplacementEnabled:$a_flag];
			 ]"
		end

	objc_is_automatic_text_replacement_enabled (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTextView *)$an_item isAutomaticTextReplacementEnabled];
			 ]"
		end

	objc_toggle_automatic_text_replacement_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextView *)$an_item toggleAutomaticTextReplacement:$a_sender];
			 ]"
		end

	objc_set_automatic_spelling_correction_enabled_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextView *)$an_item setAutomaticSpellingCorrectionEnabled:$a_flag];
			 ]"
		end

	objc_is_automatic_spelling_correction_enabled (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTextView *)$an_item isAutomaticSpellingCorrectionEnabled];
			 ]"
		end

	objc_toggle_automatic_spelling_correction_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextView *)$an_item toggleAutomaticSpellingCorrection:$a_sender];
			 ]"
		end

	objc_enabled_text_checking_types (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTextView *)$an_item enabledTextCheckingTypes];
			 ]"
		end

	objc_set_enabled_text_checking_types_ (an_item: POINTER; a_checking_types: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextView *)$an_item setEnabledTextCheckingTypes:$a_checking_types];
			 ]"
		end

	objc_check_text_in_range__types__options_ (an_item: POINTER; a_range: POINTER; a_checking_types: NATURAL_64; a_options: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextView *)$an_item checkTextInRange:*((NSRange *)$a_range) types:$a_checking_types options:$a_options];
			 ]"
		end

	objc_handle_text_checking_results__for_range__types__options__orthography__word_count_ (an_item: POINTER; a_results: POINTER; a_range: POINTER; a_checking_types: NATURAL_64; a_options: POINTER; a_orthography: POINTER; a_word_count: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextView *)$an_item handleTextCheckingResults:$a_results forRange:*((NSRange *)$a_range) types:$a_checking_types options:$a_options orthography:$a_orthography wordCount:$a_word_count];
			 ]"
		end

	objc_order_front_substitutions_panel_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextView *)$an_item orderFrontSubstitutionsPanel:$a_sender];
			 ]"
		end

	objc_check_text_in_selection_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextView *)$an_item checkTextInSelection:$a_sender];
			 ]"
		end

	objc_check_text_in_document_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextView *)$an_item checkTextInDocument:$a_sender];
			 ]"
		end

feature -- NSDeprecated

	toggle_base_writing_direction_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_toggle_base_writing_direction_ (item, a_sender__item)
		end

feature {NONE} -- NSDeprecated Externals

	objc_toggle_base_writing_direction_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextView *)$an_item toggleBaseWritingDirection:$a_sender];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSTextView"
		end

end
