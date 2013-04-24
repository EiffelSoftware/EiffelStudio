note
	description: "Low-level Objective-C for NSBundle"
	author: "Daniel Furrer <daniel.furrer@gmail.com>"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_BUNDLE_API

feature -- Initializing an NSBundle

	frozen init_with_path (a_ns_bundle: POINTER; a_path: POINTER): POINTER
			-- - (id)initWithPath: (NSString *) path
		external
			"C inline use <Foundation/NSBundle.h>"
		alias
			"return [(NSBundle*)$a_ns_bundle initWithPath: $a_path];"
		end

feature -- Getting an NSBundle

	frozen bundle_for_class (a_class: POINTER): POINTER
			-- + (NSBundle *)bundleForClass: (Class) aClass
		external
			"C inline use <Foundation/NSBundle.h>"
		alias
			"return [NSBundle bundleForClass: *(Class*)$a_class];"
		end

	frozen bundle_with_identifier (a_identifier: POINTER): POINTER
			-- + (NSBundle *)bundleWithIdentifier: (NSString *) identifier
		external
			"C inline use <Foundation/NSBundle.h>"
		alias
			"return [NSBundle bundleWithIdentifier: $a_identifier];"
		end

	frozen bundle_with_path (a_path: POINTER): POINTER
			-- + (NSBundle *)bundleWithPath: (NSString *) path
		external
			"C inline use <Foundation/NSBundle.h>"
		alias
			"return [NSBundle bundleWithPath: $a_path];"
		end

	frozen main_bundle : POINTER
			-- + (NSBundle *)mainBundle
		external
			"C inline use <Foundation/NSBundle.h>"
		alias
			"return [NSBundle mainBundle];"
		end

	frozen all_bundles : POINTER
			-- + (NSArray *)allBundles
		external
			"C inline use <Foundation/NSBundle.h>"
		alias
			"return [NSBundle allBundles];"
		end

	frozen all_frameworks : POINTER
			-- + (NSArray *)allFrameworks
		external
			"C inline use <Foundation/NSBundle.h>"
		alias
			"return [NSBundle allFrameworks];"
		end

feature -- Getting a Bundled Class

	frozen class_named (a_ns_bundle: POINTER; a_class_name: POINTER): POINTER
			-- - (Class)classNamed: (NSString *) className
		external
			"C inline use <Foundation/NSBundle.h>"
		alias
			"return [(NSBundle*)$a_ns_bundle classNamed: $a_class_name];"
		end

	frozen principal_class (a_ns_bundle: POINTER): POINTER
			-- - (Class)principalClass
		external
			"C inline use <Foundation/NSBundle.h>"
		alias
			"return [(NSBundle*)$a_ns_bundle principalClass];"
		end

feature -- Finding a Resource

	frozen path_for_resource_of_type_in_directory (a_ns_bundle: POINTER; a_name: POINTER; a_ext: POINTER; a_subpath: POINTER): POINTER
			-- - (NSString *)pathForResource: (NSString *) name ofType: (NSString *) ext inDirectory: (NSString *) subpath
		external
			"C inline use <Foundation/NSBundle.h>"
		alias
			"return [(NSBundle*)$a_ns_bundle pathForResource: $a_name ofType: $a_ext inDirectory: $a_subpath];"
		end

	frozen path_for_resource_of_type (a_ns_bundle: POINTER; a_name: POINTER; a_ext: POINTER): POINTER
			-- - (NSString *)pathForResource: (NSString *) name ofType: (NSString *) ext
		external
			"C inline use <Foundation/NSBundle.h>"
		alias
			"return [(NSBundle*)$a_ns_bundle pathForResource: $a_name ofType: $a_ext];"
		end
-- Error generating pathForResource:ofType:inDirectory:: Message signature for feature not set

	frozen path_for_resource_of_type_in_directory_for_localization (a_ns_bundle: POINTER; a_name: POINTER; a_ext: POINTER; a_subpath: POINTER; a_localization_name: POINTER): POINTER
			-- - (NSString *)pathForResource: (NSString *) name ofType: (NSString *) ext inDirectory: (NSString *) subpath forLocalization: (NSString *) localizationName
		external
			"C inline use <Foundation/NSBundle.h>"
		alias
			"return [(NSBundle*)$a_ns_bundle pathForResource: $a_name ofType: $a_ext inDirectory: $a_subpath forLocalization: $a_localization_name];"
		end

	frozen paths_for_resources_of_type_in_directory (a_ns_bundle: POINTER; a_ext: POINTER; a_subpath: POINTER): POINTER
			-- - (NSArray *)pathsForResourcesOfType: (NSString *) ext inDirectory: (NSString *) subpath
		external
			"C inline use <Foundation/NSBundle.h>"
		alias
			"return [(NSBundle*)$a_ns_bundle pathsForResourcesOfType: $a_ext inDirectory: $a_subpath];"
		end
-- Error generating pathsForResourcesOfType:inDirectory:: Message signature for feature not set

	frozen paths_for_resources_of_type_in_directory_for_localization (a_ns_bundle: POINTER; a_ext: POINTER; a_subpath: POINTER; a_localization_name: POINTER): POINTER
			-- - (NSArray *)pathsForResourcesOfType: (NSString *) ext inDirectory: (NSString *) subpath forLocalization: (NSString *) localizationName
		external
			"C inline use <Foundation/NSBundle.h>"
		alias
			"return [(NSBundle*)$a_ns_bundle pathsForResourcesOfType: $a_ext inDirectory: $a_subpath forLocalization: $a_localization_name];"
		end

	frozen resource_path (a_ns_bundle: POINTER): POINTER
			-- - (NSString *)resourcePath
		external
			"C inline use <Foundation/NSBundle.h>"
		alias
			"return [(NSBundle*)$a_ns_bundle resourcePath];"
		end

feature -- Getting the Bundle Directory

	frozen bundle_path (a_ns_bundle: POINTER): POINTER
			-- - (NSString *)bundlePath
		external
			"C inline use <Foundation/NSBundle.h>"
		alias
			"return [(NSBundle*)$a_ns_bundle bundlePath];"
		end

feature -- Getting Bundle Information

	frozen built_in_plug_ins_path (a_ns_bundle: POINTER): POINTER
			-- - (NSString *)builtInPlugInsPath
		external
			"C inline use <Foundation/NSBundle.h>"
		alias
			"return [(NSBundle*)$a_ns_bundle builtInPlugInsPath];"
		end

	frozen bundle_identifier (a_ns_bundle: POINTER): POINTER
			-- - (NSString *)bundleIdentifier
		external
			"C inline use <Foundation/NSBundle.h>"
		alias
			"return [(NSBundle*)$a_ns_bundle bundleIdentifier];"
		end

	frozen executable_path (a_ns_bundle: POINTER): POINTER
			-- - (NSString *)executablePath
		external
			"C inline use <Foundation/NSBundle.h>"
		alias
			"return [(NSBundle*)$a_ns_bundle executablePath];"
		end

	frozen info_dictionary (a_ns_bundle: POINTER): POINTER
			-- - (NSDictionary *)infoDictionary
		external
			"C inline use <Foundation/NSBundle.h>"
		alias
			"return [(NSBundle*)$a_ns_bundle infoDictionary];"
		end

	frozen object_for_info_dictionary_key (a_ns_bundle: POINTER; a_key: POINTER): POINTER
			-- - (id)objectForInfoDictionaryKey: (NSString *) key
		external
			"C inline use <Foundation/NSBundle.h>"
		alias
			"return [(NSBundle*)$a_ns_bundle objectForInfoDictionaryKey: $a_key];"
		end

	frozen path_for_auxiliary_executable (a_ns_bundle: POINTER; a_executable_name: POINTER): POINTER
			-- - (NSString *)pathForAuxiliaryExecutable: (NSString *) executableName
		external
			"C inline use <Foundation/NSBundle.h>"
		alias
			"return [(NSBundle*)$a_ns_bundle pathForAuxiliaryExecutable: $a_executable_name];"
		end

	frozen private_frameworks_path (a_ns_bundle: POINTER): POINTER
			-- - (NSString *)privateFrameworksPath
		external
			"C inline use <Foundation/NSBundle.h>"
		alias
			"return [(NSBundle*)$a_ns_bundle privateFrameworksPath];"
		end

	frozen shared_frameworks_path (a_ns_bundle: POINTER): POINTER
			-- - (NSString *)sharedFrameworksPath
		external
			"C inline use <Foundation/NSBundle.h>"
		alias
			"return [(NSBundle*)$a_ns_bundle sharedFrameworksPath];"
		end

	frozen shared_support_path (a_ns_bundle: POINTER): POINTER
			-- - (NSString *)sharedSupportPath
		external
			"C inline use <Foundation/NSBundle.h>"
		alias
			"return [(NSBundle*)$a_ns_bundle sharedSupportPath];"
		end

feature -- Managing Localized Resources

	frozen localized_string_for_key_value_table (a_ns_bundle: POINTER; a_key: POINTER; a_value: POINTER; a_table_name: POINTER): POINTER
			-- - (NSString *)localizedStringForKey: (NSString *) key value: (NSString *) value table: (NSString *) tableName
		external
			"C inline use <Foundation/NSBundle.h>"
		alias
			"return [(NSBundle*)$a_ns_bundle localizedStringForKey: $a_key value: $a_value table: $a_table_name];"
		end

feature -- Loading a Bundle`s Code

	frozen executable_architectures (a_ns_bundle: POINTER): POINTER
			-- - (NSArray *)executableArchitectures
		external
			"C inline use <Foundation/NSBundle.h>"
		alias
			"return [(NSBundle*)$a_ns_bundle executableArchitectures];"
		end

	frozen preflight_and_return_error (a_ns_bundle: POINTER; a_error: POINTER): BOOLEAN
			-- - (BOOL)preflightAndReturnError: (NSError **) error
		external
			"C inline use <Foundation/NSBundle.h>"
		alias
			"return [(NSBundle*)$a_ns_bundle preflightAndReturnError: $a_error];"
		end

	frozen load (a_ns_bundle: POINTER): BOOLEAN
			-- - (BOOL)load
		external
			"C inline use <Foundation/NSBundle.h>"
		alias
			"return [(NSBundle*)$a_ns_bundle load];"
		end

	frozen load_and_return_error (a_ns_bundle: POINTER; a_error: POINTER): BOOLEAN
			-- - (BOOL)loadAndReturnError: (NSError **) error
		external
			"C inline use <Foundation/NSBundle.h>"
		alias
			"return [(NSBundle*)$a_ns_bundle loadAndReturnError: $a_error];"
		end

	frozen is_loaded (a_ns_bundle: POINTER): BOOLEAN
			-- - (BOOL)isLoaded
		external
			"C inline use <Foundation/NSBundle.h>"
		alias
			"return [(NSBundle*)$a_ns_bundle isLoaded];"
		end

	frozen unload (a_ns_bundle: POINTER): BOOLEAN
			-- - (BOOL)unload
		external
			"C inline use <Foundation/NSBundle.h>"
		alias
			"return [(NSBundle*)$a_ns_bundle unload];"
		end

feature -- Managing Localizations

	frozen preferred_localizations_from_array (a_localizations_array: POINTER): POINTER
			-- + (NSArray *)preferredLocalizationsFromArray: (NSArray *) localizationsArray
		external
			"C inline use <Foundation/NSBundle.h>"
		alias
			"return [NSBundle preferredLocalizationsFromArray: $a_localizations_array];"
		end

	frozen preferred_localizations_from_array_for_preferences (a_localizations_array: POINTER; a_preferences_array: POINTER): POINTER
			-- + (NSArray *)preferredLocalizationsFromArray: (NSArray *) localizationsArray forPreferences: (NSArray *) preferencesArray
		external
			"C inline use <Foundation/NSBundle.h>"
		alias
			"return [NSBundle preferredLocalizationsFromArray: $a_localizations_array forPreferences: $a_preferences_array];"
		end

	frozen localizations (a_ns_bundle: POINTER): POINTER
			-- - (NSArray *)localizations
		external
			"C inline use <Foundation/NSBundle.h>"
		alias
			"return [(NSBundle*)$a_ns_bundle localizations];"
		end

	frozen development_localization (a_ns_bundle: POINTER): POINTER
			-- - (NSString *)developmentLocalization
		external
			"C inline use <Foundation/NSBundle.h>"
		alias
			"return [(NSBundle*)$a_ns_bundle developmentLocalization];"
		end

	frozen preferred_localizations (a_ns_bundle: POINTER): POINTER
			-- - (NSArray *)preferredLocalizations
		external
			"C inline use <Foundation/NSBundle.h>"
		alias
			"return [(NSBundle*)$a_ns_bundle preferredLocalizations];"
		end

	frozen localized_info_dictionary (a_ns_bundle: POINTER): POINTER
			-- - (NSDictionary *)localizedInfoDictionary
		external
			"C inline use <Foundation/NSBundle.h>"
		alias
			"return [(NSBundle*)$a_ns_bundle localizedInfoDictionary];"
		end

end
