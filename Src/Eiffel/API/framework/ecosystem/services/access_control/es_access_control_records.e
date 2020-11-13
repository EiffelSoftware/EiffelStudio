note
	description: "Summary description for {ES_ACCESS_CONTROL_RECORDS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_ACCESS_CONTROL_RECORDS

inherit
	EIFFEL_LAYOUT

create
	make

feature {NONE} -- Initialization	

	make (a_storage_id: detachable READABLE_STRING_GENERAL)
		local
			p: PATH
		do
			create issuers.make (3)
			p := eiffel_layout.hidden_files_path.extended ("access")
			p := ensure_folder_exists (p)
			if a_storage_id /= Void and then not a_storage_id.is_whitespace then
				p := p.extended (a_storage_id)
			else
				p := p.extended ("guest")
			end
			p := p.appended_with_extension ("data")
			storage_location := p
			load
		end

	ensure_folder_exists (p: PATH): PATH
		local
			d: DIRECTORY
			retried: BOOLEAN
		do
			if not retried then
				create d.make_with_path (p)
				if not d.exists then
					d.recursive_create_dir
				end
				Result := p
			else
				Result := p.parent
			end
		rescue
			retry
		end

feature {NONE} -- Access

	issuers: STRING_TABLE [like issuer_items]

feature -- Access

	issuer_items (issuer: READABLE_STRING_GENERAL): LIST [TUPLE [operation: detachable READABLE_STRING_GENERAL; date: DATE_TIME]]
		do
			update
			Result := issuers [issuer]
			if Result = Void then
				create {ARRAYED_LIST [TUPLE [operation: detachable READABLE_STRING_GENERAL; date: DATE_TIME]]} Result.make (10)
				issuers [issuer] := Result
			end
		end

feature -- Basic operation

	put_operation (issuer: READABLE_STRING_GENERAL; operation: detachable READABLE_STRING_GENERAL)
		do
			update
			issuer_items (issuer).force ([operation, create {DATE_TIME}.make_now_utc])
			commit
		end

feature -- Persistency

	commit
		do
			store
		end

feature {NONE} -- Persistency

	change_date: INTEGER

	storage_location: PATH

	update
		local
			f: RAW_FILE
		do
			-- if file is more recent that last change date, load again the data
			-- otherwise keep the current data.
			create f.make_with_path (storage_location)
			if f.exists then
				if f.change_date > change_date then
					load
				end
			else
				commit
			end
		end

	load
		local
			retried: BOOLEAN
			l_reader: SED_MEDIUM_READER_WRITER
			sed: SED_STORABLE_FACILITIES
			f: RAW_FILE
		do
			if not retried then
				create f.make_with_path (storage_location)
				if f.exists and then f.is_access_readable then
					f.open_read
					create l_reader.make_for_reading (f)
					create sed
					if attached {like issuers} sed.retrieved (l_reader, False) as l_data then
						issuers := l_data
					else
						-- Keep previous `issuers`
					end
					f.close
					change_date := f.change_date
				end
			end
		rescue
			retried := True
			retry
		end

	store
		local
			f: RAW_FILE
			l_writer: SED_MEDIUM_READER_WRITER
			retried: BOOLEAN
			sed: SED_STORABLE_FACILITIES
		do
			if not retried then
				create f.make_with_path (storage_location)
				if not f.exists or else f.is_access_writable then
					f.open_write
					create l_writer.make_for_writing (f)
					create sed
					sed.basic_store (issuers, l_writer, True)
					f.close
					change_date := f.change_date
				end
			end
		rescue
			retried := True
			retry
		end

note
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
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
