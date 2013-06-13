note
	description: "Summary description for {WSF_FS_SESSION_MANAGER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_FS_SESSION_MANAGER

inherit
	WSF_SESSION_MANAGER

create
	make,
	make_with_folder

feature {NONE} -- Initialization

	make
		do
			make_with_folder ("_WSF_SESSIONS_")
		end

	make_with_folder (a_folder: READABLE_STRING_GENERAL)
		do
			create sessions_folder_name.make_from_string (a_folder)
		end

	sessions_folder_name: PATH

feature -- Access

	session_exists (a_session_uuid: like {WSF_SESSION}.uuid): BOOLEAN
		local
			f: RAW_FILE
		do
			create f.make_with_path (file_name (a_session_uuid))
			Result := f.exists and then f.is_readable
		end

	session_data (a_session_uuid: like {WSF_SESSION}.uuid): detachable like {WSF_SESSION}.data
		local
			f: RAW_FILE
		do
			create f.make_with_path (file_name (a_session_uuid))
			if f.exists and then f.is_readable then
				f.open_read
				if attached data_from_file (f) as d then
					Result := d
				end
				f.close
			end
		rescue
			debug
				io.error.put_string ("Error occurred in " + generator)
			end
		end

feature -- Persistence

	save_session (a_session: WSF_SESSION)
		local
			f: RAW_FILE
			rescued: BOOLEAN
		do
			if not rescued then
				if a_session.is_destroyed then
					delete_session (a_session)
				else
					ensure_session_folder_exists
					create f.make_with_path (file_name (a_session.uuid))
					if not f.exists or else f.is_writable then
						f.create_read_write
						a_session.data.set_expiration (a_session.expiration)
						f.general_store (a_session.data)
						f.close
					end
				end
			end
		rescue
			debug
				io.error.put_string (generator + ": trouble saving session")
			end
			rescued := True
			retry
		end

	delete_session (a_session: WSF_SESSION)
		local
			f: RAW_FILE
			rescued: BOOLEAN
		do
			if not rescued then
				create f.make_with_path (file_name (a_session.uuid))
				if f.exists then
					f.delete
				end
			end
		rescue
			debug
				io.error.put_string (generator + ": trouble deleting session")
			end
			rescued := True
			retry
		end

feature {NONE} -- Implementation

	data_from_file (f: FILE): detachable like session_data
		require
			f.is_open_read and f.is_readable
		local
			rescued: BOOLEAN
		do
			if
				not rescued and then
				attached {like session_data} f.retrieved as d
			then
				Result := d
			end
		rescue
			debug
				--FIXME
				io.error.put_string (generator + ": incompatible session content")
			end
			rescued := True
			retry
		end

	ensure_session_folder_exists
		local
			d: DIRECTORY
		once
			create d.make_with_path (sessions_folder_name)
			if not d.exists then
				d.recursive_create_dir
			end
		ensure
			sessions_folder_exists_and_writable: sessions_folder_exists_and_writable
		end

	sessions_folder_exists_and_writable: BOOLEAN
		local
			d: DIRECTORY
		do
			create d.make_with_path (sessions_folder_name)
			Result := d.exists and then d.is_writable
		end

	file_name (a_uuid: like {WSF_SESSION}.uuid): PATH
		do
			Result := sessions_folder_name.extended (a_uuid.out).appended_with_extension ("session")
		end

note
	copyright: "2011-2013, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
