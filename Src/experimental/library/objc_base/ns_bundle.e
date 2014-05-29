note
	description: "An NS_BUNDLE object represents a location in the file system that groups code and resources that can be used in a program."
	author: "Daniel Furrer <daniel.furrer@gmail.com>"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_BUNDLE

inherit
	NS_OBJECT

create
	bundle_for_class,
	bundle_with_identifier,
	bundle_with_path,
	main_bundle
create {NS_OBJECT}
	make_from_pointer,
	share_from_pointer

feature -- Initializing an NSBundle

	init_with_path (a_path: NS_STRING_BASE): NS_OBJECT
			-- Returns an `NSBundle' object initialized to correspond to the specified directory.
		do
			create Result.share_from_pointer ({NS_BUNDLE_API}.init_with_path (item, a_path.item))
		end

feature -- Getting an NSBundle

	bundle_for_class (a_class: POINTER)
			-- Returns the `NSBundle' object with which the specified class is associated.
		do
			make_from_pointer ({NS_BUNDLE_API}.bundle_for_class (a_class.item))
		end

	bundle_with_identifier (a_identifier: NS_STRING_BASE)
			-- Returns the previously created `NSBundle' instance that has the specified bundle identifier.
		do
			make_from_pointer ({NS_BUNDLE_API}.bundle_with_identifier (a_identifier.item))
		end

	bundle_with_path (a_path: NS_STRING_BASE)
			-- Returns an `NSBundle' object that corresponds to the specified directory.
		do
			make_from_pointer ({NS_BUNDLE_API}.bundle_with_path (a_path.item))
		end

	main_bundle
			-- Returns the `NSBundle' object that corresponds to the directory where the current application executable is located.
		do
			make_from_pointer ({NS_BUNDLE_API}.main_bundle)
		end

	all_bundles: NS_ARRAY [NS_BUNDLE]
			-- Returns an array of all the application`s non-framework bundles.
		do
			create Result.share_from_pointer ({NS_BUNDLE_API}.all_bundles)
		end

	all_frameworks: NS_ARRAY [NS_BUNDLE]
			-- Returns an array of all of the application`s bundles that represent frameworks.
		do
			create Result.share_from_pointer ({NS_BUNDLE_API}.all_frameworks)
		end

feature -- Getting a Bundled Class

	class_named (a_class_name: NS_STRING_BASE): OBJC_CLASS
			-- Returns the `Class' object for the specified name.
		do
			create Result.make_from_pointer ({NS_BUNDLE_API}.class_named (item, a_class_name.item))
		end

	principal_class: OBJC_CLASS
			-- Returns the receiver`s principal class.
		do
			create Result.make_from_pointer ({NS_BUNDLE_API}.principal_class (item))
		end

feature -- Finding a Resource

	path_for_resource_of_type_in_directory (a_name: NS_STRING_BASE; a_ext: NS_STRING_BASE; a_subpath: NS_STRING_BASE): NS_STRING_BASE
			-- Returns the full pathname for the resource file identified by the specified name and extension and residing in a given bundle directory.
		do
			create Result.share_from_pointer ({NS_BUNDLE_API}.path_for_resource_of_type_in_directory (item, a_name.item, a_ext.item, a_subpath.item))
		end

	path_for_resource_of_type (a_name: NS_STRING_BASE; a_ext: NS_STRING_BASE): NS_STRING_BASE
			-- Returns the full pathname for the resource identified by the specified name and file extension.
		do
			create Result.share_from_pointer ({NS_BUNDLE_API}.path_for_resource_of_type (item, a_name.item, a_ext.item))
		end
-- Error generating pathForResource:ofType:inDirectory:: Message signature for feature not set

	path_for_resource_of_type_in_directory_for_localization (a_name: NS_STRING_BASE; a_ext: NS_STRING_BASE; a_subpath: NS_STRING_BASE; a_localization_name: NS_STRING_BASE): NS_STRING_BASE
			-- Returns the full pathname for the resource identified by the specified name and file extension, located in the specified bundle subdirectory, and limited to global resources and those associated with the specified localization.
		do
			create Result.share_from_pointer ({NS_BUNDLE_API}.path_for_resource_of_type_in_directory_for_localization (item, a_name.item, a_ext.item, a_subpath.item, a_localization_name.item))
		end

	paths_for_resources_of_type_in_directory (a_ext: NS_STRING_BASE; a_subpath: NS_STRING_BASE): NS_ARRAY [NS_STRING_BASE]
			-- Returns an array containing the pathnames for all bundle resources having the specified extension and residing in the bundle directory at the specified path.
		do
			create Result.share_from_pointer ({NS_BUNDLE_API}.paths_for_resources_of_type_in_directory (item, a_ext.item, a_subpath.item))
		end
-- Error generating pathsForResourcesOfType:inDirectory:: Message signature for feature not set

	paths_for_resources_of_type_in_directory_for_localization (a_ext: NS_STRING_BASE; a_subpath: NS_STRING_BASE; a_localization_name: NS_STRING_BASE): NS_ARRAY [NS_STRING_BASE]
			-- Returns an array containing the pathnames for all bundle resources having the specified filename extension, residing in the specified resource subdirectory, and limited to global resources and those associated with the specified localization.
		do
			create Result.share_from_pointer ({NS_BUNDLE_API}.paths_for_resources_of_type_in_directory_for_localization (item, a_ext.item, a_subpath.item, a_localization_name.item))
		end

	resource_path: NS_STRING_BASE
			-- Returns the full pathname of the receiving bundle`s subdirectory containing resources.
		do
			create Result.share_from_pointer ({NS_BUNDLE_API}.resource_path (item))
		end

feature -- Getting the Bundle Directory

	bundle_path: NS_STRING_BASE
			-- Returns the full pathname of the receiver`s bundle directory.
		do
			create Result.share_from_pointer ({NS_BUNDLE_API}.bundle_path (item))
		end

feature -- Getting Bundle Information

	built_in_plug_ins_path: NS_STRING_BASE
			-- Returns the full pathname of the receiver`s subdirectory containing plug-ins.
		do
			create Result.share_from_pointer ({NS_BUNDLE_API}.built_in_plug_ins_path (item))
		end

	bundle_identifier: NS_STRING_BASE
			-- Returns the receiver`s bundle identifier.
		do
			create Result.share_from_pointer ({NS_BUNDLE_API}.bundle_identifier (item))
		end

	executable_path: NS_STRING_BASE
			-- Returns the full pathname of the receiver`s executable file.
		do
			create Result.share_from_pointer ({NS_BUNDLE_API}.executable_path (item))
		end

	info_dictionary: NS_DICTIONARY
			-- Returns a dictionary that contains information about the receiver.
		do
			create Result.share_from_pointer ({NS_BUNDLE_API}.info_dictionary (item))
		end

	object_for_info_dictionary_key (a_key: NS_STRING_BASE): NS_OBJECT
			-- Returns the value associated with the specified key in the receiver`s information property list.
		do
			create Result.share_from_pointer ({NS_BUNDLE_API}.object_for_info_dictionary_key (item, a_key.item))
		end

	path_for_auxiliary_executable (a_executable_name: NS_STRING_BASE): NS_STRING_BASE
			-- Returns the full pathname of the executable with the specified name in the receiver`s bundle.
		do
			create Result.share_from_pointer ({NS_BUNDLE_API}.path_for_auxiliary_executable (item, a_executable_name.item))
		end

	private_frameworks_path: NS_STRING_BASE
			-- Returns the full pathname of the receiver`s subdirectory containing private frameworks.
		do
			create Result.share_from_pointer ({NS_BUNDLE_API}.private_frameworks_path (item))
		end

	shared_frameworks_path: NS_STRING_BASE
			-- Returns the full pathname of the receiver`s subdirectory containing shared frameworks.
		do
			create Result.share_from_pointer ({NS_BUNDLE_API}.shared_frameworks_path (item))
		end

	shared_support_path: NS_STRING_BASE
			-- Returns the full pathname of the receiver`s subdirectory containing shared support files.
		do
			create Result.share_from_pointer ({NS_BUNDLE_API}.shared_support_path (item))
		end

feature -- Managing Localized Resources

	localized_string_for_key_value_table (a_key: NS_STRING_BASE; a_value: NS_STRING_BASE; a_table_name: NS_STRING_BASE): NS_STRING_BASE
			-- Returns a localized version of the string designated by the specified key and residing in the specified table.
		do
			create Result.share_from_pointer ({NS_BUNDLE_API}.localized_string_for_key_value_table (item, a_key.item, a_value.item, a_table_name.item))
		end

feature -- Loading a Bundle`s Code

--	executable_architectures: NS_ARRAY [NS_NUMBER]
--			-- Returns an array of numbers indicating the architecture types supported by the bundle`s executable.
--		do
--			create Result.share_from_pointer ({NS_BUNDLE_API}.executable_architectures (item))
--		end

--	preflight_and_return_error (a_error: POINTER[NS_ERROR]): BOOLEAN
--			-- Returns a Boolean value indicating whether the bundle`s executable code could be loaded successfully.
--		do
--			Result := {NS_BUNDLE_API}.preflight_and_return_error (item, a_error.item)
--		end

	load: BOOLEAN
			-- Dynamically loads the bundle`s executable code into a running program, if the code has not already been loaded.
		do
			Result := {NS_BUNDLE_API}.load (item)
		end

--	load_and_return_error (a_error: POINTER[NS_ERROR]): BOOLEAN
--			-- Loads the bundle`s executable code and returns any errors.
--		do
--			Result := {NS_BUNDLE_API}.load_and_return_error (item, a_error.item)
--		end

	is_loaded: BOOLEAN
			-- Obtains information about the load status of a bundle.
		do
			Result := {NS_BUNDLE_API}.is_loaded (item)
		end

	unload: BOOLEAN
			-- Unloads the code associated with the receiver.
		do
			Result := {NS_BUNDLE_API}.unload (item)
		end

feature -- Managing Localizations

	preferred_localizations_from_array (a_localizations_array: NS_ARRAY [NS_STRING_BASE]): NS_ARRAY [NS_STRING_BASE]
			-- Returns one or more localizations from the specified list that a bundle object would use to locate resources for the current user.
		do
			create Result.share_from_pointer ({NS_BUNDLE_API}.preferred_localizations_from_array (a_localizations_array.object_item))
		end

	preferred_localizations_from_array_for_preferences (a_localizations_array: NS_ARRAY [NS_STRING_BASE]; a_preferences_array: NS_ARRAY [NS_STRING_BASE]): NS_ARRAY [NS_STRING_BASE]
			-- Returns the localizations that a bundle object would prefer, given the specified bundle and user preference localizations.
		do
			create Result.share_from_pointer ({NS_BUNDLE_API}.preferred_localizations_from_array_for_preferences (a_localizations_array.object_item, a_preferences_array.object_item))
		end

	localizations: NS_ARRAY [NS_STRING_BASE]
			-- Returns a list of all the localizations contained within the receiver`s bundle.
		do
			create Result.share_from_pointer ({NS_BUNDLE_API}.localizations (item))
		end

	development_localization: NS_STRING_BASE
			-- Returns the localization used to create the bundle.
		do
			create Result.share_from_pointer ({NS_BUNDLE_API}.development_localization (item))
		end

	preferred_localizations: NS_ARRAY [NS_STRING_BASE]
			-- Returns an array of strings indicating the actual localizations contained in the receiver`s bundle.
		do
			create Result.share_from_pointer ({NS_BUNDLE_API}.preferred_localizations (item))
		end

	localized_info_dictionary: NS_DICTIONARY
			-- Returns a dictionary with the keys from the bundle`s localized property list.
		do
			create Result.share_from_pointer ({NS_BUNDLE_API}.localized_info_dictionary (item))
		end

note
	copyright: "Copyright (c) 1984-2014, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
