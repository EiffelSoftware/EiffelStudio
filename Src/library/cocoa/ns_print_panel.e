note
	description: "Summary description for {NS_PRINT_PANEL}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	NS_PRINT_PANEL

inherit
	NS_PANEL

create
	print_panel

feature  -- Creating a NS_PRINT_PANEL

	print_panel
		do
			cocoa_object := print_panel_print_panel
		end


feature -- Customizing the Panel

-- These two beling to NS_PRINT_PANEL_ACCESSORIZING

--	localized_summary_items : NS_ARRAY
--		do
--			Result := print_panel_localized_summary_items(cocoa_object)
--		end

--	key_paths_for_values_affecting_preview : NS_SET
--		do
--			Result := print_panel_key_paths_for_values_affecting_preview(cocoa_object)
--		end

--	add_accessory_controller (a_accessory_controller: NS_VIEW_CONTROLLER [NS_PRINT_PANEL_ACCESSORIZING])
--		do
--			print_panel_add_accessory_controller(cocoa_object, a_accessory_controller.cocoa_object)
--		end

--	remove_accessory_controller (a_accessory_controller: NS_VIEW_CONTROLLER [NS_PRINT_PANEL_ACCESSORIZING])
--		do
--			print_panel_remove_accessory_controller(cocoa_object, a_accessory_controller.cocoa_object)
--		end

--	accessory_controllers : NS_ARRAY [NS_VIEW_CONTROLLER [NS_PRINT_PANEL_ACCESSORIZING]]
--		do
--			Result := print_panel_accessory_controllers(cocoa_object)
--		end

	set_options (a_options: INTEGER)
		do
			print_panel_set_options (cocoa_object, a_options)
		end

	options: INTEGER
		do
			Result := print_panel_options (cocoa_object)
		end

--	set_default_button_title (a_default_button_title: NS_STRING)
--		do
--			print_panel_set_default_button_title(cocoa_object, a_default_button_title.cocoa_object)
--		end

--	default_button_title : NS_STRING
--		do
--			Result := print_panel_default_button_title(cocoa_object)
--		end

--	set_help_anchor (a_help_anchor: NS_STRING)
--		do
--			print_panel_set_help_anchor(cocoa_object, a_help_anchor.cocoa_object)
--		end

--	help_anchor : NS_STRING
--		do
--			Result := print_panel_help_anchor(cocoa_object)
--		end

--	set_job_style_hint (a_hint: NS_STRING)
--		do
--			print_panel_set_job_style_hint(cocoa_object, a_hint.cocoa_object)
--		end

--	job_style_hint : NS_STRING
--		do
--			Result := print_panel_job_style_hint(cocoa_object)
--		end

--	begin_sheet_with_print_info_modal_for_window_delegate_did_end_selector_context_info (a_print_info: NS_PRINT_INFO; a_doc_window: NS_WINDOW; a_delegate: NS_OBJECT; a_did_end_selector: SELECTOR; a_context_info: ANY)
--		do
--			print_panel_begin_sheet_with_print_info_modal_for_window_delegate_did_end_selector_context_info(cocoa_object, a_print_info.cocoa_object, a_doc_window.cocoa_object, a_delegate.cocoa_object, a_did_end_selector, a_context_info)
--		end

--	run_modal_with_print_info (a_print_info: NS_PRINT_INFO): INTEGER
--		do
--			Result := print_panel_run_modal_with_print_info(cocoa_object, a_print_info.cocoa_object)
--		end

	run_modal: INTEGER
		do
			Result := print_panel_run_modal(cocoa_object)
		end

--	print_info : NS_PRINT_INFO
--		do
--			Result := print_panel_print_info(cocoa_object)
--		end

feature {NONE} -- Objective-C implementation

	frozen print_panel_print_panel: POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSPrintPanel printPanel];"
		end

	frozen print_panel_localized_summary_items (a_print_panel: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSPrintPanel*)$a_print_panel localizedSummaryItems];"
		end

	frozen print_panel_key_paths_for_values_affecting_preview (a_print_panel: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSPrintPanel*)$a_print_panel keyPathsForValuesAffectingPreview];"
		end

	frozen print_panel_add_accessory_controller (a_print_panel: POINTER; a_accessory_controller: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSPrintPanel*)$a_print_panel addAccessoryController: $a_accessory_controller];"
		end

	frozen print_panel_remove_accessory_controller (a_print_panel: POINTER; a_accessory_controller: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSPrintPanel*)$a_print_panel removeAccessoryController: $a_accessory_controller];"
		end

	frozen print_panel_accessory_controllers (a_print_panel: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSPrintPanel*)$a_print_panel accessoryControllers];"
		end

	frozen print_panel_set_options (a_print_panel: POINTER; a_options: INTEGER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSPrintPanel*)$a_print_panel setOptions: $a_options];"
		end

	frozen print_panel_options (a_print_panel: POINTER): INTEGER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSPrintPanel*)$a_print_panel options];"
		end

	frozen print_panel_set_default_button_title (a_print_panel: POINTER; a_default_button_title: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSPrintPanel*)$a_print_panel setDefaultButtonTitle: $a_default_button_title];"
		end

	frozen print_panel_default_button_title (a_print_panel: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSPrintPanel*)$a_print_panel defaultButtonTitle];"
		end

	frozen print_panel_set_help_anchor (a_print_panel: POINTER; a_help_anchor: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSPrintPanel*)$a_print_panel setHelpAnchor: $a_help_anchor];"
		end

	frozen print_panel_help_anchor (a_print_panel: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSPrintPanel*)$a_print_panel helpAnchor];"
		end

	frozen print_panel_set_job_style_hint (a_print_panel: POINTER; a_hint: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSPrintPanel*)$a_print_panel setJobStyleHint: $a_hint];"
		end

	frozen print_panel_job_style_hint (a_print_panel: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSPrintPanel*)$a_print_panel jobStyleHint];"
		end

--	frozen print_panel_begin_sheet_with_print_info_modal_for_window_delegate_did_end_selector_context_info (a_print_panel: POINTER; a_print_info: POINTER; a_doc_window: POINTER; a_delegate: NS_OBJECT; a_did_end_selector: SELECTOR; a_context_info: ANY)
--		external
--			"C inline use <Cocoa/Cocoa.h>"
--		alias
--			"[(NSPrintPanel*)$a_print_panel beginSheetWithPrintInfo: $a_print_info modalForWindow: $a_doc_window delegate: $a_delegate didEndSelector: $a_did_end_selector contextInfo: $a_context_info];"
--		end

	frozen print_panel_run_modal_with_print_info (a_print_panel: POINTER; a_print_info: POINTER): INTEGER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSPrintPanel*)$a_print_panel runModalWithPrintInfo: $a_print_info];"
		end

	frozen print_panel_run_modal (a_print_panel: POINTER): INTEGER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSPrintPanel*)$a_print_panel runModal];"
		end

	frozen print_panel_print_info (a_print_panel: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSPrintPanel*)$a_print_panel printInfo];"
		end
end
