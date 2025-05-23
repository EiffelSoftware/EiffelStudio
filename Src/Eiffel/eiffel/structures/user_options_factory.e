﻿note
	description: "Handle user files."
	date: "$Date$"
	revision: "$Revision$"

class
	USER_OPTIONS_FACTORY

inherit
	ANY

	EIFFEL_LAYOUT
		export
			{NONE} all
		end

feature -- Access

	successful: BOOLEAN
			-- Is last store/retrieve operation successful?

	last_options: detachable USER_OPTIONS
			-- Last retrieved options.

	last_file_name: PATH
			-- Last file name for last store/load operation.

feature -- Query

	mapped_uuid (a_file_path: READABLE_STRING_32): detachable UUID
			-- Retrieves a mapped UUID for a given file path
		require
			a_file_path_attached: a_file_path /= Void
			not_a_file_path_is_empty: not a_file_path.is_empty
		do
			if attached mapping.item (a_file_path.as_string_32) as l_uuid and then not l_uuid.is_empty then
				create Result.make_from_string (l_uuid)
			end
		ensure
			result_not_default: Result /= Void implies not Result.is_equal (create {UUID}.make (0, 0, 0, 0, 0))
		end

feature -- Element change

	set_mapped_uuid	(a_uuid: UUID; a_file_path: READABLE_STRING_32)
			-- Set a_uuid as mapped UUID for a given `a_file_path`.
		require
			not_mapped: mapped_uuid (a_file_path) = Void
			a_file_path_attached: a_file_path /= Void
			not_a_file_path_is_empty: not a_file_path.is_empty
		local
			fn: STRING_32
			l_mapping: like mapping
		do
			fn := a_file_path.as_string_32
			l_mapping := mapping
			l_mapping.force (a_uuid.string, fn)
			store_mapping (l_mapping)
		ensure
			mapped: attached mapped_uuid (a_file_path) as l_uuid and then
					a_uuid.string.same_string (l_uuid.string)
		end

feature -- Store/Retrieve

	store (a_options: USER_OPTIONS)
			-- Store user options to disk.
			-- `successful' is True if there is no error.
		require
			a_options_set: a_options /= Void
		local
			l_file: RAW_FILE
			l_sed_rw: SED_MEDIUM_READER_WRITER
			retried: BOOLEAN
			l_mapping: like mapping
			l_uuid_str: STRING_32
		do
			if not retried then
					-- Find associated file mapping, otherwise create a new one.
					-- The mapped name is always a UUID.
				l_mapping := mapping
				l_mapping.search (a_options.project_file_path)
				if l_mapping.found then
					l_uuid_str := l_mapping.found_item
				else
					l_uuid_str := (create {UUID_GENERATOR}).generate_uuid.out
					l_mapping.put (l_uuid_str, a_options.project_file_path)
					store_mapping (l_mapping)
				end
				last_file_name := eiffel_layout.projects_data_path.extended (l_uuid_str)
				if eiffel_layout.is_hidden_files_path_available then
					create l_file.make_with_path (last_file_name)
					l_file.open_write
					if l_file.is_writable then
						create l_sed_rw.make (l_file)
						l_sed_rw.set_for_writing
						;(create {SED_STORABLE_FACILITIES}).store (a_options, l_sed_rw)
						l_file.close
						successful := True
					else
						successful := False
					end
				end
			else
				successful := False
			end
		rescue
			retried := True
			retry
		end

	load (a_file_path: STRING_32)
			-- Retrieve content of user data associated with `a_file_path' into `last_options'.
			-- If no such file is found, then `last_options' is set to Void.
		require
			a_file_path_not_void: a_file_path /= Void
		local
			l_file: RAW_FILE
			l_sed_rw: SED_MEDIUM_READER_WRITER
			l_sed_facilities: SED_STORABLE_FACILITIES
			retried: BOOLEAN
			l_mapping: like mapping
		do
			if not retried then
				last_options := Void
					-- Even if we could not create `eiffel_home', or find the user option
					-- file, we simply handle it as if they were not user file.
					-- This is why `successful' is set to `True' in all cases.
				successful := True
				l_mapping := mapping
				l_mapping.search (a_file_path)
				if l_mapping.found then
					last_file_name := eiffel_layout.projects_data_path.extended (l_mapping.found_item)
						-- if file exists, load it
					create l_file.make_with_path (last_file_name)
					if l_file.exists and then l_file.is_readable then
						l_file.open_read
						create l_sed_rw.make (l_file)
						l_sed_rw.set_for_reading
						create l_sed_facilities
						if attached {like last_options} l_sed_facilities.retrieved (l_sed_rw, True) as o then
							last_options := o
						end
						l_file.close
					end
				end
			else
				successful := False
			end
		rescue
			retried := True
			retry
		end

	remove (a_options: USER_OPTIONS; a_target: READABLE_STRING_32)
			-- Remove from `a_options' options related to `a_target'.
		require
			a_options_not_void: a_options /= Void
		do
			a_options.targets.remove (a_target)
			store (a_options)
		end

feature {NONE} -- Implementation

	mapping: STRING_TABLE [STRING_32]
			-- Mapping between path to a config file and its associated user option file.
		local
			l_file: RAW_FILE
			l_sed_rw: SED_MEDIUM_READER_WRITER
			retried: BOOLEAN
			l_file_name: PATH
			r: detachable ANY
		do
			if not retried then
				l_file_name := eiffel_layout.projects_data_path.extended (mapping_file_name)
					-- Even if we could not create `eiffel_home', we simply handle
					-- it as if they were not mapping file.
					-- if file exists, load it
				create l_file.make_with_path (l_file_name)
				if l_file.exists and then l_file.is_readable then
					l_file.open_read
					create l_sed_rw.make (l_file)
					l_sed_rw.set_for_reading
					r := (create {SED_STORABLE_FACILITIES}).retrieved (l_sed_rw, True)
					l_file.close
				end
			end
			if attached {like mapping} r as m then
				Result := m
			else
				create Result.make (0)
			end
		ensure
			mapping_not_void: Result /= Void
		rescue
			retried := True
			retry
		end

	store_mapping (a_mapping: like mapping)
			-- Store mapping to disk.
		require
			a_mapping_not_void: a_mapping /= Void
		local
			l_file: RAW_FILE
			l_sed_rw: SED_MEDIUM_READER_WRITER
			retried: BOOLEAN
			l_file_name: PATH
		do
			if not retried then
				if eiffel_layout.is_hidden_files_path_available then
					l_file_name := eiffel_layout.projects_data_path.extended (mapping_file_name)
					create l_file.make_with_path (l_file_name)
					l_file.open_write
					if l_file.is_writable then
						create l_sed_rw.make (l_file)
						l_sed_rw.set_for_writing
						;(create {SED_STORABLE_FACILITIES}).store (a_mapping, l_sed_rw)
						l_file.close
						successful := True
					else
						successful := False
					end
				end
			else
				successful := False
			end
		rescue
			retried := True
			retry
		end

	mapping_file_name: STRING = "mapping.info"
			-- Name of file where `mapping' is stored.

note
	copyright: "Copyright (c) 1984-2019, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
