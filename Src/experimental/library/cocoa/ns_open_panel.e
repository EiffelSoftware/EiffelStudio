note
	description: "Wrapper for NSOpenPanel."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_OPEN_PANEL

inherit
	NS_SAVE_PANEL
		redefine
			make
		end

create
	make

feature {NONE} -- Creation

	make
		do
			make_from_pointer (open_panel_open_panel)
		end

feature -- Access

	filenames : NS_ARRAY [NS_STRING]
		do
			Result := create {NS_ARRAY[NS_STRING]}.share_from_pointer (open_panel_filenames(item))
		end

	resolves_aliases : BOOLEAN
		do
			Result := open_panel_resolves_aliases (item)
		end

	set_resolves_aliases (a_flag: BOOLEAN)
		do
			open_panel_set_resolves_aliases (item, a_flag)
		end

	can_choose_directories : BOOLEAN
		do
			Result := open_panel_can_choose_directories (item)
		end

	set_can_choose_directories (a_flag: BOOLEAN)
		do
			open_panel_set_can_choose_directories (item, a_flag)
		end

	allows_multiple_selection : BOOLEAN
		do
			Result := open_panel_allows_multiple_selection (item)
		end

	set_allows_multiple_selection (a_flag: BOOLEAN)
		do
			open_panel_set_allows_multiple_selection (item, a_flag)
		end

	can_choose_files : BOOLEAN
		do
			Result := open_panel_can_choose_files (item)
		end

	set_can_choose_files (a_flag: BOOLEAN)
		do
			open_panel_set_can_choose_files (item, a_flag)
		end

--	begin_sheet_for_directory_file_types_modal_for_window_modal_delegate_did_end_selector_context_info (a_path: NS_STRING; a_name: NS_STRING; a_file_types: NS_ARRAY; a_doc_window: NS_WINDOW; a_delegate: NS_OBJECT; a_did_end_selector: SELECTOR; a_context_info: ANY)
--		do
--			open_panel_begin_sheet_for_directory_file_types_modal_for_window_modal_delegate_did_end_selector_context_info(cocoa_object, a_path.cocoa_object, a_name.cocoa_object, a_file_types.cocoa_object, a_doc_window.cocoa_object, a_delegate.cocoa_object, a_did_end_selector, a_context_info)
--		end

--	begin_for_directory_file_types_modeless_delegate_did_end_selector_context_info (a_path: NS_STRING; a_name: NS_STRING; a_file_types: NS_ARRAY; a_delegate: NS_OBJECT; a_did_end_selector: SELECTOR; a_context_info: ANY)
--		do
--			open_panel_begin_for_directory_file_types_modeless_delegate_did_end_selector_context_info(cocoa_object, a_path.cocoa_object, a_name.cocoa_object, a_file_types.cocoa_object, a_delegate.cocoa_object, a_did_end_selector, a_context_info)
--		end

	run_modal_for_directory_file_types (a_path: NS_STRING; a_name: NS_STRING; a_file_types: NS_ARRAY [NS_STRING]): INTEGER
		local
			l_name: POINTER
		do
			if a_name /= void then
				l_name := a_name.item
			else
				l_name := default_pointer
			end
			Result := open_panel_run_modal_for_directory_file_types (item, a_path.item, l_name, a_file_types.item)
		end

	run_modal_for_types (a_file_types: NS_ARRAY[NS_STRING]): INTEGER
		do
			Result := open_panel_run_modal_for_types (item, a_file_types.item)
		end

feature -- Objective-C implementation

	frozen open_panel_open_panel: POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSOpenPanel openPanel];"
		end

	frozen open_panel_urls (a_open_panel: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSOpenPanel*)$a_open_panel URLs];"
		end

	frozen open_panel_filenames (a_open_panel: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSOpenPanel*)$a_open_panel filenames];"
		end

	frozen open_panel_resolves_aliases (a_open_panel: POINTER): BOOLEAN
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSOpenPanel*)$a_open_panel resolvesAliases];"
		end

	frozen open_panel_set_resolves_aliases (a_open_panel: POINTER; a_flag: BOOLEAN)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSOpenPanel*)$a_open_panel setResolvesAliases: $a_flag];"
		end

	frozen open_panel_can_choose_directories (a_open_panel: POINTER): BOOLEAN
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSOpenPanel*)$a_open_panel canChooseDirectories];"
		end

	frozen open_panel_set_can_choose_directories (a_open_panel: POINTER; a_flag: BOOLEAN)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSOpenPanel*)$a_open_panel setCanChooseDirectories: $a_flag];"
		end

	frozen open_panel_allows_multiple_selection (a_open_panel: POINTER): BOOLEAN
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSOpenPanel*)$a_open_panel allowsMultipleSelection];"
		end

	frozen open_panel_set_allows_multiple_selection (a_open_panel: POINTER; a_flag: BOOLEAN)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSOpenPanel*)$a_open_panel setAllowsMultipleSelection: $a_flag];"
		end

	frozen open_panel_can_choose_files (a_open_panel: POINTER): BOOLEAN
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSOpenPanel*)$a_open_panel canChooseFiles];"
		end

	frozen open_panel_set_can_choose_files (a_open_panel: POINTER; a_flag: BOOLEAN)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSOpenPanel*)$a_open_panel setCanChooseFiles: $a_flag];"
		end

--	frozen open_panel_begin_sheet_for_directory_file_types_modal_for_window_modal_delegate_did_end_selector_context_info (a_open_panel: POINTER; a_path: POINTER; a_name: POINTER; a_file_types: POINTER; a_doc_window: POINTER; a_delegate: NS_OBJECT; a_did_end_selector: SELECTOR; a_context_info: ANY)
--		external
--			"C inline use <Cocoa/Cocoa.h>"
--		alias
--			"[(NSOpenPanel*)$a_open_panel beginSheetForDirectory: $a_path types: $a_file_types modalForWindow: $a_doc_window modalDelegate: $a_delegate didEndSelector: $a_did_end_selector contextInfo: $a_context_info];"
--		end

--	frozen open_panel_begin_for_directory_file_types_modeless_delegate_did_end_selector_context_info (a_open_panel: POINTER; a_path: POINTER; a_name: POINTER; a_file_types: POINTER; a_delegate: NS_OBJECT; a_did_end_selector: SELECTOR; a_context_info: ANY)
--		external
--			"C inline use <Cocoa/Cocoa.h>"
--		alias
--			"[(NSOpenPanel*)$a_open_panel beginForDirectory: $a_path types: $a_file_types modelessDelegate: $a_delegate didEndSelector: $a_did_end_selector contextInfo: $a_context_info];"
--		end

	frozen open_panel_run_modal_for_directory_file_types (a_open_panel: POINTER; a_path: POINTER; a_name: POINTER; a_file_types: POINTER): INTEGER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSOpenPanel*)$a_open_panel runModalForDirectory: $a_path file: $a_name types: $a_file_types];"
		end

	frozen open_panel_run_modal_for_types (a_open_panel: POINTER; a_file_types: POINTER): INTEGER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSOpenPanel*)$a_open_panel runModalForTypes: $a_file_types];"
		end

end
