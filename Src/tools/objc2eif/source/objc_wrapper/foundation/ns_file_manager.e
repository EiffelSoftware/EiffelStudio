note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_FILE_MANAGER

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

feature -- NSFileManager

	mounted_volume_ur_ls_including_resource_values_for_keys__options_ (a_property_keys: detachable NS_ARRAY; a_options: NATURAL_64): detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_property_keys__item: POINTER
		do
			if attached a_property_keys as a_property_keys_attached then
				a_property_keys__item := a_property_keys_attached.item
			end
			result_pointer := objc_mounted_volume_ur_ls_including_resource_values_for_keys__options_ (item, a_property_keys__item, a_options)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like mounted_volume_ur_ls_including_resource_values_for_keys__options_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like mounted_volume_ur_ls_including_resource_values_for_keys__options_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

--	contents_of_directory_at_ur_l__including_properties_for_keys__options__error_ (a_url: detachable NS_URL; a_keys: detachable NS_ARRAY; a_mask: NATURAL_64; a_error: UNSUPPORTED_TYPE): detachable NS_ARRAY
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			a_url__item: POINTER
--			a_keys__item: POINTER
--			a_error__item: POINTER
--		do
--			if attached a_url as a_url_attached then
--				a_url__item := a_url_attached.item
--			end
--			if attached a_keys as a_keys_attached then
--				a_keys__item := a_keys_attached.item
--			end
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			result_pointer := objc_contents_of_directory_at_ur_l__including_properties_for_keys__options__error_ (item, a_url__item, a_keys__item, a_mask, a_error__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like contents_of_directory_at_ur_l__including_properties_for_keys__options__error_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like contents_of_directory_at_ur_l__including_properties_for_keys__options__error_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

	ur_ls_for_directory__in_domains_ (a_directory: NATURAL_64; a_domain_mask: NATURAL_64): detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_ur_ls_for_directory__in_domains_ (item, a_directory, a_domain_mask)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like ur_ls_for_directory__in_domains_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like ur_ls_for_directory__in_domains_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

--	url_for_directory__in_domain__appropriate_for_ur_l__create__error_ (a_directory: NATURAL_64; a_domain: NATURAL_64; a_url: detachable NS_URL; a_should_create: BOOLEAN; a_error: UNSUPPORTED_TYPE): detachable NS_URL
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			a_url__item: POINTER
--			a_error__item: POINTER
--		do
--			if attached a_url as a_url_attached then
--				a_url__item := a_url_attached.item
--			end
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			result_pointer := objc_url_for_directory__in_domain__appropriate_for_ur_l__create__error_ (item, a_directory, a_domain, a_url__item, a_should_create, a_error__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like url_for_directory__in_domain__appropriate_for_ur_l__create__error_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like url_for_directory__in_domain__appropriate_for_ur_l__create__error_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

	set_delegate_ (a_delegate: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_delegate__item: POINTER
		do
			if attached a_delegate as a_delegate_attached then
				a_delegate__item := a_delegate_attached.item
			end
			objc_set_delegate_ (item, a_delegate__item)
		end

	delegate: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_delegate (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like delegate} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like delegate} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

--	set_attributes__of_item_at_path__error_ (a_attributes: detachable NS_DICTIONARY; a_path: detachable NS_STRING; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_attributes__item: POINTER
--			a_path__item: POINTER
--			a_error__item: POINTER
--		do
--			if attached a_attributes as a_attributes_attached then
--				a_attributes__item := a_attributes_attached.item
--			end
--			if attached a_path as a_path_attached then
--				a_path__item := a_path_attached.item
--			end
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			Result := objc_set_attributes__of_item_at_path__error_ (item, a_attributes__item, a_path__item, a_error__item)
--		end

--	create_directory_at_path__with_intermediate_directories__attributes__error_ (a_path: detachable NS_STRING; a_create_intermediates: BOOLEAN; a_attributes: detachable NS_DICTIONARY; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_path__item: POINTER
--			a_attributes__item: POINTER
--			a_error__item: POINTER
--		do
--			if attached a_path as a_path_attached then
--				a_path__item := a_path_attached.item
--			end
--			if attached a_attributes as a_attributes_attached then
--				a_attributes__item := a_attributes_attached.item
--			end
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			Result := objc_create_directory_at_path__with_intermediate_directories__attributes__error_ (item, a_path__item, a_create_intermediates, a_attributes__item, a_error__item)
--		end

--	contents_of_directory_at_path__error_ (a_path: detachable NS_STRING; a_error: UNSUPPORTED_TYPE): detachable NS_ARRAY
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			a_path__item: POINTER
--			a_error__item: POINTER
--		do
--			if attached a_path as a_path_attached then
--				a_path__item := a_path_attached.item
--			end
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			result_pointer := objc_contents_of_directory_at_path__error_ (item, a_path__item, a_error__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like contents_of_directory_at_path__error_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like contents_of_directory_at_path__error_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	subpaths_of_directory_at_path__error_ (a_path: detachable NS_STRING; a_error: UNSUPPORTED_TYPE): detachable NS_ARRAY
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			a_path__item: POINTER
--			a_error__item: POINTER
--		do
--			if attached a_path as a_path_attached then
--				a_path__item := a_path_attached.item
--			end
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			result_pointer := objc_subpaths_of_directory_at_path__error_ (item, a_path__item, a_error__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like subpaths_of_directory_at_path__error_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like subpaths_of_directory_at_path__error_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	attributes_of_item_at_path__error_ (a_path: detachable NS_STRING; a_error: UNSUPPORTED_TYPE): detachable NS_DICTIONARY
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			a_path__item: POINTER
--			a_error__item: POINTER
--		do
--			if attached a_path as a_path_attached then
--				a_path__item := a_path_attached.item
--			end
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			result_pointer := objc_attributes_of_item_at_path__error_ (item, a_path__item, a_error__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like attributes_of_item_at_path__error_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like attributes_of_item_at_path__error_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	attributes_of_file_system_for_path__error_ (a_path: detachable NS_STRING; a_error: UNSUPPORTED_TYPE): detachable NS_DICTIONARY
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			a_path__item: POINTER
--			a_error__item: POINTER
--		do
--			if attached a_path as a_path_attached then
--				a_path__item := a_path_attached.item
--			end
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			result_pointer := objc_attributes_of_file_system_for_path__error_ (item, a_path__item, a_error__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like attributes_of_file_system_for_path__error_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like attributes_of_file_system_for_path__error_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	create_symbolic_link_at_path__with_destination_path__error_ (a_path: detachable NS_STRING; a_dest_path: detachable NS_STRING; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_path__item: POINTER
--			a_dest_path__item: POINTER
--			a_error__item: POINTER
--		do
--			if attached a_path as a_path_attached then
--				a_path__item := a_path_attached.item
--			end
--			if attached a_dest_path as a_dest_path_attached then
--				a_dest_path__item := a_dest_path_attached.item
--			end
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			Result := objc_create_symbolic_link_at_path__with_destination_path__error_ (item, a_path__item, a_dest_path__item, a_error__item)
--		end

--	destination_of_symbolic_link_at_path__error_ (a_path: detachable NS_STRING; a_error: UNSUPPORTED_TYPE): detachable NS_STRING
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			a_path__item: POINTER
--			a_error__item: POINTER
--		do
--			if attached a_path as a_path_attached then
--				a_path__item := a_path_attached.item
--			end
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			result_pointer := objc_destination_of_symbolic_link_at_path__error_ (item, a_path__item, a_error__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like destination_of_symbolic_link_at_path__error_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like destination_of_symbolic_link_at_path__error_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	copy_item_at_path__to_path__error_ (a_src_path: detachable NS_STRING; a_dst_path: detachable NS_STRING; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_src_path__item: POINTER
--			a_dst_path__item: POINTER
--			a_error__item: POINTER
--		do
--			if attached a_src_path as a_src_path_attached then
--				a_src_path__item := a_src_path_attached.item
--			end
--			if attached a_dst_path as a_dst_path_attached then
--				a_dst_path__item := a_dst_path_attached.item
--			end
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			Result := objc_copy_item_at_path__to_path__error_ (item, a_src_path__item, a_dst_path__item, a_error__item)
--		end

--	move_item_at_path__to_path__error_ (a_src_path: detachable NS_STRING; a_dst_path: detachable NS_STRING; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_src_path__item: POINTER
--			a_dst_path__item: POINTER
--			a_error__item: POINTER
--		do
--			if attached a_src_path as a_src_path_attached then
--				a_src_path__item := a_src_path_attached.item
--			end
--			if attached a_dst_path as a_dst_path_attached then
--				a_dst_path__item := a_dst_path_attached.item
--			end
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			Result := objc_move_item_at_path__to_path__error_ (item, a_src_path__item, a_dst_path__item, a_error__item)
--		end

--	link_item_at_path__to_path__error_ (a_src_path: detachable NS_STRING; a_dst_path: detachable NS_STRING; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_src_path__item: POINTER
--			a_dst_path__item: POINTER
--			a_error__item: POINTER
--		do
--			if attached a_src_path as a_src_path_attached then
--				a_src_path__item := a_src_path_attached.item
--			end
--			if attached a_dst_path as a_dst_path_attached then
--				a_dst_path__item := a_dst_path_attached.item
--			end
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			Result := objc_link_item_at_path__to_path__error_ (item, a_src_path__item, a_dst_path__item, a_error__item)
--		end

--	remove_item_at_path__error_ (a_path: detachable NS_STRING; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_path__item: POINTER
--			a_error__item: POINTER
--		do
--			if attached a_path as a_path_attached then
--				a_path__item := a_path_attached.item
--			end
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			Result := objc_remove_item_at_path__error_ (item, a_path__item, a_error__item)
--		end

--	copy_item_at_ur_l__to_ur_l__error_ (a_src_url: detachable NS_URL; a_dst_url: detachable NS_URL; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_src_url__item: POINTER
--			a_dst_url__item: POINTER
--			a_error__item: POINTER
--		do
--			if attached a_src_url as a_src_url_attached then
--				a_src_url__item := a_src_url_attached.item
--			end
--			if attached a_dst_url as a_dst_url_attached then
--				a_dst_url__item := a_dst_url_attached.item
--			end
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			Result := objc_copy_item_at_ur_l__to_ur_l__error_ (item, a_src_url__item, a_dst_url__item, a_error__item)
--		end

--	move_item_at_ur_l__to_ur_l__error_ (a_src_url: detachable NS_URL; a_dst_url: detachable NS_URL; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_src_url__item: POINTER
--			a_dst_url__item: POINTER
--			a_error__item: POINTER
--		do
--			if attached a_src_url as a_src_url_attached then
--				a_src_url__item := a_src_url_attached.item
--			end
--			if attached a_dst_url as a_dst_url_attached then
--				a_dst_url__item := a_dst_url_attached.item
--			end
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			Result := objc_move_item_at_ur_l__to_ur_l__error_ (item, a_src_url__item, a_dst_url__item, a_error__item)
--		end

--	link_item_at_ur_l__to_ur_l__error_ (a_src_url: detachable NS_URL; a_dst_url: detachable NS_URL; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_src_url__item: POINTER
--			a_dst_url__item: POINTER
--			a_error__item: POINTER
--		do
--			if attached a_src_url as a_src_url_attached then
--				a_src_url__item := a_src_url_attached.item
--			end
--			if attached a_dst_url as a_dst_url_attached then
--				a_dst_url__item := a_dst_url_attached.item
--			end
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			Result := objc_link_item_at_ur_l__to_ur_l__error_ (item, a_src_url__item, a_dst_url__item, a_error__item)
--		end

--	remove_item_at_ur_l__error_ (a_url: detachable NS_URL; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_url__item: POINTER
--			a_error__item: POINTER
--		do
--			if attached a_url as a_url_attached then
--				a_url__item := a_url_attached.item
--			end
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			Result := objc_remove_item_at_ur_l__error_ (item, a_url__item, a_error__item)
--		end

	current_directory_path: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_current_directory_path (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like current_directory_path} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like current_directory_path} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	change_current_directory_path_ (a_path: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_path__item: POINTER
		do
			if attached a_path as a_path_attached then
				a_path__item := a_path_attached.item
			end
			Result := objc_change_current_directory_path_ (item, a_path__item)
		end

	file_exists_at_path_ (a_path: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_path__item: POINTER
		do
			if attached a_path as a_path_attached then
				a_path__item := a_path_attached.item
			end
			Result := objc_file_exists_at_path_ (item, a_path__item)
		end

--	file_exists_at_path__is_directory_ (a_path: detachable NS_STRING; a_is_directory: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_path__item: POINTER
--			a_is_directory__item: POINTER
--		do
--			if attached a_path as a_path_attached then
--				a_path__item := a_path_attached.item
--			end
--			if attached a_is_directory as a_is_directory_attached then
--				a_is_directory__item := a_is_directory_attached.item
--			end
--			Result := objc_file_exists_at_path__is_directory_ (item, a_path__item, a_is_directory__item)
--		end

	is_readable_file_at_path_ (a_path: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_path__item: POINTER
		do
			if attached a_path as a_path_attached then
				a_path__item := a_path_attached.item
			end
			Result := objc_is_readable_file_at_path_ (item, a_path__item)
		end

	is_writable_file_at_path_ (a_path: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_path__item: POINTER
		do
			if attached a_path as a_path_attached then
				a_path__item := a_path_attached.item
			end
			Result := objc_is_writable_file_at_path_ (item, a_path__item)
		end

	is_executable_file_at_path_ (a_path: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_path__item: POINTER
		do
			if attached a_path as a_path_attached then
				a_path__item := a_path_attached.item
			end
			Result := objc_is_executable_file_at_path_ (item, a_path__item)
		end

	is_deletable_file_at_path_ (a_path: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_path__item: POINTER
		do
			if attached a_path as a_path_attached then
				a_path__item := a_path_attached.item
			end
			Result := objc_is_deletable_file_at_path_ (item, a_path__item)
		end

	contents_equal_at_path__and_path_ (a_path1: detachable NS_STRING; a_path2: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_path1__item: POINTER
			a_path2__item: POINTER
		do
			if attached a_path1 as a_path1_attached then
				a_path1__item := a_path1_attached.item
			end
			if attached a_path2 as a_path2_attached then
				a_path2__item := a_path2_attached.item
			end
			Result := objc_contents_equal_at_path__and_path_ (item, a_path1__item, a_path2__item)
		end

	display_name_at_path_ (a_path: detachable NS_STRING): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_path__item: POINTER
		do
			if attached a_path as a_path_attached then
				a_path__item := a_path_attached.item
			end
			result_pointer := objc_display_name_at_path_ (item, a_path__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like display_name_at_path_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like display_name_at_path_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	components_to_display_for_path_ (a_path: detachable NS_STRING): detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_path__item: POINTER
		do
			if attached a_path as a_path_attached then
				a_path__item := a_path_attached.item
			end
			result_pointer := objc_components_to_display_for_path_ (item, a_path__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like components_to_display_for_path_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like components_to_display_for_path_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	enumerator_at_path_ (a_path: detachable NS_STRING): detachable NS_DIRECTORY_ENUMERATOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_path__item: POINTER
		do
			if attached a_path as a_path_attached then
				a_path__item := a_path_attached.item
			end
			result_pointer := objc_enumerator_at_path_ (item, a_path__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like enumerator_at_path_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like enumerator_at_path_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

--	enumerator_at_ur_l__including_properties_for_keys__options__error_handler_ (a_url: detachable NS_URL; a_keys: detachable NS_ARRAY; a_mask: NATURAL_64; a_handler: UNSUPPORTED_TYPE): detachable NS_DIRECTORY_ENUMERATOR
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			a_url__item: POINTER
--			a_keys__item: POINTER
--		do
--			if attached a_url as a_url_attached then
--				a_url__item := a_url_attached.item
--			end
--			if attached a_keys as a_keys_attached then
--				a_keys__item := a_keys_attached.item
--			end
--			result_pointer := objc_enumerator_at_ur_l__including_properties_for_keys__options__error_handler_ (item, a_url__item, a_keys__item, a_mask, )
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like enumerator_at_ur_l__including_properties_for_keys__options__error_handler_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like enumerator_at_ur_l__including_properties_for_keys__options__error_handler_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

	subpaths_at_path_ (a_path: detachable NS_STRING): detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_path__item: POINTER
		do
			if attached a_path as a_path_attached then
				a_path__item := a_path_attached.item
			end
			result_pointer := objc_subpaths_at_path_ (item, a_path__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like subpaths_at_path_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like subpaths_at_path_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	contents_at_path_ (a_path: detachable NS_STRING): detachable NS_DATA
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_path__item: POINTER
		do
			if attached a_path as a_path_attached then
				a_path__item := a_path_attached.item
			end
			result_pointer := objc_contents_at_path_ (item, a_path__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like contents_at_path_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like contents_at_path_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	create_file_at_path__contents__attributes_ (a_path: detachable NS_STRING; a_data: detachable NS_DATA; a_attr: detachable NS_DICTIONARY): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_path__item: POINTER
			a_data__item: POINTER
			a_attr__item: POINTER
		do
			if attached a_path as a_path_attached then
				a_path__item := a_path_attached.item
			end
			if attached a_data as a_data_attached then
				a_data__item := a_data_attached.item
			end
			if attached a_attr as a_attr_attached then
				a_attr__item := a_attr_attached.item
			end
			Result := objc_create_file_at_path__contents__attributes_ (item, a_path__item, a_data__item, a_attr__item)
		end

--	file_system_representation_with_path_ (a_path: detachable NS_STRING): detachable UNSUPPORTED_TYPE
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			a_path__item: POINTER
--		do
--			if attached a_path as a_path_attached then
--				a_path__item := a_path_attached.item
--			end
--			result_pointer := objc_file_system_representation_with_path_ (item, a_path__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like file_system_representation_with_path_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like file_system_representation_with_path_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	string_with_file_system_representation__length_ (a_str: UNSUPPORTED_TYPE; a_len: NATURAL_64): detachable NS_STRING
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--		do
--			result_pointer := objc_string_with_file_system_representation__length_ (item, , a_len)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like string_with_file_system_representation__length_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like string_with_file_system_representation__length_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	replace_item_at_ur_l__with_item_at_ur_l__backup_item_name__options__resulting_item_ur_l__error_ (a_original_item_url: detachable NS_URL; a_new_item_url: detachable NS_URL; a_backup_item_name: detachable NS_STRING; a_options: NATURAL_64; a_resulting_url: UNSUPPORTED_TYPE; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_original_item_url__item: POINTER
--			a_new_item_url__item: POINTER
--			a_backup_item_name__item: POINTER
--			a_resulting_url__item: POINTER
--			a_error__item: POINTER
--		do
--			if attached a_original_item_url as a_original_item_url_attached then
--				a_original_item_url__item := a_original_item_url_attached.item
--			end
--			if attached a_new_item_url as a_new_item_url_attached then
--				a_new_item_url__item := a_new_item_url_attached.item
--			end
--			if attached a_backup_item_name as a_backup_item_name_attached then
--				a_backup_item_name__item := a_backup_item_name_attached.item
--			end
--			if attached a_resulting_url as a_resulting_url_attached then
--				a_resulting_url__item := a_resulting_url_attached.item
--			end
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			Result := objc_replace_item_at_ur_l__with_item_at_ur_l__backup_item_name__options__resulting_item_ur_l__error_ (item, a_original_item_url__item, a_new_item_url__item, a_backup_item_name__item, a_options, a_resulting_url__item, a_error__item)
--		end

feature {NONE} -- NSFileManager Externals

	objc_mounted_volume_ur_ls_including_resource_values_for_keys__options_ (an_item: POINTER; a_property_keys: POINTER; a_options: NATURAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFileManager *)$an_item mountedVolumeURLsIncludingResourceValuesForKeys:$a_property_keys options:$a_options];
			 ]"
		end

--	objc_contents_of_directory_at_ur_l__including_properties_for_keys__options__error_ (an_item: POINTER; a_url: POINTER; a_keys: POINTER; a_mask: NATURAL_64; a_error: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSFileManager *)$an_item contentsOfDirectoryAtURL:$a_url includingPropertiesForKeys:$a_keys options:$a_mask error:];
--			 ]"
--		end

	objc_ur_ls_for_directory__in_domains_ (an_item: POINTER; a_directory: NATURAL_64; a_domain_mask: NATURAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFileManager *)$an_item URLsForDirectory:$a_directory inDomains:$a_domain_mask];
			 ]"
		end

--	objc_url_for_directory__in_domain__appropriate_for_ur_l__create__error_ (an_item: POINTER; a_directory: NATURAL_64; a_domain: NATURAL_64; a_url: POINTER; a_should_create: BOOLEAN; a_error: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSFileManager *)$an_item URLForDirectory:$a_directory inDomain:$a_domain appropriateForURL:$a_url create:$a_should_create error:];
--			 ]"
--		end

	objc_set_delegate_ (an_item: POINTER; a_delegate: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSFileManager *)$an_item setDelegate:$a_delegate];
			 ]"
		end

	objc_delegate (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFileManager *)$an_item delegate];
			 ]"
		end

--	objc_set_attributes__of_item_at_path__error_ (an_item: POINTER; a_attributes: POINTER; a_path: POINTER; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return [(NSFileManager *)$an_item setAttributes:$a_attributes ofItemAtPath:$a_path error:];
--			 ]"
--		end

--	objc_create_directory_at_path__with_intermediate_directories__attributes__error_ (an_item: POINTER; a_path: POINTER; a_create_intermediates: BOOLEAN; a_attributes: POINTER; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return [(NSFileManager *)$an_item createDirectoryAtPath:$a_path withIntermediateDirectories:$a_create_intermediates attributes:$a_attributes error:];
--			 ]"
--		end

--	objc_contents_of_directory_at_path__error_ (an_item: POINTER; a_path: POINTER; a_error: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSFileManager *)$an_item contentsOfDirectoryAtPath:$a_path error:];
--			 ]"
--		end

--	objc_subpaths_of_directory_at_path__error_ (an_item: POINTER; a_path: POINTER; a_error: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSFileManager *)$an_item subpathsOfDirectoryAtPath:$a_path error:];
--			 ]"
--		end

--	objc_attributes_of_item_at_path__error_ (an_item: POINTER; a_path: POINTER; a_error: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSFileManager *)$an_item attributesOfItemAtPath:$a_path error:];
--			 ]"
--		end

--	objc_attributes_of_file_system_for_path__error_ (an_item: POINTER; a_path: POINTER; a_error: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSFileManager *)$an_item attributesOfFileSystemForPath:$a_path error:];
--			 ]"
--		end

--	objc_create_symbolic_link_at_path__with_destination_path__error_ (an_item: POINTER; a_path: POINTER; a_dest_path: POINTER; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return [(NSFileManager *)$an_item createSymbolicLinkAtPath:$a_path withDestinationPath:$a_dest_path error:];
--			 ]"
--		end

--	objc_destination_of_symbolic_link_at_path__error_ (an_item: POINTER; a_path: POINTER; a_error: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSFileManager *)$an_item destinationOfSymbolicLinkAtPath:$a_path error:];
--			 ]"
--		end

--	objc_copy_item_at_path__to_path__error_ (an_item: POINTER; a_src_path: POINTER; a_dst_path: POINTER; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return [(NSFileManager *)$an_item copyItemAtPath:$a_src_path toPath:$a_dst_path error:];
--			 ]"
--		end

--	objc_move_item_at_path__to_path__error_ (an_item: POINTER; a_src_path: POINTER; a_dst_path: POINTER; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return [(NSFileManager *)$an_item moveItemAtPath:$a_src_path toPath:$a_dst_path error:];
--			 ]"
--		end

--	objc_link_item_at_path__to_path__error_ (an_item: POINTER; a_src_path: POINTER; a_dst_path: POINTER; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return [(NSFileManager *)$an_item linkItemAtPath:$a_src_path toPath:$a_dst_path error:];
--			 ]"
--		end

--	objc_remove_item_at_path__error_ (an_item: POINTER; a_path: POINTER; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return [(NSFileManager *)$an_item removeItemAtPath:$a_path error:];
--			 ]"
--		end

--	objc_copy_item_at_ur_l__to_ur_l__error_ (an_item: POINTER; a_src_url: POINTER; a_dst_url: POINTER; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return [(NSFileManager *)$an_item copyItemAtURL:$a_src_url toURL:$a_dst_url error:];
--			 ]"
--		end

--	objc_move_item_at_ur_l__to_ur_l__error_ (an_item: POINTER; a_src_url: POINTER; a_dst_url: POINTER; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return [(NSFileManager *)$an_item moveItemAtURL:$a_src_url toURL:$a_dst_url error:];
--			 ]"
--		end

--	objc_link_item_at_ur_l__to_ur_l__error_ (an_item: POINTER; a_src_url: POINTER; a_dst_url: POINTER; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return [(NSFileManager *)$an_item linkItemAtURL:$a_src_url toURL:$a_dst_url error:];
--			 ]"
--		end

--	objc_remove_item_at_ur_l__error_ (an_item: POINTER; a_url: POINTER; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return [(NSFileManager *)$an_item removeItemAtURL:$a_url error:];
--			 ]"
--		end

	objc_current_directory_path (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFileManager *)$an_item currentDirectoryPath];
			 ]"
		end

	objc_change_current_directory_path_ (an_item: POINTER; a_path: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSFileManager *)$an_item changeCurrentDirectoryPath:$a_path];
			 ]"
		end

	objc_file_exists_at_path_ (an_item: POINTER; a_path: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSFileManager *)$an_item fileExistsAtPath:$a_path];
			 ]"
		end

--	objc_file_exists_at_path__is_directory_ (an_item: POINTER; a_path: POINTER; a_is_directory: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return [(NSFileManager *)$an_item fileExistsAtPath:$a_path isDirectory:];
--			 ]"
--		end

	objc_is_readable_file_at_path_ (an_item: POINTER; a_path: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSFileManager *)$an_item isReadableFileAtPath:$a_path];
			 ]"
		end

	objc_is_writable_file_at_path_ (an_item: POINTER; a_path: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSFileManager *)$an_item isWritableFileAtPath:$a_path];
			 ]"
		end

	objc_is_executable_file_at_path_ (an_item: POINTER; a_path: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSFileManager *)$an_item isExecutableFileAtPath:$a_path];
			 ]"
		end

	objc_is_deletable_file_at_path_ (an_item: POINTER; a_path: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSFileManager *)$an_item isDeletableFileAtPath:$a_path];
			 ]"
		end

	objc_contents_equal_at_path__and_path_ (an_item: POINTER; a_path1: POINTER; a_path2: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSFileManager *)$an_item contentsEqualAtPath:$a_path1 andPath:$a_path2];
			 ]"
		end

	objc_display_name_at_path_ (an_item: POINTER; a_path: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFileManager *)$an_item displayNameAtPath:$a_path];
			 ]"
		end

	objc_components_to_display_for_path_ (an_item: POINTER; a_path: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFileManager *)$an_item componentsToDisplayForPath:$a_path];
			 ]"
		end

	objc_enumerator_at_path_ (an_item: POINTER; a_path: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFileManager *)$an_item enumeratorAtPath:$a_path];
			 ]"
		end

--	objc_enumerator_at_ur_l__including_properties_for_keys__options__error_handler_ (an_item: POINTER; a_url: POINTER; a_keys: POINTER; a_mask: NATURAL_64; a_handler: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSFileManager *)$an_item enumeratorAtURL:$a_url includingPropertiesForKeys:$a_keys options:$a_mask errorHandler:];
--			 ]"
--		end

	objc_subpaths_at_path_ (an_item: POINTER; a_path: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFileManager *)$an_item subpathsAtPath:$a_path];
			 ]"
		end

	objc_contents_at_path_ (an_item: POINTER; a_path: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFileManager *)$an_item contentsAtPath:$a_path];
			 ]"
		end

	objc_create_file_at_path__contents__attributes_ (an_item: POINTER; a_path: POINTER; a_data: POINTER; a_attr: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSFileManager *)$an_item createFileAtPath:$a_path contents:$a_data attributes:$a_attr];
			 ]"
		end

--	objc_file_system_representation_with_path_ (an_item: POINTER; a_path: POINTER): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSFileManager *)$an_item fileSystemRepresentationWithPath:$a_path];
--			 ]"
--		end

--	objc_string_with_file_system_representation__length_ (an_item: POINTER; a_str: POINTER; a_len: NATURAL_64): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSFileManager *)$an_item stringWithFileSystemRepresentation:$a_str length:$a_len];
--			 ]"
--		end

--	objc_replace_item_at_ur_l__with_item_at_ur_l__backup_item_name__options__resulting_item_ur_l__error_ (an_item: POINTER; a_original_item_url: POINTER; a_new_item_url: POINTER; a_backup_item_name: POINTER; a_options: NATURAL_64; a_resulting_url: UNSUPPORTED_TYPE; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return [(NSFileManager *)$an_item replaceItemAtURL:$a_original_item_url withItemAtURL:$a_new_item_url backupItemName:$a_backup_item_name options:$a_options resultingItemURL: error:];
--			 ]"
--		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSFileManager"
		end

end
