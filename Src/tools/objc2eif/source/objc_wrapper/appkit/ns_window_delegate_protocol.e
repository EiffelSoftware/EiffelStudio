note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NS_WINDOW_DELEGATE_PROTOCOL

inherit
	NS_OBJECT_PROTOCOL

feature -- Optional Methods

	window_should_close_ (a_sender: detachable NS_OBJECT): BOOLEAN
			-- Auto generated Objective-C wrapper.
		require
			has_window_should_close_: has_window_should_close_
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			Result := objc_window_should_close_ (item, a_sender__item)
		end

	window_will_return_field_editor__to_object_ (a_sender: detachable NS_WINDOW; a_client: detachable NS_OBJECT): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		require
			has_window_will_return_field_editor__to_object_: has_window_will_return_field_editor__to_object_
		local
			result_pointer: POINTER
			a_sender__item: POINTER
			a_client__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			if attached a_client as a_client_attached then
				a_client__item := a_client_attached.item
			end
			result_pointer := objc_window_will_return_field_editor__to_object_ (item, a_sender__item, a_client__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like window_will_return_field_editor__to_object_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like window_will_return_field_editor__to_object_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	window_will_resize__to_size_ (a_sender: detachable NS_WINDOW; a_frame_size: NS_SIZE): NS_SIZE
			-- Auto generated Objective-C wrapper.
		require
			has_window_will_resize__to_size_: has_window_will_resize__to_size_
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			create Result.make
			objc_window_will_resize__to_size_ (item, Result.item, a_sender__item, a_frame_size.item)
		end

	window_will_use_standard_frame__default_frame_ (a_window: detachable NS_WINDOW; a_new_frame: NS_RECT): NS_RECT
			-- Auto generated Objective-C wrapper.
		require
			has_window_will_use_standard_frame__default_frame_: has_window_will_use_standard_frame__default_frame_
		local
			a_window__item: POINTER
		do
			if attached a_window as a_window_attached then
				a_window__item := a_window_attached.item
			end
			create Result.make
			objc_window_will_use_standard_frame__default_frame_ (item, Result.item, a_window__item, a_new_frame.item)
		end

	window_should_zoom__to_frame_ (a_window: detachable NS_WINDOW; a_new_frame: NS_RECT): BOOLEAN
			-- Auto generated Objective-C wrapper.
		require
			has_window_should_zoom__to_frame_: has_window_should_zoom__to_frame_
		local
			a_window__item: POINTER
		do
			if attached a_window as a_window_attached then
				a_window__item := a_window_attached.item
			end
			Result := objc_window_should_zoom__to_frame_ (item, a_window__item, a_new_frame.item)
		end

	window_will_return_undo_manager_ (a_window: detachable NS_WINDOW): detachable NS_UNDO_MANAGER
			-- Auto generated Objective-C wrapper.
		require
			has_window_will_return_undo_manager_: has_window_will_return_undo_manager_
		local
			result_pointer: POINTER
			a_window__item: POINTER
		do
			if attached a_window as a_window_attached then
				a_window__item := a_window_attached.item
			end
			result_pointer := objc_window_will_return_undo_manager_ (item, a_window__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like window_will_return_undo_manager_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like window_will_return_undo_manager_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	window__will_position_sheet__using_rect_ (a_window: detachable NS_WINDOW; a_sheet: detachable NS_WINDOW; a_rect: NS_RECT): NS_RECT
			-- Auto generated Objective-C wrapper.
		require
			has_window__will_position_sheet__using_rect_: has_window__will_position_sheet__using_rect_
		local
			a_window__item: POINTER
			a_sheet__item: POINTER
		do
			if attached a_window as a_window_attached then
				a_window__item := a_window_attached.item
			end
			if attached a_sheet as a_sheet_attached then
				a_sheet__item := a_sheet_attached.item
			end
			create Result.make
			objc_window__will_position_sheet__using_rect_ (item, Result.item, a_window__item, a_sheet__item, a_rect.item)
		end

	window__should_pop_up_document_path_menu_ (a_window: detachable NS_WINDOW; a_menu: detachable NS_MENU): BOOLEAN
			-- Auto generated Objective-C wrapper.
		require
			has_window__should_pop_up_document_path_menu_: has_window__should_pop_up_document_path_menu_
		local
			a_window__item: POINTER
			a_menu__item: POINTER
		do
			if attached a_window as a_window_attached then
				a_window__item := a_window_attached.item
			end
			if attached a_menu as a_menu_attached then
				a_menu__item := a_menu_attached.item
			end
			Result := objc_window__should_pop_up_document_path_menu_ (item, a_window__item, a_menu__item)
		end

	window__should_drag_document_with_event__from__with_pasteboard_ (a_window: detachable NS_WINDOW; a_event: detachable NS_EVENT; a_drag_image_location: NS_POINT; a_pasteboard: detachable NS_PASTEBOARD): BOOLEAN
			-- Auto generated Objective-C wrapper.
		require
			has_window__should_drag_document_with_event__from__with_pasteboard_: has_window__should_drag_document_with_event__from__with_pasteboard_
		local
			a_window__item: POINTER
			a_event__item: POINTER
			a_pasteboard__item: POINTER
		do
			if attached a_window as a_window_attached then
				a_window__item := a_window_attached.item
			end
			if attached a_event as a_event_attached then
				a_event__item := a_event_attached.item
			end
			if attached a_pasteboard as a_pasteboard_attached then
				a_pasteboard__item := a_pasteboard_attached.item
			end
			Result := objc_window__should_drag_document_with_event__from__with_pasteboard_ (item, a_window__item, a_event__item, a_drag_image_location.item, a_pasteboard__item)
		end

	window_did_resize_ (a_notification: detachable NS_NOTIFICATION)
			-- Auto generated Objective-C wrapper.
		require
			has_window_did_resize_: has_window_did_resize_
		local
			a_notification__item: POINTER
		do
			if attached a_notification as a_notification_attached then
				a_notification__item := a_notification_attached.item
			end
			objc_window_did_resize_ (item, a_notification__item)
		end

	window_did_expose_ (a_notification: detachable NS_NOTIFICATION)
			-- Auto generated Objective-C wrapper.
		require
			has_window_did_expose_: has_window_did_expose_
		local
			a_notification__item: POINTER
		do
			if attached a_notification as a_notification_attached then
				a_notification__item := a_notification_attached.item
			end
			objc_window_did_expose_ (item, a_notification__item)
		end

	window_will_move_ (a_notification: detachable NS_NOTIFICATION)
			-- Auto generated Objective-C wrapper.
		require
			has_window_will_move_: has_window_will_move_
		local
			a_notification__item: POINTER
		do
			if attached a_notification as a_notification_attached then
				a_notification__item := a_notification_attached.item
			end
			objc_window_will_move_ (item, a_notification__item)
		end

	window_did_move_ (a_notification: detachable NS_NOTIFICATION)
			-- Auto generated Objective-C wrapper.
		require
			has_window_did_move_: has_window_did_move_
		local
			a_notification__item: POINTER
		do
			if attached a_notification as a_notification_attached then
				a_notification__item := a_notification_attached.item
			end
			objc_window_did_move_ (item, a_notification__item)
		end

	window_did_become_key_ (a_notification: detachable NS_NOTIFICATION)
			-- Auto generated Objective-C wrapper.
		require
			has_window_did_become_key_: has_window_did_become_key_
		local
			a_notification__item: POINTER
		do
			if attached a_notification as a_notification_attached then
				a_notification__item := a_notification_attached.item
			end
			objc_window_did_become_key_ (item, a_notification__item)
		end

	window_did_resign_key_ (a_notification: detachable NS_NOTIFICATION)
			-- Auto generated Objective-C wrapper.
		require
			has_window_did_resign_key_: has_window_did_resign_key_
		local
			a_notification__item: POINTER
		do
			if attached a_notification as a_notification_attached then
				a_notification__item := a_notification_attached.item
			end
			objc_window_did_resign_key_ (item, a_notification__item)
		end

	window_did_become_main_ (a_notification: detachable NS_NOTIFICATION)
			-- Auto generated Objective-C wrapper.
		require
			has_window_did_become_main_: has_window_did_become_main_
		local
			a_notification__item: POINTER
		do
			if attached a_notification as a_notification_attached then
				a_notification__item := a_notification_attached.item
			end
			objc_window_did_become_main_ (item, a_notification__item)
		end

	window_did_resign_main_ (a_notification: detachable NS_NOTIFICATION)
			-- Auto generated Objective-C wrapper.
		require
			has_window_did_resign_main_: has_window_did_resign_main_
		local
			a_notification__item: POINTER
		do
			if attached a_notification as a_notification_attached then
				a_notification__item := a_notification_attached.item
			end
			objc_window_did_resign_main_ (item, a_notification__item)
		end

	window_will_close_ (a_notification: detachable NS_NOTIFICATION)
			-- Auto generated Objective-C wrapper.
		require
			has_window_will_close_: has_window_will_close_
		local
			a_notification__item: POINTER
		do
			if attached a_notification as a_notification_attached then
				a_notification__item := a_notification_attached.item
			end
			objc_window_will_close_ (item, a_notification__item)
		end

	window_will_miniaturize_ (a_notification: detachable NS_NOTIFICATION)
			-- Auto generated Objective-C wrapper.
		require
			has_window_will_miniaturize_: has_window_will_miniaturize_
		local
			a_notification__item: POINTER
		do
			if attached a_notification as a_notification_attached then
				a_notification__item := a_notification_attached.item
			end
			objc_window_will_miniaturize_ (item, a_notification__item)
		end

	window_did_miniaturize_ (a_notification: detachable NS_NOTIFICATION)
			-- Auto generated Objective-C wrapper.
		require
			has_window_did_miniaturize_: has_window_did_miniaturize_
		local
			a_notification__item: POINTER
		do
			if attached a_notification as a_notification_attached then
				a_notification__item := a_notification_attached.item
			end
			objc_window_did_miniaturize_ (item, a_notification__item)
		end

	window_did_deminiaturize_ (a_notification: detachable NS_NOTIFICATION)
			-- Auto generated Objective-C wrapper.
		require
			has_window_did_deminiaturize_: has_window_did_deminiaturize_
		local
			a_notification__item: POINTER
		do
			if attached a_notification as a_notification_attached then
				a_notification__item := a_notification_attached.item
			end
			objc_window_did_deminiaturize_ (item, a_notification__item)
		end

	window_did_update_ (a_notification: detachable NS_NOTIFICATION)
			-- Auto generated Objective-C wrapper.
		require
			has_window_did_update_: has_window_did_update_
		local
			a_notification__item: POINTER
		do
			if attached a_notification as a_notification_attached then
				a_notification__item := a_notification_attached.item
			end
			objc_window_did_update_ (item, a_notification__item)
		end

	window_did_change_screen_ (a_notification: detachable NS_NOTIFICATION)
			-- Auto generated Objective-C wrapper.
		require
			has_window_did_change_screen_: has_window_did_change_screen_
		local
			a_notification__item: POINTER
		do
			if attached a_notification as a_notification_attached then
				a_notification__item := a_notification_attached.item
			end
			objc_window_did_change_screen_ (item, a_notification__item)
		end

	window_did_change_screen_profile_ (a_notification: detachable NS_NOTIFICATION)
			-- Auto generated Objective-C wrapper.
		require
			has_window_did_change_screen_profile_: has_window_did_change_screen_profile_
		local
			a_notification__item: POINTER
		do
			if attached a_notification as a_notification_attached then
				a_notification__item := a_notification_attached.item
			end
			objc_window_did_change_screen_profile_ (item, a_notification__item)
		end

	window_will_begin_sheet_ (a_notification: detachable NS_NOTIFICATION)
			-- Auto generated Objective-C wrapper.
		require
			has_window_will_begin_sheet_: has_window_will_begin_sheet_
		local
			a_notification__item: POINTER
		do
			if attached a_notification as a_notification_attached then
				a_notification__item := a_notification_attached.item
			end
			objc_window_will_begin_sheet_ (item, a_notification__item)
		end

	window_did_end_sheet_ (a_notification: detachable NS_NOTIFICATION)
			-- Auto generated Objective-C wrapper.
		require
			has_window_did_end_sheet_: has_window_did_end_sheet_
		local
			a_notification__item: POINTER
		do
			if attached a_notification as a_notification_attached then
				a_notification__item := a_notification_attached.item
			end
			objc_window_did_end_sheet_ (item, a_notification__item)
		end

	window_will_start_live_resize_ (a_notification: detachable NS_NOTIFICATION)
			-- Auto generated Objective-C wrapper.
		require
			has_window_will_start_live_resize_: has_window_will_start_live_resize_
		local
			a_notification__item: POINTER
		do
			if attached a_notification as a_notification_attached then
				a_notification__item := a_notification_attached.item
			end
			objc_window_will_start_live_resize_ (item, a_notification__item)
		end

	window_did_end_live_resize_ (a_notification: detachable NS_NOTIFICATION)
			-- Auto generated Objective-C wrapper.
		require
			has_window_did_end_live_resize_: has_window_did_end_live_resize_
		local
			a_notification__item: POINTER
		do
			if attached a_notification as a_notification_attached then
				a_notification__item := a_notification_attached.item
			end
			objc_window_did_end_live_resize_ (item, a_notification__item)
		end

feature -- Status Report

	has_window_should_close_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_window_should_close_ (item)
		end

	has_window_will_return_field_editor__to_object_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_window_will_return_field_editor__to_object_ (item)
		end

	has_window_will_resize__to_size_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_window_will_resize__to_size_ (item)
		end

	has_window_will_use_standard_frame__default_frame_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_window_will_use_standard_frame__default_frame_ (item)
		end

	has_window_should_zoom__to_frame_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_window_should_zoom__to_frame_ (item)
		end

	has_window_will_return_undo_manager_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_window_will_return_undo_manager_ (item)
		end

	has_window__will_position_sheet__using_rect_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_window__will_position_sheet__using_rect_ (item)
		end

	has_window__should_pop_up_document_path_menu_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_window__should_pop_up_document_path_menu_ (item)
		end

	has_window__should_drag_document_with_event__from__with_pasteboard_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_window__should_drag_document_with_event__from__with_pasteboard_ (item)
		end

	has_window_did_resize_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_window_did_resize_ (item)
		end

	has_window_did_expose_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_window_did_expose_ (item)
		end

	has_window_will_move_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_window_will_move_ (item)
		end

	has_window_did_move_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_window_did_move_ (item)
		end

	has_window_did_become_key_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_window_did_become_key_ (item)
		end

	has_window_did_resign_key_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_window_did_resign_key_ (item)
		end

	has_window_did_become_main_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_window_did_become_main_ (item)
		end

	has_window_did_resign_main_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_window_did_resign_main_ (item)
		end

	has_window_will_close_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_window_will_close_ (item)
		end

	has_window_will_miniaturize_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_window_will_miniaturize_ (item)
		end

	has_window_did_miniaturize_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_window_did_miniaturize_ (item)
		end

	has_window_did_deminiaturize_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_window_did_deminiaturize_ (item)
		end

	has_window_did_update_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_window_did_update_ (item)
		end

	has_window_did_change_screen_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_window_did_change_screen_ (item)
		end

	has_window_did_change_screen_profile_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_window_did_change_screen_profile_ (item)
		end

	has_window_will_begin_sheet_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_window_will_begin_sheet_ (item)
		end

	has_window_did_end_sheet_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_window_did_end_sheet_ (item)
		end

	has_window_will_start_live_resize_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_window_will_start_live_resize_ (item)
		end

	has_window_did_end_live_resize_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_window_did_end_live_resize_ (item)
		end

feature -- Status Report Externals

	objc_has_window_should_close_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(windowShouldClose:)];
			 ]"
		end

	objc_has_window_will_return_field_editor__to_object_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(windowWillReturnFieldEditor:toObject:)];
			 ]"
		end

	objc_has_window_will_resize__to_size_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(windowWillResize:toSize:)];
			 ]"
		end

	objc_has_window_will_use_standard_frame__default_frame_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(windowWillUseStandardFrame:defaultFrame:)];
			 ]"
		end

	objc_has_window_should_zoom__to_frame_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(windowShouldZoom:toFrame:)];
			 ]"
		end

	objc_has_window_will_return_undo_manager_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(windowWillReturnUndoManager:)];
			 ]"
		end

	objc_has_window__will_position_sheet__using_rect_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(window:willPositionSheet:usingRect:)];
			 ]"
		end

	objc_has_window__should_pop_up_document_path_menu_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(window:shouldPopUpDocumentPathMenu:)];
			 ]"
		end

	objc_has_window__should_drag_document_with_event__from__with_pasteboard_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(window:shouldDragDocumentWithEvent:from:withPasteboard:)];
			 ]"
		end

	objc_has_window_did_resize_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(windowDidResize:)];
			 ]"
		end

	objc_has_window_did_expose_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(windowDidExpose:)];
			 ]"
		end

	objc_has_window_will_move_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(windowWillMove:)];
			 ]"
		end

	objc_has_window_did_move_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(windowDidMove:)];
			 ]"
		end

	objc_has_window_did_become_key_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(windowDidBecomeKey:)];
			 ]"
		end

	objc_has_window_did_resign_key_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(windowDidResignKey:)];
			 ]"
		end

	objc_has_window_did_become_main_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(windowDidBecomeMain:)];
			 ]"
		end

	objc_has_window_did_resign_main_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(windowDidResignMain:)];
			 ]"
		end

	objc_has_window_will_close_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(windowWillClose:)];
			 ]"
		end

	objc_has_window_will_miniaturize_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(windowWillMiniaturize:)];
			 ]"
		end

	objc_has_window_did_miniaturize_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(windowDidMiniaturize:)];
			 ]"
		end

	objc_has_window_did_deminiaturize_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(windowDidDeminiaturize:)];
			 ]"
		end

	objc_has_window_did_update_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(windowDidUpdate:)];
			 ]"
		end

	objc_has_window_did_change_screen_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(windowDidChangeScreen:)];
			 ]"
		end

	objc_has_window_did_change_screen_profile_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(windowDidChangeScreenProfile:)];
			 ]"
		end

	objc_has_window_will_begin_sheet_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(windowWillBeginSheet:)];
			 ]"
		end

	objc_has_window_did_end_sheet_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(windowDidEndSheet:)];
			 ]"
		end

	objc_has_window_will_start_live_resize_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(windowWillStartLiveResize:)];
			 ]"
		end

	objc_has_window_did_end_live_resize_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(windowDidEndLiveResize:)];
			 ]"
		end

feature {NONE} -- Optional Methods Externals

	objc_window_should_close_ (an_item: POINTER; a_sender: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSWindowDelegate>)$an_item windowShouldClose:$a_sender];
			 ]"
		end

	objc_window_will_return_field_editor__to_object_ (an_item: POINTER; a_sender: POINTER; a_client: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSWindowDelegate>)$an_item windowWillReturnFieldEditor:$a_sender toObject:$a_client];
			 ]"
		end

	objc_window_will_resize__to_size_ (an_item: POINTER; result_pointer: POINTER; a_sender: POINTER; a_frame_size: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSSize *)$result_pointer = [(id <NSWindowDelegate>)$an_item windowWillResize:$a_sender toSize:*((NSSize *)$a_frame_size)];
			 ]"
		end

	objc_window_will_use_standard_frame__default_frame_ (an_item: POINTER; result_pointer: POINTER; a_window: POINTER; a_new_frame: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRect *)$result_pointer = [(id <NSWindowDelegate>)$an_item windowWillUseStandardFrame:$a_window defaultFrame:*((NSRect *)$a_new_frame)];
			 ]"
		end

	objc_window_should_zoom__to_frame_ (an_item: POINTER; a_window: POINTER; a_new_frame: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSWindowDelegate>)$an_item windowShouldZoom:$a_window toFrame:*((NSRect *)$a_new_frame)];
			 ]"
		end

	objc_window_will_return_undo_manager_ (an_item: POINTER; a_window: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSWindowDelegate>)$an_item windowWillReturnUndoManager:$a_window];
			 ]"
		end

	objc_window__will_position_sheet__using_rect_ (an_item: POINTER; result_pointer: POINTER; a_window: POINTER; a_sheet: POINTER; a_rect: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRect *)$result_pointer = [(id <NSWindowDelegate>)$an_item window:$a_window willPositionSheet:$a_sheet usingRect:*((NSRect *)$a_rect)];
			 ]"
		end

	objc_window__should_pop_up_document_path_menu_ (an_item: POINTER; a_window: POINTER; a_menu: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSWindowDelegate>)$an_item window:$a_window shouldPopUpDocumentPathMenu:$a_menu];
			 ]"
		end

	objc_window__should_drag_document_with_event__from__with_pasteboard_ (an_item: POINTER; a_window: POINTER; a_event: POINTER; a_drag_image_location: POINTER; a_pasteboard: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSWindowDelegate>)$an_item window:$a_window shouldDragDocumentWithEvent:$a_event from:*((NSPoint *)$a_drag_image_location) withPasteboard:$a_pasteboard];
			 ]"
		end

	objc_window_did_resize_ (an_item: POINTER; a_notification: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSWindowDelegate>)$an_item windowDidResize:$a_notification];
			 ]"
		end

	objc_window_did_expose_ (an_item: POINTER; a_notification: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSWindowDelegate>)$an_item windowDidExpose:$a_notification];
			 ]"
		end

	objc_window_will_move_ (an_item: POINTER; a_notification: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSWindowDelegate>)$an_item windowWillMove:$a_notification];
			 ]"
		end

	objc_window_did_move_ (an_item: POINTER; a_notification: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSWindowDelegate>)$an_item windowDidMove:$a_notification];
			 ]"
		end

	objc_window_did_become_key_ (an_item: POINTER; a_notification: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSWindowDelegate>)$an_item windowDidBecomeKey:$a_notification];
			 ]"
		end

	objc_window_did_resign_key_ (an_item: POINTER; a_notification: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSWindowDelegate>)$an_item windowDidResignKey:$a_notification];
			 ]"
		end

	objc_window_did_become_main_ (an_item: POINTER; a_notification: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSWindowDelegate>)$an_item windowDidBecomeMain:$a_notification];
			 ]"
		end

	objc_window_did_resign_main_ (an_item: POINTER; a_notification: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSWindowDelegate>)$an_item windowDidResignMain:$a_notification];
			 ]"
		end

	objc_window_will_close_ (an_item: POINTER; a_notification: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSWindowDelegate>)$an_item windowWillClose:$a_notification];
			 ]"
		end

	objc_window_will_miniaturize_ (an_item: POINTER; a_notification: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSWindowDelegate>)$an_item windowWillMiniaturize:$a_notification];
			 ]"
		end

	objc_window_did_miniaturize_ (an_item: POINTER; a_notification: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSWindowDelegate>)$an_item windowDidMiniaturize:$a_notification];
			 ]"
		end

	objc_window_did_deminiaturize_ (an_item: POINTER; a_notification: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSWindowDelegate>)$an_item windowDidDeminiaturize:$a_notification];
			 ]"
		end

	objc_window_did_update_ (an_item: POINTER; a_notification: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSWindowDelegate>)$an_item windowDidUpdate:$a_notification];
			 ]"
		end

	objc_window_did_change_screen_ (an_item: POINTER; a_notification: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSWindowDelegate>)$an_item windowDidChangeScreen:$a_notification];
			 ]"
		end

	objc_window_did_change_screen_profile_ (an_item: POINTER; a_notification: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSWindowDelegate>)$an_item windowDidChangeScreenProfile:$a_notification];
			 ]"
		end

	objc_window_will_begin_sheet_ (an_item: POINTER; a_notification: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSWindowDelegate>)$an_item windowWillBeginSheet:$a_notification];
			 ]"
		end

	objc_window_did_end_sheet_ (an_item: POINTER; a_notification: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSWindowDelegate>)$an_item windowDidEndSheet:$a_notification];
			 ]"
		end

	objc_window_will_start_live_resize_ (an_item: POINTER; a_notification: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSWindowDelegate>)$an_item windowWillStartLiveResize:$a_notification];
			 ]"
		end

	objc_window_did_end_live_resize_ (an_item: POINTER; a_notification: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSWindowDelegate>)$an_item windowDidEndLiveResize:$a_notification];
			 ]"
		end

end
