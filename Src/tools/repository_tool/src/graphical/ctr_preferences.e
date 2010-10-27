note
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CTR_PREFERENCES

inherit
	EXECUTION_ENVIRONMENT

	PLATFORM

	REPOSITORY_SHARED

create
	make

feature {NONE} -- Initialization

	make (fn: STRING)
		local
			l_storage: PREFERENCES_STORAGE_XML
		do
			create l_storage.make_with_location (fn)
			create preferences.make_with_storage (l_storage)

			load_preferences
			if not preferences.preferences_storage_exists then
				save_preferences
			end
		end

	manager: PREFERENCE_MANAGER

	factory: BASIC_PREFERENCE_FACTORY

	namespace: STRING = "ctr"

	get_factory
		do
			create factory
		end

	get_manager (a_namespace: STRING)
		do
			if preferences.has_manager (a_namespace) then
				manager := preferences.manager (a_namespace)
			else
				manager := preferences.new_manager (a_namespace)
			end
		end

feature -- Basic operation

	preferences: PREFERENCES

	save_preferences
		do
			preferences.save_preferences
		end

	load_preferences
		local
--			dir: DIRECTORY_NAME
		do
			get_manager (namespace)
			get_factory

			svn_executable_pref := factory.new_string_preference_value (manager, namespace + ".svn_executable", "svn")
			svn_executable_pref.set_description ("Full path to svn executable")


--			if is_windows then
--				create dir.make_from_string (get ("APPDATA"))
--				dir.extend ("svn_backup")
--			else
--				create dir.make_from_string (get ("HOME"))
--				dir.extend (".svn_backup")
--			end
--			last_backup_directory_pref := factory.new_string_preference_value (manager, namespace + ".last_backup_directory", dir)
		end

feature -- Preferences

	svn_executable_pref: STRING_PREFERENCE

end
