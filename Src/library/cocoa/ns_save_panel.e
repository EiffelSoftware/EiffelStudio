note
	description: "Wrapper for NSSavePanel."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_SAVE_PANEL

inherit
	NS_PANEL
		rename
			make as make_window
		end

create
	make

feature {NONE} -- Creation

	make
		do
			make_from_pointer ({NS_SAVE_PANEL_API}.save_panel)
		end

feature -- Configuring Panels

	accessory_view : NS_VIEW
		do
			create Result.share_from_pointer ({NS_SAVE_PANEL_API}.accessory_view (item))
		end

	set_accessory_view (a_view: NS_VIEW)
		do
			{NS_SAVE_PANEL_API}.set_accessory_view (item, a_view.item)
		end

feature -- Configuring Panel Content

feature -- Running Panels

--	url: NS_URL
--		do
--			Result := {NS_SAVE_PANEL_API}.url (cocoa_object)
--		end

	filename: NS_STRING
		do
			create Result.share_from_pointer ({NS_SAVE_PANEL_API}.filename (item))
		end

	directory: NS_STRING
		do
			create Result.share_from_pointer ({NS_SAVE_PANEL_API}.directory (item))
		end

	set_directory (a_path: NS_STRING)
		do
			{NS_SAVE_PANEL_API}.set_directory (item, a_path.item)
		end

	required_file_type : NS_STRING
		do
			create Result.share_from_pointer ({NS_SAVE_PANEL_API}.required_file_type (item))
		end

	set_required_file_type (a_type: NS_STRING)
		do
			{NS_SAVE_PANEL_API}.set_required_file_type (item, a_type.item)
		end

	allowed_file_types: NS_ARRAY [NS_STRING]
		do
			create Result.share_from_pointer ({NS_SAVE_PANEL_API}.allowed_file_types (item))
		end

	set_allowed_file_types (a_types: NS_ARRAY [NS_STRING])
		do
			{NS_SAVE_PANEL_API}.set_allowed_file_types (item, a_types.object_item)
		end

	allows_other_file_types : BOOLEAN
		do
			Result := {NS_SAVE_PANEL_API}.allows_other_file_types (item)
		end

	set_allows_other_file_types (a_flag: BOOLEAN)
		do
			{NS_SAVE_PANEL_API}.set_allows_other_file_types (item, a_flag)
		end

--	delegate : NS_SAVE_PANEL_DELEGATE
--		do
--			Result := save_panel_delegate (item)
--		end

--	set_delegate (a_delegate: NS_SAVE_PANEL_DELEGATE)
--		do
--			save_panel_set_delegate (item, a_delegate.item)
--		end

	is_expanded : BOOLEAN
		do
			Result := {NS_SAVE_PANEL_API}.is_expanded (item)
		end

	can_create_directories : BOOLEAN
		do
			Result := {NS_SAVE_PANEL_API}.can_create_directories (item)
		end

	set_can_create_directories (a_flag: BOOLEAN)
		do
			{NS_SAVE_PANEL_API}.set_can_create_directories (item, a_flag)
		end

	can_select_hidden_extension : BOOLEAN
		do
			Result := {NS_SAVE_PANEL_API}.can_select_hidden_extension (item)
		end

	set_can_select_hidden_extension (a_flag: BOOLEAN)
		do
			{NS_SAVE_PANEL_API}.set_can_select_hidden_extension (item, a_flag)
		end

	is_extension_hidden : BOOLEAN
		do
			Result := {NS_SAVE_PANEL_API}.is_extension_hidden (item)
		end

	set_extension_hidden (a_flag: BOOLEAN)
		do
			{NS_SAVE_PANEL_API}.set_extension_hidden (item, a_flag)
		end

	treats_file_packages_as_directories : BOOLEAN
		do
			Result := {NS_SAVE_PANEL_API}.treats_file_packages_as_directories (item)
		end

	set_treats_file_packages_as_directories (a_flag: BOOLEAN)
		do
			{NS_SAVE_PANEL_API}.set_treats_file_packages_as_directories (item, a_flag)
		end

	prompt: NS_STRING
		do
			create Result.share_from_pointer ({NS_SAVE_PANEL_API}.prompt (item))
		end

	set_prompt (a_prompt: NS_STRING)
		do
			{NS_SAVE_PANEL_API}.set_prompt (item, a_prompt.item)
		end

--	title : STRING
--		do
--			Result := {NS_SAVE_PANEL_API}.title (item)
--		end

--	set_title (a_title: STRING_GENERAL)
--		do
--			{NS_SAVE_PANEL_API}.set_title (item, (create {NS_STRING}.make_with_string (a_title)).item)
--		end

	name_field_label: NS_STRING
		do
			create Result.share_from_pointer ({NS_SAVE_PANEL_API}.name_field_label (item))
		end

	set_name_field_label (a_label: NS_STRING)
		do
			{NS_SAVE_PANEL_API}.set_name_field_label (item, a_label.item)
		end

	message: NS_STRING
		do
			create Result.share_from_pointer ({NS_SAVE_PANEL_API}.message (item))
		end

	set_message (a_message: NS_STRING)
		do
			{NS_SAVE_PANEL_API}.set_message (item, a_message.item)
		end

	validate_visible_columns
		do
			{NS_SAVE_PANEL_API}.validate_visible_columns (item)
		end

	ok (a_sender: NS_OBJECT)
		do
			{NS_SAVE_PANEL_API}.ok (item, a_sender.item)
		end

	cancel (a_sender: NS_OBJECT)
		do
			{NS_SAVE_PANEL_API}.cancel (item, a_sender.item)
		end

--	begin_sheet_for_directory_file_modal_for_window_modal_delegate_did_end_selector_context_info (a_path: NS_STRING; a_name: NS_STRING; a_doc_window: NS_WINDOW; a_delegate: NS_OBJECT; a_did_end_selector: SELECTOR; a_context_info: ANY)
--		do
--			{NS_SAVE_PANEL_API}.begin_sheet_for_directory_file_modal_for_window_modal_delegate_did_end_selector_context_info(cocoa_object, a_path.cocoa_object, a_name.cocoa_object, a_doc_window.cocoa_object, a_delegate.cocoa_object, a_did_end_selector, a_context_info)
--		end

	run_modal_for_directory_file (a_path: NS_STRING; a_name: NS_STRING): INTEGER
		do
			Result := {NS_SAVE_PANEL_API}.run_modal_for_directory_file (item, a_path.item, a_name.item)
		end

	run_modal: INTEGER
		do
			Result := {NS_SAVE_PANEL_API}.run_modal (item)
		end

end
