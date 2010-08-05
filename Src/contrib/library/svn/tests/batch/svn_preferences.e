note
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SVN_PREFERENCES

inherit
	ANY
		undefine
			default_create
		end

	EXECUTION_ENVIRONMENT
		undefine
			default_create
		end

	PLATFORM
		undefine
			default_create
		end

feature {NONE} -- Initialization

	default_create
		local
			args: ARGUMENTS
			l_storage: PREFERENCES_STORAGE_XML
			fn: FILE_NAME
			i: INTEGER
		do
			create args
			i := args.index_of_word_option ("cfg")
			if i > 0 then
				create fn.make_from_string (args.separate_word_option_value ("cfg"))
			else
				create fn.make_from_string (args.command_name)
				fn.add_extension ("cfg")
			end
			create l_storage.make_with_location (fn)
			create preferences.make_with_storage (l_storage)

			load_preferences
			if not preferences.preferences_storage_exists then
				save_preferences
			end
		end

	manager: PREFERENCE_MANAGER

	factory: BASIC_PREFERENCE_FACTORY

	namespace: STRING = "svntool"

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
			dir: DIRECTORY_NAME
		do
			get_manager (namespace)
			get_factory

			last_directory_pref := factory.new_string_preference_value (manager, namespace + ".last_directory", "")
			open_wc_folders_pref := factory.new_array_preference_value (manager, namespace + ".open_wc_folders", <<>>)
			image_directory_pref := factory.new_string_preference_value (manager, namespace + ".image_directory", "..\img")
			svn_executable_pref := factory.new_string_preference_value (manager, namespace + ".svn_executable", "svn")
			svn_executable_pref.set_description ("Full path to svn executable")

			tsvn_directory_pref := factory.new_string_preference_value (manager, namespace + ".tsvn_directory", "")
			tsvn_directory_pref.set_description ("Full path to TSVN directory")

			editor_command_pref := factory.new_string_preference_value (manager, namespace + ".editor_command", "notepad ${path_name}")
			editor_command_pref.set_description ("Full path to editor executable")

			if is_windows then
				create dir.make_from_string (get ("APPDATA"))
				dir.extend ("svn_backup")
			else
				create dir.make_from_string (get ("HOME"))
				dir.extend (".svn_backup")
			end
			last_backup_directory_pref := factory.new_string_preference_value (manager, namespace + ".last_backup_directory", dir)
		end

feature -- Preferences

	last_backup_directory_pref: STRING_PREFERENCE

	svn_executable_pref: STRING_PREFERENCE

	tsvn_directory_pref: STRING_PREFERENCE

	editor_command_pref: STRING_PREFERENCE

	image_directory_pref: STRING_PREFERENCE

	last_directory_pref: STRING_PREFERENCE

	open_wc_folders_pref: ARRAY_PREFERENCE

end
