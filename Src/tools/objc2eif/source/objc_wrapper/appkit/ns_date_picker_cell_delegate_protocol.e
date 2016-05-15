note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NS_DATE_PICKER_CELL_DELEGATE_PROTOCOL

inherit
	NS_OBJECT_PROTOCOL

feature -- Optional Methods

--	date_picker_cell__validate_proposed_date_value__time_interval_ (a_date_picker_cell: detachable NS_DATE_PICKER_CELL; a_proposed_date_value: UNSUPPORTED_TYPE; a_proposed_time_interval: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		require
--			has_date_picker_cell__validate_proposed_date_value__time_interval_: has_date_picker_cell__validate_proposed_date_value__time_interval_
--		local
--			a_date_picker_cell__item: POINTER
--			a_proposed_date_value__item: POINTER
--			a_proposed_time_interval__item: POINTER
--		do
--			if attached a_date_picker_cell as a_date_picker_cell_attached then
--				a_date_picker_cell__item := a_date_picker_cell_attached.item
--			end
--			if attached a_proposed_date_value as a_proposed_date_value_attached then
--				a_proposed_date_value__item := a_proposed_date_value_attached.item
--			end
--			if attached a_proposed_time_interval as a_proposed_time_interval_attached then
--				a_proposed_time_interval__item := a_proposed_time_interval_attached.item
--			end
--			objc_date_picker_cell__validate_proposed_date_value__time_interval_ (item, a_date_picker_cell__item, a_proposed_date_value__item, a_proposed_time_interval__item)
--		end

feature -- Status Report

--	has_date_picker_cell__validate_proposed_date_value__time_interval_: BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		do
--			Result := objc_has_date_picker_cell__validate_proposed_date_value__time_interval_ (item)
--		end

feature -- Status Report Externals

--	objc_has_date_picker_cell__validate_proposed_date_value__time_interval_ (an_item: POINTER): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return [(id)$an_item respondsToSelector:@selector(datePickerCell:validateProposedDateValue:timeInterval:)];
--			 ]"
--		end

feature {NONE} -- Optional Methods Externals

--	objc_date_picker_cell__validate_proposed_date_value__time_interval_ (an_item: POINTER; a_date_picker_cell: POINTER; a_proposed_date_value: UNSUPPORTED_TYPE; a_proposed_time_interval: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				[(id <NSDatePickerCellDelegate>)$an_item datePickerCell:$a_date_picker_cell validateProposedDateValue: timeInterval:];
--			 ]"
--		end

end
