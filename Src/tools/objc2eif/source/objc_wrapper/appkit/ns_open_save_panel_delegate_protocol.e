note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NS_OPEN_SAVE_PANEL_DELEGATE_PROTOCOL

inherit
	NS_OBJECT_PROTOCOL

feature -- Optional Methods

	panel__should_enable_ur_l_ (a_sender: detachable NS_OBJECT; a_url: detachable NS_URL): BOOLEAN
			-- Auto generated Objective-C wrapper.
		require
			has_panel__should_enable_ur_l_: has_panel__should_enable_ur_l_
		local
			a_sender__item: POINTER
			a_url__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			if attached a_url as a_url_attached then
				a_url__item := a_url_attached.item
			end
			Result := objc_panel__should_enable_ur_l_ (item, a_sender__item, a_url__item)
		end

--	panel__validate_ur_l__error_ (a_sender: detachable NS_OBJECT; a_url: detachable NS_URL; a_out_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		require
--			has_panel__validate_ur_l__error_: has_panel__validate_ur_l__error_
--		local
--			a_sender__item: POINTER
--			a_url__item: POINTER
--			a_out_error__item: POINTER
--		do
--			if attached a_sender as a_sender_attached then
--				a_sender__item := a_sender_attached.item
--			end
--			if attached a_url as a_url_attached then
--				a_url__item := a_url_attached.item
--			end
--			if attached a_out_error as a_out_error_attached then
--				a_out_error__item := a_out_error_attached.item
--			end
--			Result := objc_panel__validate_ur_l__error_ (item, a_sender__item, a_url__item, a_out_error__item)
--		end

	panel__did_change_to_directory_ur_l_ (a_sender: detachable NS_OBJECT; a_url: detachable NS_URL)
			-- Auto generated Objective-C wrapper.
		require
			has_panel__did_change_to_directory_ur_l_: has_panel__did_change_to_directory_ur_l_
		local
			a_sender__item: POINTER
			a_url__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			if attached a_url as a_url_attached then
				a_url__item := a_url_attached.item
			end
			objc_panel__did_change_to_directory_ur_l_ (item, a_sender__item, a_url__item)
		end

	panel__user_entered_filename__confirmed_ (a_sender: detachable NS_OBJECT; a_filename: detachable NS_STRING; a_ok_flag: BOOLEAN): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		require
			has_panel__user_entered_filename__confirmed_: has_panel__user_entered_filename__confirmed_
		local
			result_pointer: POINTER
			a_sender__item: POINTER
			a_filename__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			if attached a_filename as a_filename_attached then
				a_filename__item := a_filename_attached.item
			end
			result_pointer := objc_panel__user_entered_filename__confirmed_ (item, a_sender__item, a_filename__item, a_ok_flag)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like panel__user_entered_filename__confirmed_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like panel__user_entered_filename__confirmed_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	panel__will_expand_ (a_sender: detachable NS_OBJECT; a_expanding: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		require
			has_panel__will_expand_: has_panel__will_expand_
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_panel__will_expand_ (item, a_sender__item, a_expanding)
		end

	panel_selection_did_change_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		require
			has_panel_selection_did_change_: has_panel_selection_did_change_
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_panel_selection_did_change_ (item, a_sender__item)
		end

feature -- Status Report

	has_panel__should_enable_ur_l_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_panel__should_enable_ur_l_ (item)
		end

--	has_panel__validate_ur_l__error_: BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		do
--			Result := objc_has_panel__validate_ur_l__error_ (item)
--		end

	has_panel__did_change_to_directory_ur_l_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_panel__did_change_to_directory_ur_l_ (item)
		end

	has_panel__user_entered_filename__confirmed_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_panel__user_entered_filename__confirmed_ (item)
		end

	has_panel__will_expand_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_panel__will_expand_ (item)
		end

	has_panel_selection_did_change_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_panel_selection_did_change_ (item)
		end

feature -- Status Report Externals

	objc_has_panel__should_enable_ur_l_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(panel:shouldEnableURL:)];
			 ]"
		end

--	objc_has_panel__validate_ur_l__error_ (an_item: POINTER): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return [(id)$an_item respondsToSelector:@selector(panel:validateURL:error:)];
--			 ]"
--		end

	objc_has_panel__did_change_to_directory_ur_l_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(panel:didChangeToDirectoryURL:)];
			 ]"
		end

	objc_has_panel__user_entered_filename__confirmed_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(panel:userEnteredFilename:confirmed:)];
			 ]"
		end

	objc_has_panel__will_expand_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(panel:willExpand:)];
			 ]"
		end

	objc_has_panel_selection_did_change_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(panelSelectionDidChange:)];
			 ]"
		end

feature {NONE} -- Optional Methods Externals

	objc_panel__should_enable_ur_l_ (an_item: POINTER; a_sender: POINTER; a_url: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSOpenSavePanelDelegate>)$an_item panel:$a_sender shouldEnableURL:$a_url];
			 ]"
		end

--	objc_panel__validate_ur_l__error_ (an_item: POINTER; a_sender: POINTER; a_url: POINTER; a_out_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return [(id <NSOpenSavePanelDelegate>)$an_item panel:$a_sender validateURL:$a_url error:];
--			 ]"
--		end

	objc_panel__did_change_to_directory_ur_l_ (an_item: POINTER; a_sender: POINTER; a_url: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSOpenSavePanelDelegate>)$an_item panel:$a_sender didChangeToDirectoryURL:$a_url];
			 ]"
		end

	objc_panel__user_entered_filename__confirmed_ (an_item: POINTER; a_sender: POINTER; a_filename: POINTER; a_ok_flag: BOOLEAN): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSOpenSavePanelDelegate>)$an_item panel:$a_sender userEnteredFilename:$a_filename confirmed:$a_ok_flag];
			 ]"
		end

	objc_panel__will_expand_ (an_item: POINTER; a_sender: POINTER; a_expanding: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSOpenSavePanelDelegate>)$an_item panel:$a_sender willExpand:$a_expanding];
			 ]"
		end

	objc_panel_selection_did_change_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSOpenSavePanelDelegate>)$an_item panelSelectionDidChange:$a_sender];
			 ]"
		end

end
