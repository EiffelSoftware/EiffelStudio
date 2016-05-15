note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NS_COMBO_BOX_DELEGATE_PROTOCOL

inherit
	NS_TEXT_FIELD_DELEGATE_PROTOCOL

feature -- Optional Methods

	combo_box_will_pop_up_ (a_notification: detachable NS_NOTIFICATION)
			-- Auto generated Objective-C wrapper.
		require
			has_combo_box_will_pop_up_: has_combo_box_will_pop_up_
		local
			a_notification__item: POINTER
		do
			if attached a_notification as a_notification_attached then
				a_notification__item := a_notification_attached.item
			end
			objc_combo_box_will_pop_up_ (item, a_notification__item)
		end

	combo_box_will_dismiss_ (a_notification: detachable NS_NOTIFICATION)
			-- Auto generated Objective-C wrapper.
		require
			has_combo_box_will_dismiss_: has_combo_box_will_dismiss_
		local
			a_notification__item: POINTER
		do
			if attached a_notification as a_notification_attached then
				a_notification__item := a_notification_attached.item
			end
			objc_combo_box_will_dismiss_ (item, a_notification__item)
		end

	combo_box_selection_did_change_ (a_notification: detachable NS_NOTIFICATION)
			-- Auto generated Objective-C wrapper.
		require
			has_combo_box_selection_did_change_: has_combo_box_selection_did_change_
		local
			a_notification__item: POINTER
		do
			if attached a_notification as a_notification_attached then
				a_notification__item := a_notification_attached.item
			end
			objc_combo_box_selection_did_change_ (item, a_notification__item)
		end

	combo_box_selection_is_changing_ (a_notification: detachable NS_NOTIFICATION)
			-- Auto generated Objective-C wrapper.
		require
			has_combo_box_selection_is_changing_: has_combo_box_selection_is_changing_
		local
			a_notification__item: POINTER
		do
			if attached a_notification as a_notification_attached then
				a_notification__item := a_notification_attached.item
			end
			objc_combo_box_selection_is_changing_ (item, a_notification__item)
		end

feature -- Status Report

	has_combo_box_will_pop_up_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_combo_box_will_pop_up_ (item)
		end

	has_combo_box_will_dismiss_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_combo_box_will_dismiss_ (item)
		end

	has_combo_box_selection_did_change_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_combo_box_selection_did_change_ (item)
		end

	has_combo_box_selection_is_changing_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_combo_box_selection_is_changing_ (item)
		end

feature -- Status Report Externals

	objc_has_combo_box_will_pop_up_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(comboBoxWillPopUp:)];
			 ]"
		end

	objc_has_combo_box_will_dismiss_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(comboBoxWillDismiss:)];
			 ]"
		end

	objc_has_combo_box_selection_did_change_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(comboBoxSelectionDidChange:)];
			 ]"
		end

	objc_has_combo_box_selection_is_changing_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(comboBoxSelectionIsChanging:)];
			 ]"
		end

feature {NONE} -- Optional Methods Externals

	objc_combo_box_will_pop_up_ (an_item: POINTER; a_notification: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSComboBoxDelegate>)$an_item comboBoxWillPopUp:$a_notification];
			 ]"
		end

	objc_combo_box_will_dismiss_ (an_item: POINTER; a_notification: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSComboBoxDelegate>)$an_item comboBoxWillDismiss:$a_notification];
			 ]"
		end

	objc_combo_box_selection_did_change_ (an_item: POINTER; a_notification: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSComboBoxDelegate>)$an_item comboBoxSelectionDidChange:$a_notification];
			 ]"
		end

	objc_combo_box_selection_is_changing_ (an_item: POINTER; a_notification: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSComboBoxDelegate>)$an_item comboBoxSelectionIsChanging:$a_notification];
			 ]"
		end

end
