note
	description: "[
		A windows-specific implementation of a backup manager, used to backup and restore configurations.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

class
	WINDOWS_BACKUP_MANAGER

inherit
	BACKUP_MANAGER
		redefine
			path_provider
		end

create
	make

feature {NONE} -- Access

	path_provider: WINDOWS_PATH_PROVIDER
			-- Access to Eiffel related paths
		do
			Result ?= package.path_provider
		end

	storable_utils: SED_STORABLE_FACILITIES
			-- Access to storable factilities
		once
			create Result
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Access

	backup_preferences_time_stamp: INTEGER_32
			-- Backup timestamp for preferences
		do
			Result := backup_file_time_stamp (preferences_file_name)
		end

	preferences_file_name: FILE_NAME
			-- File name given to the preferences file.
			-- Note: This is not the name of the back up file. Use `backup_file_name' to retrieve the actual file name
		do
			create Result.make_from_string (package.eiffel_env.eiffel_home)
			Result.set_file_name (once "es_preferences")
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

feature  -- Basic operations

	backup_preferences
			-- Backs up preferences configuration file(s)
		local
			l_path: STRING_8
			l_reg: WEL_REGISTRY
			l_key: POINTER
			l_items: LIST [STRING_8]
			l_table: HASH_TABLE [STRING, STRING]
			l_file: RAW_FILE
			retried: BOOLEAN
			l_writer: SED_MEDIUM_READER_WRITER
		do
			if not retried then
				l_path := path_provider.preferences_registy_path

				create l_reg
				l_key := l_reg.open_key_with_access (l_path, {WEL_REGISTRY_ACCESS_MODE}.key_read)
				if l_key /= default_pointer then
					l_items := l_reg.enumerate_values_as_string_8 (l_key)
					create l_table.make (l_items.count)
					l_items.do_all (agent (a_item: STRING; a_reg: WEL_REGISTRY; a_parent: POINTER; a_table: HASH_TABLE [STRING, STRING])
						local
							l_value: WEL_REGISTRY_KEY_VALUE
						do
							l_value := a_reg.key_value (a_parent, a_item)
							if l_value.type = {WEL_REGISTRY_KEY_VALUE_TYPE}.reg_sz then
								a_table.force (l_value.string_value, a_item)
							end
						end (?, l_reg, l_key, l_table))

						-- Write information to disk
					create l_file.make_open_write (backup_file_name (preferences_file_name))
					create l_writer.make (l_file)
					l_writer.set_for_writing
					storable_utils.independent_store (l_table, l_writer, True)
				end
			else
				if l_file = Void then
					if l_path = Void then
						l_path := "Unable to retrieve path"
					end
					error_handler.add_error (create {ESC_B02}.make_with_context ([l_path]), False)
				else
					error_handler.add_error (create {ESC_B03}.make_with_context ([l_file.name]), False)
				end
			end

				-- Release allocated resources
			if l_reg /= Void and then l_key /= default_pointer then
				l_reg.close_key (l_key)
			end
			if l_file /= Void and then not l_file.is_closed then
				l_file.flush
				l_file.close
			end
		rescue
			retried := True
			retry
		end

	restore_preferences
			-- Restores from a back up the preferences configuration file(s).
		local
			l_path: STRING_8
			l_reg: WEL_REGISTRY
			l_key: POINTER
			l_table: HASH_TABLE [STRING, STRING]
			l_file: RAW_FILE
			retried: BOOLEAN
			l_reader: SED_MEDIUM_READER_WRITER
		do
			if not retried then
				l_path := path_provider.preferences_registy_path

					-- Write information to disk
				create l_file.make_open_read (backup_file_name (preferences_file_name))
				create l_reader.make (l_file)
				l_reader.set_for_reading
				l_table ?= storable_utils.retrieved (l_reader, False)
				if l_table /= Void then
					create l_reg
					l_key := l_reg.open_key_with_access (l_path, {WEL_REGISTRY_ACCESS_MODE}.key_read)
					if l_key = default_pointer then
							-- Need to recreate key
						l_reg.create_new_key (l_path)
						l_key := l_reg.open_key_with_access (l_path, {WEL_REGISTRY_ACCESS_MODE}.key_read)
					end
					if l_key /= default_pointer then
						l_table.current_keys.do_all (agent (a_item: STRING; a_reg: WEL_REGISTRY; a_key: POINTER; a_table: HASH_TABLE [STRING, STRING])
							local
								l_value: STRING
							do
								l_value := a_table.item (a_item)
								check l_value_attached: l_value /= Void end
								if l_value /= Void then
									a_reg.set_key_value (a_key, a_item, create {WEL_REGISTRY_KEY_VALUE}.make ({WEL_REGISTRY_KEY_VALUE_TYPE}.reg_sz, l_value))
								end
							end (?, l_reg, l_key, l_table))
					end
				else
					error_handler.add_error (create {ESC_R03}.make_with_context ([l_file]), False)
				end
			else
				if l_path = Void then
					l_path := "Unable to retrieve path"
				end
				error_handler.add_error (create {ESC_R02}.make_with_context ([l_path]), False)
			end

				-- Release allocated resources
			if l_reg /= Void and then l_key /= default_pointer then
				l_reg.close_key (l_key)
			end
			if l_file /= Void and then not l_file.is_closed then
				l_file.close
			end
		rescue
			retried := True
			retry
		end

feature -- Query

	does_backup_preferences_exist: BOOLEAN
			-- Determines if the backed up preferences data exists
		do
			Result := does_backup_file_exist (preferences_file_name)
		end

note
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
