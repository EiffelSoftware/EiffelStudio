note
	description: "Storage of EIS, access to servers"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EIS_STORAGE

inherit
	ES_EIS_STORAGE_OBSERVER_MANAGER
		rename
			make as make_observer_manager
		end

	EB_SHARED_ID_SOLUTION
		export
			{NONE} all
		end

	EIFFEL_LAYOUT
		export
			{NONE} all
		end

	PROJECT_CONTEXT
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization
		do
			create internal_tag_server
			create internal_entry_server
			create internal_date_server.make (10)
			make_observer_manager
		end

feature -- Retrieve and save

	retrieve_from_file
			-- Retrieve storage from file	
		local
			l_tuple: TUPLE [tag_server: like tag_server; entry_server: like entry_server]
			l_file: RAW_FILE
			l_facility: SED_STORABLE_FACILITIES
			l_reader: SED_MEDIUM_READER_WRITER
			l_retried: BOOLEAN
		do
			if not l_retried then
				create l_file.make (storage_file_name)
				if l_file.exists then
					l_file.open_read
					create l_reader.make (l_file)
					l_reader.set_for_reading
					create l_facility
					l_tuple ?= l_facility.retrieved (l_reader, True)
					if l_tuple /= Void then
						internal_tag_server := l_tuple.tag_server
						internal_entry_server := l_tuple.entry_server
						save_needed := False
					end
				end
				if not l_file.is_closed then
					l_file.close
				end
			end
		rescue
			save_needed := True
			l_retried := True
			if l_file /= Void and not l_file.is_closed then
				l_file.close
			end
		end

	save_to_file
			-- Save storage to file when needed.
		local
			l_tuple: TUPLE [tag_server: like tag_server; entry_server: like entry_server]
			l_file: RAW_FILE
			l_facility: SED_STORABLE_FACILITIES
			l_writer: SED_MEDIUM_READER_WRITER
			l_retried: BOOLEAN
		do
			if not l_retried and then save_needed then
				l_tuple := [tag_server, entry_server]
				create l_file.make_create_read_write (storage_file_name)
				create l_writer.make (l_file)
				create l_facility
				l_facility.independent_store (l_tuple, l_writer, True)
				l_file.close
				save_needed := False
			end
		rescue
			save_needed := True
			l_retried := True
			if l_file /= Void and not l_file.is_closed then
				l_file.close
			end
		end

feature -- Element change

	register_entry (a_entry: EIS_ENTRY; a_component_id: STRING; a_date: INTEGER)
			-- Register an entry from the storage
			-- Syncronize servers
			-- `a_component_id' is the class EIS id when `a_entry' is written in a feature
		require
			a_entry_attached: a_entry /= Void
			a_component_id_attached: a_component_id /= Void
			has_date: a_date /= 0
		local
			l_tags: ARRAYED_LIST [STRING_32]
		do
			if entry_server.register_entry (a_entry, a_component_id) then
					-- Syncronize tag server
				if (attached a_entry.tags as lt_tags) and then not lt_tags.is_empty then
					l_tags := lt_tags.twin
					from
						l_tags.start
					until
						l_tags.after
					loop
						if (attached l_tags.item as lt_tag) and then not lt_tag.is_empty then
							if tag_server.register_entry (a_entry, lt_tag) then
								on_tag_extended (lt_tag)
							end
						end
						l_tags.forth
					end
				else
						-- Register empty string to reference entry without tag.
					if tag_server.register_entry (a_entry, create {STRING_32}.make_empty) then
						-- Do nothing.
					end
				end

					-- Syncronize date sever
				date_server.search (a_component_id)
				if date_server.found then
					date_server.replace (a_date, a_component_id)
				else
					date_server.put (a_date, a_component_id)
				end

				save_needed := True
			end
		end

	deregister_entry (a_entry: EIS_ENTRY; a_component_id: STRING)
			-- Deregister an entry from the storage
			-- Syncronize servers
			-- `a_component_id' is the class EIS id when `a_entry' is written in a feature
		require
			a_entry_attached: a_entry /= Void
			a_component_id_attached: a_component_id /= Void
		local
			l_tags: ARRAYED_LIST [STRING_32]
			l_entries: SEARCH_TABLE [EIS_ENTRY]
		do
			if entry_server.deregister_entry (a_entry, a_component_id) then
					-- Syncronize tag server
				if (attached a_entry.tags as lt_tags) and then not lt_tags.is_empty then
					l_tags := lt_tags.twin
					from
						l_tags.start
					until
						l_tags.after
					loop
						if (attached l_tags.item as lt_tag) and then not lt_tag.is_empty then
							if tag_server.deregister_entry (a_entry, lt_tag) then
								l_entries := tag_server.entries_of_id (lt_tag)
								if l_entries = Void or else l_entries.is_empty then
									on_tag_removed (lt_tag)
								end
							end
						end
						l_tags.forth
					end
				else
						-- Deregister entry without tag with empty string.
					if tag_server.deregister_entry (a_entry, create {STRING_32}.make_empty) then
						-- Do nothing
					end
				end

					-- No need to syncronize the date server.

				save_needed := True
			end
		end

	register_entries_of_component_id (a_entries: SEARCH_TABLE [EIS_ENTRY]; a_component_id: STRING; a_date: INTEGER)
			-- Deregister entries of `a_component_id'.
			-- Syncronize servers
		require
			a_entries_attached: a_entries /= Void
			a_component_id_attached: a_component_id /= Void
			has_date: a_date /= 0
		local
			l_entry: detachable EIS_ENTRY
		do
				-- We need to correctly remove old entries first, and sync tag server.
			deregister_entries_of_component_id (a_component_id)
				-- Start registration.
			from
				a_entries.start
			until
				a_entries.after
			loop
				l_entry := a_entries.item_for_iteration
				check l_entry_not_void: l_entry /= Void end
				register_entry (l_entry, a_component_id, a_date)
				a_entries.forth
			end
				-- We still keep the information that the component does not contain any entry.
			if a_entries.is_empty then
				entry_server.register_component (a_component_id)
			end
				-- We still keep date of the component.
			if a_entries.is_empty then
				date_server.search (a_component_id)
				if date_server.found then
					date_server.replace (a_date, a_component_id)
				else
					date_server.put (a_date, a_component_id)
				end
			end
		end

	deregister_entries_of_component_id (a_component_id: STRING)
			-- Deregister entries of `a_component_id'.
			-- Syncronize servers
		require
			a_component_id_attached: a_component_id /= Void
		local
			l_entries: SEARCH_TABLE [EIS_ENTRY]
			l_entry: detachable EIS_ENTRY
		do
			if (attached entry_server.entries_of_id (a_component_id) as lt_entries) then
					-- Twinning to ensure that the circulation structure is not broken by `deregister_entry'
				l_entries := lt_entries.twin
				from
					lt_entries.start
				until
					lt_entries.after
				loop
					l_entry := lt_entries.item_for_iteration
					check l_entry_not_void: l_entry /= Void end
					deregister_entry (l_entry, a_component_id)
					lt_entries.forth
				end
			end
		end

	clean_up
			-- Clean up the storage, remove garbage information
		local
			l_entries: HASH_TABLE [SEARCH_TABLE [EIS_ENTRY], STRING]
		do
			l_entries := entry_server.entries.twin
			from
				l_entries.start
			until
				l_entries.after
			loop
				if not id_valid (l_entries.key_for_iteration) then
					deregister_entries_of_component_id (l_entries.key_for_iteration)
						-- Now remove from the date server, as it is an invalid component id.
					date_server.remove (l_entries.key_for_iteration)
				end
				l_entries.forth
			end
		end

feature -- Access

	tag_server: EIS_ENTRY_SERVER [EIS_ENTRY, STRING_32]
			-- Tag server
		do
			Result := internal_tag_server
		ensure
			tag_server_attached: Result /= Void
		end

	entry_server: EIS_ENTRY_SERVER [EIS_ENTRY, STRING]
			-- Entry server
		do
			Result := internal_entry_server
		ensure
			entry_server_attached: Result /= Void
		end

	date_server: HASH_TABLE [INTEGER, STRING]
			-- Date server
			-- Save time stamp for each components.
		do
			Result := internal_date_server
		ensure
			date_server_attached: Result /= Void
		end

feature {NONE} -- Access

	storage_file_name: FILE_NAME
			-- Path of the place to store tags.
		do
			create Result.make_from_string (project_location.target_path)
			Result.set_file_name (eiffel_layout.eis_storage_file)
		ensure
			storage_file_name_attached: Result /= Void
		end

	save_needed: BOOLEAN
			-- Save needed?

	internal_tag_server: like tag_server
			-- Internal tag server

	internal_entry_server: like entry_server;
			-- Internal entry server

	internal_date_server: like date_server;
			-- Internal date server

invariant
	internal_tag_server_attached: internal_tag_server /= Void
	internal_entry_server_attached: internal_entry_server /= Void
	internal_date_server_attached: internal_date_server /= Void

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
