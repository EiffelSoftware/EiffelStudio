note
	description: "Backup files into directory given in configuration file"
	
class
	CODE_BACKUP

inherit
	CODE_CONFIGURATION
		export
			{NONE} all
		end

feature -- Access

	backup_enabled: BOOLEAN
			-- Is backup option enabled?
		do
			Result := backup_folder /= Void
		end

feature -- Status Report

	backup_successful: BOOLEAN
			-- Was last backup successful?

feature -- Basic Operations

	backup_content (a_content, a_backup_file_name: STRING)
			-- Save `a_content' in `a_backup_file_name' in folder `backup_folder'.
			-- Append smallest unique integer to `a_backup_file_name' if file with same name already exists.
			-- Do nothing is `backup_folder' is Void.
		require
			attached_backup_file_name: a_backup_file_name /= Void
			attached_content: a_content /= Void
			backup_enabled: backup_enabled
		local
			l_file: RAW_FILE
			l_retried: BOOLEAN
		do
			backup_successful := False
			if not l_retried then
				create l_file.make (unique_file_name (a_backup_file_name, backup_folder))
				l_file.open_write
				l_file.put_string (a_content)
				l_file.close
				backup_successful := True
			end
		rescue
			l_retried := True
			retry
		end

	backup_file (a_file: FILE)
			-- Backup `a_file' in backup folder.
			-- Append smallest unique integer to `a_file' name if file with same name already exists.
		require
			attached_file: a_file /= Void
		local
			l_backup_file: RAW_FILE
			l_retried: BOOLEAN
			l_index: INTEGER
			l_file_name: STRING
		do
			backup_successful := False
			if not l_retried then
				l_file_name := a_file.name
				l_index := l_file_name.last_index_of (Directory_separator, l_file_name.count)
				if l_index > 0 then
					l_file_name := l_file_name.substring (l_index + 1, l_file_name.count)
				end
				create l_backup_file.make (unique_file_name (l_file_name, backup_folder))
				l_backup_file.open_write
				a_file.open_read
				a_file.copy_to (l_backup_file)
				a_file.close
				l_backup_file.close
				backup_successful := True
			end
		rescue
			l_retried := True
			retry
		end

	backup_file_from_path (a_path: STRING)
			-- Backup file located at `a_path' in backup folder.
			-- Append smallest unique integer to `a_file' name if file with same name already exists.
		require
			attached_path: a_path /= Void
		do
			backup_file (create {RAW_FILE}.make (a_path))
		end

feature {NONE} -- Implementation

	unique_file_name (a_file_name, a_path: STRING): STRING
			-- File name based on `a_file_name' for a file that does not exist in `a_path'
		require
			attached_file_name: a_file_name /= Void
			attached_path: a_path /= Void
			valid_path: a_path.item (a_path.count) = Directory_separator
			backup_enabled: backup_enabled
		local
			l_partial_name, l_extension: STRING
			i, l_index: INTEGER
			l_file: PLAIN_TEXT_FILE
		do
			create Result.make (240)
			Result.append (a_path)
			Result.append (a_file_name)
			create l_file.make (Result)
			if l_file.exists then
				l_index := a_file_name.last_index_of ('.', a_file_name.count)
				if l_index > 0 then
					l_partial_name := a_file_name.substring (1, l_index - 1)
					l_extension := a_file_name.substring (l_index, a_file_name.count)
				else
					l_partial_name := a_file_name.twin
					create l_extension.make_empty
				end
				from
					i := 2
				until
					not l_file.exists
				loop
					create Result.make (240)
					Result.append (a_path)
					Result.append (l_partial_name)
					Result.append_character ('_')
					Result.append (i.out)
					Result.append (l_extension)
					create l_file.make (Result)
					i := i + 1
				end
			end
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
