note
	description: "Summary description for {NS_SAVE_PANEL}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	NS_SAVE_PANEL

inherit
	NS_PANEL
	redefine
		set_title
	end

feature

--	url : NS_URL
--		do
--			Result := save_panel_url(cocoa_object)
--		end

	filename : NS_STRING
		do
--			Result := save_panel_filename(cocoa_object)
		end

	directory : NS_STRING
		do
--			Result := save_panel_directory(cocoa_object)
		end

	set_directory (a_path: NS_STRING)
		do
			save_panel_set_directory(cocoa_object, a_path.cocoa_object)
		end

	required_file_type : NS_STRING
		do
--			Result := save_panel_required_file_type(cocoa_object)
		end

	set_required_file_type (a_type: NS_STRING)
		do
			save_panel_set_required_file_type(cocoa_object, a_type.cocoa_object)
		end

	allowed_file_types : NS_ARRAY [NS_STRING]
		do
--			Result := save_panel_allowed_file_types(cocoa_object)
		end

	set_allowed_file_types (a_types: NS_ARRAY [NS_STRING])
		do
			save_panel_set_allowed_file_types(cocoa_object, a_types.cocoa_object)
		end

	allows_other_file_types : BOOLEAN
		do
			Result := save_panel_allows_other_file_types(cocoa_object)
		end

	set_allows_other_file_types (a_flag: BOOLEAN)
		do
			save_panel_set_allows_other_file_types(cocoa_object, a_flag)
		end

	accessory_view : NS_VIEW
		do
--			Result := save_panel_accessory_view(cocoa_object)
		end

	set_accessory_view (a_view: NS_VIEW)
		do
			save_panel_set_accessory_view(cocoa_object, a_view.cocoa_object)
		end

--	delegate : NS_SAVE_PANEL_DELEGATE
--		do
--			Result := save_panel_delegate(cocoa_object)
--		end

--	set_delegate (a_delegate: NS_SAVE_PANEL_DELEGATE)
--		do
--			save_panel_set_delegate(cocoa_object, a_delegate.cocoa_object)
--		end

	is_expanded : BOOLEAN
		do
			Result := save_panel_is_expanded(cocoa_object)
		end

	can_create_directories : BOOLEAN
		do
			Result := save_panel_can_create_directories(cocoa_object)
		end

	set_can_create_directories (a_flag: BOOLEAN)
		do
			save_panel_set_can_create_directories(cocoa_object, a_flag)
		end

	can_select_hidden_extension : BOOLEAN
		do
			Result := save_panel_can_select_hidden_extension(cocoa_object)
		end

	set_can_select_hidden_extension (a_flag: BOOLEAN)
		do
			save_panel_set_can_select_hidden_extension(cocoa_object, a_flag)
		end

	is_extension_hidden : BOOLEAN
		do
			Result := save_panel_is_extension_hidden(cocoa_object)
		end

	set_extension_hidden (a_flag: BOOLEAN)
		do
			save_panel_set_extension_hidden(cocoa_object, a_flag)
		end

	treats_file_packages_as_directories : BOOLEAN
		do
			Result := save_panel_treats_file_packages_as_directories(cocoa_object)
		end

	set_treats_file_packages_as_directories (a_flag: BOOLEAN)
		do
			save_panel_set_treats_file_packages_as_directories(cocoa_object, a_flag)
		end

	prompt : NS_STRING
		do
--			Result := save_panel_prompt(cocoa_object)
		end

	set_prompt (a_prompt: NS_STRING)
		do
			save_panel_set_prompt(cocoa_object, a_prompt.cocoa_object)
		end

	title : NS_STRING
		do
--			Result := save_panel_title(cocoa_object)
		end

	set_title (a_title: STRING_GENERAL)
		do
			save_panel_set_title (cocoa_object, (create {NS_STRING}.make_with_string (a_title)).cocoa_object)
		end

	name_field_label : NS_STRING
		do
--			Result := save_panel_name_field_label(cocoa_object)
		end

	set_name_field_label (a_label: NS_STRING)
		do
			save_panel_set_name_field_label(cocoa_object, a_label.cocoa_object)
		end

	message : NS_STRING
		do
--			Result := save_panel_message(cocoa_object)
		end

	set_message (a_message: NS_STRING)
		do
			save_panel_set_message(cocoa_object, a_message.cocoa_object)
		end

	validate_visible_columns
		do
			save_panel_validate_visible_columns(cocoa_object)
		end

	select_text (a_sender: NS_OBJECT)
		do
			save_panel_select_text(cocoa_object, a_sender.cocoa_object)
		end

	ok (a_sender: NS_OBJECT)
		do
			save_panel_ok(cocoa_object, a_sender.cocoa_object)
		end

	cancel (a_sender: NS_OBJECT)
		do
			save_panel_cancel(cocoa_object, a_sender.cocoa_object)
		end

--	begin_sheet_for_directory_file_modal_for_window_modal_delegate_did_end_selector_context_info (a_path: NS_STRING; a_name: NS_STRING; a_doc_window: NS_WINDOW; a_delegate: NS_OBJECT; a_did_end_selector: SELECTOR; a_context_info: ANY)
--		do
--			save_panel_begin_sheet_for_directory_file_modal_for_window_modal_delegate_did_end_selector_context_info(cocoa_object, a_path.cocoa_object, a_name.cocoa_object, a_doc_window.cocoa_object, a_delegate.cocoa_object, a_did_end_selector, a_context_info)
--		end

	run_modal_for_directory_file (a_path: NS_STRING; a_name: NS_STRING): INTEGER
		do
			Result := save_panel_run_modal_for_directory_file(cocoa_object, a_path.cocoa_object, a_name.cocoa_object)
		end

	run_modal : INTEGER
		do
			Result := save_panel_run_modal(cocoa_object)
		end

feature -- Objective-C implementation

--	frozen save_panel__u_r_l (a_save_panel: POINTER): POINTER
--		external
--			"C inline use <Cocoa/Cocoa.h>"
--		alias
--			"return [(NSSavePanel*)$a_save_panel URL];"
--		end

	frozen save_panel_filename (a_save_panel: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSavePanel*)$a_save_panel filename];"
		end

	frozen save_panel_directory (a_save_panel: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSavePanel*)$a_save_panel directory];"
		end

	frozen save_panel_set_directory (a_save_panel: POINTER; a_path: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSSavePanel*)$a_save_panel setDirectory: $a_path];"
		end

	frozen save_panel_required_file_type (a_save_panel: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSavePanel*)$a_save_panel requiredFileType];"
		end

	frozen save_panel_set_required_file_type (a_save_panel: POINTER; a_type: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSSavePanel*)$a_save_panel setRequiredFileType: $a_type];"
		end

	frozen save_panel_allowed_file_types (a_save_panel: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSavePanel*)$a_save_panel allowedFileTypes];"
		end

	frozen save_panel_set_allowed_file_types (a_save_panel: POINTER; a_types: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSSavePanel*)$a_save_panel setAllowedFileTypes: $a_types];"
		end

	frozen save_panel_allows_other_file_types (a_save_panel: POINTER): BOOLEAN
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSavePanel*)$a_save_panel allowsOtherFileTypes];"
		end

	frozen save_panel_set_allows_other_file_types (a_save_panel: POINTER; a_flag: BOOLEAN)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSSavePanel*)$a_save_panel setAllowsOtherFileTypes: $a_flag];"
		end

	frozen save_panel_accessory_view (a_save_panel: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSavePanel*)$a_save_panel accessoryView];"
		end

	frozen save_panel_set_accessory_view (a_save_panel: POINTER; a_view: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSSavePanel*)$a_save_panel setAccessoryView: $a_view];"
		end

	frozen save_panel_delegate (a_save_panel: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSavePanel*)$a_save_panel delegate];"
		end

	frozen save_panel_set_delegate (a_save_panel: POINTER; a_delegate: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSSavePanel*)$a_save_panel setDelegate: $a_delegate];"
		end

	frozen save_panel_is_expanded (a_save_panel: POINTER): BOOLEAN
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSavePanel*)$a_save_panel isExpanded];"
		end

	frozen save_panel_can_create_directories (a_save_panel: POINTER): BOOLEAN
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSavePanel*)$a_save_panel canCreateDirectories];"
		end

	frozen save_panel_set_can_create_directories (a_save_panel: POINTER; a_flag: BOOLEAN)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSSavePanel*)$a_save_panel setCanCreateDirectories: $a_flag];"
		end

	frozen save_panel_can_select_hidden_extension (a_save_panel: POINTER): BOOLEAN
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSavePanel*)$a_save_panel canSelectHiddenExtension];"
		end

	frozen save_panel_set_can_select_hidden_extension (a_save_panel: POINTER; a_flag: BOOLEAN)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSSavePanel*)$a_save_panel setCanSelectHiddenExtension: $a_flag];"
		end

	frozen save_panel_is_extension_hidden (a_save_panel: POINTER): BOOLEAN
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSavePanel*)$a_save_panel isExtensionHidden];"
		end

	frozen save_panel_set_extension_hidden (a_save_panel: POINTER; a_flag: BOOLEAN)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSSavePanel*)$a_save_panel setExtensionHidden: $a_flag];"
		end

	frozen save_panel_treats_file_packages_as_directories (a_save_panel: POINTER): BOOLEAN
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSavePanel*)$a_save_panel treatsFilePackagesAsDirectories];"
		end

	frozen save_panel_set_treats_file_packages_as_directories (a_save_panel: POINTER; a_flag: BOOLEAN)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSSavePanel*)$a_save_panel setTreatsFilePackagesAsDirectories: $a_flag];"
		end

	frozen save_panel_prompt (a_save_panel: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSavePanel*)$a_save_panel prompt];"
		end

	frozen save_panel_set_prompt (a_save_panel: POINTER; a_prompt: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSSavePanel*)$a_save_panel setPrompt: $a_prompt];"
		end

	frozen save_panel_title (a_save_panel: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSavePanel*)$a_save_panel title];"
		end

	frozen save_panel_set_title (a_save_panel: POINTER; a_title: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSSavePanel*)$a_save_panel setTitle: $a_title];"
		end

	frozen save_panel_name_field_label (a_save_panel: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSavePanel*)$a_save_panel nameFieldLabel];"
		end

	frozen save_panel_set_name_field_label (a_save_panel: POINTER; a_label: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSSavePanel*)$a_save_panel setNameFieldLabel: $a_label];"
		end

	frozen save_panel_message (a_save_panel: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSavePanel*)$a_save_panel message];"
		end

	frozen save_panel_set_message (a_save_panel: POINTER; a_message: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSSavePanel*)$a_save_panel setMessage: $a_message];"
		end

	frozen save_panel_validate_visible_columns (a_save_panel: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSSavePanel*)$a_save_panel validateVisibleColumns];"
		end

	frozen save_panel_select_text (a_save_panel: POINTER; a_sender: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSavePanel*)$a_save_panel selectText: $a_sender];"
		end

	frozen save_panel_ok (a_save_panel: POINTER; a_sender: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSavePanel*)$a_save_panel ok: $a_sender];"
		end

	frozen save_panel_cancel (a_save_panel: POINTER; a_sender: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSavePanel*)$a_save_panel cancel: $a_sender];"
		end

--	frozen save_panel_begin_sheet_for_directory_file_modal_for_window_modal_delegate_did_end_selector_context_info (a_save_panel: POINTER; a_path: POINTER; a_name: POINTER; a_doc_window: POINTER; a_delegate: NS_OBJECT; a_did_end_selector: SELECTOR; a_context_info: ANY)
--		external
--			"C inline use <Cocoa/Cocoa.h>"
--		alias
--			"[(NSSavePanel*)$a_save_panel beginSheetForDirectory: $a_path modalForWindow: $a_doc_window modalDelegate: $a_delegate didEndSelector: $a_did_end_selector contextInfo: $a_context_info];"
--		end

	frozen save_panel_run_modal_for_directory_file (a_save_panel: POINTER; a_path: POINTER; a_name: POINTER): INTEGER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSavePanel*)$a_save_panel runModalForDirectory: $a_path file: $a_name];"
		end

	frozen save_panel_run_modal (a_save_panel: POINTER): INTEGER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSavePanel*)$a_save_panel runModal];"
		end
end
