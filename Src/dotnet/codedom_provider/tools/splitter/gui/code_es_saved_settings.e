indexing
	description: "Graphical settings for eSplitter"
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_ES_SAVED_SETTINGS

inherit
	CODE_ES_REGISTRY_KEYS
		export
			{NONE} all
		end

	CODE_GRAPHICAL_SETTINGS_MANAGER
		rename
			make as settings_make
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize `registry_path'.
		do
			settings_make (Saved_settings_key)
		end
		
feature -- Access

	saved_process_subfolders: BOOLEAN is
			-- Should subfolders be scanned?
		do
			Result := saved_boolean (Process_subfolders_key)
		end

	saved_has_destination: BOOLEAN is
			-- Should generated source files be created in destination folder?
		do
			Result := saved_boolean (Has_destination_key)
		end

	saved_folders: LIST [STRING] is
			-- List of saved values for folders combo
		do
			Result := saved_list (Folders_key)
		end

	saved_destination_folders: LIST [STRING] is
			-- List of saved values for destination folders combo
		do
			Result := saved_list (Destination_folders_key)
		end

	saved_regexps: LIST [STRING] is
			-- List of saved values for regular expression combo
		do
			Result := saved_list (Regexps_key)
		end

feature -- Element Settings

	save_folders (a_folders: LIST [STRING]) is
			-- Set folders paths.
		require
			non_void_folders: a_folders /= Void
		do
			save_list (Folders_key, a_folders)
		end

	save_destination_folders (a_folders: LIST [STRING]) is
			-- Set folders paths.
		require
			non_void_folders: a_folders /= Void
		do
			save_list (Destination_folders_key, a_folders)
		end

	save_regexps (a_regexps: LIST [STRING]) is
			-- Set regular expressions.
		require
			non_void_regexpss: a_regexps /= Void
		do
			save_list (Regexps_key, a_regexps)
		end

	save_process_subfolders (a_value: BOOLEAN) is
			-- Set `process subfolders' checkable button state.
		do
			save_boolean (Process_subfolders_key, a_value)
		end

	save_has_destination (a_value: BOOLEAN) is
			-- Set `saved_has_destination' with `a_value'.
		do
			save_boolean (Has_destination_key, a_value)
		end

feature {NONE} -- Private Access

	Folders_key: STRING is "folders_key"
			-- Folders paths key name

	Destination_folders_key: STRING is "destination_folders_key"
			-- Folders paths key name

	Regexps_key: STRING is "regexps_key"
			-- Regular expressions key name

	Process_subfolders_key: STRING is "process_subfolders"
			-- Process subfolders key name

	Has_destination_key: STRING is "has_destination_key"
			-- Has destination key

end -- class CODE_ES_SAVED_SETTINGS

--+--------------------------------------------------------------------
--| eSplitter
--| Copyright (C) Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------