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
			make_from_pointer ({NS_OPEN_PANEL_API}.open_panel)
		end

feature -- Access

	filenames: NS_ARRAY [NS_STRING]
		do
			Result := create {NS_ARRAY[NS_STRING]}.share_from_pointer ({NS_OPEN_PANEL_API}.filenames(item))
		end

	resolves_aliases: BOOLEAN
		do
			Result := {NS_OPEN_PANEL_API}.resolves_aliases (item)
		end

	set_resolves_aliases (a_flag: BOOLEAN)
		do
			{NS_OPEN_PANEL_API}.set_resolves_aliases (item, a_flag)
		end

	can_choose_directories : BOOLEAN
		do
			Result := {NS_OPEN_PANEL_API}.can_choose_directories (item)
		end

	set_can_choose_directories (a_flag: BOOLEAN)
		do
			{NS_OPEN_PANEL_API}.set_can_choose_directories (item, a_flag)
		end

	allows_multiple_selection: BOOLEAN
		do
			Result := {NS_OPEN_PANEL_API}.allows_multiple_selection (item)
		end

	set_allows_multiple_selection (a_flag: BOOLEAN)
		do
			{NS_OPEN_PANEL_API}.set_allows_multiple_selection (item, a_flag)
		end

	can_choose_files: BOOLEAN
			-- Returns whether the receiver allows the user to choose files to open.
		do
			Result := {NS_OPEN_PANEL_API}.can_choose_files (item)
		end

	set_can_choose_files (a_flag: BOOLEAN)
			-- Sets whether the user can select files in the receiver's browser.
		do
			{NS_OPEN_PANEL_API}.set_can_choose_files (item, a_flag)
		ensure
			can_choose_files_set: can_choose_files = a_flag
		end

	begin_sheet (a_path: detachable NS_STRING; a_filename: detachable NS_STRING; a_file_types: detachable NS_ARRAY [NS_STRING]; a_doc_window: NS_WINDOW; a_delegate: NS_OBJECT; a_did_end_selector: POINTER; a_context_info: POINTER)
			-- Presents an Open panel as a sheet with the directory specified by absoluteDirectoryPath and optionally the file specified by filename selected.
		local
			l_path, l_filename, l_file_types: POINTER
		do
			if attached a_path then
				l_path := a_path.item
			end
			if attached a_filename then
				l_filename := a_filename.item
			end
			if attached a_file_types then
				l_file_types := a_file_types.object_item
			end
			{NS_OPEN_PANEL_API}.begin_sheet (item, l_path, l_filename, l_file_types, a_doc_window.item, a_delegate.item, a_did_end_selector, a_context_info)
		end

	begin (a_path: NS_STRING; a_name: NS_STRING; a_file_types: NS_ARRAY [NS_STRING]; a_delegate: NS_OBJECT; a_did_end_selector: POINTER; a_context_info: POINTER)

		do
			{NS_OPEN_PANEL_API}.begin (item, a_path.item, a_name.item, a_file_types.object_item, a_delegate.item, a_did_end_selector, a_context_info)
		end

	run_modal_for_directory_file_types (a_path: NS_STRING; a_name: NS_STRING; a_file_types: NS_ARRAY [NS_STRING]): INTEGER
		local
			l_name: POINTER
		do
			if a_name /= void then
				l_name := a_name.item
			else
				l_name := default_pointer
			end
			Result := {NS_OPEN_PANEL_API}.run_modal_for_directory_file_types (item, a_path.item, l_name, a_file_types.object_item)
		end

	run_modal_for_types (a_file_types: NS_ARRAY[NS_STRING]): INTEGER
		do
			Result := {NS_OPEN_PANEL_API}.run_modal_for_types (item, a_file_types.object_item)
		end

end
