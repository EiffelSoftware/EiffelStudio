note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NS_APPLICATION_DELEGATE_PROTOCOL

inherit
	NS_OBJECT_PROTOCOL

feature -- Optional Methods

	application_should_terminate_ (a_sender: detachable NS_APPLICATION): NATURAL_64
			-- Auto generated Objective-C wrapper.
		require
			has_application_should_terminate_: has_application_should_terminate_
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			Result := objc_application_should_terminate_ (item, a_sender__item)
		end

	application__open_file_ (a_sender: detachable NS_APPLICATION; a_filename: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		require
			has_application__open_file_: has_application__open_file_
		local
			a_sender__item: POINTER
			a_filename__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			if attached a_filename as a_filename_attached then
				a_filename__item := a_filename_attached.item
			end
			Result := objc_application__open_file_ (item, a_sender__item, a_filename__item)
		end

	application__open_files_ (a_sender: detachable NS_APPLICATION; a_filenames: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		require
			has_application__open_files_: has_application__open_files_
		local
			a_sender__item: POINTER
			a_filenames__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			if attached a_filenames as a_filenames_attached then
				a_filenames__item := a_filenames_attached.item
			end
			objc_application__open_files_ (item, a_sender__item, a_filenames__item)
		end

	application__open_temp_file_ (a_sender: detachable NS_APPLICATION; a_filename: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		require
			has_application__open_temp_file_: has_application__open_temp_file_
		local
			a_sender__item: POINTER
			a_filename__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			if attached a_filename as a_filename_attached then
				a_filename__item := a_filename_attached.item
			end
			Result := objc_application__open_temp_file_ (item, a_sender__item, a_filename__item)
		end

	application_should_open_untitled_file_ (a_sender: detachable NS_APPLICATION): BOOLEAN
			-- Auto generated Objective-C wrapper.
		require
			has_application_should_open_untitled_file_: has_application_should_open_untitled_file_
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			Result := objc_application_should_open_untitled_file_ (item, a_sender__item)
		end

	application_open_untitled_file_ (a_sender: detachable NS_APPLICATION): BOOLEAN
			-- Auto generated Objective-C wrapper.
		require
			has_application_open_untitled_file_: has_application_open_untitled_file_
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			Result := objc_application_open_untitled_file_ (item, a_sender__item)
		end

	application__open_file_without_u_i_ (a_sender: detachable NS_OBJECT; a_filename: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		require
			has_application__open_file_without_u_i_: has_application__open_file_without_u_i_
		local
			a_sender__item: POINTER
			a_filename__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			if attached a_filename as a_filename_attached then
				a_filename__item := a_filename_attached.item
			end
			Result := objc_application__open_file_without_u_i_ (item, a_sender__item, a_filename__item)
		end

	application__print_file_ (a_sender: detachable NS_APPLICATION; a_filename: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		require
			has_application__print_file_: has_application__print_file_
		local
			a_sender__item: POINTER
			a_filename__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			if attached a_filename as a_filename_attached then
				a_filename__item := a_filename_attached.item
			end
			Result := objc_application__print_file_ (item, a_sender__item, a_filename__item)
		end

	application__print_files__with_settings__show_print_panels_ (a_application: detachable NS_APPLICATION; a_file_names: detachable NS_ARRAY; a_print_settings: detachable NS_DICTIONARY; a_show_print_panels: BOOLEAN): NATURAL_64
			-- Auto generated Objective-C wrapper.
		require
			has_application__print_files__with_settings__show_print_panels_: has_application__print_files__with_settings__show_print_panels_
		local
			a_application__item: POINTER
			a_file_names__item: POINTER
			a_print_settings__item: POINTER
		do
			if attached a_application as a_application_attached then
				a_application__item := a_application_attached.item
			end
			if attached a_file_names as a_file_names_attached then
				a_file_names__item := a_file_names_attached.item
			end
			if attached a_print_settings as a_print_settings_attached then
				a_print_settings__item := a_print_settings_attached.item
			end
			Result := objc_application__print_files__with_settings__show_print_panels_ (item, a_application__item, a_file_names__item, a_print_settings__item, a_show_print_panels)
		end

	application_should_terminate_after_last_window_closed_ (a_sender: detachable NS_APPLICATION): BOOLEAN
			-- Auto generated Objective-C wrapper.
		require
			has_application_should_terminate_after_last_window_closed_: has_application_should_terminate_after_last_window_closed_
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			Result := objc_application_should_terminate_after_last_window_closed_ (item, a_sender__item)
		end

	application_should_handle_reopen__has_visible_windows_ (a_sender: detachable NS_APPLICATION; a_flag: BOOLEAN): BOOLEAN
			-- Auto generated Objective-C wrapper.
		require
			has_application_should_handle_reopen__has_visible_windows_: has_application_should_handle_reopen__has_visible_windows_
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			Result := objc_application_should_handle_reopen__has_visible_windows_ (item, a_sender__item, a_flag)
		end

	application_dock_menu_ (a_sender: detachable NS_APPLICATION): detachable NS_MENU
			-- Auto generated Objective-C wrapper.
		require
			has_application_dock_menu_: has_application_dock_menu_
		local
			result_pointer: POINTER
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			result_pointer := objc_application_dock_menu_ (item, a_sender__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like application_dock_menu_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like application_dock_menu_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	application__will_present_error_ (a_application: detachable NS_APPLICATION; a_error: detachable NS_ERROR): detachable NS_ERROR
			-- Auto generated Objective-C wrapper.
		require
			has_application__will_present_error_: has_application__will_present_error_
		local
			result_pointer: POINTER
			a_application__item: POINTER
			a_error__item: POINTER
		do
			if attached a_application as a_application_attached then
				a_application__item := a_application_attached.item
			end
			if attached a_error as a_error_attached then
				a_error__item := a_error_attached.item
			end
			result_pointer := objc_application__will_present_error_ (item, a_application__item, a_error__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like application__will_present_error_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like application__will_present_error_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	application_will_finish_launching_ (a_notification: detachable NS_NOTIFICATION)
			-- Auto generated Objective-C wrapper.
		require
			has_application_will_finish_launching_: has_application_will_finish_launching_
		local
			a_notification__item: POINTER
		do
			if attached a_notification as a_notification_attached then
				a_notification__item := a_notification_attached.item
			end
			objc_application_will_finish_launching_ (item, a_notification__item)
		end

	application_did_finish_launching_ (a_notification: detachable NS_NOTIFICATION)
			-- Auto generated Objective-C wrapper.
		require
			has_application_did_finish_launching_: has_application_did_finish_launching_
		local
			a_notification__item: POINTER
		do
			if attached a_notification as a_notification_attached then
				a_notification__item := a_notification_attached.item
			end
			objc_application_did_finish_launching_ (item, a_notification__item)
		end

	application_will_hide_ (a_notification: detachable NS_NOTIFICATION)
			-- Auto generated Objective-C wrapper.
		require
			has_application_will_hide_: has_application_will_hide_
		local
			a_notification__item: POINTER
		do
			if attached a_notification as a_notification_attached then
				a_notification__item := a_notification_attached.item
			end
			objc_application_will_hide_ (item, a_notification__item)
		end

	application_did_hide_ (a_notification: detachable NS_NOTIFICATION)
			-- Auto generated Objective-C wrapper.
		require
			has_application_did_hide_: has_application_did_hide_
		local
			a_notification__item: POINTER
		do
			if attached a_notification as a_notification_attached then
				a_notification__item := a_notification_attached.item
			end
			objc_application_did_hide_ (item, a_notification__item)
		end

	application_will_unhide_ (a_notification: detachable NS_NOTIFICATION)
			-- Auto generated Objective-C wrapper.
		require
			has_application_will_unhide_: has_application_will_unhide_
		local
			a_notification__item: POINTER
		do
			if attached a_notification as a_notification_attached then
				a_notification__item := a_notification_attached.item
			end
			objc_application_will_unhide_ (item, a_notification__item)
		end

	application_did_unhide_ (a_notification: detachable NS_NOTIFICATION)
			-- Auto generated Objective-C wrapper.
		require
			has_application_did_unhide_: has_application_did_unhide_
		local
			a_notification__item: POINTER
		do
			if attached a_notification as a_notification_attached then
				a_notification__item := a_notification_attached.item
			end
			objc_application_did_unhide_ (item, a_notification__item)
		end

	application_will_become_active_ (a_notification: detachable NS_NOTIFICATION)
			-- Auto generated Objective-C wrapper.
		require
			has_application_will_become_active_: has_application_will_become_active_
		local
			a_notification__item: POINTER
		do
			if attached a_notification as a_notification_attached then
				a_notification__item := a_notification_attached.item
			end
			objc_application_will_become_active_ (item, a_notification__item)
		end

	application_did_become_active_ (a_notification: detachable NS_NOTIFICATION)
			-- Auto generated Objective-C wrapper.
		require
			has_application_did_become_active_: has_application_did_become_active_
		local
			a_notification__item: POINTER
		do
			if attached a_notification as a_notification_attached then
				a_notification__item := a_notification_attached.item
			end
			objc_application_did_become_active_ (item, a_notification__item)
		end

	application_will_resign_active_ (a_notification: detachable NS_NOTIFICATION)
			-- Auto generated Objective-C wrapper.
		require
			has_application_will_resign_active_: has_application_will_resign_active_
		local
			a_notification__item: POINTER
		do
			if attached a_notification as a_notification_attached then
				a_notification__item := a_notification_attached.item
			end
			objc_application_will_resign_active_ (item, a_notification__item)
		end

	application_did_resign_active_ (a_notification: detachable NS_NOTIFICATION)
			-- Auto generated Objective-C wrapper.
		require
			has_application_did_resign_active_: has_application_did_resign_active_
		local
			a_notification__item: POINTER
		do
			if attached a_notification as a_notification_attached then
				a_notification__item := a_notification_attached.item
			end
			objc_application_did_resign_active_ (item, a_notification__item)
		end

	application_will_update_ (a_notification: detachable NS_NOTIFICATION)
			-- Auto generated Objective-C wrapper.
		require
			has_application_will_update_: has_application_will_update_
		local
			a_notification__item: POINTER
		do
			if attached a_notification as a_notification_attached then
				a_notification__item := a_notification_attached.item
			end
			objc_application_will_update_ (item, a_notification__item)
		end

	application_did_update_ (a_notification: detachable NS_NOTIFICATION)
			-- Auto generated Objective-C wrapper.
		require
			has_application_did_update_: has_application_did_update_
		local
			a_notification__item: POINTER
		do
			if attached a_notification as a_notification_attached then
				a_notification__item := a_notification_attached.item
			end
			objc_application_did_update_ (item, a_notification__item)
		end

	application_will_terminate_ (a_notification: detachable NS_NOTIFICATION)
			-- Auto generated Objective-C wrapper.
		require
			has_application_will_terminate_: has_application_will_terminate_
		local
			a_notification__item: POINTER
		do
			if attached a_notification as a_notification_attached then
				a_notification__item := a_notification_attached.item
			end
			objc_application_will_terminate_ (item, a_notification__item)
		end

	application_did_change_screen_parameters_ (a_notification: detachable NS_NOTIFICATION)
			-- Auto generated Objective-C wrapper.
		require
			has_application_did_change_screen_parameters_: has_application_did_change_screen_parameters_
		local
			a_notification__item: POINTER
		do
			if attached a_notification as a_notification_attached then
				a_notification__item := a_notification_attached.item
			end
			objc_application_did_change_screen_parameters_ (item, a_notification__item)
		end

feature -- Status Report

	has_application_should_terminate_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_application_should_terminate_ (item)
		end

	has_application__open_file_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_application__open_file_ (item)
		end

	has_application__open_files_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_application__open_files_ (item)
		end

	has_application__open_temp_file_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_application__open_temp_file_ (item)
		end

	has_application_should_open_untitled_file_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_application_should_open_untitled_file_ (item)
		end

	has_application_open_untitled_file_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_application_open_untitled_file_ (item)
		end

	has_application__open_file_without_u_i_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_application__open_file_without_u_i_ (item)
		end

	has_application__print_file_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_application__print_file_ (item)
		end

	has_application__print_files__with_settings__show_print_panels_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_application__print_files__with_settings__show_print_panels_ (item)
		end

	has_application_should_terminate_after_last_window_closed_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_application_should_terminate_after_last_window_closed_ (item)
		end

	has_application_should_handle_reopen__has_visible_windows_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_application_should_handle_reopen__has_visible_windows_ (item)
		end

	has_application_dock_menu_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_application_dock_menu_ (item)
		end

	has_application__will_present_error_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_application__will_present_error_ (item)
		end

	has_application_will_finish_launching_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_application_will_finish_launching_ (item)
		end

	has_application_did_finish_launching_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_application_did_finish_launching_ (item)
		end

	has_application_will_hide_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_application_will_hide_ (item)
		end

	has_application_did_hide_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_application_did_hide_ (item)
		end

	has_application_will_unhide_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_application_will_unhide_ (item)
		end

	has_application_did_unhide_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_application_did_unhide_ (item)
		end

	has_application_will_become_active_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_application_will_become_active_ (item)
		end

	has_application_did_become_active_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_application_did_become_active_ (item)
		end

	has_application_will_resign_active_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_application_will_resign_active_ (item)
		end

	has_application_did_resign_active_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_application_did_resign_active_ (item)
		end

	has_application_will_update_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_application_will_update_ (item)
		end

	has_application_did_update_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_application_did_update_ (item)
		end

	has_application_will_terminate_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_application_will_terminate_ (item)
		end

	has_application_did_change_screen_parameters_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_application_did_change_screen_parameters_ (item)
		end

feature -- Status Report Externals

	objc_has_application_should_terminate_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(applicationShouldTerminate:)];
			 ]"
		end

	objc_has_application__open_file_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(application:openFile:)];
			 ]"
		end

	objc_has_application__open_files_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(application:openFiles:)];
			 ]"
		end

	objc_has_application__open_temp_file_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(application:openTempFile:)];
			 ]"
		end

	objc_has_application_should_open_untitled_file_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(applicationShouldOpenUntitledFile:)];
			 ]"
		end

	objc_has_application_open_untitled_file_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(applicationOpenUntitledFile:)];
			 ]"
		end

	objc_has_application__open_file_without_u_i_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(application:openFileWithoutUI:)];
			 ]"
		end

	objc_has_application__print_file_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(application:printFile:)];
			 ]"
		end

	objc_has_application__print_files__with_settings__show_print_panels_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(application:printFiles:withSettings:showPrintPanels:)];
			 ]"
		end

	objc_has_application_should_terminate_after_last_window_closed_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(applicationShouldTerminateAfterLastWindowClosed:)];
			 ]"
		end

	objc_has_application_should_handle_reopen__has_visible_windows_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(applicationShouldHandleReopen:hasVisibleWindows:)];
			 ]"
		end

	objc_has_application_dock_menu_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(applicationDockMenu:)];
			 ]"
		end

	objc_has_application__will_present_error_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(application:willPresentError:)];
			 ]"
		end

	objc_has_application_will_finish_launching_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(applicationWillFinishLaunching:)];
			 ]"
		end

	objc_has_application_did_finish_launching_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(applicationDidFinishLaunching:)];
			 ]"
		end

	objc_has_application_will_hide_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(applicationWillHide:)];
			 ]"
		end

	objc_has_application_did_hide_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(applicationDidHide:)];
			 ]"
		end

	objc_has_application_will_unhide_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(applicationWillUnhide:)];
			 ]"
		end

	objc_has_application_did_unhide_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(applicationDidUnhide:)];
			 ]"
		end

	objc_has_application_will_become_active_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(applicationWillBecomeActive:)];
			 ]"
		end

	objc_has_application_did_become_active_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(applicationDidBecomeActive:)];
			 ]"
		end

	objc_has_application_will_resign_active_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(applicationWillResignActive:)];
			 ]"
		end

	objc_has_application_did_resign_active_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(applicationDidResignActive:)];
			 ]"
		end

	objc_has_application_will_update_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(applicationWillUpdate:)];
			 ]"
		end

	objc_has_application_did_update_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(applicationDidUpdate:)];
			 ]"
		end

	objc_has_application_will_terminate_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(applicationWillTerminate:)];
			 ]"
		end

	objc_has_application_did_change_screen_parameters_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(applicationDidChangeScreenParameters:)];
			 ]"
		end

feature {NONE} -- Optional Methods Externals

	objc_application_should_terminate_ (an_item: POINTER; a_sender: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSApplicationDelegate>)$an_item applicationShouldTerminate:$a_sender];
			 ]"
		end

	objc_application__open_file_ (an_item: POINTER; a_sender: POINTER; a_filename: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSApplicationDelegate>)$an_item application:$a_sender openFile:$a_filename];
			 ]"
		end

	objc_application__open_files_ (an_item: POINTER; a_sender: POINTER; a_filenames: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSApplicationDelegate>)$an_item application:$a_sender openFiles:$a_filenames];
			 ]"
		end

	objc_application__open_temp_file_ (an_item: POINTER; a_sender: POINTER; a_filename: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSApplicationDelegate>)$an_item application:$a_sender openTempFile:$a_filename];
			 ]"
		end

	objc_application_should_open_untitled_file_ (an_item: POINTER; a_sender: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSApplicationDelegate>)$an_item applicationShouldOpenUntitledFile:$a_sender];
			 ]"
		end

	objc_application_open_untitled_file_ (an_item: POINTER; a_sender: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSApplicationDelegate>)$an_item applicationOpenUntitledFile:$a_sender];
			 ]"
		end

	objc_application__open_file_without_u_i_ (an_item: POINTER; a_sender: POINTER; a_filename: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSApplicationDelegate>)$an_item application:$a_sender openFileWithoutUI:$a_filename];
			 ]"
		end

	objc_application__print_file_ (an_item: POINTER; a_sender: POINTER; a_filename: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSApplicationDelegate>)$an_item application:$a_sender printFile:$a_filename];
			 ]"
		end

	objc_application__print_files__with_settings__show_print_panels_ (an_item: POINTER; a_application: POINTER; a_file_names: POINTER; a_print_settings: POINTER; a_show_print_panels: BOOLEAN): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSApplicationDelegate>)$an_item application:$a_application printFiles:$a_file_names withSettings:$a_print_settings showPrintPanels:$a_show_print_panels];
			 ]"
		end

	objc_application_should_terminate_after_last_window_closed_ (an_item: POINTER; a_sender: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSApplicationDelegate>)$an_item applicationShouldTerminateAfterLastWindowClosed:$a_sender];
			 ]"
		end

	objc_application_should_handle_reopen__has_visible_windows_ (an_item: POINTER; a_sender: POINTER; a_flag: BOOLEAN): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSApplicationDelegate>)$an_item applicationShouldHandleReopen:$a_sender hasVisibleWindows:$a_flag];
			 ]"
		end

	objc_application_dock_menu_ (an_item: POINTER; a_sender: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSApplicationDelegate>)$an_item applicationDockMenu:$a_sender];
			 ]"
		end

	objc_application__will_present_error_ (an_item: POINTER; a_application: POINTER; a_error: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSApplicationDelegate>)$an_item application:$a_application willPresentError:$a_error];
			 ]"
		end

	objc_application_will_finish_launching_ (an_item: POINTER; a_notification: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSApplicationDelegate>)$an_item applicationWillFinishLaunching:$a_notification];
			 ]"
		end

	objc_application_did_finish_launching_ (an_item: POINTER; a_notification: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSApplicationDelegate>)$an_item applicationDidFinishLaunching:$a_notification];
			 ]"
		end

	objc_application_will_hide_ (an_item: POINTER; a_notification: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSApplicationDelegate>)$an_item applicationWillHide:$a_notification];
			 ]"
		end

	objc_application_did_hide_ (an_item: POINTER; a_notification: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSApplicationDelegate>)$an_item applicationDidHide:$a_notification];
			 ]"
		end

	objc_application_will_unhide_ (an_item: POINTER; a_notification: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSApplicationDelegate>)$an_item applicationWillUnhide:$a_notification];
			 ]"
		end

	objc_application_did_unhide_ (an_item: POINTER; a_notification: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSApplicationDelegate>)$an_item applicationDidUnhide:$a_notification];
			 ]"
		end

	objc_application_will_become_active_ (an_item: POINTER; a_notification: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSApplicationDelegate>)$an_item applicationWillBecomeActive:$a_notification];
			 ]"
		end

	objc_application_did_become_active_ (an_item: POINTER; a_notification: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSApplicationDelegate>)$an_item applicationDidBecomeActive:$a_notification];
			 ]"
		end

	objc_application_will_resign_active_ (an_item: POINTER; a_notification: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSApplicationDelegate>)$an_item applicationWillResignActive:$a_notification];
			 ]"
		end

	objc_application_did_resign_active_ (an_item: POINTER; a_notification: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSApplicationDelegate>)$an_item applicationDidResignActive:$a_notification];
			 ]"
		end

	objc_application_will_update_ (an_item: POINTER; a_notification: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSApplicationDelegate>)$an_item applicationWillUpdate:$a_notification];
			 ]"
		end

	objc_application_did_update_ (an_item: POINTER; a_notification: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSApplicationDelegate>)$an_item applicationDidUpdate:$a_notification];
			 ]"
		end

	objc_application_will_terminate_ (an_item: POINTER; a_notification: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSApplicationDelegate>)$an_item applicationWillTerminate:$a_notification];
			 ]"
		end

	objc_application_did_change_screen_parameters_ (an_item: POINTER; a_notification: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSApplicationDelegate>)$an_item applicationDidChangeScreenParameters:$a_notification];
			 ]"
		end

end
