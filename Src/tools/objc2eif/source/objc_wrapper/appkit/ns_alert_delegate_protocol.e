note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NS_ALERT_DELEGATE_PROTOCOL

inherit
	NS_OBJECT_PROTOCOL

feature -- Optional Methods

	alert_show_help_ (a_alert: detachable NS_ALERT): BOOLEAN
			-- Auto generated Objective-C wrapper.
		require
			has_alert_show_help_: has_alert_show_help_
		local
			a_alert__item: POINTER
		do
			if attached a_alert as a_alert_attached then
				a_alert__item := a_alert_attached.item
			end
			Result := objc_alert_show_help_ (item, a_alert__item)
		end

feature -- Status Report

	has_alert_show_help_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_alert_show_help_ (item)
		end

feature -- Status Report Externals

	objc_has_alert_show_help_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(alertShowHelp:)];
			 ]"
		end

feature {NONE} -- Optional Methods Externals

	objc_alert_show_help_ (an_item: POINTER; a_alert: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSAlertDelegate>)$an_item alertShowHelp:$a_alert];
			 ]"
		end

end
