note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_OPEN_PANEL

inherit
	NS_SAVE_PANEL
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_content_rect__style_mask__backing__defer_,
	make_with_content_rect__style_mask__backing__defer__screen_,
	makeial_first_responder,
	make

feature -- NSOpenPanel

	ur_ls: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_ur_ls (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like ur_ls} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like ur_ls} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	resolves_aliases: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_resolves_aliases (item)
		end

	set_resolves_aliases_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_resolves_aliases_ (item, a_flag)
		end

	can_choose_directories: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_can_choose_directories (item)
		end

	set_can_choose_directories_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_can_choose_directories_ (item, a_flag)
		end

	allows_multiple_selection: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_allows_multiple_selection (item)
		end

	set_allows_multiple_selection_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_allows_multiple_selection_ (item, a_flag)
		end

	can_choose_files: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_can_choose_files (item)
		end

	set_can_choose_files_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_can_choose_files_ (item, a_flag)
		end

feature {NONE} -- NSOpenPanel Externals

	objc_ur_ls (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSOpenPanel *)$an_item URLs];
			 ]"
		end

	objc_resolves_aliases (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSOpenPanel *)$an_item resolvesAliases];
			 ]"
		end

	objc_set_resolves_aliases_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSOpenPanel *)$an_item setResolvesAliases:$a_flag];
			 ]"
		end

	objc_can_choose_directories (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSOpenPanel *)$an_item canChooseDirectories];
			 ]"
		end

	objc_set_can_choose_directories_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSOpenPanel *)$an_item setCanChooseDirectories:$a_flag];
			 ]"
		end

	objc_allows_multiple_selection (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSOpenPanel *)$an_item allowsMultipleSelection];
			 ]"
		end

	objc_set_allows_multiple_selection_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSOpenPanel *)$an_item setAllowsMultipleSelection:$a_flag];
			 ]"
		end

	objc_can_choose_files (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSOpenPanel *)$an_item canChooseFiles];
			 ]"
		end

	objc_set_can_choose_files_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSOpenPanel *)$an_item setCanChooseFiles:$a_flag];
			 ]"
		end

feature -- NSDeprecated

	filenames: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_filenames (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like filenames} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like filenames} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

--	begin_sheet_for_directory__file__types__modal_for_window__modal_delegate__did_end_selector__context_info_ (a_path: detachable NS_STRING; a_name: detachable NS_STRING; a_file_types: detachable NS_ARRAY; a_doc_window: detachable NS_WINDOW; a_delegate: detachable NS_OBJECT; a_did_end_selector: detachable OBJC_SELECTOR; a_context_info: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_path__item: POINTER
--			a_name__item: POINTER
--			a_file_types__item: POINTER
--			a_doc_window__item: POINTER
--			a_delegate__item: POINTER
--			a_did_end_selector__item: POINTER
--			a_context_info__item: POINTER
--		do
--			if attached a_path as a_path_attached then
--				a_path__item := a_path_attached.item
--			end
--			if attached a_name as a_name_attached then
--				a_name__item := a_name_attached.item
--			end
--			if attached a_file_types as a_file_types_attached then
--				a_file_types__item := a_file_types_attached.item
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
--			objc_begin_sheet_for_directory__file__types__modal_for_window__modal_delegate__did_end_selector__context_info_ (item, a_path__item, a_name__item, a_file_types__item, a_doc_window__item, a_delegate__item, a_did_end_selector__item, a_context_info__item)
--		end

--	begin_for_directory__file__types__modeless_delegate__did_end_selector__context_info_ (a_path: detachable NS_STRING; a_name: detachable NS_STRING; a_file_types: detachable NS_ARRAY; a_delegate: detachable NS_OBJECT; a_did_end_selector: detachable OBJC_SELECTOR; a_context_info: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_path__item: POINTER
--			a_name__item: POINTER
--			a_file_types__item: POINTER
--			a_delegate__item: POINTER
--			a_did_end_selector__item: POINTER
--			a_context_info__item: POINTER
--		do
--			if attached a_path as a_path_attached then
--				a_path__item := a_path_attached.item
--			end
--			if attached a_name as a_name_attached then
--				a_name__item := a_name_attached.item
--			end
--			if attached a_file_types as a_file_types_attached then
--				a_file_types__item := a_file_types_attached.item
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
--			objc_begin_for_directory__file__types__modeless_delegate__did_end_selector__context_info_ (item, a_path__item, a_name__item, a_file_types__item, a_delegate__item, a_did_end_selector__item, a_context_info__item)
--		end

	run_modal_for_directory__file__types_ (a_path: detachable NS_STRING; a_name: detachable NS_STRING; a_file_types: detachable NS_ARRAY): INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
			a_path__item: POINTER
			a_name__item: POINTER
			a_file_types__item: POINTER
		do
			if attached a_path as a_path_attached then
				a_path__item := a_path_attached.item
			end
			if attached a_name as a_name_attached then
				a_name__item := a_name_attached.item
			end
			if attached a_file_types as a_file_types_attached then
				a_file_types__item := a_file_types_attached.item
			end
			Result := objc_run_modal_for_directory__file__types_ (item, a_path__item, a_name__item, a_file_types__item)
		end

	run_modal_for_types_ (a_file_types: detachable NS_ARRAY): INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
			a_file_types__item: POINTER
		do
			if attached a_file_types as a_file_types_attached then
				a_file_types__item := a_file_types_attached.item
			end
			Result := objc_run_modal_for_types_ (item, a_file_types__item)
		end

feature {NONE} -- NSDeprecated Externals

	objc_filenames (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSOpenPanel *)$an_item filenames];
			 ]"
		end

--	objc_begin_sheet_for_directory__file__types__modal_for_window__modal_delegate__did_end_selector__context_info_ (an_item: POINTER; a_path: POINTER; a_name: POINTER; a_file_types: POINTER; a_doc_window: POINTER; a_delegate: POINTER; a_did_end_selector: POINTER; a_context_info: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				[(NSOpenPanel *)$an_item beginSheetForDirectory:$a_path file:$a_name types:$a_file_types modalForWindow:$a_doc_window modalDelegate:$a_delegate didEndSelector:$a_did_end_selector contextInfo:];
--			 ]"
--		end

--	objc_begin_for_directory__file__types__modeless_delegate__did_end_selector__context_info_ (an_item: POINTER; a_path: POINTER; a_name: POINTER; a_file_types: POINTER; a_delegate: POINTER; a_did_end_selector: POINTER; a_context_info: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				[(NSOpenPanel *)$an_item beginForDirectory:$a_path file:$a_name types:$a_file_types modelessDelegate:$a_delegate didEndSelector:$a_did_end_selector contextInfo:];
--			 ]"
--		end

	objc_run_modal_for_directory__file__types_ (an_item: POINTER; a_path: POINTER; a_name: POINTER; a_file_types: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSOpenPanel *)$an_item runModalForDirectory:$a_path file:$a_name types:$a_file_types];
			 ]"
		end

	objc_run_modal_for_types_ (an_item: POINTER; a_file_types: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSOpenPanel *)$an_item runModalForTypes:$a_file_types];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSOpenPanel"
		end

end
