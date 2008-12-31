note
	description: "[
		Basic, common, implementation for a backup manager use to backup and restore configuration data.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

deferred class
	BACKUP_MANAGER

inherit
	PACKAGE_CREATABLE

	I_BACKUP_MANAGER

feature -- Access

	last_backup_date_stamp: INTEGER
			-- Last back up date, in ticks
		do
			Result := backup_file_time_stamp (path_provider.docking_debug_layout_file.out)
			if Result = 0 then
				Result := backup_file_time_stamp (path_provider.docking_editing_layout_file.out)
			end
			if Result = 0 and does_backup_preferences_exist then
				Result := backup_preferences_time_stamp
			end
		end

feature {NONE} -- Access

	path_provider: PATH_PROVIDER
			-- Access to Eiffel related paths
		do
			Result := package.path_provider
		ensure
			result_attached: Result /= Void
		end

	error_handler: MULTI_ERROR_MANAGER
			-- Access to error manager
		do
			Result := package.error_handler
		ensure
			result_attached: Result /= Void
		end

	backup_preferences_time_stamp: INTEGER
			-- Backup timestamp for preferences
		require
			does_backup_preferences_exist: does_backup_preferences_exist
		deferred
		end

feature -- Status report

	is_restore_data_available: BOOLEAN
			-- Determines if the any restore data is available
		do
			Result := does_backup_file_exist (path_provider.docking_debug_layout_file.out)
			if not Result then
				Result := does_backup_file_exist (path_provider.docking_editing_layout_file.out)
			end
			if not Result then
				Result := does_backup_preferences_exist
			end
		end

	is_config_restore_data_available (a_config: I_BACKUP_CONFIG): BOOLEAN
			-- Determines if the any restore data is available based on `a_config'
		local
			l_available: NATURAL
		do
			if a_config.process_environement_debug_layout then
				if does_backup_file_exist (path_provider.docking_debug_layout_file.out) then
					l_available := l_available + 1
				end
			end
			if a_config.process_environement_editing_layout then
				if does_backup_file_exist (path_provider.docking_editing_layout_file.out) then
					l_available := l_available + 1
				end
			end
			if a_config.process_environement_preferences then
				if does_backup_preferences_exist then
					l_available := l_available + 1
				end
			end
			Result := l_available > 0
		end

feature {NONE} -- Status report

	does_backup_file_exist (a_file: STRING): BOOLEAN
			-- Determines if the back up file for file `a_file' exists
		require
			a_file_attached: a_file /= Void
			not_a_file_is_empty: not a_file.is_empty
		local
			l_file: RAW_FILE
		do
			create l_file.make (backup_file_name (a_file))
			Result := l_file.exists and then not l_file.is_device and not l_file.is_directory
		end

	does_backup_preferences_exist: BOOLEAN
			-- Determines if the backed up preferences data exists
		deferred
		end

feature -- Basic operations

	backup (a_config: I_BACKUP_CONFIG)
			-- Backs up configuration files base on user settings.
		do
			if a_config.process_environement_debug_layout then
				backup_file (path_provider.docking_debug_layout_file.out)
			end
			if a_config.process_environement_editing_layout then
				backup_file (path_provider.docking_editing_layout_file.out)
			end
			if a_config.process_environement_preferences then
				backup_preferences
			end
		end

	restore (a_config: I_BACKUP_CONFIG)
			-- Restores from a back up, if available, configuration files base on user settings.
		do
			if a_config.process_environement_debug_layout and then does_backup_file_exist (path_provider.docking_debug_layout_file.out) then
				restore_file (path_provider.docking_debug_layout_file.out)
			end
			if a_config.process_environement_editing_layout  and then does_backup_file_exist (path_provider.docking_editing_layout_file.out) then
				restore_file (path_provider.docking_editing_layout_file.out)
			end
			if a_config.process_environement_preferences and does_backup_preferences_exist then
				restore_preferences
			end
		end

feature {NONE} -- Basic operations

	backup_preferences
			-- Backs up preferences configuration file(s)
		deferred
		ensure
		end

	restore_preferences
			-- Restores from a back up the preferences configuration file(s).
		require
			does_backup_preferences_exist: does_backup_preferences_exist
		deferred
		end

feature {NONE} -- Query

	backup_file_name (a_file: STRING): STRING
			-- Generates a back up file name for `a_file'
		require
			a_file_attached: a_file /= Void
			not_a_file_is_empty: not a_file.is_empty
		do
			create Result.make_from_string (a_file)
			Result.append (".bak~")
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	backup_file_time_stamp (a_file: STRING): INTEGER
			-- Retrieves the time stamp, in ticks, of a backup file, if it exists.
		require
			a_file_attached: a_file /= Void
			not_a_file_is_empty: not a_file.is_empty
		do
			if does_backup_file_exist (a_file) then
				Result := (create {RAW_FILE}.make (backup_file_name (a_file))).change_date
			end
		ensure
			not_result_is_negative: Result >= 0
		end

feature {NONE} -- Basic operations

	backup_file (a_file: STRING)
			-- Backs up file `a_file', if it exists.
		require
			a_file_attached: a_file /= Void
			not_a_file_is_empty: not a_file.is_empty
		do
			if not copy_file (a_file, backup_file_name (a_file)) then
				error_handler.add_error (create {ESC_B01}.make_with_context ([a_file]), False)
			end
		ensure
			backup_created: (create {RAW_FILE}.make (a_file)).exists and error_handler.successful implies (create {RAW_FILE}.make (backup_file_name (a_file))).exists
		end

	restore_file (a_file: STRING)
			-- Restores file `a_file' from a backup.
		require
			a_file_attached: a_file /= Void
			not_a_file_is_empty: not a_file.is_empty
			backup_file_exists: does_backup_file_exist (a_file)
		do
			if not copy_file (backup_file_name (a_file), a_file) then
				error_handler.add_error (create {ESC_R01}.make_with_context ([a_file]), False)
			end
		ensure
			backup_restored: does_backup_file_exist (a_file) and error_handler.successful implies (create {RAW_FILE}.make (backup_file_name (a_file))).exists
		end

	copy_file (a_src_file, a_dest_file: STRING): BOOLEAN
			-- Copied file `a_src_file' to `a_dest_file', if `a_src_file_exists'.
		require
			a_src_file_attached: a_src_file /= Void
			not_a_src_file_is_empty: not a_src_file.is_empty
			a_dest_file_file_attached: a_dest_file /= Void
			not_a_dest_file_file_is_empty: not a_dest_file.is_empty
		local
			l_src_file: RAW_FILE
			l_dest_file: RAW_FILE
			retried: BOOLEAN
		do
			if not retried then
				create l_src_file.make (a_src_file)
				if l_src_file.exists and not l_src_file.is_directory and not l_src_file.is_device then
					l_src_file.open_read
					create l_dest_file.make_open_write (a_dest_file)
					l_src_file.copy_to (l_dest_file)
				end
				Result := True
			end

				-- Final clean up
			if l_src_file /= Void and then not l_src_file.is_closed then
				l_src_file.close
			end
			if l_dest_file /= Void and then not l_dest_file.is_closed then
				l_dest_file.close
			end
		ensure
			file_copied: (create {RAW_FILE}.make (a_src_file)).exists and Result implies (create {RAW_FILE}.make (a_dest_file)).exists
		rescue
			retried := True
			retry
		end

;note
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
