note
	description: "Summary description for {NS_OPEN_PANEL_API}."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_OPEN_PANEL_API

feature -- Creating Panels

	frozen open_panel: POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSOpenPanel openPanel];"
		end

feature -- Configuring Panels

	frozen resolves_aliases (a_open_panel: POINTER): BOOLEAN
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSOpenPanel*)$a_open_panel resolvesAliases];"
		end

	frozen set_resolves_aliases (a_open_panel: POINTER; a_flag: BOOLEAN)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSOpenPanel*)$a_open_panel setResolvesAliases: $a_flag];"
		end

	frozen can_choose_directories (a_open_panel: POINTER): BOOLEAN
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSOpenPanel*)$a_open_panel canChooseDirectories];"
		end

	frozen set_can_choose_directories (a_open_panel: POINTER; a_flag: BOOLEAN)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSOpenPanel*)$a_open_panel setCanChooseDirectories: $a_flag];"
		end

	frozen allows_multiple_selection (a_open_panel: POINTER): BOOLEAN
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSOpenPanel*)$a_open_panel allowsMultipleSelection];"
		end

	frozen set_allows_multiple_selection (a_open_panel: POINTER; a_flag: BOOLEAN)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSOpenPanel*)$a_open_panel setAllowsMultipleSelection: $a_flag];"
		end

	frozen can_choose_files (a_open_panel: POINTER): BOOLEAN
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSOpenPanel*)$a_open_panel canChooseFiles];"
		end

	frozen set_can_choose_files (a_open_panel: POINTER; a_flag: BOOLEAN)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSOpenPanel*)$a_open_panel setCanChooseFiles: $a_flag];"
		end

feature -- Running Pansels

	frozen begin_sheet (a_open_panel: POINTER; a_path: POINTER; a_filename: POINTER; a_file_types: POINTER; a_doc_window: POINTER; a_delegate: POINTER; a_did_end_selector: POINTER; a_context_info: POINTER)
			-- - (void)beginSheetForDirectory:(NSString *)absoluteDirectoryPath file:(NSString *)filename types:(NSArray *)fileTypes modalForWindow:(NSWindow *)docWindow modalDelegate:(id)modalDelegate didEndSelector:(SEL)didEndSelector contextInfo:(void *)contextInfo
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSOpenPanel*)$a_open_panel beginSheetForDirectory: $a_path file: $a_filename types: $a_file_types modalForWindow: $a_doc_window modalDelegate: $a_delegate didEndSelector: $a_did_end_selector contextInfo: $a_context_info];"
		end

	frozen begin (a_open_panel: POINTER; a_path: POINTER; a_filename: POINTER; a_file_types: POINTER; a_delegate: POINTER; a_did_end_selector: POINTER; a_context_info: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSOpenPanel*)$a_open_panel beginForDirectory: $a_path file: $a_filename types: $a_file_types modelessDelegate: $a_delegate didEndSelector: $a_did_end_selector contextInfo: $a_context_info];"
		end

	frozen run_modal_for_directory_file_types (a_open_panel: POINTER; a_path: POINTER; a_name: POINTER; a_file_types: POINTER): INTEGER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSOpenPanel*)$a_open_panel runModalForDirectory: $a_path file: $a_name types: $a_file_types];"
		end

	frozen run_modal_for_types (a_open_panel: POINTER; a_file_types: POINTER): INTEGER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSOpenPanel*)$a_open_panel runModalForTypes: $a_file_types];"
		end

feature -- Accessing User Selection

	frozen urls (a_open_panel: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSOpenPanel*)$a_open_panel URLs];"
		end

	frozen filenames (a_open_panel: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSOpenPanel*)$a_open_panel filenames];"
		end

end
