note
	description: "Summary description for {NS_SAVE_PANEL_API}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	NS_SAVE_PANEL_API

feature -- Creating Panels

	frozen save_panel: POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSSavePanel savePanel];"
		end

feature -- Configuring Panels

	frozen accessory_view (a_ns_save_panel: POINTER): POINTER
			-- - (NSView *)accessoryView
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSavePanel*)$a_ns_save_panel accessoryView];"
		end

	frozen set_accessory_view (a_ns_save_panel: POINTER; a_view: POINTER)
			-- - (void)setAccessoryView: (NSView *) view
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSSavePanel*)$a_ns_save_panel setAccessoryView: $a_view];"
		end

	frozen title (a_ns_save_panel: POINTER): POINTER
			-- - (NSString *)title
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSavePanel*)$a_ns_save_panel title];"
		end

	frozen set_title (a_ns_save_panel: POINTER; a_title: POINTER)
			-- - (void)setTitle: (NSString *) title
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSSavePanel*)$a_ns_save_panel setTitle: $a_title];"
		end

	frozen prompt (a_ns_save_panel: POINTER): POINTER
			-- - (NSString *)prompt
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSavePanel*)$a_ns_save_panel prompt];"
		end

	frozen set_prompt (a_ns_save_panel: POINTER; a_prompt: POINTER)
			-- - (void)setPrompt: (NSString *) prompt
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSSavePanel*)$a_ns_save_panel setPrompt: $a_prompt];"
		end

	frozen name_field_label (a_ns_save_panel: POINTER): POINTER
			-- - (NSString *)nameFieldLabel
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSavePanel*)$a_ns_save_panel nameFieldLabel];"
		end

	frozen set_name_field_label (a_ns_save_panel: POINTER; a_label: POINTER)
			-- - (void)setNameFieldLabel: (NSString *) label
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSSavePanel*)$a_ns_save_panel setNameFieldLabel: $a_label];"
		end

	frozen message (a_ns_save_panel: POINTER): POINTER
			-- - (NSString *)message
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSavePanel*)$a_ns_save_panel message];"
		end

	frozen set_message (a_ns_save_panel: POINTER; a_message: POINTER)
			-- - (void)setMessage: (NSString *) message
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSSavePanel*)$a_ns_save_panel setMessage: $a_message];"
		end

	frozen can_create_directories (a_ns_save_panel: POINTER): BOOLEAN
			-- - (BOOL)canCreateDirectories
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSavePanel*)$a_ns_save_panel canCreateDirectories];"
		end

	frozen set_can_create_directories (a_ns_save_panel: POINTER; a_flag: BOOLEAN)
			-- - (void)setCanCreateDirectories: (BOOL) flag
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSSavePanel*)$a_ns_save_panel setCanCreateDirectories: $a_flag];"
		end

	frozen delegate (a_ns_save_panel: POINTER): POINTER
			-- - (id)delegate
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSavePanel*)$a_ns_save_panel delegate];"
		end

	frozen set_delegate (a_ns_save_panel: POINTER; a_delegate: POINTER)
			-- - (void)setDelegate: (id) delegate
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSSavePanel*)$a_ns_save_panel setDelegate: *(id*)$a_delegate];"
		end

feature -- Configuring Panel Content

	frozen is_extension_hidden (a_ns_save_panel: POINTER): BOOLEAN
			-- - (BOOL)isExtensionHidden
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSavePanel*)$a_ns_save_panel isExtensionHidden];"
		end

	frozen set_extension_hidden (a_ns_save_panel: POINTER; a_flag: BOOLEAN)
			-- - (void)setExtensionHidden: (BOOL) flag
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSSavePanel*)$a_ns_save_panel setExtensionHidden: $a_flag];"
		end

	frozen required_file_type (a_ns_save_panel: POINTER): POINTER
			-- - (NSString *)requiredFileType
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSavePanel*)$a_ns_save_panel requiredFileType];"
		end

	frozen set_required_file_type (a_ns_save_panel: POINTER; a_type: POINTER)
			-- - (void)setRequiredFileType: (NSString *) type
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSSavePanel*)$a_ns_save_panel setRequiredFileType: $a_type];"
		end

	frozen can_select_hidden_extension (a_ns_save_panel: POINTER): BOOLEAN
			-- - (BOOL)canSelectHiddenExtension
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSavePanel*)$a_ns_save_panel canSelectHiddenExtension];"
		end

	frozen set_can_select_hidden_extension (a_ns_save_panel: POINTER; a_flag: BOOLEAN)
			-- - (void)setCanSelectHiddenExtension: (BOOL) flag
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSSavePanel*)$a_ns_save_panel setCanSelectHiddenExtension: $a_flag];"
		end

	frozen allowed_file_types (a_ns_save_panel: POINTER): POINTER
			-- - (NSArray *)allowedFileTypes
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSavePanel*)$a_ns_save_panel allowedFileTypes];"
		end

	frozen set_allowed_file_types (a_ns_save_panel: POINTER; a_types: POINTER)
			-- - (void)setAllowedFileTypes: (NSArray *) types
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSSavePanel*)$a_ns_save_panel setAllowedFileTypes: $a_types];"
		end

	frozen allows_other_file_types (a_ns_save_panel: POINTER): BOOLEAN
			-- - (BOOL)allowsOtherFileTypes
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSavePanel*)$a_ns_save_panel allowsOtherFileTypes];"
		end

	frozen set_allows_other_file_types (a_ns_save_panel: POINTER; a_flag: BOOLEAN)
			-- - (void)setAllowsOtherFileTypes: (BOOL) flag
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSSavePanel*)$a_ns_save_panel setAllowsOtherFileTypes: $a_flag];"
		end

	frozen treats_file_packages_as_directories (a_ns_save_panel: POINTER): BOOLEAN
			-- - (BOOL)treatsFilePackagesAsDirectories
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSavePanel*)$a_ns_save_panel treatsFilePackagesAsDirectories];"
		end

	frozen set_treats_file_packages_as_directories (a_ns_save_panel: POINTER; a_flag: BOOLEAN)
			-- - (void)setTreatsFilePackagesAsDirectories: (BOOL) flag
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSSavePanel*)$a_ns_save_panel setTreatsFilePackagesAsDirectories: $a_flag];"
		end

feature -- Running Panels

feature -- Accessing User Selection

	frozen directory (a_ns_save_panel: POINTER): POINTER
			-- - (NSString *)directory
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSavePanel*)$a_ns_save_panel directory];"
		end

	frozen set_directory (a_ns_save_panel: POINTER; a_path: POINTER)
			-- - (void)setDirectory: (NSString *) path
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSSavePanel*)$a_ns_save_panel setDirectory: $a_path];"
		end

	frozen filename (a_ns_save_panel: POINTER): POINTER
			-- - (NSString *)filename
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSavePanel*)$a_ns_save_panel filename];"
		end

	frozen url (a_ns_save_panel: POINTER): POINTER
			-- - (NSURL *)URL
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSavePanel*)$a_ns_save_panel URL];"
		end

	frozen is_expanded (a_ns_save_panel: POINTER): BOOLEAN
			-- - (BOOL)isExpanded
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSavePanel*)$a_ns_save_panel isExpanded];"
		end

feature -- Handling Actions

	frozen validate_visible_columns (a_ns_save_panel: POINTER)
			-- - (void)validateVisibleColumns
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSSavePanel*)$a_ns_save_panel validateVisibleColumns];"
		end

	frozen ok (a_ns_save_panel: POINTER; a_sender: POINTER)
			-- - (IBAction)ok: (id) sender
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSSavePanel*)$a_ns_save_panel ok: $a_sender];"
		end

	frozen cancel (a_ns_save_panel: POINTER; a_sender: POINTER)
			-- - (IBAction)cancel: (id) sender
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSSavePanel*)$a_ns_save_panel cancel: $a_sender];"
		end

	frozen begin_sheet_for_directory_file_modal_for_window_modal_delegate_did_end_selector_context_info (a_ns_save_panel: POINTER; a_path: POINTER; a_name: POINTER; a_doc_window: POINTER; a_delegate: POINTER; a_did_end_selector: POINTER; a_context_info: POINTER)
			-- - (void)beginSheetForDirectory: (NSString *) path file: (NSString *) name modalForWindow: (NSString *) docWindow modalDelegate: (NSString *) delegate didEndSelector: (NSString *) didEndSelector contextInfo: (NSString *) contextInfo
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSSavePanel*)$a_ns_save_panel beginSheetForDirectory: $a_path file: $a_name modalForWindow: $a_doc_window modalDelegate: *(id*)$a_delegate didEndSelector: *(SEL*)$a_did_end_selector contextInfo: $a_context_info];"
		end

	frozen run_modal_for_directory_file (a_ns_save_panel: POINTER; a_path: POINTER; a_name: POINTER): INTEGER
			-- - (NSInteger)runModalForDirectory: (NSString *) path file: (NSString *) name
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSavePanel*)$a_ns_save_panel runModalForDirectory: $a_path file: $a_name];"
		end

	frozen run_modal (a_ns_save_panel: POINTER): INTEGER
			-- - (NSInteger)runModal
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSavePanel*)$a_ns_save_panel runModal];"
		end

	frozen panel_should_show_filename (a_ns_save_panel: POINTER; a_sender: POINTER; a_filename: POINTER): BOOLEAN
			-- - (BOOL)panel: (id) sender shouldShowFilename: (id) filename
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSavePanel*)$a_ns_save_panel panel: *(id*)$a_sender shouldShowFilename: $a_filename];"
		end

	frozen panel_compare_filename_with_case_sensitive (a_ns_save_panel: POINTER; a_sender: POINTER; a_name1: POINTER; a_name2: POINTER; a_case_sensitive: BOOLEAN): INTEGER
			-- - (NSComparisonResult)panel: (id) sender compareFilename: (id) name1 with: (id) name2 caseSensitive: (id) caseSensitive
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSavePanel*)$a_ns_save_panel panel: *(id*)$a_sender compareFilename: $a_name1 with: $a_name2 caseSensitive: $a_case_sensitive];"
		end

	frozen panel_is_valid_filename (a_ns_save_panel: POINTER; a_sender: POINTER; a_filename: POINTER): BOOLEAN
			-- - (BOOL)panel: (id) sender isValidFilename: (id) filename
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSavePanel*)$a_ns_save_panel panel: *(id*)$a_sender isValidFilename: $a_filename];"
		end

	frozen panel_user_entered_filename_confirmed (a_ns_save_panel: POINTER; a_sender: POINTER; a_filename: POINTER; a_ok_flag: BOOLEAN): POINTER
			-- - (NSString *)panel: (id) sender userEnteredFilename: (id) filename confirmed: (id) okFlag
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSavePanel*)$a_ns_save_panel panel: *(id*)$a_sender userEnteredFilename: $a_filename confirmed: $a_ok_flag];"
		end

	frozen panel_will_expand (a_ns_save_panel: POINTER; a_sender: POINTER; a_expanding: BOOLEAN)
			-- - (void)panel: (id) sender willExpand: (id) expanding
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSSavePanel*)$a_ns_save_panel panel: *(id*)$a_sender willExpand: $a_expanding];"
		end

	frozen panel_directory_did_change (a_ns_save_panel: POINTER; a_sender: POINTER; a_path: POINTER)
			-- - (void)panel: (id) sender directoryDidChange: (id) path
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSSavePanel*)$a_ns_save_panel panel: *(id*)$a_sender directoryDidChange: $a_path];"
		end

	frozen panel_selection_did_change (a_ns_save_panel: POINTER; a_sender: POINTER)
			-- - (void)panelSelectionDidChange: (id) sender
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSSavePanel*)$a_ns_save_panel panelSelectionDidChange: *(id*)$a_sender];"
		end

end
