note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_BUNDLE_UTILS

inherit
	NS_OBJECT_UTILS
		redefine
			wrapper_objc_class_name,
			is_subclass_instance
		end


feature -- NSBundle

	main_bundle: detachable NS_BUNDLE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_main_bundle (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like main_bundle} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like main_bundle} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	bundle_with_path_ (a_path: detachable NS_STRING): detachable NS_BUNDLE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_path__item: POINTER
		do
			if attached a_path as a_path_attached then
				a_path__item := a_path_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_bundle_with_path_ (l_objc_class.item, a_path__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like bundle_with_path_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like bundle_with_path_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	bundle_with_ur_l_ (a_url: detachable NS_URL): detachable NS_BUNDLE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_url__item: POINTER
		do
			if attached a_url as a_url_attached then
				a_url__item := a_url_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_bundle_with_ur_l_ (l_objc_class.item, a_url__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like bundle_with_ur_l_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like bundle_with_ur_l_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	bundle_for_class_ (a_class: detachable OBJC_CLASS): detachable NS_BUNDLE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_class__item: POINTER
		do
			if attached a_class as a_class_attached then
				a_class__item := a_class_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_bundle_for_class_ (l_objc_class.item, a_class__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like bundle_for_class_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like bundle_for_class_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	bundle_with_identifier_ (a_identifier: detachable NS_STRING): detachable NS_BUNDLE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_identifier__item: POINTER
		do
			if attached a_identifier as a_identifier_attached then
				a_identifier__item := a_identifier_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_bundle_with_identifier_ (l_objc_class.item, a_identifier__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like bundle_with_identifier_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like bundle_with_identifier_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	all_bundles: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_all_bundles (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like all_bundles} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like all_bundles} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	all_frameworks: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_all_frameworks (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like all_frameworks} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like all_frameworks} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	url_for_resource__with_extension__subdirectory__in_bundle_with_ur_l_ (a_name: detachable NS_STRING; a_ext: detachable NS_STRING; a_subpath: detachable NS_STRING; a_bundle_url: detachable NS_URL): detachable NS_URL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_name__item: POINTER
			a_ext__item: POINTER
			a_subpath__item: POINTER
			a_bundle_url__item: POINTER
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
			if attached a_bundle_url as a_bundle_url_attached then
				a_bundle_url__item := a_bundle_url_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_url_for_resource__with_extension__subdirectory__in_bundle_with_ur_l_ (l_objc_class.item, a_name__item, a_ext__item, a_subpath__item, a_bundle_url__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like url_for_resource__with_extension__subdirectory__in_bundle_with_ur_l_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like url_for_resource__with_extension__subdirectory__in_bundle_with_ur_l_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	ur_ls_for_resources_with_extension__subdirectory__in_bundle_with_ur_l_ (a_ext: detachable NS_STRING; a_subpath: detachable NS_STRING; a_bundle_url: detachable NS_URL): detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_ext__item: POINTER
			a_subpath__item: POINTER
			a_bundle_url__item: POINTER
		do
			if attached a_ext as a_ext_attached then
				a_ext__item := a_ext_attached.item
			end
			if attached a_subpath as a_subpath_attached then
				a_subpath__item := a_subpath_attached.item
			end
			if attached a_bundle_url as a_bundle_url_attached then
				a_bundle_url__item := a_bundle_url_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_ur_ls_for_resources_with_extension__subdirectory__in_bundle_with_ur_l_ (l_objc_class.item, a_ext__item, a_subpath__item, a_bundle_url__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like ur_ls_for_resources_with_extension__subdirectory__in_bundle_with_ur_l_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like ur_ls_for_resources_with_extension__subdirectory__in_bundle_with_ur_l_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	path_for_resource__of_type__in_directory_ (a_name: detachable NS_STRING; a_ext: detachable NS_STRING; a_bundle_path: detachable NS_STRING): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_name__item: POINTER
			a_ext__item: POINTER
			a_bundle_path__item: POINTER
		do
			if attached a_name as a_name_attached then
				a_name__item := a_name_attached.item
			end
			if attached a_ext as a_ext_attached then
				a_ext__item := a_ext_attached.item
			end
			if attached a_bundle_path as a_bundle_path_attached then
				a_bundle_path__item := a_bundle_path_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_path_for_resource__of_type__in_directory_ (l_objc_class.item, a_name__item, a_ext__item, a_bundle_path__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like path_for_resource__of_type__in_directory_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like path_for_resource__of_type__in_directory_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	paths_for_resources_of_type__in_directory_ (a_ext: detachable NS_STRING; a_bundle_path: detachable NS_STRING): detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_ext__item: POINTER
			a_bundle_path__item: POINTER
		do
			if attached a_ext as a_ext_attached then
				a_ext__item := a_ext_attached.item
			end
			if attached a_bundle_path as a_bundle_path_attached then
				a_bundle_path__item := a_bundle_path_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_paths_for_resources_of_type__in_directory_ (l_objc_class.item, a_ext__item, a_bundle_path__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like paths_for_resources_of_type__in_directory_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like paths_for_resources_of_type__in_directory_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	preferred_localizations_from_array_ (a_localizations_array: detachable NS_ARRAY): detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_localizations_array__item: POINTER
		do
			if attached a_localizations_array as a_localizations_array_attached then
				a_localizations_array__item := a_localizations_array_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_preferred_localizations_from_array_ (l_objc_class.item, a_localizations_array__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like preferred_localizations_from_array_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like preferred_localizations_from_array_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	preferred_localizations_from_array__for_preferences_ (a_localizations_array: detachable NS_ARRAY; a_preferences_array: detachable NS_ARRAY): detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_localizations_array__item: POINTER
			a_preferences_array__item: POINTER
		do
			if attached a_localizations_array as a_localizations_array_attached then
				a_localizations_array__item := a_localizations_array_attached.item
			end
			if attached a_preferences_array as a_preferences_array_attached then
				a_preferences_array__item := a_preferences_array_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_preferred_localizations_from_array__for_preferences_ (l_objc_class.item, a_localizations_array__item, a_preferences_array__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like preferred_localizations_from_array__for_preferences_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like preferred_localizations_from_array__for_preferences_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSBundle Externals

	objc_main_bundle (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object mainBundle];
			 ]"
		end

	objc_bundle_with_path_ (a_class_object: POINTER; a_path: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object bundleWithPath:$a_path];
			 ]"
		end

	objc_bundle_with_ur_l_ (a_class_object: POINTER; a_url: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object bundleWithURL:$a_url];
			 ]"
		end

	objc_bundle_for_class_ (a_class_object: POINTER; a_class: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object bundleForClass:$a_class];
			 ]"
		end

	objc_bundle_with_identifier_ (a_class_object: POINTER; a_identifier: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object bundleWithIdentifier:$a_identifier];
			 ]"
		end

	objc_all_bundles (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object allBundles];
			 ]"
		end

	objc_all_frameworks (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object allFrameworks];
			 ]"
		end

	objc_url_for_resource__with_extension__subdirectory__in_bundle_with_ur_l_ (a_class_object: POINTER; a_name: POINTER; a_ext: POINTER; a_subpath: POINTER; a_bundle_url: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object URLForResource:$a_name withExtension:$a_ext subdirectory:$a_subpath inBundleWithURL:$a_bundle_url];
			 ]"
		end

	objc_ur_ls_for_resources_with_extension__subdirectory__in_bundle_with_ur_l_ (a_class_object: POINTER; a_ext: POINTER; a_subpath: POINTER; a_bundle_url: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object URLsForResourcesWithExtension:$a_ext subdirectory:$a_subpath inBundleWithURL:$a_bundle_url];
			 ]"
		end

	objc_path_for_resource__of_type__in_directory_ (a_class_object: POINTER; a_name: POINTER; a_ext: POINTER; a_bundle_path: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object pathForResource:$a_name ofType:$a_ext inDirectory:$a_bundle_path];
			 ]"
		end

	objc_paths_for_resources_of_type__in_directory_ (a_class_object: POINTER; a_ext: POINTER; a_bundle_path: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object pathsForResourcesOfType:$a_ext inDirectory:$a_bundle_path];
			 ]"
		end

	objc_preferred_localizations_from_array_ (a_class_object: POINTER; a_localizations_array: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object preferredLocalizationsFromArray:$a_localizations_array];
			 ]"
		end

	objc_preferred_localizations_from_array__for_preferences_ (a_class_object: POINTER; a_localizations_array: POINTER; a_preferences_array: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object preferredLocalizationsFromArray:$a_localizations_array forPreferences:$a_preferences_array];
			 ]"
		end

feature -- NSNibLoading

--	load_nib_file__external_name_table__with_zone_ (a_file_name: detachable NS_STRING; a_context: detachable NS_DICTIONARY; a_zone: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			l_objc_class: OBJC_CLASS
--			a_file_name__item: POINTER
--			a_context__item: POINTER
--			a_zone__item: POINTER
--		do
--			if attached a_file_name as a_file_name_attached then
--				a_file_name__item := a_file_name_attached.item
--			end
--			if attached a_context as a_context_attached then
--				a_context__item := a_context_attached.item
--			end
--			if attached a_zone as a_zone_attached then
--				a_zone__item := a_zone_attached.item
--			end
--			create l_objc_class.make_with_name (get_class_name)
--			check l_objc_class_registered: l_objc_class.registered end
--			Result := objc_load_nib_file__external_name_table__with_zone_ (l_objc_class.item, a_file_name__item, a_context__item, a_zone__item)
--		end

	load_nib_named__owner_ (a_nib_name: detachable NS_STRING; a_owner: detachable NS_OBJECT): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
			a_nib_name__item: POINTER
			a_owner__item: POINTER
		do
			if attached a_nib_name as a_nib_name_attached then
				a_nib_name__item := a_nib_name_attached.item
			end
			if attached a_owner as a_owner_attached then
				a_owner__item := a_owner_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			Result := objc_load_nib_named__owner_ (l_objc_class.item, a_nib_name__item, a_owner__item)
		end

feature {NONE} -- NSNibLoading Externals

--	objc_load_nib_file__external_name_table__with_zone_ (a_class_object: POINTER; a_file_name: POINTER; a_context: POINTER; a_zone: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return [(Class)$a_class_object loadNibFile:$a_file_name externalNameTable:$a_context withZone:];
--			 ]"
--		end

	objc_load_nib_named__owner_ (a_class_object: POINTER; a_nib_name: POINTER; a_owner: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(Class)$a_class_object loadNibNamed:$a_nib_name owner:$a_owner];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSBundle"
		end

	is_subclass_instance: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

end
