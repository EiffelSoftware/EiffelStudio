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

	CODE_SETTINGS_MANAGER
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

	saved_x_pos: INTEGER is
			-- Starting window x position
		do
			Result := setting (X_pos_key)
		end

	saved_y_pos: INTEGER is
			-- Starting window y position
		do
			Result := setting (Y_pos_key)
		end

	saved_process_subfolders: BOOLEAN is
			-- Should subfolders be scanned?
		do
			Result := setting (Process_subfolders_key) = 2
		end

	saved_has_destination: BOOLEAN is
			-- Should generated source files be created in destination folder?
		do
			Result := setting (Has_destination_key) = 2
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

	save_x_pos (a_value: INTEGER) is
			-- Set starting window x position
		do
			set_setting (X_pos_key, a_value)
		end

	save_y_pos (a_value: INTEGER) is
			-- Set starting window y position.
		do
			set_setting (Y_pos_key, a_value)
		end

	save_process_subfolders (a_value: BOOLEAN) is
			-- Set `process subfolders' checkable button state.
		do
			if a_value then
				set_setting (Process_subfolders_key, 2)
			else
				set_setting (Process_subfolders_key, 1)
			end
		end

	save_has_destination (a_value: BOOLEAN) is
			-- Set `saved_has_destination' with `a_value'.
		do
			if a_value then
				set_setting (Has_destination_key, 2)
			else
				set_setting (Has_destination_key, 1)
			end
		end

feature {NONE} -- Implementation

	save_list (a_name: STRING; a_list: LIST [STRING]) is
			-- Save `a_list' using key `a_name'.
		require
			non_void_list: a_list /= Void
		local
			l_items: STRING
		do
			from
				create l_items.make (240 * a_list.count)
				a_list.start
				if not a_list.after then
					l_items.append (a_list.item)
					a_list.forth
				end
			until
				a_list.after
			loop
				l_items.append_character (';')
				l_items.append (a_list.item)
				a_list.forth
			end
			set_text_setting (a_name, l_items)
		end

	saved_list (a_name: STRING): LIST [STRING] is
			-- List of saved values with key `a_name' if any
		require
			non_void_name: a_name /= Void
		local
			l_paths: STRING
		do
			l_paths := text_setting (a_name)
			if l_paths /= Void then
				Result := l_paths.split (';')
			end
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

	X_pos_key: STRING is "x_pos"
			-- Height key name

	Y_pos_key: STRING is "y_pos"
			-- Height key name

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