note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_FILE_WRAPPER

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end

	NS_CODING_PROTOCOL

create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_directory_with_file_wrappers_,
	make_regular_file_with_contents_,
	make_symbolic_link_with_destination_ur_l_,
	make_with_serialized_representation_,
	make_with_path_,
	make_symbolic_link_with_destination_,
	make

feature {NONE} -- Initialization

--	make_with_ur_l__options__error_ (a_url: detachable NS_URL; a_options: NATURAL_64; a_out_error: UNSUPPORTED_TYPE)
--			-- Initialize `Current'.
--		local
--			a_url__item: POINTER
--			a_out_error__item: POINTER
--		do
--			if attached a_url as a_url_attached then
--				a_url__item := a_url_attached.item
--			end
--			if attached a_out_error as a_out_error_attached then
--				a_out_error__item := a_out_error_attached.item
--			end
--			make_with_pointer (objc_init_with_ur_l__options__error_(allocate_object, a_url__item, a_options, a_out_error__item))
--			if item = default_pointer then
--				-- TODO: handle initialization error.
--			end
--		end

	make_directory_with_file_wrappers_ (a_children_by_preferred_name: detachable NS_DICTIONARY)
			-- Initialize `Current'.
		local
			a_children_by_preferred_name__item: POINTER
		do
			if attached a_children_by_preferred_name as a_children_by_preferred_name_attached then
				a_children_by_preferred_name__item := a_children_by_preferred_name_attached.item
			end
			make_with_pointer (objc_init_directory_with_file_wrappers_(allocate_object, a_children_by_preferred_name__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_regular_file_with_contents_ (a_contents: detachable NS_DATA)
			-- Initialize `Current'.
		local
			a_contents__item: POINTER
		do
			if attached a_contents as a_contents_attached then
				a_contents__item := a_contents_attached.item
			end
			make_with_pointer (objc_init_regular_file_with_contents_(allocate_object, a_contents__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_symbolic_link_with_destination_ur_l_ (a_url: detachable NS_URL)
			-- Initialize `Current'.
		local
			a_url__item: POINTER
		do
			if attached a_url as a_url_attached then
				a_url__item := a_url_attached.item
			end
			make_with_pointer (objc_init_symbolic_link_with_destination_ur_l_(allocate_object, a_url__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_with_serialized_representation_ (a_serialize_representation: detachable NS_DATA)
			-- Initialize `Current'.
		local
			a_serialize_representation__item: POINTER
		do
			if attached a_serialize_representation as a_serialize_representation_attached then
				a_serialize_representation__item := a_serialize_representation_attached.item
			end
			make_with_pointer (objc_init_with_serialized_representation_(allocate_object, a_serialize_representation__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_with_path_ (a_path: detachable NS_STRING)
			-- Initialize `Current'.
		local
			a_path__item: POINTER
		do
			if attached a_path as a_path_attached then
				a_path__item := a_path_attached.item
			end
			make_with_pointer (objc_init_with_path_(allocate_object, a_path__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_symbolic_link_with_destination_ (a_path: detachable NS_STRING)
			-- Initialize `Current'.
		local
			a_path__item: POINTER
		do
			if attached a_path as a_path_attached then
				a_path__item := a_path_attached.item
			end
			make_with_pointer (objc_init_symbolic_link_with_destination_(allocate_object, a_path__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSFileWrapper Externals

--	objc_init_with_ur_l__options__error_ (an_item: POINTER; a_url: POINTER; a_options: NATURAL_64; a_out_error: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSFileWrapper *)$an_item initWithURL:$a_url options:$a_options error:];
--			 ]"
--		end

	objc_init_directory_with_file_wrappers_ (an_item: POINTER; a_children_by_preferred_name: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFileWrapper *)$an_item initDirectoryWithFileWrappers:$a_children_by_preferred_name];
			 ]"
		end

	objc_init_regular_file_with_contents_ (an_item: POINTER; a_contents: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFileWrapper *)$an_item initRegularFileWithContents:$a_contents];
			 ]"
		end

	objc_init_symbolic_link_with_destination_ur_l_ (an_item: POINTER; a_url: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFileWrapper *)$an_item initSymbolicLinkWithDestinationURL:$a_url];
			 ]"
		end

	objc_init_with_serialized_representation_ (an_item: POINTER; a_serialize_representation: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFileWrapper *)$an_item initWithSerializedRepresentation:$a_serialize_representation];
			 ]"
		end

	objc_is_directory (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSFileWrapper *)$an_item isDirectory];
			 ]"
		end

	objc_is_regular_file (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSFileWrapper *)$an_item isRegularFile];
			 ]"
		end

	objc_is_symbolic_link (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSFileWrapper *)$an_item isSymbolicLink];
			 ]"
		end

	objc_set_preferred_filename_ (an_item: POINTER; a_file_name: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSFileWrapper *)$an_item setPreferredFilename:$a_file_name];
			 ]"
		end

	objc_preferred_filename (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFileWrapper *)$an_item preferredFilename];
			 ]"
		end

	objc_set_filename_ (an_item: POINTER; a_file_name: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSFileWrapper *)$an_item setFilename:$a_file_name];
			 ]"
		end

	objc_filename (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFileWrapper *)$an_item filename];
			 ]"
		end

	objc_set_file_attributes_ (an_item: POINTER; a_file_attributes: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSFileWrapper *)$an_item setFileAttributes:$a_file_attributes];
			 ]"
		end

	objc_file_attributes (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFileWrapper *)$an_item fileAttributes];
			 ]"
		end

	objc_set_icon_ (an_item: POINTER; a_icon: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSFileWrapper *)$an_item setIcon:$a_icon];
			 ]"
		end

	objc_icon (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFileWrapper *)$an_item icon];
			 ]"
		end

	objc_matches_contents_of_ur_l_ (an_item: POINTER; a_url: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSFileWrapper *)$an_item matchesContentsOfURL:$a_url];
			 ]"
		end

--	objc_read_from_ur_l__options__error_ (an_item: POINTER; a_url: POINTER; a_options: NATURAL_64; a_out_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return [(NSFileWrapper *)$an_item readFromURL:$a_url options:$a_options error:];
--			 ]"
--		end

--	objc_write_to_ur_l__options__original_contents_ur_l__error_ (an_item: POINTER; a_url: POINTER; a_options: NATURAL_64; a_original_contents_url: POINTER; a_out_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return [(NSFileWrapper *)$an_item writeToURL:$a_url options:$a_options originalContentsURL:$a_original_contents_url error:];
--			 ]"
--		end

	objc_serialized_representation (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFileWrapper *)$an_item serializedRepresentation];
			 ]"
		end

	objc_add_file_wrapper_ (an_item: POINTER; a_child: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFileWrapper *)$an_item addFileWrapper:$a_child];
			 ]"
		end

	objc_add_regular_file_with_contents__preferred_filename_ (an_item: POINTER; a_data: POINTER; a_file_name: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFileWrapper *)$an_item addRegularFileWithContents:$a_data preferredFilename:$a_file_name];
			 ]"
		end

	objc_remove_file_wrapper_ (an_item: POINTER; a_child: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSFileWrapper *)$an_item removeFileWrapper:$a_child];
			 ]"
		end

	objc_file_wrappers (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFileWrapper *)$an_item fileWrappers];
			 ]"
		end

	objc_key_for_file_wrapper_ (an_item: POINTER; a_child: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFileWrapper *)$an_item keyForFileWrapper:$a_child];
			 ]"
		end

	objc_regular_file_contents (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFileWrapper *)$an_item regularFileContents];
			 ]"
		end

	objc_symbolic_link_destination_url (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFileWrapper *)$an_item symbolicLinkDestinationURL];
			 ]"
		end

feature -- NSFileWrapper

	is_directory: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_directory (item)
		end

	is_regular_file: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_regular_file (item)
		end

	is_symbolic_link: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_symbolic_link (item)
		end

	set_preferred_filename_ (a_file_name: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_file_name__item: POINTER
		do
			if attached a_file_name as a_file_name_attached then
				a_file_name__item := a_file_name_attached.item
			end
			objc_set_preferred_filename_ (item, a_file_name__item)
		end

	preferred_filename: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_preferred_filename (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like preferred_filename} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like preferred_filename} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_filename_ (a_file_name: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_file_name__item: POINTER
		do
			if attached a_file_name as a_file_name_attached then
				a_file_name__item := a_file_name_attached.item
			end
			objc_set_filename_ (item, a_file_name__item)
		end

	filename: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_filename (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like filename} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like filename} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_file_attributes_ (a_file_attributes: detachable NS_DICTIONARY)
			-- Auto generated Objective-C wrapper.
		local
			a_file_attributes__item: POINTER
		do
			if attached a_file_attributes as a_file_attributes_attached then
				a_file_attributes__item := a_file_attributes_attached.item
			end
			objc_set_file_attributes_ (item, a_file_attributes__item)
		end

	file_attributes: detachable NS_DICTIONARY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_file_attributes (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like file_attributes} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like file_attributes} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_icon_ (a_icon: detachable NS_IMAGE)
			-- Auto generated Objective-C wrapper.
		local
			a_icon__item: POINTER
		do
			if attached a_icon as a_icon_attached then
				a_icon__item := a_icon_attached.item
			end
			objc_set_icon_ (item, a_icon__item)
		end

	icon: detachable NS_IMAGE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_icon (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like icon} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like icon} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	matches_contents_of_ur_l_ (a_url: detachable NS_URL): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_url__item: POINTER
		do
			if attached a_url as a_url_attached then
				a_url__item := a_url_attached.item
			end
			Result := objc_matches_contents_of_ur_l_ (item, a_url__item)
		end

--	read_from_ur_l__options__error_ (a_url: detachable NS_URL; a_options: NATURAL_64; a_out_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_url__item: POINTER
--			a_out_error__item: POINTER
--		do
--			if attached a_url as a_url_attached then
--				a_url__item := a_url_attached.item
--			end
--			if attached a_out_error as a_out_error_attached then
--				a_out_error__item := a_out_error_attached.item
--			end
--			Result := objc_read_from_ur_l__options__error_ (item, a_url__item, a_options, a_out_error__item)
--		end

--	write_to_ur_l__options__original_contents_ur_l__error_ (a_url: detachable NS_URL; a_options: NATURAL_64; a_original_contents_url: detachable NS_URL; a_out_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_url__item: POINTER
--			a_original_contents_url__item: POINTER
--			a_out_error__item: POINTER
--		do
--			if attached a_url as a_url_attached then
--				a_url__item := a_url_attached.item
--			end
--			if attached a_original_contents_url as a_original_contents_url_attached then
--				a_original_contents_url__item := a_original_contents_url_attached.item
--			end
--			if attached a_out_error as a_out_error_attached then
--				a_out_error__item := a_out_error_attached.item
--			end
--			Result := objc_write_to_ur_l__options__original_contents_ur_l__error_ (item, a_url__item, a_options, a_original_contents_url__item, a_out_error__item)
--		end

	serialized_representation: detachable NS_DATA
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_serialized_representation (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like serialized_representation} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like serialized_representation} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	add_file_wrapper_ (a_child: detachable NS_FILE_WRAPPER): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_child__item: POINTER
		do
			if attached a_child as a_child_attached then
				a_child__item := a_child_attached.item
			end
			result_pointer := objc_add_file_wrapper_ (item, a_child__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like add_file_wrapper_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like add_file_wrapper_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	add_regular_file_with_contents__preferred_filename_ (a_data: detachable NS_DATA; a_file_name: detachable NS_STRING): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_data__item: POINTER
			a_file_name__item: POINTER
		do
			if attached a_data as a_data_attached then
				a_data__item := a_data_attached.item
			end
			if attached a_file_name as a_file_name_attached then
				a_file_name__item := a_file_name_attached.item
			end
			result_pointer := objc_add_regular_file_with_contents__preferred_filename_ (item, a_data__item, a_file_name__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like add_regular_file_with_contents__preferred_filename_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like add_regular_file_with_contents__preferred_filename_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	remove_file_wrapper_ (a_child: detachable NS_FILE_WRAPPER)
			-- Auto generated Objective-C wrapper.
		local
			a_child__item: POINTER
		do
			if attached a_child as a_child_attached then
				a_child__item := a_child_attached.item
			end
			objc_remove_file_wrapper_ (item, a_child__item)
		end

	file_wrappers: detachable NS_DICTIONARY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_file_wrappers (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like file_wrappers} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like file_wrappers} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	key_for_file_wrapper_ (a_child: detachable NS_FILE_WRAPPER): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_child__item: POINTER
		do
			if attached a_child as a_child_attached then
				a_child__item := a_child_attached.item
			end
			result_pointer := objc_key_for_file_wrapper_ (item, a_child__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like key_for_file_wrapper_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like key_for_file_wrapper_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	regular_file_contents: detachable NS_DATA
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_regular_file_contents (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like regular_file_contents} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like regular_file_contents} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	symbolic_link_destination_url: detachable NS_URL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_symbolic_link_destination_url (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like symbolic_link_destination_url} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like symbolic_link_destination_url} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSDeprecated Externals

	objc_init_with_path_ (an_item: POINTER; a_path: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFileWrapper *)$an_item initWithPath:$a_path];
			 ]"
		end

	objc_init_symbolic_link_with_destination_ (an_item: POINTER; a_path: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFileWrapper *)$an_item initSymbolicLinkWithDestination:$a_path];
			 ]"
		end

	objc_needs_to_be_updated_from_path_ (an_item: POINTER; a_path: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSFileWrapper *)$an_item needsToBeUpdatedFromPath:$a_path];
			 ]"
		end

	objc_update_from_path_ (an_item: POINTER; a_path: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSFileWrapper *)$an_item updateFromPath:$a_path];
			 ]"
		end

	objc_write_to_file__atomically__update_filenames_ (an_item: POINTER; a_path: POINTER; a_atomic_flag: BOOLEAN; a_update_filenames_flag: BOOLEAN): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSFileWrapper *)$an_item writeToFile:$a_path atomically:$a_atomic_flag updateFilenames:$a_update_filenames_flag];
			 ]"
		end

	objc_add_file_with_path_ (an_item: POINTER; a_path: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFileWrapper *)$an_item addFileWithPath:$a_path];
			 ]"
		end

	objc_add_symbolic_link_with_destination__preferred_filename_ (an_item: POINTER; a_path: POINTER; a_filename: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFileWrapper *)$an_item addSymbolicLinkWithDestination:$a_path preferredFilename:$a_filename];
			 ]"
		end

	objc_symbolic_link_destination (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFileWrapper *)$an_item symbolicLinkDestination];
			 ]"
		end

feature -- NSDeprecated

	needs_to_be_updated_from_path_ (a_path: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_path__item: POINTER
		do
			if attached a_path as a_path_attached then
				a_path__item := a_path_attached.item
			end
			Result := objc_needs_to_be_updated_from_path_ (item, a_path__item)
		end

	update_from_path_ (a_path: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_path__item: POINTER
		do
			if attached a_path as a_path_attached then
				a_path__item := a_path_attached.item
			end
			Result := objc_update_from_path_ (item, a_path__item)
		end

	write_to_file__atomically__update_filenames_ (a_path: detachable NS_STRING; a_atomic_flag: BOOLEAN; a_update_filenames_flag: BOOLEAN): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_path__item: POINTER
		do
			if attached a_path as a_path_attached then
				a_path__item := a_path_attached.item
			end
			Result := objc_write_to_file__atomically__update_filenames_ (item, a_path__item, a_atomic_flag, a_update_filenames_flag)
		end

	add_file_with_path_ (a_path: detachable NS_STRING): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_path__item: POINTER
		do
			if attached a_path as a_path_attached then
				a_path__item := a_path_attached.item
			end
			result_pointer := objc_add_file_with_path_ (item, a_path__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like add_file_with_path_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like add_file_with_path_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	add_symbolic_link_with_destination__preferred_filename_ (a_path: detachable NS_STRING; a_filename: detachable NS_STRING): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_path__item: POINTER
			a_filename__item: POINTER
		do
			if attached a_path as a_path_attached then
				a_path__item := a_path_attached.item
			end
			if attached a_filename as a_filename_attached then
				a_filename__item := a_filename_attached.item
			end
			result_pointer := objc_add_symbolic_link_with_destination__preferred_filename_ (item, a_path__item, a_filename__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like add_symbolic_link_with_destination__preferred_filename_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like add_symbolic_link_with_destination__preferred_filename_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	symbolic_link_destination: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_symbolic_link_destination (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like symbolic_link_destination} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like symbolic_link_destination} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSFileWrapper"
		end

end
