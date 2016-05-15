note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_BUNDLE

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_path_,
	make_with_ur_l_,
	make

feature {NONE} -- Initialization

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

	make_with_ur_l_ (a_url: detachable NS_URL)
			-- Initialize `Current'.
		local
			a_url__item: POINTER
		do
			if attached a_url as a_url_attached then
				a_url__item := a_url_attached.item
			end
			make_with_pointer (objc_init_with_ur_l_(allocate_object, a_url__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSBundle Externals

	objc_init_with_path_ (an_item: POINTER; a_path: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSBundle *)$an_item initWithPath:$a_path];
			 ]"
		end

	objc_init_with_ur_l_ (an_item: POINTER; a_url: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSBundle *)$an_item initWithURL:$a_url];
			 ]"
		end

	objc_load (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSBundle *)$an_item load];
			 ]"
		end

	objc_is_loaded (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSBundle *)$an_item isLoaded];
			 ]"
		end

	objc_unload (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSBundle *)$an_item unload];
			 ]"
		end

--	objc_preflight_and_return_error_ (an_item: POINTER; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return [(NSBundle *)$an_item preflightAndReturnError:];
--			 ]"
--		end

--	objc_load_and_return_error_ (an_item: POINTER; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return [(NSBundle *)$an_item loadAndReturnError:];
--			 ]"
--		end

	objc_bundle_url (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSBundle *)$an_item bundleURL];
			 ]"
		end

	objc_resource_url (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSBundle *)$an_item resourceURL];
			 ]"
		end

	objc_executable_url (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSBundle *)$an_item executableURL];
			 ]"
		end

	objc_url_for_auxiliary_executable_ (an_item: POINTER; a_executable_name: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSBundle *)$an_item URLForAuxiliaryExecutable:$a_executable_name];
			 ]"
		end

	objc_private_frameworks_url (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSBundle *)$an_item privateFrameworksURL];
			 ]"
		end

	objc_shared_frameworks_url (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSBundle *)$an_item sharedFrameworksURL];
			 ]"
		end

	objc_shared_support_url (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSBundle *)$an_item sharedSupportURL];
			 ]"
		end

	objc_built_in_plug_ins_url (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSBundle *)$an_item builtInPlugInsURL];
			 ]"
		end

	objc_bundle_path (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSBundle *)$an_item bundlePath];
			 ]"
		end

	objc_resource_path (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSBundle *)$an_item resourcePath];
			 ]"
		end

	objc_executable_path (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSBundle *)$an_item executablePath];
			 ]"
		end

	objc_path_for_auxiliary_executable_ (an_item: POINTER; a_executable_name: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSBundle *)$an_item pathForAuxiliaryExecutable:$a_executable_name];
			 ]"
		end

	objc_private_frameworks_path (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSBundle *)$an_item privateFrameworksPath];
			 ]"
		end

	objc_shared_frameworks_path (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSBundle *)$an_item sharedFrameworksPath];
			 ]"
		end

	objc_shared_support_path (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSBundle *)$an_item sharedSupportPath];
			 ]"
		end

	objc_built_in_plug_ins_path (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSBundle *)$an_item builtInPlugInsPath];
			 ]"
		end

	objc_url_for_resource__with_extension_ (an_item: POINTER; a_name: POINTER; a_ext: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSBundle *)$an_item URLForResource:$a_name withExtension:$a_ext];
			 ]"
		end

	objc_url_for_resource__with_extension__subdirectory_ (an_item: POINTER; a_name: POINTER; a_ext: POINTER; a_subpath: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSBundle *)$an_item URLForResource:$a_name withExtension:$a_ext subdirectory:$a_subpath];
			 ]"
		end

	objc_url_for_resource__with_extension__subdirectory__localization_ (an_item: POINTER; a_name: POINTER; a_ext: POINTER; a_subpath: POINTER; a_localization_name: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSBundle *)$an_item URLForResource:$a_name withExtension:$a_ext subdirectory:$a_subpath localization:$a_localization_name];
			 ]"
		end

	objc_ur_ls_for_resources_with_extension__subdirectory_ (an_item: POINTER; a_ext: POINTER; a_subpath: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSBundle *)$an_item URLsForResourcesWithExtension:$a_ext subdirectory:$a_subpath];
			 ]"
		end

	objc_ur_ls_for_resources_with_extension__subdirectory__localization_ (an_item: POINTER; a_ext: POINTER; a_subpath: POINTER; a_localization_name: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSBundle *)$an_item URLsForResourcesWithExtension:$a_ext subdirectory:$a_subpath localization:$a_localization_name];
			 ]"
		end

	objc_path_for_resource__of_type_ (an_item: POINTER; a_name: POINTER; a_ext: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSBundle *)$an_item pathForResource:$a_name ofType:$a_ext];
			 ]"
		end

	objc_path_for_resource__of_type__in_directory__for_localization_ (an_item: POINTER; a_name: POINTER; a_ext: POINTER; a_subpath: POINTER; a_localization_name: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSBundle *)$an_item pathForResource:$a_name ofType:$a_ext inDirectory:$a_subpath forLocalization:$a_localization_name];
			 ]"
		end

	objc_paths_for_resources_of_type__in_directory__for_localization_ (an_item: POINTER; a_ext: POINTER; a_subpath: POINTER; a_localization_name: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSBundle *)$an_item pathsForResourcesOfType:$a_ext inDirectory:$a_subpath forLocalization:$a_localization_name];
			 ]"
		end

	objc_localized_string_for_key__value__table_ (an_item: POINTER; a_key: POINTER; a_value: POINTER; a_table_name: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSBundle *)$an_item localizedStringForKey:$a_key value:$a_value table:$a_table_name];
			 ]"
		end

	objc_bundle_identifier (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSBundle *)$an_item bundleIdentifier];
			 ]"
		end

	objc_info_dictionary (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSBundle *)$an_item infoDictionary];
			 ]"
		end

	objc_localized_info_dictionary (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSBundle *)$an_item localizedInfoDictionary];
			 ]"
		end

	objc_object_for_info_dictionary_key_ (an_item: POINTER; a_key: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSBundle *)$an_item objectForInfoDictionaryKey:$a_key];
			 ]"
		end

	objc_class_named_ (an_item: POINTER; a_class_name: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSBundle *)$an_item classNamed:$a_class_name];
			 ]"
		end

	objc_principal_class (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSBundle *)$an_item principalClass];
			 ]"
		end

	objc_localizations (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSBundle *)$an_item localizations];
			 ]"
		end

	objc_preferred_localizations (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSBundle *)$an_item preferredLocalizations];
			 ]"
		end

	objc_development_localization (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSBundle *)$an_item developmentLocalization];
			 ]"
		end

	objc_executable_architectures (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSBundle *)$an_item executableArchitectures];
			 ]"
		end

feature -- NSBundle

	load: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_load (item)
		end

	is_loaded: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_loaded (item)
		end

	unload: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_unload (item)
		end

--	preflight_and_return_error_ (a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_error__item: POINTER
--		do
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			Result := objc_preflight_and_return_error_ (item, a_error__item)
--		end

--	load_and_return_error_ (a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_error__item: POINTER
--		do
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			Result := objc_load_and_return_error_ (item, a_error__item)
--		end

	bundle_url: detachable NS_URL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_bundle_url (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like bundle_url} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like bundle_url} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	resource_url: detachable NS_URL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_resource_url (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like resource_url} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like resource_url} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	executable_url: detachable NS_URL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_executable_url (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like executable_url} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like executable_url} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	url_for_auxiliary_executable_ (a_executable_name: detachable NS_STRING): detachable NS_URL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_executable_name__item: POINTER
		do
			if attached a_executable_name as a_executable_name_attached then
				a_executable_name__item := a_executable_name_attached.item
			end
			result_pointer := objc_url_for_auxiliary_executable_ (item, a_executable_name__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like url_for_auxiliary_executable_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like url_for_auxiliary_executable_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	private_frameworks_url: detachable NS_URL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_private_frameworks_url (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like private_frameworks_url} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like private_frameworks_url} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	shared_frameworks_url: detachable NS_URL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_shared_frameworks_url (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like shared_frameworks_url} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like shared_frameworks_url} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	shared_support_url: detachable NS_URL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_shared_support_url (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like shared_support_url} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like shared_support_url} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	built_in_plug_ins_url: detachable NS_URL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_built_in_plug_ins_url (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like built_in_plug_ins_url} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like built_in_plug_ins_url} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	bundle_path: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_bundle_path (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like bundle_path} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like bundle_path} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	resource_path: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_resource_path (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like resource_path} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like resource_path} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	executable_path: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_executable_path (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like executable_path} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like executable_path} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	path_for_auxiliary_executable_ (a_executable_name: detachable NS_STRING): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_executable_name__item: POINTER
		do
			if attached a_executable_name as a_executable_name_attached then
				a_executable_name__item := a_executable_name_attached.item
			end
			result_pointer := objc_path_for_auxiliary_executable_ (item, a_executable_name__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like path_for_auxiliary_executable_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like path_for_auxiliary_executable_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	private_frameworks_path: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_private_frameworks_path (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like private_frameworks_path} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like private_frameworks_path} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	shared_frameworks_path: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_shared_frameworks_path (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like shared_frameworks_path} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like shared_frameworks_path} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	shared_support_path: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_shared_support_path (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like shared_support_path} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like shared_support_path} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	built_in_plug_ins_path: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_built_in_plug_ins_path (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like built_in_plug_ins_path} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like built_in_plug_ins_path} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	url_for_resource__with_extension_ (a_name: detachable NS_STRING; a_ext: detachable NS_STRING): detachable NS_URL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_name__item: POINTER
			a_ext__item: POINTER
		do
			if attached a_name as a_name_attached then
				a_name__item := a_name_attached.item
			end
			if attached a_ext as a_ext_attached then
				a_ext__item := a_ext_attached.item
			end
			result_pointer := objc_url_for_resource__with_extension_ (item, a_name__item, a_ext__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like url_for_resource__with_extension_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like url_for_resource__with_extension_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	url_for_resource__with_extension__subdirectory_ (a_name: detachable NS_STRING; a_ext: detachable NS_STRING; a_subpath: detachable NS_STRING): detachable NS_URL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_name__item: POINTER
			a_ext__item: POINTER
			a_subpath__item: POINTER
		do
			if attached a_name as a_name_attached then
				a_name__item := a_name_attached.item
			end
			if attached a_ext as a_ext_attached then
				a_ext__item := a_ext_attached.item
			end
			if attached a_subpath as a_subpath_attached then
				a_subpath__item := a_subpath_attached.item
			end
			result_pointer := objc_url_for_resource__with_extension__subdirectory_ (item, a_name__item, a_ext__item, a_subpath__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like url_for_resource__with_extension__subdirectory_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like url_for_resource__with_extension__subdirectory_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	url_for_resource__with_extension__subdirectory__localization_ (a_name: detachable NS_STRING; a_ext: detachable NS_STRING; a_subpath: detachable NS_STRING; a_localization_name: detachable NS_STRING): detachable NS_URL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_name__item: POINTER
			a_ext__item: POINTER
			a_subpath__item: POINTER
			a_localization_name__item: POINTER
		do
			if attached a_name as a_name_attached then
				a_name__item := a_name_attached.item
			end
			if attached a_ext as a_ext_attached then
				a_ext__item := a_ext_attached.item
			end
			if attached a_subpath as a_subpath_attached then
				a_subpath__item := a_subpath_attached.item
			end
			if attached a_localization_name as a_localization_name_attached then
				a_localization_name__item := a_localization_name_attached.item
			end
			result_pointer := objc_url_for_resource__with_extension__subdirectory__localization_ (item, a_name__item, a_ext__item, a_subpath__item, a_localization_name__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like url_for_resource__with_extension__subdirectory__localization_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like url_for_resource__with_extension__subdirectory__localization_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	ur_ls_for_resources_with_extension__subdirectory_ (a_ext: detachable NS_STRING; a_subpath: detachable NS_STRING): detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_ext__item: POINTER
			a_subpath__item: POINTER
		do
			if attached a_ext as a_ext_attached then
				a_ext__item := a_ext_attached.item
			end
			if attached a_subpath as a_subpath_attached then
				a_subpath__item := a_subpath_attached.item
			end
			result_pointer := objc_ur_ls_for_resources_with_extension__subdirectory_ (item, a_ext__item, a_subpath__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like ur_ls_for_resources_with_extension__subdirectory_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like ur_ls_for_resources_with_extension__subdirectory_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	ur_ls_for_resources_with_extension__subdirectory__localization_ (a_ext: detachable NS_STRING; a_subpath: detachable NS_STRING; a_localization_name: detachable NS_STRING): detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_ext__item: POINTER
			a_subpath__item: POINTER
			a_localization_name__item: POINTER
		do
			if attached a_ext as a_ext_attached then
				a_ext__item := a_ext_attached.item
			end
			if attached a_subpath as a_subpath_attached then
				a_subpath__item := a_subpath_attached.item
			end
			if attached a_localization_name as a_localization_name_attached then
				a_localization_name__item := a_localization_name_attached.item
			end
			result_pointer := objc_ur_ls_for_resources_with_extension__subdirectory__localization_ (item, a_ext__item, a_subpath__item, a_localization_name__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like ur_ls_for_resources_with_extension__subdirectory__localization_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like ur_ls_for_resources_with_extension__subdirectory__localization_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	path_for_resource__of_type_ (a_name: detachable NS_STRING; a_ext: detachable NS_STRING): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_name__item: POINTER
			a_ext__item: POINTER
		do
			if attached a_name as a_name_attached then
				a_name__item := a_name_attached.item
			end
			if attached a_ext as a_ext_attached then
				a_ext__item := a_ext_attached.item
			end
			result_pointer := objc_path_for_resource__of_type_ (item, a_name__item, a_ext__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like path_for_resource__of_type_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like path_for_resource__of_type_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	path_for_resource__of_type__in_directory__for_localization_ (a_name: detachable NS_STRING; a_ext: detachable NS_STRING; a_subpath: detachable NS_STRING; a_localization_name: detachable NS_STRING): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_name__item: POINTER
			a_ext__item: POINTER
			a_subpath__item: POINTER
			a_localization_name__item: POINTER
		do
			if attached a_name as a_name_attached then
				a_name__item := a_name_attached.item
			end
			if attached a_ext as a_ext_attached then
				a_ext__item := a_ext_attached.item
			end
			if attached a_subpath as a_subpath_attached then
				a_subpath__item := a_subpath_attached.item
			end
			if attached a_localization_name as a_localization_name_attached then
				a_localization_name__item := a_localization_name_attached.item
			end
			result_pointer := objc_path_for_resource__of_type__in_directory__for_localization_ (item, a_name__item, a_ext__item, a_subpath__item, a_localization_name__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like path_for_resource__of_type__in_directory__for_localization_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like path_for_resource__of_type__in_directory__for_localization_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	paths_for_resources_of_type__in_directory__for_localization_ (a_ext: detachable NS_STRING; a_subpath: detachable NS_STRING; a_localization_name: detachable NS_STRING): detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_ext__item: POINTER
			a_subpath__item: POINTER
			a_localization_name__item: POINTER
		do
			if attached a_ext as a_ext_attached then
				a_ext__item := a_ext_attached.item
			end
			if attached a_subpath as a_subpath_attached then
				a_subpath__item := a_subpath_attached.item
			end
			if attached a_localization_name as a_localization_name_attached then
				a_localization_name__item := a_localization_name_attached.item
			end
			result_pointer := objc_paths_for_resources_of_type__in_directory__for_localization_ (item, a_ext__item, a_subpath__item, a_localization_name__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like paths_for_resources_of_type__in_directory__for_localization_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like paths_for_resources_of_type__in_directory__for_localization_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	localized_string_for_key__value__table_ (a_key: detachable NS_STRING; a_value: detachable NS_STRING; a_table_name: detachable NS_STRING): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_key__item: POINTER
			a_value__item: POINTER
			a_table_name__item: POINTER
		do
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			if attached a_value as a_value_attached then
				a_value__item := a_value_attached.item
			end
			if attached a_table_name as a_table_name_attached then
				a_table_name__item := a_table_name_attached.item
			end
			result_pointer := objc_localized_string_for_key__value__table_ (item, a_key__item, a_value__item, a_table_name__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like localized_string_for_key__value__table_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like localized_string_for_key__value__table_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	bundle_identifier: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_bundle_identifier (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like bundle_identifier} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like bundle_identifier} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	info_dictionary: detachable NS_DICTIONARY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_info_dictionary (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like info_dictionary} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like info_dictionary} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	localized_info_dictionary: detachable NS_DICTIONARY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_localized_info_dictionary (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like localized_info_dictionary} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like localized_info_dictionary} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	object_for_info_dictionary_key_ (a_key: detachable NS_STRING): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_key__item: POINTER
		do
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			result_pointer := objc_object_for_info_dictionary_key_ (item, a_key__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like object_for_info_dictionary_key_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like object_for_info_dictionary_key_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	class_named_ (a_class_name: detachable NS_STRING): detachable OBJC_CLASS
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_class_name__item: POINTER
		do
			if attached a_class_name as a_class_name_attached then
				a_class_name__item := a_class_name_attached.item
			end
			result_pointer := objc_class_named_ (item, a_class_name__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like class_named_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like class_named_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	principal_class: detachable OBJC_CLASS
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_principal_class (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like principal_class} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like principal_class} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	localizations: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_localizations (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like localizations} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like localizations} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	preferred_localizations: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_preferred_localizations (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like preferred_localizations} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like preferred_localizations} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	development_localization: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_development_localization (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like development_localization} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like development_localization} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	executable_architectures: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_executable_architectures (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like executable_architectures} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like executable_architectures} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSBundle"
		end

end
