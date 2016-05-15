note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_PRINT_PANEL

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make

feature -- NSPrintPanel

--	add_accessory_controller_ (a_accessory_controller: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_accessory_controller__item: POINTER
--		do
--			if attached a_accessory_controller as a_accessory_controller_attached then
--				a_accessory_controller__item := a_accessory_controller_attached.item
--			end
--			objc_add_accessory_controller_ (item, a_accessory_controller__item)
--		end

--	remove_accessory_controller_ (a_accessory_controller: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_accessory_controller__item: POINTER
--		do
--			if attached a_accessory_controller as a_accessory_controller_attached then
--				a_accessory_controller__item := a_accessory_controller_attached.item
--			end
--			objc_remove_accessory_controller_ (item, a_accessory_controller__item)
--		end

	accessory_controllers: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_accessory_controllers (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like accessory_controllers} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like accessory_controllers} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_options_ (a_options: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_options_ (item, a_options)
		end

	options: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_options (item)
		end

	set_default_button_title_ (a_default_button_title: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_default_button_title__item: POINTER
		do
			if attached a_default_button_title as a_default_button_title_attached then
				a_default_button_title__item := a_default_button_title_attached.item
			end
			objc_set_default_button_title_ (item, a_default_button_title__item)
		end

	default_button_title: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_default_button_title (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like default_button_title} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like default_button_title} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_help_anchor_ (a_help_anchor: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_help_anchor__item: POINTER
		do
			if attached a_help_anchor as a_help_anchor_attached then
				a_help_anchor__item := a_help_anchor_attached.item
			end
			objc_set_help_anchor_ (item, a_help_anchor__item)
		end

	help_anchor: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_help_anchor (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like help_anchor} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like help_anchor} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_job_style_hint_ (a_hint: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_hint__item: POINTER
		do
			if attached a_hint as a_hint_attached then
				a_hint__item := a_hint_attached.item
			end
			objc_set_job_style_hint_ (item, a_hint__item)
		end

	job_style_hint: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_job_style_hint (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like job_style_hint} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like job_style_hint} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

--	begin_sheet_with_print_info__modal_for_window__delegate__did_end_selector__context_info_ (a_print_info: detachable NS_PRINT_INFO; a_doc_window: detachable NS_WINDOW; a_delegate: detachable NS_OBJECT; a_did_end_selector: detachable OBJC_SELECTOR; a_context_info: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_print_info__item: POINTER
--			a_doc_window__item: POINTER
--			a_delegate__item: POINTER
--			a_did_end_selector__item: POINTER
--			a_context_info__item: POINTER
--		do
--			if attached a_print_info as a_print_info_attached then
--				a_print_info__item := a_print_info_attached.item
--			end
--			if attached a_doc_window as a_doc_window_attached then
--				a_doc_window__item := a_doc_window_attached.item
--			end
--			if attached a_delegate as a_delegate_attached then
--				a_delegate__item := a_delegate_attached.item
--			end
--			if attached a_did_end_selector as a_did_end_selector_attached then
--				a_did_end_selector__item := a_did_end_selector_attached.item
--			end
--			if attached a_context_info as a_context_info_attached then
--				a_context_info__item := a_context_info_attached.item
--			end
--			objc_begin_sheet_with_print_info__modal_for_window__delegate__did_end_selector__context_info_ (item, a_print_info__item, a_doc_window__item, a_delegate__item, a_did_end_selector__item, a_context_info__item)
--		end

	run_modal_with_print_info_ (a_print_info: detachable NS_PRINT_INFO): INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
			a_print_info__item: POINTER
		do
			if attached a_print_info as a_print_info_attached then
				a_print_info__item := a_print_info_attached.item
			end
			Result := objc_run_modal_with_print_info_ (item, a_print_info__item)
		end

	run_modal: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_run_modal (item)
		end

	print_info: detachable NS_PRINT_INFO
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_print_info (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like print_info} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like print_info} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSPrintPanel Externals

--	objc_add_accessory_controller_ (an_item: POINTER; a_accessory_controller: POINTER)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				[(NSPrintPanel *)$an_item addAccessoryController:$a_accessory_controller];
--			 ]"
--		end

--	objc_remove_accessory_controller_ (an_item: POINTER; a_accessory_controller: POINTER)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				[(NSPrintPanel *)$an_item removeAccessoryController:$a_accessory_controller];
--			 ]"
--		end

	objc_accessory_controllers (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPrintPanel *)$an_item accessoryControllers];
			 ]"
		end

	objc_set_options_ (an_item: POINTER; a_options: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSPrintPanel *)$an_item setOptions:$a_options];
			 ]"
		end

	objc_options (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSPrintPanel *)$an_item options];
			 ]"
		end

	objc_set_default_button_title_ (an_item: POINTER; a_default_button_title: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSPrintPanel *)$an_item setDefaultButtonTitle:$a_default_button_title];
			 ]"
		end

	objc_default_button_title (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPrintPanel *)$an_item defaultButtonTitle];
			 ]"
		end

	objc_set_help_anchor_ (an_item: POINTER; a_help_anchor: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSPrintPanel *)$an_item setHelpAnchor:$a_help_anchor];
			 ]"
		end

	objc_help_anchor (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPrintPanel *)$an_item helpAnchor];
			 ]"
		end

	objc_set_job_style_hint_ (an_item: POINTER; a_hint: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSPrintPanel *)$an_item setJobStyleHint:$a_hint];
			 ]"
		end

	objc_job_style_hint (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPrintPanel *)$an_item jobStyleHint];
			 ]"
		end

--	objc_begin_sheet_with_print_info__modal_for_window__delegate__did_end_selector__context_info_ (an_item: POINTER; a_print_info: POINTER; a_doc_window: POINTER; a_delegate: POINTER; a_did_end_selector: POINTER; a_context_info: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				[(NSPrintPanel *)$an_item beginSheetWithPrintInfo:$a_print_info modalForWindow:$a_doc_window delegate:$a_delegate didEndSelector:$a_did_end_selector contextInfo:];
--			 ]"
--		end

	objc_run_modal_with_print_info_ (an_item: POINTER; a_print_info: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSPrintPanel *)$an_item runModalWithPrintInfo:$a_print_info];
			 ]"
		end

	objc_run_modal (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSPrintPanel *)$an_item runModal];
			 ]"
		end

	objc_print_info (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPrintPanel *)$an_item printInfo];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSPrintPanel"
		end

end
